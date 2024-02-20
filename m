Return-Path: <linux-kernel+bounces-73379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0188E85C1AD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF05F287109
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1927641C;
	Tue, 20 Feb 2024 16:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="Dwn4aPsb"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1FB2E84E;
	Tue, 20 Feb 2024 16:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708447698; cv=none; b=XdDSCjusEwDzuHwcctb7tM7wME4jfPEGDNQh7ydHZbcpLyUCqzdNTtyXxhzrEt6B3o8b+LCnp1BJ3SkCYEEpZtEKpkocxnYPSBiUFV3zxZddlsB0Zs3Mdbt9wU11he6HOHizkN93ZE/FRgbRjeWudMP09Q9jsqpekS4NgBIfevU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708447698; c=relaxed/simple;
	bh=5ug8sqZ+EHeY/Ph1ShtPeGnxemtNhiuWDUEotTR3KbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hj/V0lP/1HVGFXzoYd2FbY7/u211NuneViRAkEc/a2guzaU7UQ+lNlmOwImCaAfCYleSWqW1MTRB14tZ6zXp1Icy+UQele2j6K21CBQmrpL7MrrKS5zo4NX+OFk6sA+iLP3AGzaAAI/H5CIfyfnTIm607GS4D9A5qIoGQBvBtA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=Dwn4aPsb; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1708447695; bh=5ug8sqZ+EHeY/Ph1ShtPeGnxemtNhiuWDUEotTR3KbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dwn4aPsbZsQRT1WJnxBrccDOUgprF5FMg2ktiHYYTN8QG8nxZv1bv49yD4ztyBEnh
	 5fMVkzfktOXRlelEl8s1KXR90QZzCXsZc+n6QbEZdb3QAqPmAy0xn5GJDLqyNnw9Ro
	 3e5CAMNm6IG9zCX8iVjfeLUCWA1PIzdH4DuCgKqQ=
From: Luca Weiss <luca@z3ntu.xyz>
To: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Daniel Thompson <daniel.thompson@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH RESEND 0/4] Ensure all backlight drivers zero the properties
 structure
Date: Tue, 20 Feb 2024 17:48:14 +0100
Message-ID: <2007720.tdWV9SEqCh@g550jk>
In-Reply-To: <20240220153532.76613-1-daniel.thompson@linaro.org>
References: <20240220153532.76613-1-daniel.thompson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 20. Februar 2024 16:35:23 CET Daniel Thompson wrote:
> [Sorry for the RESEND so soon... embarrassingly I got Lee's e-mail
> address wrong the first time!]
> 
> Luca Weiss recently shared a patch to zero the properties structure for
> lm3630a... and shortly afterwards I realized I should probably scan for
> a similar class of errors in other drivers.

Thanks for fixing the other drivers! Was definitely a fun one to debug :)

> 
> Results follow in the next four patches (they could all be one patch but
> for the fact there are different Fixes: tags)!
> 
> Daniel Thompson (4):
>   backlight: da9052: Fully initialize backlight_properties during probe
>   backlight: lm3639: Fully initialize backlight_properties during probe
>   backlight: lp8788: Fully initialize backlight_properties during probe
>   backlight: mp3309c: Fully initialize backlight_properties during probe
> 
>  drivers/video/backlight/da9052_bl.c | 1 +
>  drivers/video/backlight/lm3639_bl.c | 1 +
>  drivers/video/backlight/lp8788_bl.c | 1 +
>  drivers/video/backlight/mp3309c.c   | 1 +
>  4 files changed, 4 insertions(+)
> 
> 
> base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
> --
> 2.43.0
> 
> 





