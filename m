Return-Path: <linux-kernel+bounces-149773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3F08A95A3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3701C2094C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0228515AD8E;
	Thu, 18 Apr 2024 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZSM+iswS"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A6B158845;
	Thu, 18 Apr 2024 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713431320; cv=none; b=ASKCmjNnQELrOCU294DJUzCyhPXcTFpFdBo64tb4QcpUZ/je241NiyZxZ/zI8iqOEhrbiYkpWangZOtObDT6wjVrkx6FUjhTKmOYlJ8IgqKtrMlVObGm6AYT05wPVCmCtWi6EFVQQTFrptoI9Bc+Wtf04h5pw/xGMq0MHATpYrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713431320; c=relaxed/simple;
	bh=LsD7yUmtMCTzO1crQtPBvcjHCAiLcbN7MpNEaC3Gpgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ECFZ1WGyHRNHSWhV2HG2Fzmk7Izt0rE+Rbe/oXlZOJv1oGr5DRQLo1oXECMfAShX/3jbdHIs9S2c7812VmMrFUpcU6P0VSMWCvC0uM6Ir8r+8I6csw6EilolOuH+Q3KprDWvVKB3cz2gp1v3ba2Ymp0qvSuoVUFbRMHm0as7TDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZSM+iswS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713431314;
	bh=LsD7yUmtMCTzO1crQtPBvcjHCAiLcbN7MpNEaC3Gpgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZSM+iswSiJQUhdHGJZ5VxHCJyxeJgeADTcN/qrYIiaa/asAzkICNqsr4/5U9k44rs
	 QPZfkY59B8IMG7vKo49CkAUiJM///EsWvguueXGdNQpjZMq2xQx3GlPXqOx+xlHMib
	 jc2aPNAVdUuKtcXum8MMmkIMtLFaGrrYdYZwwgraNT2OzJ4mP0LeHGIiJt2Cjj2ux6
	 ToRFZXHBrIj+MAIFxWQy1f+5bbtRwaDvjRfoVjtqh6PeetCgOTg8sylHq9oI1QXaXo
	 OiSYk4PwgCyeZ4LrwCxqSBgmLt/jom8s4i9w52Ymtj22OhN1zVYROjj0z9puzHYh5X
	 nOGMCfUIeaXlQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BB7E6378203F;
	Thu, 18 Apr 2024 09:08:33 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Macpaul Lin <macpaul.lin@mediatek.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Bear Wang <bear.wang@mediatek.com>,
	Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul@gmail.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8395-genio-1200-evk: add u3port1 for xhci1
Date: Thu, 18 Apr 2024 11:08:26 +0200
Message-ID: <171343130258.187209.10545268279574102752.b4-ty@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240216095751.4937-1-macpaul.lin@mediatek.com>
References: <20240216095751.4937-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 16 Feb 2024 17:57:51 +0800, Macpaul Lin wrote:
> This patch fixes an issue where xhci1 was not functioning properly because
> the state and PHY settings were incorrect.
> 
> The introduction of the 'force-mode' property in the phy-mtk-tphy driver
> allows for the correct initialization of xhci1 by updating the Device Tree
> settings accordingly.
> 
> [...]

Applied to v6.9-next/dts64, thanks!

[1/1] arm64: dts: mediatek: mt8395-genio-1200-evk: add u3port1 for xhci1
      commit: 2cf936800fc1eb22465e43d9d908336630255c3d

Cheers,
Angelo


