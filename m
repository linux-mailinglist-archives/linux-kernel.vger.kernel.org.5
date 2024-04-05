Return-Path: <linux-kernel+bounces-132630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A62899776
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04981F216B7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C800E146D59;
	Fri,  5 Apr 2024 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LwKM9jOc"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6A6144303;
	Fri,  5 Apr 2024 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712304156; cv=none; b=hX9KM14w75N/OfuiTr0K0HqNKpBJN+7UAA+3AaWi1wW9iXXj2mB+IbhAMO2FoZG4vgi+lyQW+4ygr7J3cfQF3jnI0B1y3o5d1KSgHUny5wo8vz7KI4IpEXEo++mh1LuMNSCp7ipA/64LlZ6l6WQ2MZIaZg2cqvDjkOqHxOmziiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712304156; c=relaxed/simple;
	bh=BIJJgcRPxOpdBOEXKKQxyUXL5a66OYCr71+nyRJdHFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+bT0F0Rnk+1t9dKbZJXXroTY/N91XslP7fw3U5kESj17ivP2h3q7JXaD1h16Mmi+u14lU81eDlGTIdn6jhaqIB3T9ZTRIWT3nnRLo7gfYIwRCljeVoYvqr9LsaW/cOvzBxhTYR3LlONpdwgFhG3lruRcfx1KuOsthja++lHWa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LwKM9jOc; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712304153;
	bh=BIJJgcRPxOpdBOEXKKQxyUXL5a66OYCr71+nyRJdHFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LwKM9jOcy1Roo/sCfot9ELPKgmvolRaeCN2gfOZl0NyPLHqLR3482d0j99EitCR5k
	 oPOtRBhlup8UW+g35dgqXQnhNA0hObLqXoHtkxJVPouVbLIAaUMckLJQOk4MhlVcNA
	 LqPaW21xljHfZZ7A36SXEGqPx6qwBOHgi8qK2LcMRcIOP6ZJ01FLbeG3kVC2wikEEG
	 y07GthI5oxFe0kpDPxKYqfBrO6pjZSOfn6+EDgDDii8aFXFDUygev8avN5jFs69oF6
	 QHVtHqB8XdQ+umltX2au62D/14B8I79OEHWBhJq81wSqxIdvOKY6dO9xh14qnFJh0S
	 8c+NzSqfyTvcw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0C067378212D;
	Fri,  5 Apr 2024 08:02:31 +0000 (UTC)
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
Subject: Re: (subset) [PATCH 1/2] dt-bindings: usb: mtk-xhci: add compatible for MT7988
Date: Fri,  5 Apr 2024 10:02:25 +0200
Message-ID: <171230395357.52952.4394849084208817868.b4-ty@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240213130044.1976-1-zajec5@gmail.com>
References: <20240213130044.1976-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 13 Feb 2024 14:00:43 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> MT7988 SoC contains two on-SoC XHCI controllers. Add proper binding.
> 
> 

Applied to v6.9-next/dts64, thanks!

[2/2] arm64: dts: mediatek: mt7988: add XHCI controllers
      commit: 4ee20d528b0487f879f789e010fe2269bc1b2f71

Cheers,
Angelo


