Return-Path: <linux-kernel+bounces-138588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A777E89F876
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 364F3B2C159
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD2E16D302;
	Wed, 10 Apr 2024 13:20:32 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FA6158A0E;
	Wed, 10 Apr 2024 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755231; cv=none; b=slzXO5fOXOss3BJHRoDtNLJ32BG7Ws56ehgMWHmEukI+AMjfPuSlzcKUKNH7Im74CXC1dXGbSFmmLBXIifqPCvHLsDAZQcTzl74/CHdWqzxB6dqpWQ7PhJetexUqef2t4A9K8GH0f7vLx/vGgFX9rMcAIY4MqSirA6dj20BXBZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755231; c=relaxed/simple;
	bh=frXcCQMlx8RE8Bbo8U+apyurjJdqHMgkpVKzPCvQcCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZEYVVI9j64iotDLPyAmnBJ61X0nWuNkvlBpBosXxho6eO5KTayGy0Lp15ZIKBP5PsN0AGOC6AOs+UgiUtUhDDtPpJHqTxc4O2s8NhmXxv76DAasqwIhYsku/tB+mL0OvwDHvxikchy/UrJDoD0KGLuIdolLf7/GBCuerKF9c4eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6961AC433F1;
	Wed, 10 Apr 2024 13:20:28 +0000 (UTC)
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
Subject: [PATCH 3/4] LoongArch: Update dts for Loongson-2K2000 to support PCI-MSI
Date: Wed, 10 Apr 2024 21:18:03 +0800
Message-ID: <20240410131804.2165848-4-chenhuacai@loongson.cn>
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

Current dts file for Loongson-2K2000 misses the interrupt-controller &
interrupt-cells descriptions in the msi-controller node, and misses the
msi-parent link in the pci root node. Add them to support PCI-MSI.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/boot/dts/loongson-2k2000.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/loongarch/boot/dts/loongson-2k2000.dtsi b/arch/loongarch/boot/dts/loongson-2k2000.dtsi
index dcee9f3783fd..481c6c869a8b 100644
--- a/arch/loongarch/boot/dts/loongson-2k2000.dtsi
+++ b/arch/loongarch/boot/dts/loongson-2k2000.dtsi
@@ -116,6 +116,8 @@ pic: interrupt-controller@10000000 {
 		msi: msi-controller@1fe01140 {
 			compatible = "loongson,pch-msi-1.0";
 			reg = <0x0 0x1fe01140 0x0 0x8>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
 			msi-controller;
 			loongson,msi-base-vec = <64>;
 			loongson,msi-num-vecs = <192>;
@@ -147,6 +149,7 @@ pcie@1a000000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
+			msi-parent = <&msi>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x01000000 0x0 0x00008000 0x0 0x18408000 0x0 0x00008000>,
 				 <0x02000000 0x0 0x60000000 0x0 0x60000000 0x0 0x20000000>;
-- 
2.43.0


