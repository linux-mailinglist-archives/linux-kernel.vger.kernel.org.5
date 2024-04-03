Return-Path: <linux-kernel+bounces-129285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E114989683B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C26928BACA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767278565C;
	Wed,  3 Apr 2024 08:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cr/P1UqD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97DA839F7;
	Wed,  3 Apr 2024 08:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131726; cv=none; b=T2fHEObanKcY/TCei58VdxDb9WxOpL3fuea49phwh2K9ccgucmLnYLOGCbh1fonJSdEZ/pX6qHcE422EazH6jkzzDGxkWZlhoPoi68XJRzxgmcEs3U3EwVyowVSzy02LLIo+IoTR2bxxU/9AIhEUGzz9NfSxeYhJhHa3IWOVPLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131726; c=relaxed/simple;
	bh=FdHqMqMo9sUCpqipxuKBSJYP0dDiQNo82fvPaq1PpTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CJXR2LjZHxzQC6NZZ8hqT+omf+qy5YSfc43crrnRCL7dh6cPV97Knq9JrCeaVXUS+oFhMVuR6siMwSj1ulNCXk1HGlNBNyZe2FcBbIg1Xk0dmUHHgEi+h8uXJjFCReK8HkcolKoTh7CKLbBszFMTE2bE8mRkbPOcVimknyhZB0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cr/P1UqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE870C433F1;
	Wed,  3 Apr 2024 08:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131726;
	bh=FdHqMqMo9sUCpqipxuKBSJYP0dDiQNo82fvPaq1PpTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cr/P1UqDYRkzPKqWmBayNR3jsXD6jMn0kadZyFxqYE7IyvhZShvACgtnZHttX24IG
	 r1JUFlP+XeTxLhjkf9rioOJNZDuspkIFHOuD9cjXIRhHsLmaiigk3Da/7Dui2ehupf
	 nwl2kb0SRVwce6S20DGkI7cUjKWszmAY7dAiBNij74+qwVb7bS/ZkUweB77DTFIgbJ
	 3C0HVjZAaX13S9UvkBLXDa1GUYxy0hSgmFu3aU9eSzT+AnfaZhKidYmlZtxl1cueEw
	 +Um7ksYhBu/qR2i+ILNCm8u5Mj993Z+Ln7r4uL+NW3t2VrrExsYg/XvJROJrSjLbDg
	 hFlY7HeYvOqxg==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>,
	Raul Rangel <rrangel@chromium.org>,
	Jeffery Miller <jefferymiller@google.com>,
	linux-input@vger.kernel.org
Subject: [PATCH 08/34] Input: synaptics: hide unused smbus_pnp_ids[] array
Date: Wed,  3 Apr 2024 10:06:26 +0200
Message-Id: <20240403080702.3509288-9-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403080702.3509288-1-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When SMBUS is disabled, this is never referenced, causing a W=1 warning:

drivers/input/mouse/synaptics.c:164:27: error: 'smbus_pnp_ids' defined but not used [-Werror=unused-const-variable=]

Hide the array behind the same #ifdef as the code referencing it.

Fixes: e839ffab0289 ("Input: synaptics - add support for Intertouch devices")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/mouse/synaptics.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 7a303a9d6bf7..bc22b75e64a7 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -161,6 +161,7 @@ static const char * const topbuttonpad_pnp_ids[] = {
 	NULL
 };
 
+#ifdef CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS
 static const char * const smbus_pnp_ids[] = {
 	/* all of the topbuttonpad_pnp_ids are valid, we just add some extras */
 	"LEN0048", /* X1 Carbon 3 */
@@ -195,6 +196,7 @@ static const char * const smbus_pnp_ids[] = {
 	"SYN3257", /* HP Envy 13-ad105ng */
 	NULL
 };
+#endif
 
 static const char * const forcepad_pnp_ids[] = {
 	"SYN300D",
-- 
2.39.2


