Return-Path: <linux-kernel+bounces-56644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAF184CD26
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C592F1F21A6C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD5C7E765;
	Wed,  7 Feb 2024 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I4eLrhBM"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7472030F
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317214; cv=none; b=rJ2aCAhLmmb4oBQL+aCwfJtlP7LqdZQ2u2iGeDTF7Qh0SkcAyYD0rZ3/dpoqSCQWJE3QHIZTLGuXmVgwrkEBzmueM33+rX1eSi7yDxUyhZ9fYw838po6akAFNATAY94GU4Sf8gnZLfKftGA6pXr7BcVQ+/Tn2C+GqtQVCrEEpWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317214; c=relaxed/simple;
	bh=/+5Ax2hSk99F5O69NYL28HyxqMdfko1Syo5d5CD5HYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FtErLy4u0Alu13/TXjNFh8epVb+6c1Rij8PpgP38x/ZL3/orUVoMapJw5ZTFJj5irTFudJ4rvJF6QXvFZOdaDavMEMH6+mwqFDgGakxEFoQ/DnSdedGaZMnwklOYaIAwWNNhj7d2XdpNfXjny4NohJdzt4B7X0YEpNgLr1nDx/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I4eLrhBM; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a30e445602cso376671566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 06:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707317211; x=1707922011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UM9iIW7HjZWB1xD5kJizaiHrI85sdwm4gmOhcZxYsu4=;
        b=I4eLrhBMrfttDYZKG9NvPzqmUrgOCHACMlWNDCmeDUV8wrqearza1+SkqJ/QdFkc49
         yhQlkNqMBsigrqp8XlGnBQbFBpTrYYF5r8JJQcXEpXPgySBo2T/KJOn1CEGnGT/I9h7z
         Sjai5qCjvB7BNu2Ll/O/869oqUiudL7tzyPtAfe7KoMQ4TxA+cV25za9qyf3Qi3QzN/w
         RuCjUQtmBoF1NZIC2iMxZBIwcxro0me1eZXBtWbYGH/6GX6CkNRvJSx86d/3VGcruXO9
         fxzjGe3oqrRaLGWajZLcJ7XExm6ypCrbU3jSYvZAK7NJ2nKv27ip+sYS2zf9w1ujhst7
         TPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707317211; x=1707922011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UM9iIW7HjZWB1xD5kJizaiHrI85sdwm4gmOhcZxYsu4=;
        b=hvXyFuJ7r+1W/bUmhVXe+u53Uw1wx3L6Dx9GVir52DqAqjhbj33k+oX8U4Aw8T/ApV
         ALPhQ0WV6B8zVFohwx7EVaeAN2BqWrg6XyF4W5tO7VkAwWu2JSCp7tUE0zqVnHxcmEHv
         +gqgzGwcWYn97f1qOy8QAty+zpz3GfN/3riwQMMe9ThqEIdcNIHlMv9eMLBKiraobVMj
         0l0/msPqW+j+2WJ6fU4cLU6pABfR1nfl926YecL3GvXA8WogrHJjD3dsJ5Iitdnme+UA
         VXRzM/zT2wJpg3lW/idPKoVRItu8Q/Vj1ym9ZR6JsV7wE0t0cBQCJwHoC5f2Zog0vcWv
         NIDw==
X-Forwarded-Encrypted: i=1; AJvYcCVHAg+P8SEBiPa4VBwXBICZH76yZtW8dlW6OSubNYG352Bb05YKC0xoflYKG2NiWA8ZPOR4LdqOHk6WI/j0m/ROIGS9brEnk7Jl+R3r
X-Gm-Message-State: AOJu0YzG7WBOQQ15yQABh0D1dk37VeM0DKn15/sY3ZbTPZhjRGEu8Kcu
	2fBVPlmdI91pHz2UGkpMiWnClv51eJ9P40nrjg/P45Saxrz2pKyCzpOg9oVO3sQDpc9n7vhcWsG
	/SyirY9Wpvm/QbesC9U7gyd1kBszstx0PkyaE
X-Google-Smtp-Source: AGHT+IFyZS+87fmpcf+H1SnVXiGeifiadi7tt3T0qo6oS9P89a816YleSLXYnt4w29SL3RY4vdG+Lys4yCbp7XDgOqE=
X-Received: by 2002:a17:907:7759:b0:a38:1711:ee61 with SMTP id
 kx25-20020a170907775900b00a381711ee61mr6175816ejc.19.1707317211142; Wed, 07
 Feb 2024 06:46:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206042408.224138-1-joychakr@google.com> <1ecb3744-7baf-4bdd-a01c-8c87fa0a42b3@linaro.org>
 <CAOSNQF2TpA1QXKQBEZXsjXojGcfRKZDjCtLhRUGwLPVfhNWmgA@mail.gmail.com> <feff8e48-c974-447a-99bb-21d5beda1dd1@linaro.org>
In-Reply-To: <feff8e48-c974-447a-99bb-21d5beda1dd1@linaro.org>
From: Joy Chakraborty <joychakr@google.com>
Date: Wed, 7 Feb 2024 20:16:37 +0530
Message-ID: <CAOSNQF0akup9owP6EC0Q7eSrfdsr-sr1bhArF+YQAiAxfRJaVQ@mail.gmail.com>
Subject: Re: [PATCH v2] nvmem: rmem: Fix return value of rmem_read()
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, linux-kernel@vger.kernel.org, manugautam@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 3:00=E2=80=AFPM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
>
> On 07/02/2024 06:35, Joy Chakraborty wrote:
> > On Wed, Feb 7, 2024 at 4:06=E2=80=AFAM Srinivas Kandagatla
> > <srinivas.kandagatla@linaro.org> wrote:
> >>
> >>
> >>
> >> On 06/02/2024 04:24, Joy Chakraborty wrote:
> >>> reg_read() callback registered with nvmem core expects an integer err=
or
> >>> as a return value but rmem_read() returns the number of bytes read, a=
s a
> >>> result error checks in nvmem core fail even when they shouldn't.
> >>>
> >>> Return 0 on success where number of bytes read match the number of by=
tes
> >>> requested and a negative error -EINVAL on all other cases.
> >>>
> >>> Fixes: 5a3fa75a4d9c ("nvmem: Add driver to expose reserved memory as =
nvmem")
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Joy Chakraborty <joychakr@google.com>
> >>> ---
> >>>    drivers/nvmem/rmem.c | 7 ++++++-
> >>>    1 file changed, 6 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/nvmem/rmem.c b/drivers/nvmem/rmem.c
> >>> index 752d0bf4445e..a74dfa279ff4 100644
> >>> --- a/drivers/nvmem/rmem.c
> >>> +++ b/drivers/nvmem/rmem.c
> >>> @@ -46,7 +46,12 @@ static int rmem_read(void *context, unsigned int o=
ffset,
> >>>
> >>>        memunmap(addr);
> >>>
> >>> -     return count;
> >>> +     if (count !=3D bytes) {
> >>
> >> How can this fail unless the values set in priv->mem->size is incorrec=
t
> >>
> >
> > That should be correct since it would be fetched from the reserved
> > memory definition in the device tree.
> >
> >> Only case I see this failing with short reads is when offset cross the
> >> boundary of priv->mem->size.
> >>
> >>
> >> can you provide more details on the failure usecase, may be with actua=
l
> >> values of offsets, bytes and priv->mem->size?
> >>
> >
> > This could very well happen if a fixed-layout defined for the reserved
> > memory has a cell which defines an offset and size greater than the
> > actual size of the reserved mem.
>
> No that should just be blocked from core layer, atleast which is what is
> checked bin_attr_nvmem_read(), if checks are missing in other places
> then that needs fixing.
>

Sure.

>
> > For E.g. if the device tree node is as follows
> > reserved-memory {
> >      #address-cells =3D <1>;
> >      #size-cells =3D <1>;
> >      ranges;
> >      nvmem@1000 {
> >          compatible =3D "nvmem-rmem";
> >          reg =3D <0x1000 0x400>;
> >          no-map;
> >          nvmem-layout {
> >              compatible =3D "fixed-layout";
> >              #address-cells =3D <1>;
> >              #size-cells =3D <1>;
> >              calibration@13ff {
> >                  reg =3D <0x13ff 0x2>;
>
> this is out of range, core should just err out.
>

Cells are currently unchecked, I can fix that in a different patch.

> --srini
>
> >              };
> >          };
> >      };
> > };
> > If we try to read the cell "calibration" which crosses the boundary of
> > the reserved memory then it will lead to a short read.
> > Though, one might argue that the protection against such cell
> > definition should be there during fixed-layout parsing in core itself
> > but that is not there now and would not be a fix.
> >
> > What I am trying to fix here is not exactly short reads but how the
> > return value of rmem_read() is treated by the nvmem core, where it
> > treats a non-zero return from read as an error currently. Hence
> > returning the number of bytes read leads to false failures if we try
> > to read a cell.
> >
> >
> >>
> >>> +             dev_err(priv->dev, "Failed read memory (%d)\n", count);
> >>> +             return -EINVAL;
> >>> +     }
> >>> +
> >>
> >>> +     return 0;
> >>
> >> thanks,
> >> srini
> >>
> >>>    }
> >>>
> >>>    static int rmem_probe(struct platform_device *pdev)

Thanks
Joy

