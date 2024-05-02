Return-Path: <linux-kernel+bounces-166095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF4E8B9627
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97409282EA5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E974B3B2BD;
	Thu,  2 May 2024 08:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="brYtJ8R6"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BFF36134
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 08:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637383; cv=none; b=sMwnaYKyaENmnbNv17mshxdhFspF5B8s7wegWmxubl+p4EEA1IVY7ABdR9xP4F0wGTLsBjOxxHRV/4w9STsJlTy2gkgiH0pfRcZ23bmsN3ZQZrkAJscFVhwFQjcIEQozthCB+biv1FjVITOkxNW2Y24C+FLALGjNwOVmS8andiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637383; c=relaxed/simple;
	bh=arWodmRQt8BTMsudQ7mKMBFSFOLZxXEvmY+VBtmcYWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKCraMBS+Co+5q7VI8svvOk2JJOd7xCDW/H2AUCDVtU2JgJ4Rv4JkWR9LsUUoR7ghFFCHbyWszhDbfcUsErWZuv9SsPPsOYlMhbzyBKj/T+YGF9YvGYBQw+OlLO8G5BG/DVWfSZUBqytWCKILcghl9JUNeR0uXfV1jrSyyhbv44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=brYtJ8R6; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-de45dba15feso9066238276.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 01:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714637380; x=1715242180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arWodmRQt8BTMsudQ7mKMBFSFOLZxXEvmY+VBtmcYWQ=;
        b=brYtJ8R6Y6jBSj+dRQfmc8DLR2HfAMjDOhJXDBvfTJSRN4ne+eB6IDymBOHrMSUQ23
         fbbq1+kHmBvqejh/jB7cDm1hppkx7OkivUddvXdHWlemokGSsSzEiyQ1419rQhL3P2y5
         d4Z4Y35vrFC3XIPhWEtJuCu49BkI6n9OOZjMWyJCWz3QmHV70A6Jt8hKzSnuxs0FQdYB
         Y54Dle0G9BQO3opm0geMIo9Xr2Ey1qOSIEyzi9j9tiOeb6gaNhwRG1dDTd5ceDUvpf+2
         Gyt3B3ldoSeRS9vlEd+WJRiQFOo5+/d3qmXXzO0Sm74yKnOuPBlW9egWRPzrJaTykq9y
         EGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714637380; x=1715242180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=arWodmRQt8BTMsudQ7mKMBFSFOLZxXEvmY+VBtmcYWQ=;
        b=joOcUjuz+hasXgPeKoIVTu33Du/Tnw/coXCnhD0oFPkn0sKf2skGsg095I/WrwWrve
         yq6cuzzlbHRBj+jOa/nGTlhitg4c2CUyRraCmgs06czcluXD/d/4gU7mJy2YlTfr3s3g
         WYepuejh7VrmvLV0vegM/tbpUQCvtYmd+O4g3XxD1GHe+6BNucWFEkUnpm/iGhMWERj4
         lybQv3EehUldtDxlMytKdR29CroO75kHQOGvs9SYuyn9bx5g7vF9Iixx04LkkxR0gTex
         f+09lQVhR6CWSyJKleLQl3dgnBNSi9b+rfpxqki9qbsjXtKPQRTn5+bAC+d2U9vK/8Ew
         ZoSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpdTV4QWQj9AvvURMkYHMhl1nheJVoKieI5HEyR0LUHYB3achK61BORoAnmULgtoSKkZBcyM/roIr06gPzkPHHtllvV9SOO+0xd7R6
X-Gm-Message-State: AOJu0YxvilAQOKmVppS2+LtuNhSEPu9bXIw9NYJtir/FO0BbiW+3MdKZ
	XK3GhAKAug+uKwhAPyPy3scdtWfBOP+l6NFuUuwvBDrq/OWSh41zr2WUHGaP8cMDgfbVLkhAXPo
	WZmOoPhQC2lqSkB5OxRGcSSYDLotSTNcmo9Gtsw==
X-Google-Smtp-Source: AGHT+IHKrpohsKXBOozgDWcLAULi3t9vpnfK/zzXTOHgpMX2dpa+QwhZN6Pr7wodgIcBDkNJ2eKnp1WLdJlSgtpWOLo=
X-Received: by 2002:a5b:d0a:0:b0:de1:1b21:4f8 with SMTP id y10-20020a5b0d0a000000b00de11b2104f8mr4629460ybp.62.1714637380290;
 Thu, 02 May 2024 01:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417110334.2671228-1-andriy.shevchenko@linux.intel.com> <20240417110334.2671228-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240417110334.2671228-5-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 2 May 2024 10:09:29 +0200
Message-ID: <CACRpkdYf_qNFkmAo-C5w-sef_mOc62w8nj1kv61frK05yrF+eg@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] spi: pxa2xx: Remove outdated documentation
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 1:04=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The documentation is referring to the legacy enumeration of the SPI
> host controllers and target devices. It has nothing to do with the
> modern way, which is the only supported in kernel right now. Hence,
> remove outdated documentation file.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

