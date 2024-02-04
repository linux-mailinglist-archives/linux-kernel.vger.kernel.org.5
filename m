Return-Path: <linux-kernel+bounces-51601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D71848D1C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB5DCB22C0D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 11:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9000222089;
	Sun,  4 Feb 2024 11:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="o2N7X+iU"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7E721A0B;
	Sun,  4 Feb 2024 11:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707045694; cv=none; b=c3EopjpOf00xbsGgkxCVDN5Sm+VENujFuTFAqnOoyBPIf2cpmEOvRVYvqFugsJ9nyoOy8LQLBaSNE9mRDYkAOgGYLpLXxn7XobRSbcfuLkvWvGKQjVYaq/WWLStSAIiW6AcbwdgXLaXqrrO375LHy2pD1ATADh0MYPQdqnry+OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707045694; c=relaxed/simple;
	bh=Vb3YmF683066tIPoSuDUcl9qbopdPekEaMtsmpdpHsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oR5brHRq+P+7XpuerD4ccO674Pf+zgDoIvjGgpDM3ZGneIAszZ5DK33hWUImB536DSXwzOkWO+O1SbqrLb0um66mA7z3UV25NF2esqnBl/V61VRyAy/ltNLoMQklT+dyKPTr+o83sLPFP81/maBn2Nu5tmOipBxIzDhQT1+plb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=o2N7X+iU; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4TSRsf07MjzDqQx;
	Sun,  4 Feb 2024 11:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1707045686; bh=Vb3YmF683066tIPoSuDUcl9qbopdPekEaMtsmpdpHsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o2N7X+iU499azt0/4WdoUiz0OneM3eANP3GSZW+PdMWUoM2dOgJwJCj1s6GCufrJc
	 tsOtvmRttNDhWvnaUYxXePrE5iH2J/KF/cpRSdYm7VlhOD+TayX6g8ccu8bCuH+mme
	 JR+Fhl08DP2R0PCAIM39iBJHAcQ/NuZZHWiSUlpE=
X-Riseup-User-ID: F3B69E510B5B8F6ACC69F1E225E5734AF332A64007D9BE214E89A2D8B174F445
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4TSRsV2pvdzJntZ;
	Sun,  4 Feb 2024 11:21:18 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sandy Huang <hjc@rock-chips.com>, Mark Yao <markyao0591@gmail.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Segfault <awarnecke002@hotmail.com>, Arnaud Ferraris <aferraris@debian.org>,
 Ondrej Jirman <megi@xff.cz>, Manuel Traut <manut@mecka.net>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, Manuel Traut <manut@mecka.net>
Subject:
 Re: [PATCH v4 4/4] arm64: dts: rockchip: Add devicetree for Pine64 PineTab2
Date: Sun, 04 Feb 2024 11:21:05 +0000
Message-ID: <2724385.mvXUDI8C0e@melttower>
In-Reply-To: <20240127-pinetab2-v4-4-37aab1c39194@mecka.net>
References:
 <20240127-pinetab2-v4-0-37aab1c39194@mecka.net>
 <20240127-pinetab2-v4-4-37aab1c39194@mecka.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Tested-by: Dang Huynh <danct12@riseup.net>

On Saturday, January 27, 2024 9:48:45 AM UTC Manuel Traut wrote:
> This includes support for both the v0.1 units that were sent to developers
> and the v2.0 units from production.



