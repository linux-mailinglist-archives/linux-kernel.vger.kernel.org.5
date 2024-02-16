Return-Path: <linux-kernel+bounces-68609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5BA857D20
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90CDE1C24453
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405B41292E1;
	Fri, 16 Feb 2024 13:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5ZnHsJE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F281292DA;
	Fri, 16 Feb 2024 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708088536; cv=none; b=MpHxUS4IxL6jhZijkfSoAk7SWTpe3tPBxF/MlKh/FRQuzzWJIttmgKU5hJGEBo2oEYsI/7BPb5FIOzBocGynVmwvCyGMJ1ToP9Gt9QnGoc0bx4eu5S5gpkaTfegOwpjoOVheI/Svz6zsbzXgeGt4vv4Srcjgdxdfwj4EEmcCKFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708088536; c=relaxed/simple;
	bh=sb3buG/KU+fA4QRtXXNpnvZ40Wej6Dxm15Q7iU/SnQI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rQQXpxRZvvfAr3wLq4qtIIpQ5dkVE8kPHotw3Lxi1rC3iD3KPLApfQsAykRaiqNy9Y+bk4XHPf+N4FpA8clXk+5Gf+zA/3gMMi3+162rHqs0haJzQXHjwX2XvCCAOiOnOB2vfvhFIX5Wz1tCrwcKkVTYYtG9YJRijWAsinb4p/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5ZnHsJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99AC1C433C7;
	Fri, 16 Feb 2024 13:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708088535;
	bh=sb3buG/KU+fA4QRtXXNpnvZ40Wej6Dxm15Q7iU/SnQI=;
	h=From:To:Cc:Subject:Date:From;
	b=D5ZnHsJEeYoJJQ6k26htv9rfQcX+9/3LnxIyhnEtTP0XY7HDEDpgY1t+JLTv8gZZ3
	 SvVaF+yQh7GVAMVuy2qVUvX0mYxFWk4smSeo/tPtjMR5nzn67Dg3IwQ0P3SLcXwVkp
	 0NB9hYL9amIMwv6PDTCJGYE8dhqrT5s6/gwXv+VWWD3XAdbhoQ7fPMclaVCFfZ+26e
	 mebnJPZHASzXDVkBTMMSkJZ+QJTVDv78mwUtLmGmSr2TeWZOiLd86mS97X1FLWL6QB
	 85IW0Idmxa7+m/tbtWTzPc6WQjbqmE48UugA/O6XSMKUupVpXEix9EPOtTWJsMbiX4
	 lH69vqy8Vrv5Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: avoid 'bool' as variable name
Date: Fri, 16 Feb 2024 14:02:04 +0100
Message-Id: <20240216130211.3828455-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

In modern C versions, 'bool' is a keyword that cannot be used as
a variable name, so change this instance use something else, and
change the type to bool instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/core/seq/oss/seq_oss_device.h | 2 +-
 sound/core/seq/oss/seq_oss_init.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/core/seq/oss/seq_oss_device.h b/sound/core/seq/oss/seq_oss_device.h
index 6c2c4fb9b753..f0e964b19af7 100644
--- a/sound/core/seq/oss/seq_oss_device.h
+++ b/sound/core/seq/oss/seq_oss_device.h
@@ -163,6 +163,6 @@ snd_seq_oss_fill_addr(struct seq_oss_devinfo *dp, struct snd_seq_event *ev,
 
 
 /* misc. functions for proc interface */
-char *enabled_str(int bool);
+char *enabled_str(bool b);
 
 #endif /* __SEQ_OSS_DEVICE_H */
diff --git a/sound/core/seq/oss/seq_oss_init.c b/sound/core/seq/oss/seq_oss_init.c
index 42d4e7535a82..76bf41c26acd 100644
--- a/sound/core/seq/oss/seq_oss_init.c
+++ b/sound/core/seq/oss/seq_oss_init.c
@@ -455,9 +455,9 @@ snd_seq_oss_reset(struct seq_oss_devinfo *dp)
  * misc. functions for proc interface
  */
 char *
-enabled_str(int bool)
+enabled_str(bool b)
 {
-	return bool ? "enabled" : "disabled";
+	return b ? "enabled" : "disabled";
 }
 
 static const char *
-- 
2.39.2


