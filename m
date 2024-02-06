Return-Path: <linux-kernel+bounces-54844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE13A84B462
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16C91C22FCA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC7E12EBED;
	Tue,  6 Feb 2024 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uUwKGVVY"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED14212BF2D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707220830; cv=none; b=uokVx23WZVkIQee0stpYGZYA87e6BeEkqwf5m9kuaIihy4Pre1bF/JQ7CzN7aBV8wV6YlnalePhEXdNi4X6pyHLhEgBMiUE0uDd+GICXVWypQQwoYPYHDMR4PpkdjaSPPtTwBnWKfUgFDahH61wBrRaohcKNWQpWRLvb2Q52tWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707220830; c=relaxed/simple;
	bh=zHzTftf7qljyFyamE3gPK65Zs/n2+lrZ0S7UePOD9lA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQp4xFCYXLS/A5xCW/zn/9rRJESqdAvjuAr1t3N559dtb4FJY20Fy71heFFWinblLY2k/3f0bfG6b+SF7v87orBhZIa2vL7l/xoIkMqObhV1erYPGk08lAde0RTcwj/MmP4Clsn6N6QmGB17NPhJgRZOqpsp2eYCFoHLjWptK1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uUwKGVVY; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6869233d472so28626316d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 04:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707220828; x=1707825628; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VYcLq+0GybZqiLelEzr2Y9hS+F3sRASXDSVWvTM+L0U=;
        b=uUwKGVVYrBChUZfjOXBJuiPNkZpMJAMaHB5s+riSgawFAx5YgeSAV9bxi008vjymw7
         SY1ueT+NftJoBeHY1kAT/yhKQz+BvVgmVgwdIYTtIHbhjbUwnEOrDepawx27cbWJDXpX
         N1fk+QmH4cAfVv+1H+hVzcaPvMl5ss/iW+pAf9DT2d0yjTF3Fs5MHSNJyIC4tbvN3EFc
         qGs6sCr6xLv0H5S35KDImW5YH+mReEXAfT9U3OrJqH0PXMDuhuwnu/wSrZGhpWoFw60M
         FnaCLZYX/qrue2rzWRE4fimr6Gry+btpmQWq9+vvviZsATA/kUVOlcs34hg5cAizECw1
         JXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707220828; x=1707825628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VYcLq+0GybZqiLelEzr2Y9hS+F3sRASXDSVWvTM+L0U=;
        b=itdGy8cB0WCeHhSt4odujtMnCXDG7P9RnUDTZiEvWCx31JfIsPspslw0/0U3jmXGxa
         fkvQUFz3ooPDpwU+9nl2O8wytwEGMVjoQVmV6EigMY1NrA6JnWV9JUsnx/75aB5jhPlb
         cevdHsvj8IRoK1eF74UYVmrac9uCV0s6SUXJA1q4v+eWvjx06joY75Lxtx9todGzVZW0
         RRD3xnS4Eg9v73RcSV+KHmAwXmKHuEFQBGINaiwUlV8savyt0boAi7AKAbsC1mtz5hnJ
         XFfwb/ddm3u4fmryp516K5yZil22BLcorMTvfmX9fJdOLoIx/3fCdpnTxU5MjlPANbI1
         diKQ==
X-Gm-Message-State: AOJu0YylQwWPXaFidt8lY++Y8s6jDBtLilT5B2M/qnvss+BcVMk2gjqL
	5Q4QMSCsHOnqujBK0loFpkct8oDDVEQebZcnPISa4uATvho260E6bBNwWs2d/p9TG6KxN1a2anz
	jPykapulVZJ+lEX7LMwjgbe95UBd4qxXSp52OJw==
X-Google-Smtp-Source: AGHT+IFV+oUSkiUAp29uvJltm9vvmt4Me3yZxlKDNCTv1Gn65ralsDCsUWdPBGzl8Rj9xoJuSnBOEhj1ISiTbwxIvxQ=
X-Received: by 2002:a05:6214:27e1:b0:68c:91be:68ea with SMTP id
 jt1-20020a05621427e100b0068c91be68eamr2250014qvb.38.1707220827979; Tue, 06
 Feb 2024 04:00:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206085238.1208256-1-tudor.ambarus@linaro.org>
 <20240206085238.1208256-5-tudor.ambarus@linaro.org> <CADrjBPqaE9Mmbr+zkHOAadr3aLSu3GMjS4nPPd4VZY4s2DTznA@mail.gmail.com>
 <ZcISMLoB2ytoQs/0@finisterre.sirena.org.uk> <833b96e5-348f-4c5c-b157-c57c9a67e0f2@linaro.org>
In-Reply-To: <833b96e5-348f-4c5c-b157-c57c9a67e0f2@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 6 Feb 2024 12:00:16 +0000
Message-ID: <CADrjBPpF_RdB5fe9udOgxLKmdb7D0Gux+n0XxUtneuAawSjoaA@mail.gmail.com>
Subject: Re: [PATCH 4/4] spi: s3c64xx: add support for google,gs101-spi
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, andi.shyti@kernel.org, semen.protsenko@linaro.org, 
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	andre.draszik@linaro.org, kernel-team@android.com, willmcvicker@google.com, 
	robh+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Feb 2024 at 11:19, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
>
>
> On 2/6/24 11:04, Mark Brown wrote:
> > On Tue, Feb 06, 2024 at 10:12:30AM +0000, Peter Griffin wrote:
> >
> >> The patch ordering seems a bit off with this series..I believe it should be
> >> 1) dt-bindings patch (docs first)
> >> 2) Add the use_32bit_io flag / functionality
> >> 3) gs101 support (this patch) that uses the use_32bit_io functionality
> >
> > That's the ordering the series has?  There's a random cleanup patch
> > tacked on the front but that really ought to be separate anyway.
>
> I put the include <linux/types.h> patch first because I considered it a
> fix (driver is using u32) and because I need types.h in patch 3/4. Fixes
> first, then bindings, then driver.
>
> Was I wrong?

No my mistake, sorry for the noise. Gmail showed this driver change as
the first patch after the cover letter but the subject was hidden so
it wasn't obvious it was [4/4]

