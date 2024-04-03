Return-Path: <linux-kernel+bounces-129559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46822896C8B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAA0C1F2CA78
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B917C146A99;
	Wed,  3 Apr 2024 10:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ww0vKXnZ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE52145B3F;
	Wed,  3 Apr 2024 10:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140286; cv=none; b=Yc0bC9IGCNX4cJUPNtZPTv/8JoKC2ws/DoF7ysO5uCjcKwqM+2QTxyHniOsGSR9ljXZ/DFnUwTqlZb75mm1yLBU/GSCP7PPxShIHskQig2MFSVMyzJRdhRQocM800a/tApbz3gHeEOFv2OS1keN/NuL4jL4WLGNjy5a6SKhG3oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140286; c=relaxed/simple;
	bh=Hk5lU1iRK1GgpT71qfZlp1fjEZfdR8ivceCWc2U1aU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iXL5xqpwtvLZNsHQ3ryNw/KqJ7qrFw8zLUwT7urAx2h9BtRTfbdvbObAE93VdSSvx7DS7LO68uQpBa1qYp0iPMcIIX3aVv/a/YYF+7m9eMKqwMdc+J3dwxGprbn3n/db48dPPPCuCtM2oWt8i8TAj6Igemf9bT6CjqfWd34TPJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ww0vKXnZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712140282;
	bh=Hk5lU1iRK1GgpT71qfZlp1fjEZfdR8ivceCWc2U1aU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ww0vKXnZ4Fdy+6hX82DmeP34CR6MxyDteRTbdGGufT1Lr4UjrfUR4psPPuGgHI7oV
	 lbxhgjYtIHz49u4d/2wwgcXNWOKg74aYgPfi9zNagh5HbzjRSvB9m4GtR+Dt5RltIS
	 89U3mC1IQfTdLNxAZWN+g//VTfyAranewDfroAF13DH3Bgu2oZ5wV9MUCChh3fEBno
	 pb0yuoLn97UrzJCfQP2DL3Z4vRfdDGYgEzVw6HwGZLzl1cxvcJgBu/Byq9txeEkeQH
	 Bwa6Of5XmoKgeBaZmgJLnC6p/x+uG01poMnAN5QO42PRJFlqR0Ut2ov22RdMs4pjQs
	 5EnS8PcO+Guzw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8B9F137820F8;
	Wed,  3 Apr 2024 10:31:21 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
	Tinghan Shen <tinghan.shen@mediatek.com>,
	"Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
	"Nancy.Lin" <nancy.lin@mediatek.com>,
	kernel@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	"David S . Miller" <davem@davemloft.net>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: Re: [PATCH V2 0/4] arm64: dts: mediatek: mt7622: fix some validation errors
Date: Wed,  3 Apr 2024 12:30:58 +0200
Message-ID: <171213179799.60933.1750718061760478051.b4-ty@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240317221050.18595-1-zajec5@gmail.com>
References: <20240317221050.18595-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 17 Mar 2024 23:10:46 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> One more step in cleaning up DTS for "make dtbs_check".
> 
> V2: Add "Fixes" tags
> 
> Rafał Miłecki (4):
>   arm64: dts: mediatek: mt7622: fix clock controllers
>   arm64: dts: mediatek: mt7622: fix IR nodename
>   arm64: dts: mediatek: mt7622: fix ethernet controller "compatible"
>   arm64: dts: mediatek: mt7622: drop "reset-names" from thermal block
> 
> [...]

Applied to v6.9-fixes/dts64, thanks!

[1/4] arm64: dts: mediatek: mt7622: fix clock controllers
      commit: 3ba5a61594347ab46e7c2cff6cd63ea0f1282efb
[2/4] arm64: dts: mediatek: mt7622: fix IR nodename
      commit: 800dc93c3941e372c94278bf4059e6e82f60bd66
[3/4] arm64: dts: mediatek: mt7622: fix ethernet controller "compatible"
      commit: 208add29ce5b7291f6c466e4dfd9cbf61c72888e
[4/4] arm64: dts: mediatek: mt7622: drop "reset-names" from thermal block
      commit: ecb5b0034f5bcc35003b4b965cf50c6e98316e79

Cheers,
Angelo


