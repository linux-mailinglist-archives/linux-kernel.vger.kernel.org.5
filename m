Return-Path: <linux-kernel+bounces-48906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FCA846314
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C103B287DA1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5293FB19;
	Thu,  1 Feb 2024 22:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PJ8CSMz/"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DD63EA8C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 22:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706824924; cv=none; b=BhR3+C7cI36VVrr2yEvMK4POWU5+MVAGElp7fecr0WC8/pg9d/ErpZzLtg9sTdHQyQFioOZCD6hbvviswY7WEhLIS1y+G7D1djISzIcmoZdhrZnR4PKcBPXO5nucbp5RgYnt/0w48TpFZFubmNo6WQcdLqlcW+aoenofQn8+qb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706824924; c=relaxed/simple;
	bh=S6DpmYrKJpOGFAgtneCrOt+ncWmf0tGol08ByubioAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6uxpcbOXKL+w5wBGXLO1L8BumQqfAGMtRnePlEgkIlZ+b1UV1urGvznDx/hLa60VecS2ENJA2GW6C5iIOASldwU1UNa10AG16gNh0BDeG3kP1+Tded+5c8NaxCbZWwC8R+LGgqN8KCepQFMX7/IN92Ry+9G7R9gPQXleW3up+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PJ8CSMz/; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5a0dc313058so191379a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 14:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1706824922; x=1707429722; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8ppaICaXf3g7Wt71Pc3oHyszUVtZ6Se3vtGBU6vpn9Y=;
        b=PJ8CSMz/xxDqogSZpn5t85QoNuUIdE9p21al4RNAJ9niDxip0fF2Y+t4m8U8Bkbkoe
         nAbX4PZMzFfUclJhbvGjEmQZ1xYjsNOSGSPtUDKS/V2hWKcFLkYs2ZuzQfng4MzosuqV
         UANAUOBE4F4JWhVFGOXjb4HQpTAUbOlKJzAbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706824922; x=1707429722;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ppaICaXf3g7Wt71Pc3oHyszUVtZ6Se3vtGBU6vpn9Y=;
        b=S8GVfNq0ufllr02OgzlifFl4NDSn+gkOx4iG7vA1xFbuG2PlgDXxmhW4nuSP2PnPog
         YVAKhSHcRfh/mR53BVXE77NpN+dqIU0+cgxzseMDSYkAx2hN3yBdNHKhuIhmpM9zbE3i
         nucT0Q9twSXRJXVjaOtZOoUI9GV+gcVeltq01GTu2kick/k9fjbfzkBthpGwsO5uqHjy
         ZK7UyTV4zj2tJC4WNXeiJ/HqxyMCF5RpA3ohTmxCgPL80UcSF2irQGXTlplJdl8SuO0H
         qZhUjhsfw3RqskPeE5k1YlohbDMfexXV8hvg68oj8jy9kXOzUIwcz5rLYkpvXCdnyq85
         t0iQ==
X-Gm-Message-State: AOJu0YxdV2v8ifBvdgkeTeMNFXvy2bcOdj3x6lvI4lSRuhtF953etuCP
	LB2pxbk3E2KMxK5DZVqiQbJPYglGsl1SD8Z6guvVSpJezDkW2P+VgZvtIB1Vc06eZ4envSHfVDV
	HG6pjsAAJCDPZVqz5z3Wi8qXoDcs4CmGuQuCw
X-Google-Smtp-Source: AGHT+IGK7NczUcaboxCiNkef8pw/9OZXamqniEcxc5GJeGDmCBGqmnlJE/0IzKhUGAkYGNJDJenikr0cOUmw9MrwRVs=
X-Received: by 2002:a05:6a20:7d8c:b0:19e:3390:4a42 with SMTP id
 v12-20020a056a207d8c00b0019e33904a42mr4291134pzj.3.1706824922026; Thu, 01 Feb
 2024 14:02:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119215231.758844-1-mmayer@broadcom.com> <20240119215231.758844-2-mmayer@broadcom.com>
 <6d8d5c33-f814-4c06-ae97-7579aec3bb15@linaro.org>
In-Reply-To: <6d8d5c33-f814-4c06-ae97-7579aec3bb15@linaro.org>
From: Markus Mayer <mmayer@broadcom.com>
Date: Thu, 1 Feb 2024 14:01:50 -0800
Message-ID: <CAGt4E5uU1aiS9ZFowYFUYM5ARdzR2sP+FaWErjZ-VbEoui3-0A@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: memory: remove generic compatible
 string brcm,dpfe-cpu
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Rob Herring <robh+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, 
	Device Tree Mailing List <devicetree@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 13:22, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 19/01/2024 22:52, Markus Mayer wrote:
> > The generic compatible string "brcm,dpfe-cpu" is removed from the
> > binding as it does not provide any actual benefit.
> >
> > Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> > ---
> >  .../devicetree/bindings/memory-controllers/brcm,dpfe-cpu.yaml  | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.yaml b/Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.yaml
> > index 08cbdcddfead..e2b990e4a792 100644
> > --- a/Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.yaml
> > +++ b/Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.yaml
> > @@ -16,7 +16,6 @@ properties:
> >        - enum:
> >            - brcm,bcm7271-dpfe-cpu
> >            - brcm,bcm7268-dpfe-cpu
> > -      - const: brcm,dpfe-cpu
>
> We cannot have undocumented compatibles, so I think you wanted to
> deprecate it instead. Also, please extend the reasoning from "any actual
> benefit". Were there any users? Don't they need it?

Absolutely. I'll change it to deprecate the compatible string instead.

As for the reason deprecating it, it was intended as the "standard"
compatible string that everybody would end up using with the
chip-specific one as fallback should a particular chip require a tweak
down the road. That's why it was introduced. But then the business
with the incompatible DPFE APIs started happening, and the plan to use
"brcm,dpfe-cpu" as the "normal" compatible string that everybody could
use was no longer workable.

Does that make sense as the more in-depth explanation for deprecating it?

Regards,
-Markus

