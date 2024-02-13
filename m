Return-Path: <linux-kernel+bounces-63330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8D3852DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB231F28067
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCF02260B;
	Tue, 13 Feb 2024 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9rSz7y2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC99C249E6;
	Tue, 13 Feb 2024 10:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819481; cv=none; b=nfwvkJVn7of/ObW0E4MMO8CE2TJaNT7MWkgVpRD3/re8/WXlOhoVz79/EYb3bEQ28KosYRO+TV+YsSPKrAoVpUwfOSxcqvZg8gd0kZio4UIgRkY8gVOuI0/n9maDKhkv3BIUZni0eInNm/F6+2Z8c/OK6XDaDMSLtMU6UD8CXP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819481; c=relaxed/simple;
	bh=M0omCzupnR3eO9G0ZEKmTrZW1r/VLKkL8eLhQp9cwrA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gjbPMEdVoMh+Rf6d1VzDTJdFNIX9bT1JnEi8zM8v3pPCHLPVkvfUe2a4ZlZNW1dtflndEiq2SceufKCaZdgW0kEktBxyAsuK3MnUHUCzoki40gGksbfiuNVUcd6MDYoJwTI6MECGWAdfRVQLDYvXc9VJDoBcBA/S54L045e0uGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9rSz7y2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311D5C433F1;
	Tue, 13 Feb 2024 10:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707819481;
	bh=M0omCzupnR3eO9G0ZEKmTrZW1r/VLKkL8eLhQp9cwrA=;
	h=From:To:Cc:Subject:Date:From;
	b=s9rSz7y2uHJMnZhKr4qSW9mpG7iRl6rFaesUumx6kTwL75nBPio0n+kTi3qJv/DKP
	 gNGyOl0ZlFS40+OiuZJuVQV18VucJadwMoEhCT8xe5gBgM1y8CHioDDwWwczTl02G7
	 DiJDA8DIUmNoelB2CJCau+WyZulEZK67E53aoxc+Wnfbc3TOjsjDoVG1UyoiAJPYJc
	 Naqu3voXnhoBzjqKcUvajkwaOASC+Q0ljhyjtD19NregQBDzt6GyzkCgVjB4XK5DkP
	 I9Z0+AvAv0g3JtOSu3ydnaCIY6C1beITu7hnuSMBApg08r46EuSu/Ye7oFNzdSg/mH
	 KREKGIuYyWMZQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] tty: hvc-iucv: fix function pointer casts
Date: Tue, 13 Feb 2024 11:17:49 +0100
Message-Id: <20240213101756.461701-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang warns about explicitly casting between incompatible function
pointers:

drivers/tty/hvc/hvc_iucv.c:1100:23: error: cast from 'void (*)(const void *)' to 'void (*)(struct device *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
 1100 |         priv->dev->release = (void (*)(struct device *)) kfree;
      |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Add a separate function to handle this correctly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/hvc/hvc_iucv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/hvc_iucv.c b/drivers/tty/hvc/hvc_iucv.c
index fdecc0d63731..b1149bc62ca1 100644
--- a/drivers/tty/hvc/hvc_iucv.c
+++ b/drivers/tty/hvc/hvc_iucv.c
@@ -1035,6 +1035,10 @@ static const struct attribute_group *hvc_iucv_dev_attr_groups[] = {
 	NULL,
 };
 
+static void hvc_iucv_free(struct device *data)
+{
+	kfree(data);
+}
 
 /**
  * hvc_iucv_alloc() - Allocates a new struct hvc_iucv_private instance
@@ -1097,7 +1101,7 @@ static int __init hvc_iucv_alloc(int id, unsigned int is_console)
 	priv->dev->bus = &iucv_bus;
 	priv->dev->parent = iucv_root;
 	priv->dev->groups = hvc_iucv_dev_attr_groups;
-	priv->dev->release = (void (*)(struct device *)) kfree;
+	priv->dev->release = hvc_iucv_free;
 	rc = device_register(priv->dev);
 	if (rc) {
 		put_device(priv->dev);
-- 
2.39.2


