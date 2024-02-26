Return-Path: <linux-kernel+bounces-81741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D0F867994
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8171C23862
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F0D1339A9;
	Mon, 26 Feb 2024 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IIKbD6Gp"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A0912D76F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708959258; cv=none; b=oelXXT0Yz9bfsrjpqfOzQ/ZTh+oDK291TeLloWqexfg4C5jwKpzlkDgFw4qB6QZGOFqNyvpbC0LP/qkqc3mwFLp6gjJ/djz2NjHoWEEk8jEy1cEBQ2DYwMZaem2SNchCGlprekekkdyKLEb5N3hrVra1tNyGG90joTk+VjdCVes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708959258; c=relaxed/simple;
	bh=+/3x0KqyHOPTRYlw4GtUE9dLmWgAf0LHJfu8+hfKIZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIcc4IOxYVZwqjh2WXoML1ghF+a7zbZOMSDlB5QnvmvTeMRxXVdfzPHhOlS/p1fIiXQ4rhZOKIy9ayxH2HcePk5EhDBQfPs44YAx3BbEwn3hf21BGtSBVAq5hMfMb+DnncFBPe3OVK+EqyFcSShU7EmYl6TNlAct7nRsfDY+66s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IIKbD6Gp; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68fff2b2984so7265586d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 06:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1708959255; x=1709564055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PhKx5RN8BGOt7qaJdVuPeh1gBcvVzdbEvZwAOUpborE=;
        b=IIKbD6Gpk6tLnl6A2U/g/Y8jzffN05jPhtiTP3e4dxaHKPNjxnSuxw/pfZXMO97ybH
         rcSB/CzJg5DDG/htzgxnjDEEBaxLgnMLWBEvAdEBrI+DYdfUabdS695WV3Wlqm4SUAoL
         8Oajb2NQbY7hNcXfm844kdsWP3WdGSQUP+qc/+Yi/7GHl+/d5/ujtgRGx8wpSghBxp6E
         yZEOb0nSNLOrcAXX08iYED+lpVJ6K/hDL5kzG2EMUtx3L24bg33YR9q5RuXmHsE5ckmk
         7ORbU74eu/lyqYWBDbObYLkPrkrwHb5bbV4lmqSV1x2r7iIuZjMQi/FQeqDMOflHafCx
         E4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708959255; x=1709564055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhKx5RN8BGOt7qaJdVuPeh1gBcvVzdbEvZwAOUpborE=;
        b=i22huZHfY2g0SPLczzH8f1b5/cbpbAP6NhqqMg17xMMw0Okn4+wqWEZdS0BdPyVsq8
         NT8mcmLw4NmLhZv/6VhwISrORupnbLNhn/s3WbkZl0oDvvNuQfdCafALoFmpDSdeh4eG
         0V+fZ/o3CzWQbCcWxjacfh9P19BBsO1Mk5J6f5xX0kHottzDymq8l8uUiH06/HQh8gNX
         +P4VLhgMS/tv+bRn24szYpxdgGqrS7oZdeeGkMZG1XqSWUwc042wGlnppBKJjS8ofWii
         5B8cxGBMGkpFqVs0300PungWDalozoAa4DMEEroNV57qTuBNSfpqNnL6KGhrgmBZHntV
         G5RA==
X-Forwarded-Encrypted: i=1; AJvYcCULG7uNjTU3vBX4cGf4Sj97JGkszxm2/vVGylApYJL00JoDVfokN9Cra9kRWFDyNqmV1ajrxYnLyRPmMYYqhYV2SsZFiQtRBsZx+QtH
X-Gm-Message-State: AOJu0Yx9KcrQHe/cB2ZClpe8bUFINX3yYhHxo3NAb6s0o0s5sXIiOB/V
	3ViJr8Ko1ffMshEP/Ilf5q3lNHlu2OPqfZuZWbFFJgscHBhG69MXwLbakeszIuE=
X-Google-Smtp-Source: AGHT+IFG8IA1MhzDu5mBfgrDa5+jfgySxX44NFn5JkVLCjSLzcXdc4sTcq8nfBI/KeHX+xqovKkBfg==
X-Received: by 2002:ad4:4ead:0:b0:690:1829:55c4 with SMTP id ed13-20020ad44ead000000b00690182955c4mr751409qvb.22.1708959255274;
        Mon, 26 Feb 2024 06:54:15 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id mf2-20020a0562145d8200b0068fef2bc3a6sm2774652qvb.135.2024.02.26.06.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 06:54:14 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1recMw-00HS9Y-0p;
	Mon, 26 Feb 2024 10:54:14 -0400
Date: Mon, 26 Feb 2024 10:54:14 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Antonios Motakis <a.motakis@virtualopensystems.com>,
	Eric Auger <eric.auger@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio: amba: Rename pl330_ids[] to vfio_amba_ids[]
Message-ID: <20240226145414.GC3220539@ziepe.ca>
References: <1d1b873b59b208547439225aee1f24d6f2512a1f.1708945194.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d1b873b59b208547439225aee1f24d6f2512a1f.1708945194.git.geert+renesas@glider.be>

On Mon, Feb 26, 2024 at 12:09:26PM +0100, Geert Uytterhoeven wrote:
> Obviously drivers/vfio/platform/vfio_amba.c started its life as a
> simplified copy of drivers/dma/pl330.c, but not all variable names were
> updated.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/vfio/platform/vfio_amba.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

