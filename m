Return-Path: <linux-kernel+bounces-49806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BF5846F9C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2531F233B9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FA913E202;
	Fri,  2 Feb 2024 11:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="X8rgu6I2"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05A913DB9E
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 11:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875044; cv=none; b=pHWQTTpyQ62HjTIFL1zMgDWo7oHCemli9QI6vxFE6ACTRMUTTRmuRGUYemdSSB0m4Nx9nunFuMsOuRgmGDMAEhJvNAdWdNPx26M9CVOHS79qiwoKebtL+mSnjUCf4ZS6Yfx6JdKRyFXOcsIy9piG/hCBRAdGTgqdnF1dzxaaHR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875044; c=relaxed/simple;
	bh=A0ZTZ5Fv5G06cPe13glChI/Tnu7WN5JP9QQMn76pliI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRWk8aXicphwuIJIRMVdh2/WAEuh0zIqM0FcSG4irPDXRMNxgKVmF4pXBj6hi71OUOmUcJEPIz4Vld1GUEuk8juI4Wydh/QeqcHaoW8yugL+eM0IbMuea+1eNMO5NtTt4S8rXwUoJiyhX+JGSNg1sLlhP7fu1NhrKsIm7DXTfnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=X8rgu6I2; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-29631796acdso686565a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 03:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1706875041; x=1707479841; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6q90R/XkiuMdf0PYdVgoTLd07p+VuylRmuCDSu77XgU=;
        b=X8rgu6I2x+TiCDHjsmIjWzvCziOj/zvYdCb3MXYsBSK+l4mW0w2SJAZflb9u+yZMz9
         b3BFO+4e9L4DlWacrOzpWtUWcQBlDCsHf7yJYIaOP/Uk2KS32k5irlFYQvBl9IyLIylJ
         KHRj5wm31U57fiQje6GuFVWCz4MW4d9CD8IoviKZcF/vs/gu3YzUWZxfmNMub3SR54fD
         xRcN/NU8EDPAImOpuAmHq7c5W3Yhkx/ZuRn1ljiY5Lb522YYs1JOh1cwLFdjvu6X8Jcz
         +BvQlTtt4lChJHiDFL/d82eQD+jD0YtTclg9yMXY7WOoPikVWXNXkUuu0geC28pEj7Fv
         VgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706875041; x=1707479841;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6q90R/XkiuMdf0PYdVgoTLd07p+VuylRmuCDSu77XgU=;
        b=RHsS2fS++e6jYQz1Y4UZ+1r9GTVexWDTFWLrCS5LNJhbeHKr3QQaohwvA/ITHs/nA5
         ztChqFZ5zRNxMM5NpfPQowWRrBPWQuXyiPt1iP1cJtceGUofv2yJJ0Y8CRYzJN0dTqYN
         mKdPeF6KyT23XKb443po3pVkwoSYY6OrkRHLpjDKG0gz3j0riFn1IrKdcSmL1vZCdPhh
         cOXLfsMzV+pNo8cSi95xT0X1jyfClSSR1GngkWg2AUGc2IBfOiW4qIKLeX4ajT2LGvn6
         RyItuASoMzPKTpsiCAPYG0Ti2O1+WMct928lb91iIE64+FiGInbu0sfEmH7fjRnKbqRm
         XKsw==
X-Gm-Message-State: AOJu0YzPsP2ZhMwA7wdNYghgnTdy8XsijvsfdPTzzDfI/y2SrmGV0yeh
	rl5tOAG/Ibf7VsY0KR++Aq8tIuE49XyYlWnLH8qXh9e+BfJeJVnvr7P7zVsZ9fQ25fZwIwHI8un
	ZW/eQ+eezM6GlYzstkUmzhgXmeCquqf4mEGQqPQ==
X-Google-Smtp-Source: AGHT+IEbDrDTf5KsggBbKRPlPzzC4UhkmWtVLLNeKmwNZxMrMKnrQRKTVpvRk9YlsXq8IW+uCo6xqsYixuoSOu9NnxQ=
X-Received: by 2002:a17:90a:c250:b0:296:1cb5:c26a with SMTP id
 d16-20020a17090ac25000b002961cb5c26amr4366751pjx.6.1706875040985; Fri, 02 Feb
 2024 03:57:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126114614.1424592-1-naresh.solanki@9elements.com> <20240126-deflate-ashy-158a91efb25a@spud>
In-Reply-To: <20240126-deflate-ashy-158a91efb25a@spud>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Fri, 2 Feb 2024 17:27:10 +0530
Message-ID: <CABqG17g+wQ5brngLDYObV+t2y+CEf+85rzqTSYTcmS5jckWZRg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mfd: Add regulator-compatible property
To: Conor Dooley <conor@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Patrick Rudolph <patrick.rudolph@9elements.com>, mazziesaccount@gmail.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Conor,


On Fri, 26 Jan 2024 at 21:50, Conor Dooley <conor@kernel.org> wrote:
>
> On Fri, Jan 26, 2024 at 05:16:14PM +0530, Naresh Solanki wrote:
> > Add regulator-compatible property.
>
> Why? I can see that this is what you did, but there's no justification
> for it.
>
> grepping for this property, the first thing I see is:
> rg "regulator-compatible"
> drivers/regulator/of_regulator.c
> 389: * based on either the deprecated property regulator-compatible if present,
> 428:                                    "regulator-compatible", NULL);
> 486:            name = of_get_property(child, "regulator-compatible", NULL);
>
>
> The property is deprecated, so you'll need twice as good a justification
> for adding it!
Yes this is deprecated property. I missed noticing that earlier.
Will remove this dependency. Thanks for pointing that out.

Regards,
Naresh
>
> > Also update example.
> >
> > TEST=Run below command & make sure there is no error
> > make DT_CHECKER_FLAGS=-m dt_binding_check
>
> Same comment here as my other mail.
>
> Thanks,
> Conor.
>
> >
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/maxim,max5970.yaml | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
> > index 0da5cae3852e..75175098cbc2 100644
> > --- a/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
> > @@ -74,6 +74,9 @@ properties:
> >              description: |
> >                The value of current sense resistor in microohms.
> >
> > +          regulator-compatible:
> > +            pattern: "^SW[0-1]$"
> > +
> >          required:
> >            - shunt-resistor-micro-ohms
> >
> > @@ -111,6 +114,8 @@ examples:
> >
> >              regulators {
> >                  sw0_ref_0: sw0 {
> > +                    regulator-compatible = "SW0";
> > +                    regulator-name = "p5v";
> >                      shunt-resistor-micro-ohms = <12000>;
> >                  };
> >              };
> > @@ -145,9 +150,13 @@ examples:
> >
> >              regulators {
> >                  sw0_ref_1: sw0 {
> > +                    regulator-compatible = "SW0";
> > +                    regulator-name = "p5v_aux";
> >                      shunt-resistor-micro-ohms = <12000>;
> >                  };
> >                  sw1_ref_1: sw1 {
> > +                    regulator-compatible = "SW1";
> > +                    regulator-name = "p3v3_aux";
> >                      shunt-resistor-micro-ohms = <10000>;
> >                  };
> >              };
> >
> > base-commit: ecb1b8288dc7ccbdcb3b9df005fa1c0e0c0388a7
> > --
> > 2.42.0
> >

