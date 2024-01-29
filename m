Return-Path: <linux-kernel+bounces-43369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B6C8412C4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B852875E7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123A533CE7;
	Mon, 29 Jan 2024 18:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="vZSXZ+d7"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BBF76C63
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554445; cv=none; b=FWwZ/pU8K71De6Mkwmeb/YJV/kUbXpEzB/2AdFaYQDsHy5yA+/Ozz4xFXqfZ/fiyvkDVW2ze90Eehd+etCwJyZ0ApsDK9tohW1VEJ19pOD96FagSYJbjLTDfOOZsSo/LPZ1LnAz/jY3L6hbnQZmn43udgwjbgJNB96cLGGEZvCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554445; c=relaxed/simple;
	bh=JeZJfxUbhOcjTviijQYRAn1s2uITCFQ+zhFFFu5Xo1U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sgjOw2Sy4EQK4LrvMsIy3p7ZoZULM1En/NffO2AEEjOZas8vsAgRGyvfLXl8SOYUtNioQLUk2V8GOGhMQRFMqwOSe3GWmHFM2Pj4nu1QHPqdQsZnvA82xml9lp3y693jZFrFgDUogGU9zYDocIoNFcPYo1PoQ/upJlv14UDDor0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=vZSXZ+d7; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id D7744C0094DB;
	Mon, 29 Jan 2024 10:46:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com D7744C0094DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1706554012;
	bh=JeZJfxUbhOcjTviijQYRAn1s2uITCFQ+zhFFFu5Xo1U=;
	h=From:To:Cc:Subject:Date:From;
	b=vZSXZ+d71mX13XNrk1YfEAW2wXaYC2no3D516QFYiJK1xWKFBmSYM2C9X8DJLMOYA
	 ZFaTVoDPKnK9n3NVv7XdRmuHFwPaVwiHl02774xzLToiF9bH7gxDWJhimXn/97y2b8
	 2GJn16eKac6r9qNWLpbExNnpCVeWGS98b9h5JmYI=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 4DA6518041CAC4;
	Mon, 29 Jan 2024 10:46:51 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: brcmstb: Add debug UART entry for 74165
Date: Mon, 29 Jan 2024 10:46:51 -0800
Message-Id: <20240129184651.2405485-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BCM74165 uses the same address map as the 7278 family (v7 memory map)
therefore re-use that constant and shit down the other labels to keep
numerical ordering.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/arm/include/debug/brcmstb.S | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/debug/brcmstb.S b/arch/arm/include/debug/brcmstb.S
index f6175e6e28cd..3f7d68740ed4 100644
--- a/arch/arm/include/debug/brcmstb.S
+++ b/arch/arm/include/debug/brcmstb.S
@@ -27,6 +27,7 @@
 #define UARTA_72165		UARTA_7278
 #define UARTA_7364		REG_PHYS_ADDR(0x40b000)
 #define UARTA_7366		UARTA_7364
+#define UARTA_74165		UARTA_7278
 #define UARTA_74371		REG_PHYS_ADDR(0x406b00)
 #define UARTA_7439		REG_PHYS_ADDR(0x40a900)
 #define UARTA_7445		REG_PHYS_ADDR(0x40ab00)
@@ -88,9 +89,10 @@ ARM_BE8(	rev	\rv, \rv )
 30:		checkuart(\rp, \rv, 0x72780000, 7278)
 31:		checkuart(\rp, \rv, 0x73640000, 7364)
 32:		checkuart(\rp, \rv, 0x73660000, 7366)
-33:		checkuart(\rp, \rv, 0x07437100, 74371)
-34:		checkuart(\rp, \rv, 0x74390000, 7439)
-35:		checkuart(\rp, \rv, 0x74450000, 7445)
+33:		checkuart(\rp, \rv, 0x07416500, 74165)
+34:		checkuart(\rp, \rv, 0x07437100, 74371)
+35:		checkuart(\rp, \rv, 0x74390000, 7439)
+36:		checkuart(\rp, \rv, 0x74450000, 7445)
 
 		/* No valid UART found */
 90:		mov	\rp, #0
-- 
2.34.1


