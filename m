Return-Path: <linux-kernel+bounces-71085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEAF85A075
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A696281E49
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EAD25576;
	Mon, 19 Feb 2024 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fIYyj7Hk"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F752241E1;
	Mon, 19 Feb 2024 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336987; cv=none; b=C1g1joQOm406kWan+06tAZMYyA/Fs2VvAWf+0P13aOlGZU8H/xrQiojEQsTyEqgccncdqgXORr7+cD4VC7AIKNRN0R0Wchfg2uHXMTeFKNAp2CDu51QR+uXw6655T4UJxe98XoV364pCMi88nCrbXHS7eE++4Ma54R+i09U9fAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336987; c=relaxed/simple;
	bh=HqsOIJb5iZIsdTx/9+wzLDZFTiKmXPmHGZEETmuqA/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O8UhZDw3lPFgSRGU3/SCUp9QrmiJNL6LdYkLPfQLNBVgWIgJ/FaZHLyg+jBI+BPZVEmpvKZboHx/yp49zbMJ5EggDPsrna+ppBee6XtQSe/xOrPNJZsfV2rr+5T/2AdkMUTqVbV8p5gJ6ZsGPbWp3hrckqiN5LDETnTlyQcY0/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fIYyj7Hk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708336983;
	bh=HqsOIJb5iZIsdTx/9+wzLDZFTiKmXPmHGZEETmuqA/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fIYyj7HkYuKtsPw+l99jhHS5OjmIhBzOR0qVzZA3mylXcuJ/nt+0O0TCYIitsaew/
	 uo2cw6ONm7yCiTe1IrgpCd5L9r25x2nAnPx9o1sx68joxz1n+PCNI2qQ7XV8krEzFf
	 F8AglYpaNodVpajOe6J0ra+6WgHAdW+TM94J8CBUqwlw5JTkv2NWFtHQpCMhcuizsJ
	 lOZ9ectKFROthHAh41ycto5TX/jmhjsSBB+3PXTh8A1MUsUHYVNa+yuBrs6PsYLCul
	 pEA4bVuCNVDO41v/o3ZcTk6WHgkuCJlCOuTiaZ1C31CPK8MIuSA+c2QRyWhZXdjw9V
	 W5CUhJHABQgfg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E8B583781FD9;
	Mon, 19 Feb 2024 10:03:02 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	erkin.bozoglu@xeront.com,
	mithat.guner@xeront.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/2] Add port@5 as CPU port on certain MT7622 and MT7986 boards
Date: Mon, 19 Feb 2024 11:03:00 +0100
Message-ID: <170833695121.72704.8159416902422246326.b4-ty@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240219-for-mediatek-v1-0-7078f23eab82@arinc9.com>
References: <20240219-for-mediatek-v1-0-7078f23eab82@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 19 Feb 2024 12:36:12 +0300, Arınç ÜNAL wrote:
> This patch series adds port@5 as CPU port on certain MT7622 and MT7986
> boards.
> 
> 

Applied to v6.8-next/dts64, thanks!

[1/2] arm64: dts: mt7622: add port@5 as CPU port
      https://git.kernel.org/mediatek/c/7b8cc130
[2/2] arm64: dts: mt7986: add port@5 as CPU port
      https://git.kernel.org/mediatek/c/43ec7fc9

Cheers,
Angelo


