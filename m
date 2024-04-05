Return-Path: <linux-kernel+bounces-132631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E361F899779
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20605B2132C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1557614831F;
	Fri,  5 Apr 2024 08:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="E9QpCMx6"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5911465B4;
	Fri,  5 Apr 2024 08:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712304157; cv=none; b=qMRkwTGNFZQokrvuPd20tAHy7eWKX3QuUXllog2D+JvIgP1Nvs2IB3u1PdPPBJv6J3AATUy7HU2nRKwcXAB1+kzIZ8vbjc8btER7B6uZUpFCT3QcfXeddHBCsbJzDC3TC+Lt7bJQEc4G5osS6jIFhk2mE3BGAizazy8AoV5JoCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712304157; c=relaxed/simple;
	bh=M3yAVxJTT1w5cqJys+gZWTSh5yMgC3YJ8GXKlzaEoKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HOFO4+9wHLeeYfAu1xRTI7jdqtg5yFa17YWsZ6WpByjVk2nWNkPEOfscfvw1BbW3gL5t0Vcy8VmmJuFFRmaRv0UK+yfYE20WhSKqWo1uZyL+dh/rONTCVDdzO6l2W0k3T0WI6xKIBmUIFgZcCEigX/rfuzJeOD/H82RKqSvBoX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=E9QpCMx6; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712304154;
	bh=M3yAVxJTT1w5cqJys+gZWTSh5yMgC3YJ8GXKlzaEoKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E9QpCMx6LNrGeWeT/oPVfXLsHesBSdx2uoJQ5xPUS2d7BlscvppUCGaHxSA7jxYK1
	 C5VBcYvLE3pOrrfGhZWaWUujWvfN6ALpGryeEZJkK19JI5+8UQqE3Rt79axp5XjTLu
	 7BHnDTaBPn8sprbd03gctIvWDjV5Zt2NPv0+8nwEBYlexdpdrD+cIZn7nhhuZXzg2j
	 21ya0d6A/LJfPgQL03fwLUHhj+cIoyn2Q1DNT1mXRViPzl8uMD6ydzSial8662ZqqR
	 fwamxFyGGFvNKptYS2PDx+rd5IoLDp2g7vUEga/Y7bz791sio4BFU0Uuj2nbCmxBFu
	 8JBZpszG4/FcA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 49EDB378212E;
	Fri,  5 Apr 2024 08:02:33 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Golle <daniel@makrotopia.org>,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: Re: [PATCH] arm64: dts: mediatek: mt7981: add watchdog & WiFi controllers
Date: Fri,  5 Apr 2024 10:02:26 +0200
Message-ID: <171230395357.52952.9902355743801356290.b4-ty@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240221085547.27840-1-zajec5@gmail.com>
References: <20240221085547.27840-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 21 Feb 2024 09:55:47 +0100, Rafał Miłecki wrote:
> MT7981 (Filogic 820) is a low cost version of MT7986 (Filogic 830) with
> the same watchdog controller. It also comes with on-SoC 802.11ax
> wireless.
> 
> 

Applied to v6.9-next/dts64, thanks!

[1/1] arm64: dts: mediatek: mt7981: add watchdog & WiFi controllers
      commit: 452f39543ce4cebda3471931b0efc6a46e765458

Cheers,
Angelo


