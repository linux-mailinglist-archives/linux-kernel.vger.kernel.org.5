Return-Path: <linux-kernel+bounces-56022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D84184C507
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1171C24731
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1685E1CD2D;
	Wed,  7 Feb 2024 06:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4pohP0mN"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9530B1CD2C
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 06:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707287741; cv=none; b=AC5WU7nYX4hLYn2tKwbpWTdDcSipeWiN1FGQZIl5ON5UmnmGUAu7CLWe9b0AiJ4BiVffuN0Yas7ooJiq4D6t+CenME+dWqhWTKXfhEH3yomQADAvVWEJXREDywtJKsdfAZuA1qxgIhzMZBWbzggadS8cTMuZO5uAbVpzS+uaf84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707287741; c=relaxed/simple;
	bh=lqjlboo+jCWTaQSOgl2/7ecV28tdxUQ+Zzm5dCkuAeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VNOQdh414m6X5N/FqS3fwdjMA+n4bKdaZs5xjUBB1oDFO2sv4BN+1nglEV7ne3KZRI799yF2oxq5sMcCUC0imFABmE85wBqJGwZqTMSWW3WUn3rKq4aCAA1OOJJfnIaQRKJfBYMq3hLFcR7FB78pqHZfZtSd7R5bG1ZPKwJFq7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4pohP0mN; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51160b0ecd9so391055e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 22:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707287737; x=1707892537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHTInI5cACMMsQHW0IyT/5k+Ed2vdENZgygT/PrhjmM=;
        b=4pohP0mN8o6eRyH7V3ucx3zhmJyaAW/mIM7fhzcV/8pHQV0lR9LLy5W6kpG6Jmgk1/
         Dv4qQup5wtSdZvq+xSyOl3v4eZkXvYHaBjGCLwo6haFbSoGLlu6vsUsokO4VWO+wU0Jo
         +m7r39b2r94VyNKI7WtjsnPYb2dP6C8mm3jnQRJM1c+7rhJv+wD8n0HXPAQA1hKNNpZ4
         liQSaQEY7y/rup0d9fjMxRCGOotUPCxRW6DZpiCYQXOTHi/l4DWe/0BSb2aVk1bObnx6
         Yk7PJSdS3VelYlCd9zoOzOO7ESxfW4tMnYJrSJJMvSsp7eVKG8soy/SmTxCJwVOhTIA0
         ZjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707287737; x=1707892537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHTInI5cACMMsQHW0IyT/5k+Ed2vdENZgygT/PrhjmM=;
        b=Yx4ZXr2lYao71qj46XAR8W+GZ+fePU0WzMh39BVGVl9x1CMzPqogzayRUdT3AwVvE0
         /ufYVV51iZ2AS+qoCTnlp0WCv8ShQ7Tvf17y8yStpVHtqkM53aAK5SpYV0+A040e7cdw
         c7LyeGLza45eDyVkv5cNMsmQW9sC6rQYxiLCBNRURgS84r5bXtdex1Bi64KS4bN+GrvT
         F5nWE/ithCk/t5iZQzaUFm2sueQ6RNY7qi53vUvdlsIjqTbL1qayakZIShqqmVUWQa/u
         n1gyuXGn4PVDWOvyBR/pqjRxmFjF3bCP5Iiu3AMm6JfUCV0Sb9xVK8iPLCjjbcw9zOHL
         KuIg==
X-Gm-Message-State: AOJu0YwUVW1BU1aSRdJ6tZFbjvSSz1REn5rtctavf6cvydckpaL6RgDS
	LVAgUyl9p2rbcgghU2sOXxAtLdrOoVzmWnhteFJey315Udz1wiETPl0IHW4+84Sd+8PGxYONXpB
	I1vop6C5Hz82pL/3poQe2V2v8d2k/EjhmZc/C
X-Google-Smtp-Source: AGHT+IHwIwmvcIrCK41RgEA8bHQFvL5yOaWzfiS1P8s06hkFLAoBZ8Gkp+Or3sg9vK292ChagbPvh1XmYxchf0/oT74=
X-Received: by 2002:a19:5f57:0:b0:511:51a9:7759 with SMTP id
 a23-20020a195f57000000b0051151a97759mr3538502lfj.64.1707287737501; Tue, 06
 Feb 2024 22:35:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206042408.224138-1-joychakr@google.com> <1ecb3744-7baf-4bdd-a01c-8c87fa0a42b3@linaro.org>
In-Reply-To: <1ecb3744-7baf-4bdd-a01c-8c87fa0a42b3@linaro.org>
From: Joy Chakraborty <joychakr@google.com>
Date: Wed, 7 Feb 2024 12:05:25 +0530
Message-ID: <CAOSNQF2TpA1QXKQBEZXsjXojGcfRKZDjCtLhRUGwLPVfhNWmgA@mail.gmail.com>
Subject: Re: [PATCH v2] nvmem: rmem: Fix return value of rmem_read()
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, linux-kernel@vger.kernel.org, manugautam@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 4:06=E2=80=AFAM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
>
> On 06/02/2024 04:24, Joy Chakraborty wrote:
> > reg_read() callback registered with nvmem core expects an integer error
> > as a return value but rmem_read() returns the number of bytes read, as =
a
> > result error checks in nvmem core fail even when they shouldn't.
> >
> > Return 0 on success where number of bytes read match the number of byte=
s
> > requested and a negative error -EINVAL on all other cases.
> >
> > Fixes: 5a3fa75a4d9c ("nvmem: Add driver to expose reserved memory as nv=
mem")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Joy Chakraborty <joychakr@google.com>
> > ---
> >   drivers/nvmem/rmem.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/nvmem/rmem.c b/drivers/nvmem/rmem.c
> > index 752d0bf4445e..a74dfa279ff4 100644
> > --- a/drivers/nvmem/rmem.c
> > +++ b/drivers/nvmem/rmem.c
> > @@ -46,7 +46,12 @@ static int rmem_read(void *context, unsigned int off=
set,
> >
> >       memunmap(addr);
> >
> > -     return count;
> > +     if (count !=3D bytes) {
>
> How can this fail unless the values set in priv->mem->size is incorrect
>

That should be correct since it would be fetched from the reserved
memory definition in the device tree.

> Only case I see this failing with short reads is when offset cross the
> boundary of priv->mem->size.
>
>
> can you provide more details on the failure usecase, may be with actual
> values of offsets, bytes and priv->mem->size?
>

This could very well happen if a fixed-layout defined for the reserved
memory has a cell which defines an offset and size greater than the
actual size of the reserved mem.
For E.g. if the device tree node is as follows
reserved-memory {
    #address-cells =3D <1>;
    #size-cells =3D <1>;
    ranges;
    nvmem@1000 {
        compatible =3D "nvmem-rmem";
        reg =3D <0x1000 0x400>;
        no-map;
        nvmem-layout {
            compatible =3D "fixed-layout";
            #address-cells =3D <1>;
            #size-cells =3D <1>;
            calibration@13ff {
                reg =3D <0x13ff 0x2>;
            };
        };
    };
};
If we try to read the cell "calibration" which crosses the boundary of
the reserved memory then it will lead to a short read.
Though, one might argue that the protection against such cell
definition should be there during fixed-layout parsing in core itself
but that is not there now and would not be a fix.

What I am trying to fix here is not exactly short reads but how the
return value of rmem_read() is treated by the nvmem core, where it
treats a non-zero return from read as an error currently. Hence
returning the number of bytes read leads to false failures if we try
to read a cell.


>
> > +             dev_err(priv->dev, "Failed read memory (%d)\n", count);
> > +             return -EINVAL;
> > +     }
> > +
>
> > +     return 0;
>
> thanks,
> srini
>
> >   }
> >
> >   static int rmem_probe(struct platform_device *pdev)

