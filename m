Return-Path: <linux-kernel+bounces-71326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C58E085A38F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 044E71C21349
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086482E647;
	Mon, 19 Feb 2024 12:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lDzM2UQC"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A8C3306B;
	Mon, 19 Feb 2024 12:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708346182; cv=none; b=IA6RRt7vMQEW2yTMvqr0MfiYH2d5Uyu9lXfYlVVaTzpITpnpPeZUNevnLRWhyK35ZWSxQSbpS12djlHkwgiw40gkQksLfxoo8V/QG9rGm1gHHwET0C/HekK+JCZMW/3thROtap5btaShqqAgOPuZppNRQEL0PcjBISeXu8N1nQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708346182; c=relaxed/simple;
	bh=Z+VCUj+P51+feGqkafHO97lvAdT97kUE6BEl9CA8Xe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gz5wHVB+ZQL8ZSBm4+AC7QKyZt1u274dWCRZ299lFFehlJmrosZjiJtnV3kH34bQilMIVOWe3aL1CZ9g2jUs9pEVtdAl44Lf4KDBEk3Y2dLhH2qx/wdovCfFKLvfr5/dN3kbxSd8+BVjvvje8rzCl8y145W5HjBsKOZJAOus4Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lDzM2UQC; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708346179;
	bh=Z+VCUj+P51+feGqkafHO97lvAdT97kUE6BEl9CA8Xe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lDzM2UQCSH6Ufq0AHo74hyY0MFzQA7epV1lt440ufl8Vip3qViDWLHImekeeW03PN
	 TijyF6ZxLxrzvQWmCZS49OJ8oMCppaH0EdBjGtGmilFOphp5GK72v+5NVDFqhUOgjn
	 9cXgM6sOBcO5EG7ITbKuyc+fdWGyfN1+rzoU/UHa6xs5h+01HdpufXRsLpkQ7JSQcT
	 8R/nPGiTVh6THJJOtxTSA3sAhHITzlkAFpIeqjlEWCw1DsWuLO/ygLY7DgFRZLSLx1
	 iN1NyvBPKD374LG5z5+qUD605z+oFMcRZ6sdERFQFu3D8ycY7uu6ZeReok6F9CIQQ4
	 HYsVddxq+7Tsw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7478937820C1;
	Mon, 19 Feb 2024 12:36:18 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Hsin-Te Yuan <yuanhsinte@google.com>
Subject: Re: [PATCH v3] arm64: dts: mt8195-cherry-tomato: change watchdog reset boot flow
Date: Mon, 19 Feb 2024 13:36:14 +0100
Message-ID: <170834614185.140678.1878504560854372421.b4-ty@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124-send-upstream-v3-1-5097c9862a73@chromium.org>
References: <20240124-send-upstream-v3-1-5097c9862a73@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 24 Jan 2024 07:51:57 +0000, Hsin-Te Yuan wrote:
> The external output reset signal was originally disabled and sent from
> firmware. However, an unfixed bug in the firmware on tomato prevents
> the signal from being sent, causing the device to fail to boot. To fix
> this, enable external output reset signal to allow the device to reboot
> normally.
> 
> 
> [...]

Applied to v6.8-next/dts64, thanks!

[1/1] arm64: dts: mt8195-cherry-tomato: change watchdog reset boot flow
      https://git.kernel.org/mediatek/c/ef569d5d

Cheers,
Angelo


