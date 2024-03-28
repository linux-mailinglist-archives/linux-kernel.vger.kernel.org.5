Return-Path: <linux-kernel+bounces-123000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 832688900DF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2372B1F26042
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1190382D66;
	Thu, 28 Mar 2024 13:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZjGgAqL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5069181AC1;
	Thu, 28 Mar 2024 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634136; cv=none; b=oAZQq0iLjqMH6m/c2CWuQPEArsrQDRezCaKNbwztnrllCG8KwlBhy0p8OW3nmFElWWbdIcz0CCnKUcaMziV/3fyHrauDtk7OlELxdntumFMw1Z8lF7Jxnv8+94BWjtWc+oqxy+5+/daVbAXdQSqOfoXP4YHfHQeyW7mg3ckb5mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634136; c=relaxed/simple;
	bh=B1bIIrooihislE1mX6BRJC65yAmjnRAiaxE9OMZQxAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RqCENXwZp8ijks5Y4brg+iD+Kd4bondaHdyQyKJbqJffhFxf1gZop8QHdoJ3ilXcDwVyURX7vSGEI4mj8OJBCqjXKhMBrwxP+2Za8xtKd6Gz/3m4zDQX6qUJbaTnpgpVJD5teND7J3NkPE9Rq1LTg076u+PbWxlWCOYrIuz2hFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZjGgAqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97163C433C7;
	Thu, 28 Mar 2024 13:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711634136;
	bh=B1bIIrooihislE1mX6BRJC65yAmjnRAiaxE9OMZQxAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eZjGgAqL4xfmx+WtA+DkKBbpM0763PjFCAfx7FMQr7cL7//eBJVQP5QwfqrQ/WbVZ
	 qB2za8R9/WhWcvAsK3nUbTZjLQQFP1GHR5RneRJPQWh3jbhr3mDMhdlp7mr8Wp1gCN
	 riwiiWjnA2CGUMpMjzlBXYXevIlkmuBlUJ7zkZy/shsLb4Y4GW0X4+Ei69Y67wLgip
	 T3zN8gEsbmh0DVdesbL8czMAUOJIB3ZMDxxs8X5Xi+NClNLGzIcMx3aZn0HtQzLC7U
	 usJ1xUL/E/RS3M0JU3jwITusYF0fwi6QxFOT8/+lJXikBKde7hEab2/RORmzN7zIQB
	 aj+BkIsu2YE7Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Kees Cook <keescook@chromium.org>,
	Kalle Valo <kvalo@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: linux-hardening@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Hancheng Yang <hyang@freebox.fr>,
	Remi Pommarel <repk@triplefau.lt>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] wifi: ath9k: work around memset overflow warning
Date: Thu, 28 Mar 2024 14:55:05 +0100
Message-Id: <20240328135509.3755090-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328135509.3755090-1-arnd@kernel.org>
References: <20240328135509.3755090-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

gcc-9 and some other older versions produce a false-positive warning
for zeroing two fields

In file included from include/linux/string.h:369,
                 from drivers/net/wireless/ath/ath9k/main.c:18:
In function 'fortify_memset_chk',
    inlined from 'ath9k_ps_wakeup' at drivers/net/wireless/ath/ath9k/main.c:140:3:
include/linux/fortify-string.h:462:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
  462 |                         __write_overflow_field(p_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Using a struct_group seems to reliably avoid the warning and
not make the code much uglier. The combined memset() should even
save a couple of cpu cycles.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This is from randconfig testing, see https://pastebin.com/yjKk5N81
for a reproducer
---
 drivers/net/wireless/ath/ath.h        | 6 ++++--
 drivers/net/wireless/ath/ath9k/main.c | 3 +--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath.h b/drivers/net/wireless/ath/ath.h
index f02a308a9ffc..34654f710d8a 100644
--- a/drivers/net/wireless/ath/ath.h
+++ b/drivers/net/wireless/ath/ath.h
@@ -171,8 +171,10 @@ struct ath_common {
 	unsigned int clockrate;
 
 	spinlock_t cc_lock;
-	struct ath_cycle_counters cc_ani;
-	struct ath_cycle_counters cc_survey;
+	struct_group(cc,
+		struct ath_cycle_counters cc_ani;
+		struct ath_cycle_counters cc_survey;
+	);
 
 	struct ath_regulatory regulatory;
 	struct ath_regulatory reg_world_copy;
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index a2943aaecb20..01173aac3045 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -135,8 +135,7 @@ void ath9k_ps_wakeup(struct ath_softc *sc)
 	if (power_mode != ATH9K_PM_AWAKE) {
 		spin_lock(&common->cc_lock);
 		ath_hw_cycle_counters_update(common);
-		memset(&common->cc_survey, 0, sizeof(common->cc_survey));
-		memset(&common->cc_ani, 0, sizeof(common->cc_ani));
+		memset(&common->cc, 0, sizeof(common->cc));
 		spin_unlock(&common->cc_lock);
 	}
 
-- 
2.39.2


