Return-Path: <linux-kernel+bounces-48908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B4B846318
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2787CB22BA2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B81F3FB19;
	Thu,  1 Feb 2024 22:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RXSBfRKM"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2B63FE36
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 22:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706824996; cv=none; b=R+26EUUeTpII9kcSeURLMhawUpWoOkQePuNOuSuLQBdz3YKiZ9SkX9+05vYILLWFVnIjqf8hSt/FHPHeD0jBNFd4Jzd7GZ7smwEHtQ9btvrF4HxPW/xRVfjjpdTupH/y2wQye8Qzu8jkz8M0q2H84vlhyOplDxGgXBK94jLBRrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706824996; c=relaxed/simple;
	bh=/LHHNxpRNN+aCgLsWTGmEOOYGm9vuH7c1Ayn4+O4xdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSnNqyud9zPV9E0fee2ZD27OLiw9WbaupMQp0mKrCb2UrfnwXuKu8GBtgD9A4VnfvMNFubSidxsH/9eylWFKCpqFNuH3ulIBHIzDKKRH919zp0wNys0d9qLNu01GiLGb2kmaL2Rjd/wz3mx6uT/mo+StlHBJFFeV6o575D6xo00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RXSBfRKM; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d96c4c93e3so548395ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 14:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1706824994; x=1707429794; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fLTCeqqs7LS1BVCIczTAghwYgdDv2RsofcZvmLSUpMU=;
        b=RXSBfRKMt+T7o7SltaQLbFSGUsw+HynjxxoQFPYUMoI7HiHipDjQKZOBKkNeqydL6S
         DCMf042U9nlsHmDPwHNDZqYoFGM0+5nllI7+QI9zdyG+6XCOZGxkd1Y45vnkJiWHanBv
         gI3DTBSjALB1Rr/i/j/Pnpsm1Z+K0yDG7U66E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706824994; x=1707429794;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fLTCeqqs7LS1BVCIczTAghwYgdDv2RsofcZvmLSUpMU=;
        b=q1H+2IgjFsa/kTTPvZO+qqK/5nSYfeXnBoLKXm3jle0uhwLY4EEeCrYD/gIFlMdpsr
         lxUr/gA/8UecU2kZ2d0ikmtbcUq0jKfdU30XwyPwp794NZVyrUqZ7OoHR8I+QQ3EfYiW
         k+1zPOXTkF8KNuLDfxXCQiX0NpgihgGWi+4lCTTzqXsT3s1NxmAAY81nm950phUyR7SN
         abSr88TwNfCIUj9wPOhBUzbtzxPe2zwBg2ltVdB3sdWIJsinGRJ+nBgHbmzVW8Qx+zB3
         5bUy7twmBLe0upmO95fFkGIrk7hf9fe8qJ7yNpvCs/9znyof8KHVy0bzh26VqpryNM5b
         2BYg==
X-Gm-Message-State: AOJu0YxgmvRHwWX8zVbgkDn8qAphf1ncfE6ReIh/nYL3xH0JMJjjyaFA
	9f/xqfQVCaDvTifMyhIqKvkd3Wl9EcByCY1h12FXg6tR2NM7GyRGesz4gxLLMtiPwPmq0P8GH8n
	hAAtAYlJXRC0ZyOojOd/HgCgB7iCZ8s9yGGQZ
X-Google-Smtp-Source: AGHT+IHzp2iFZWQZJSAO8Nbx7x3Phbo6qDk0kUZjKrjruGVs3zVDkcrukNb6evmHFZcstHgIheK2ue3bCxR47ylrMVE=
X-Received: by 2002:a17:90b:3911:b0:296:3de3:2b1d with SMTP id
 ob17-20020a17090b391100b002963de32b1dmr46804pjb.4.1706824994371; Thu, 01 Feb
 2024 14:03:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119215231.758844-1-mmayer@broadcom.com> <20240119215231.758844-3-mmayer@broadcom.com>
 <279dab82-aff6-4d1d-b414-57910433e36c@linaro.org>
In-Reply-To: <279dab82-aff6-4d1d-b414-57910433e36c@linaro.org>
From: Markus Mayer <mmayer@broadcom.com>
Date: Thu, 1 Feb 2024 14:03:03 -0800
Message-ID: <CAGt4E5uucNbsyeBeTesQ9pJj+9gtOut7MaoOBhqVfVJL-Hjq1A@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: memory: add two chip-specific
 compatible string
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Rob Herring <robh+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, 
	Device Tree Mailing List <devicetree@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 13:23, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 19/01/2024 22:52, Markus Mayer wrote:
> > Add brcm,bcm7278-dpfe-cpu and brcm,bcm7211-dpfe-cpu to the list of
> > acceptable compatible strings.
> >
> > Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> > ---
> >  .../devicetree/bindings/memory-controllers/brcm,dpfe-cpu.yaml   | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.yaml b/Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.yaml
> > index e2b990e4a792..3f00bc2fd3ec 100644
> > --- a/Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.yaml
> > +++ b/Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.yaml
> > @@ -16,6 +16,8 @@ properties:
> >        - enum:
> >            - brcm,bcm7271-dpfe-cpu
> >            - brcm,bcm7268-dpfe-cpu
> > +          - brcm,bcm7278-dpfe-cpu
> > +          - brcm,bcm7211-dpfe-cpu
>
> Let's not make it more random than it already is. Feel free to re-order
> the two entries to have alphabetical order and then place new entries in
> proper places.

Will do.

> Best regards,
> Krzysztof

