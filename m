Return-Path: <linux-kernel+bounces-166681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 162D48B9E18
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93671F24B35
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC1715DBA2;
	Thu,  2 May 2024 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wnyF615A"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653D515CD78
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714665760; cv=none; b=q9eGutm3nTGdiAj++LoevbdJFat4qGdnPEStsOxWH1cBldH64nX5w/yRI4BAMLxv37udBk4L4a5XiD3Vxiqukqxp+AT7/5dm9d6t8xyTitplsGUedOAbW0iaeGIrw4sMRLkShuj9/ca9TkriKXmtNFedjlS5qUUPYLN5yYK4BpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714665760; c=relaxed/simple;
	bh=4zrGVyY7oeyk5looNBSKhoeZb0nLxyxkhsaMw8NDxgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqp4W1cXb4BlwAk8Gcidzf25I41Af5+k9L4GLLNapxIMS1/m9QTOdi3m5tH5AOr9PJ/14T9N1E9uR+fkzmiWpdzRS57qlt/6y1JxGMlbS+tIXmRgixsuYkgdOfVlfjjmlbowV7A1zY03u/B9utpwOy6/ynzMyh5f7fWppp6XI3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wnyF615A; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-de5b1e6beceso7781327276.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 09:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714665758; x=1715270558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zrGVyY7oeyk5looNBSKhoeZb0nLxyxkhsaMw8NDxgQ=;
        b=wnyF615A8dpEuTB1Th1zxN1zoh990PcFbD24yYWQQ3M38iJiLu4vRfI3I1ud7sVCuh
         hBkGSLykL7LIOcsC8dFtFwNOgKgYZuHizZKElUe3ZFRQRNKuZTY1LkoECf5IqpdpPNsA
         zFEpVsW2aRRvHIi6W+uwvji3je4vaDcFoSTLN2hj6gpnJVhVgjHnqAlRL3wNJqgHjVQP
         uT46ehKWtFxNG2og+89w6Z6wVyEXpbNRbBgvsFKO2NlhOPycJ+OXQnMNo7wWWC5qNvS/
         hJWJZzQ997P2aNwCbNg+0SDSvja8gD84/RYBpMfpfX5cOcarGBG4qhrtTCAwAQxaFkyW
         KACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714665758; x=1715270558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4zrGVyY7oeyk5looNBSKhoeZb0nLxyxkhsaMw8NDxgQ=;
        b=hMstOrHejdEANHy/RaePVfFJOYlExupQ7QVCfRtHfBENtC7r/Cq50zGcymalXlzDIB
         LHZI3AAdAu+d7gVsq9UTWh6MONW6jxwS/IJDj9uVSlFbvZ86k9tZmkXb/U3cHKa1I9C4
         xRriHavzi2yFJDRbjWg4PKvyQJxjz6XQ+VT/u9Z5M27ZBG7/pwEXJSjUh9DL1qSV72gI
         qHptlgEEpUSU7i65h+by0E19pKMiFttQZxZqPSj2wucGlv5jGab+p3R4FIT0wPBE3pQx
         HjP8E5TwIuPaxrfCpO8EgfqbD1MsRfqQypvt+BJxVkGwJQKEZjzU43XQDnGRinMc9/cr
         na8w==
X-Forwarded-Encrypted: i=1; AJvYcCUqVBQgn4S8uvqfFZ1SGrWMD2eT7exNqPhCjcGFYbPLKgLPe2skJCxFHuahzUCE55ThMWYQwMrPZlOb6baISDCbjU0BerERSGbo+6sT
X-Gm-Message-State: AOJu0Yz7P5CDTy7NFFNALadY93vv1Zn7JXtGkEu6W/kYzoKhBXo7l9zc
	CQP0jukDAM3YchmZBdb9f8N9IEVH2qVfKZo90r+PBWAAxdF9oxHWxNXI/LE/n/jLnWWB1wtW7bh
	xtIyBmsqYKK/TnUL6tPyZuLNNHk+Z8aDrWcrl
X-Google-Smtp-Source: AGHT+IHVNHQC5SLyOth+ELmjn3kDXf0QPueuFFd/3ftxdlJ3rQVGDzpbXKZBydBreAIgG64UsDFz3vBJjSuJ+Lyf7Tk=
X-Received: by 2002:a5b:70f:0:b0:de6:1a10:11c0 with SMTP id
 g15-20020a5b070f000000b00de61a1011c0mr301803ybq.44.1714665755811; Thu, 02 May
 2024 09:02:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501201319.586289-1-tjmercier@google.com> <ZjMfl2G377qexhi-@infradead.org>
 <b4b11ebb-4e42-402c-8e9e-48eb57ef34d5@arm.com>
In-Reply-To: <b4b11ebb-4e42-402c-8e9e-48eb57ef34d5@arm.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 2 May 2024 09:02:23 -0700
Message-ID: <CABdmKX1+MyJCwgbpYaZn5uLdqgfJbv_5iCX_3cmpL1UaqeggEA@mail.gmail.com>
Subject: Re: [PATCH] iommu/dma: Respect SWIOTLB force_bounce
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	isaacmanjarres@google.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 5:50=E2=80=AFAM Robin Murphy <robin.murphy@arm.com> =
wrote:
>
> On 02/05/2024 6:07 am, Christoph Hellwig wrote:
> > On Wed, May 01, 2024 at 08:13:18PM +0000, T.J. Mercier wrote:
> >> iommu_dma_map_page and iommu_dma_map_sg conditionally use SWIOTLB, but
> >> checking if force_bounce is set for the device is not part of that
> >> condition. Check if devices have requested to force SWIOTLB use as par=
t
> >> of deciding to take the existing SWIOTLB paths.
> >
> > This fails to explain why you'd want this somewhat surprising behavior,
> > and why you consider it a bug fix.
>
> Indeed, it's rather intentional that the "swiotlb=3Dforce" argument
> doesn't affect iommu-dma, since that's primarily for weeding out drivers
> making dodgy assumptions about DMA addresses, and iommu-dma is
> inherently even better at that already.
>
> Beyond that I think this change also seems likely to interact badly with
> CC_ATTR_GUEST_MEM_ENCRYPT on x86, where we invoke the SWIOTLB_FORCE flag
> for dma-direct, but expect that an IOMMU can provide a decrypted view
> in-place, thus bouncing in that path would be unnecessarily detrimental.
>
> Thanks,
> Robin.

I encountered this while testing a change to DMA direct which makes
sure that sg_dma_mark_swiotlb is called there like it is here. (Right
now the SG_DMA_SWIOTLB flag is set only if dma_map_sgtable takes the
IOMMU path, but not if SWIOTLB is used on the direct path.) While I
agree IOMMU + force_bounce is an unusual config, I found it equally
surprising that swiotlb=3Dforce wasn't doing what is advertised, or even
giving a warning/error. Since the iommu-dma code is already set up for
conditionally bouncing through SWIOTLB, it looked straightforward to
give what's asked for in the case of swiotlb=3Dforce. If it's
intentional that SWIOTLB options don't affect IOMMU code, then should
we just warn about it here when it's ignored? The presence of a
warning like that would also be a suggestion of, "you probably don't
actually want what you're asking for with this configuration you've
specified".

Thanks,
T.J.

