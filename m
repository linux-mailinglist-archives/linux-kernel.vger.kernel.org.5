Return-Path: <linux-kernel+bounces-64940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A528544E8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2DB28241D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E85F125A2;
	Wed, 14 Feb 2024 09:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bsPs3WFb"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B90812E45;
	Wed, 14 Feb 2024 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902360; cv=none; b=UVdeY0WgzIhF3w0mhtUFIhrzXkz71yyQQ5vutZ6+BzONYjt/dJY5r7TBFJlzrZU7xQ5o2syYg8SpquoC6AmZGyCmg25VDzcQhSgcILOS/uXYr7f4b94/F9Sh+BhNlnrv74IrehSfa+Dj8BBebzWYcCvijIHVqPKHUxorjQ3FuiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902360; c=relaxed/simple;
	bh=eopsYwS3LqpqJFXQ6Zuagfea0xeoUuIZuhfwfg1L0A0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b1NUWCCWA4dR0ayTzEn6dCZMxE90w3LHRE6kJin5M+nyoFRbmHxUZjpyIYfUOz0ccqS3NPZAZHhZdI0WQoVJ5c8dXk5v9NAcmjQfbxGANH1pJG+SqL2KcaAeZW9Jnfhpx6dM/ye16lrRgWUJ1ktJgyw9uqoasSu+ubGBo9Tvi6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bsPs3WFb; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707902357;
	bh=eopsYwS3LqpqJFXQ6Zuagfea0xeoUuIZuhfwfg1L0A0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bsPs3WFbo+AGEVfYLhDzM4a+lV/fZYEyUxr5cFSD07EM0L6ljKbgKTKKScSo8R870
	 dI8iri9GayobJEa2LMELQzotfdkSy9k8r0/eSKQTVKwG1ygwMuL9G0+7cfORryI2mN
	 ukVrJJ83+KnV/Y+ptTtAZFYBDTPsSSi4RstfCnjDiFhgdLItMirFyQozVriRq5Yw4z
	 HRZub6h+Jge5dYlU6S2Vva5Y92KR9QZGsKkDT/ZTO2BwofIhTIGGyW6rIr/nJwDI/v
	 jziw246t2InYjfXQ5vLJX6ODBgP4Fp1ARPfowjklkKczp07lmgiSOu+kCVAmtNI3TX
	 voWsOgXWMyxzA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C04B33781FEF;
	Wed, 14 Feb 2024 09:19:16 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] arm64: dts: mediatek: replace underscores in node names
Date: Wed, 14 Feb 2024 10:19:12 +0100
Message-ID: <170790234013.477427.13548425234687450683.b4-ty@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213144626.341463-1-krzysztof.kozlowski@linaro.org>
References: <20240213144626.341463-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 13 Feb 2024 15:46:26 +0100, Krzysztof Kozlowski wrote:
> Underscores should not be used in node names (dtc with W=2 warns about
> them), so replace them with hyphens.
> 
> 

Applied to v6.8-next/dts64, thanks!

[1/1] arm64: dts: mediatek: replace underscores in node names
      https://git.kernel.org/mediatek/c/e630c7b0

Cheers,
Angelo


