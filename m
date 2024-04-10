Return-Path: <linux-kernel+bounces-138586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7C589F7C4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6839FB2BBFE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FACC160790;
	Wed, 10 Apr 2024 13:20:02 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AC915E801;
	Wed, 10 Apr 2024 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755201; cv=none; b=STynnCeTKrc2r0GHMxqVYHCTVKqawsF5y9Oq0JM84TPJlueM9nH6NPCV9YGSflLMB8/KQk7NbarEHOlSAd2hIB/EKQJda0ES1Caci7EwOy3x7NIimZuTQN/xDgeGDf4DaLK8ipiXz+X/nzCzDxvPaSjtq1axZaFmQtzQTVajTDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755201; c=relaxed/simple;
	bh=Y2xFVKVJYXpxExcTVw1OG0qaRy+eheyCTegub5oKido=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BH4HxZFGGpZMPM/DTIdOXFVwl1prWz9xFC2lPkQoBz7hZgL4G3b5QATW1JIBEOocDgIw9fs75JYt72DGvzI+39n1NENNY2uu+AOHGon3bQ+eoFzNnsCtLspfbic54Jfr+buC2oGkAVx6bRmYLVYaDWgI2qTIYuLOFyRMVCwK0oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA4EC433F1;
	Wed, 10 Apr 2024 13:19:58 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 2/4] LoongArch: Update dts for Loongson-2K2000 to support ISA/LPC
Date: Wed, 10 Apr 2024 21:18:02 +0800
Message-ID: <20240410131804.2165848-3-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410131804.2165848-1-chenhuacai@loongson.cn>
References: <20240410131804.2165848-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Loongson-2K2000 platforms have ISA/LPC devices such as Super-IO,
define an ISA node in the dts file to avoid access error. Also adjust
the PCI io resource range to avoid confliction.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/boot/dts/loongson-2k2000.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/boot/dts/loongson-2k2000.dtsi b/arch/loongarch/boot/dts/loongson-2k2000.dtsi
index a231949b5f55..dcee9f3783fd 100644
--- a/arch/loongarch/boot/dts/loongson-2k2000.dtsi
+++ b/arch/loongarch/boot/dts/loongson-2k2000.dtsi
@@ -51,6 +51,13 @@ bus@10000000 {
 		#address-cells = <2>;
 		#size-cells = <2>;
 
+		isa@18400000 {
+			compatible = "isa";
+			#size-cells = <1>;
+			#address-cells = <2>;
+			ranges = <1 0x0 0x0 0x18400000 0x4000>;
+		};
+
 		pmc: power-management@100d0000 {
 			compatible = "loongson,ls2k2000-pmc", "loongson,ls2k0500-pmc", "syscon";
 			reg = <0x0 0x100d0000 0x0 0x58>;
@@ -141,7 +148,7 @@ pcie@1a000000 {
 			#size-cells = <2>;
 			device_type = "pci";
 			bus-range = <0x0 0xff>;
-			ranges = <0x01000000 0x0 0x00008000 0x0 0x18400000 0x0 0x00008000>,
+			ranges = <0x01000000 0x0 0x00008000 0x0 0x18408000 0x0 0x00008000>,
 				 <0x02000000 0x0 0x60000000 0x0 0x60000000 0x0 0x20000000>;
 
 			gmac0: ethernet@3,0 {
-- 
2.43.0


