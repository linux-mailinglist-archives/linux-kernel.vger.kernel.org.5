Return-Path: <linux-kernel+bounces-77013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D35D086000A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 714741F26137
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3772515699F;
	Thu, 22 Feb 2024 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=baikalelectronics.ru header.i=@baikalelectronics.ru header.b="UtkeAyN0"
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F48A131722;
	Thu, 22 Feb 2024 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.79.110.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624224; cv=none; b=oCKtigmKQ0r2UM713tA94rchV2OwNnQ1x0pEMqKEDTIxRauJDbeUqLLpb1c93T28nCX5bVktow3E/wilIVz+zmlUal8rJcG4Ki4umEQMYyY/PuHa1UUuCDjz5c/sEVRqKpm/1yCzvx+ZuDZrHk+IoQTPSfQoy8o+N2RoDJRUK4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624224; c=relaxed/simple;
	bh=LzydD9nA3JRX2bdSqsq/c30MSWBNw6+4r4mK9UEZNbc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcI4lBO5YFtgHTSjKz/XSwAi3DNTZsyEKGSsvuHwhDzY5+/nJlyrrRM6qlCS9mbxuwZRomtHCtxxMPpnOs6TutxmKikZWImXc9fg099r8kZBBJbdSZsm1JZh518pW+AVdgxqDMPe8js1bAfD0OyVwZffeBBMnuxUxSsqksGf598=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baikalelectronics.ru; spf=pass smtp.mailfrom=baikalelectronics.ru; dkim=pass (1024-bit key) header.d=baikalelectronics.ru header.i=@baikalelectronics.ru header.b=UtkeAyN0; arc=none smtp.client-ip=213.79.110.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baikalelectronics.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baikalelectronics.ru
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
	by post.baikalelectronics.com (Proxmox) with ESMTP id E050AE0ECC;
	Thu, 22 Feb 2024 20:44:58 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	baikalelectronics.ru; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=post;
	 bh=9lKQbTvvvBtu+/xIRzSEw0xWHHrnTA6OZ3oo1VxzsVo=; b=UtkeAyN0MCXM
	btzuqgDfBN+3fxVvjk6ptU4Iz3AHbqWViGOdaSun6cho0T6XalgPnyDigYf6iJAL
	LsSOVt7lRO2SZc4ZXDOXWbkGPQq51O6NFdgyGbxE5KEDqAITnSxExovf1IWGtOiu
	OGu125ttGi/FJHpghyfRJkTGtxFefig=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
	by post.baikalelectronics.com (Proxmox) with ESMTP id BE9C2E0DE6;
	Thu, 22 Feb 2024 20:44:58 +0300 (MSK)
Received: from localhost (10.8.30.70) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Thu, 22 Feb 2024 20:44:58 +0300
From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
	<npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Aneesh
 Kumar K.V <aneesh.kumar@kernel.org>, "Naveen N. Rao"
	<naveen.n.rao@linux.ibm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
	<frowand.list@gmail.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Serge Semin <Sergey.Semin@baikalelectronics.ru>, Serge Semin
	<fancer.lancer@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring
	<robh@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v10 1/1] powerpc: dts: akebono: Harmonize EHCI/OHCI DT nodes name
Date: Thu, 22 Feb 2024 20:44:51 +0300
Message-ID: <20240222174456.25903-2-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222174456.25903-1-Sergey.Semin@baikalelectronics.ru>
References: <20240222174456.25903-1-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)

In accordance with the Generic EHCI/OHCI bindings the corresponding node
name is suppose to comply with the Generic USB HCD DT schema, which
requires the USB nodes to have the name acceptable by the regexp:
"^usb(@.*)?" . Make sure the "generic-ehci" and "generic-ohci"-compatible
nodes are correctly named.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/powerpc/boot/dts/akebono.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/akebono.dts b/arch/powerpc/boot/dts/akebono.dts
index df18f8dc4642..343326c30380 100644
--- a/arch/powerpc/boot/dts/akebono.dts
+++ b/arch/powerpc/boot/dts/akebono.dts
@@ -126,7 +126,7 @@ SATA0: sata@30000010000 {
 			interrupts = <93 2>;
 		};
 
-		EHCI0: ehci@30010000000 {
+		EHCI0: usb@30010000000 {
 			compatible = "ibm,476gtr-ehci", "generic-ehci";
 			reg = <0x300 0x10000000 0x0 0x10000>;
 			interrupt-parent = <&MPIC>;
@@ -140,14 +140,14 @@ SD0: sd@30000000000 {
 			interrupt-parent = <&MPIC>;
 		};
 
-		OHCI0: ohci@30010010000 {
+		OHCI0: usb@30010010000 {
 			compatible = "ibm,476gtr-ohci", "generic-ohci";
 			reg = <0x300 0x10010000 0x0 0x10000>;
 			interrupt-parent = <&MPIC>;
 			interrupts = <89 1>;
 			};
 
-		OHCI1: ohci@30010020000 {
+		OHCI1: usb@30010020000 {
 			compatible = "ibm,476gtr-ohci", "generic-ohci";
 			reg = <0x300 0x10020000 0x0 0x10000>;
 			interrupt-parent = <&MPIC>;
-- 
2.43.0



