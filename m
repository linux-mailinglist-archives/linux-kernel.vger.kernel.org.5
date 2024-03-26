Return-Path: <linux-kernel+bounces-119223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A697588C5D9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44DB51F367B0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F35513C685;
	Tue, 26 Mar 2024 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUbmDVlb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A659013C3E8;
	Tue, 26 Mar 2024 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464757; cv=none; b=sVzkR/TWo2wicLbHD4wX6YFsgiBgQFK/Adq0UY6cPgS2X0z4KBpk/QWxPn2NFlJ5vX76mA0cQrf3Z8sPaiHJV0uNcmqfj9bahqsUcZNB27EkaNhBSqPGD9J0s9dD+iyrZGNtQpYDOtoWM6pe7warEewuk3fpS4VFMHAFYvqrLv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464757; c=relaxed/simple;
	bh=9Zh9r/IExbwuD6PUJoYWn+L19V/xILVXS9xvRzthMQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SipAG1QgB23zZPHnSB0x5T4sy5HzPl+pj1dE4006o0V9JHDVbQgOWOoKmmbiJNc1WJh8zg+cm8ppG4Cqr3GyiPcdEhhO/vleKP0xH6isoaO40mO9n/wyJoKhhsg7FsrVQlLuZzKreSiQmRH8oZMujy6sBni2Jgb9MrrXAKWNwlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUbmDVlb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A2AC433F1;
	Tue, 26 Mar 2024 14:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711464757;
	bh=9Zh9r/IExbwuD6PUJoYWn+L19V/xILVXS9xvRzthMQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cUbmDVlbj2He+YwrB/NnIPO9G2q7g7VXGpKRaC9FlE7V/XKaIdf46bvyuAYXOsavm
	 TB+dOCV9RYMJig9OEsF/vF6vUHGno2xQXaH5D4lrnblzQrsDj30D1WCJVmoAEBtP2V
	 KIrbEcxFW/pgv3xr03HR86mncXQBTlOZ6XWkiikodaW+y0JgaovV8hCP+zbeEsacrn
	 Scb0CuKcRAqc+PH4Ooh5fE/e6KURL5ZcT85/JDUjhYaj2RH4ztlXB83iOc6HN+Y+hw
	 I90F8Sn//jAHHMjulbYqVx4d+nnNVoII9URgQzzDsVDP1j4non1RIf9DGEMXTkGh6B
	 fWOzUYBXsC1Vg==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kbuild@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Greg Kroah-Hartman <gregkh@suse.de>
Cc: Nicolas Schier <nicolas@fjasle.eu>,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 05/12] firmware: dmi-id: add a release callback function
Date: Tue, 26 Mar 2024 15:51:30 +0100
Message-Id: <20240326145140.3257163-4-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326144741.3094687-1-arnd@kernel.org>
References: <20240326144741.3094687-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

dmi_class uses kfree() as the .release function, but that now causes
a warning with clang-16 as it violates control flow integrity (KCFI)
rules:

drivers/firmware/dmi-id.c:174:17: error: cast from 'void (*)(const void *)' to 'void (*)(struct device *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  174 |         .dev_release = (void(*)(struct device *)) kfree,

Add an explicit function to call kfree() instead.

Fixes: 4f5c791a850e ("DMI-based module autoloading")
Link: https://lore.kernel.org/lkml/20240213100238.456912-1-arnd@kernel.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I sent this before but got no comments for it
---
 drivers/firmware/dmi-id.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/dmi-id.c b/drivers/firmware/dmi-id.c
index 5f3a3e913d28..d19c78a78ae3 100644
--- a/drivers/firmware/dmi-id.c
+++ b/drivers/firmware/dmi-id.c
@@ -169,9 +169,14 @@ static int dmi_dev_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
+static void dmi_dev_release(struct device *dev)
+{
+	kfree(dev);
+}
+
 static struct class dmi_class = {
 	.name = "dmi",
-	.dev_release = (void(*)(struct device *)) kfree,
+	.dev_release = dmi_dev_release,
 	.dev_uevent = dmi_dev_uevent,
 };
 
-- 
2.39.2


