Return-Path: <linux-kernel+bounces-2326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75E7815B1A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 19:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D2B72850AD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 18:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C0225564;
	Sat, 16 Dec 2023 18:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WEkX07mc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5990013FEE
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a1fae88e66eso187259966b.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 10:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702752026; x=1703356826; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+SToXMiV9mri8KrKoibWPhYhfPKu1nabLRpzMkuhlN4=;
        b=WEkX07mc1NPEwoZYih4zScLS2sispBD4dAiz3JQcNLE5+sqv3naP/t3hxU5K/Ru609
         JtLeIqBcCwFmR2Uc3ggGTVOcvnVRdb72xDyNeTka0C4NGxdJI/YF/5tsC11EH0R7XPyU
         t88/YuvbP3O5Su0L2YBsmRxkpNglYVQfzDvKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702752026; x=1703356826;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+SToXMiV9mri8KrKoibWPhYhfPKu1nabLRpzMkuhlN4=;
        b=la8V2pBwQbxuOB4YoP+qMClohLYNvQsz4NdVNei2EwIRxK+DRtjNOaPG8BcmoKVeu+
         U9Z+FQn5RHyLabrkF7FjlzkX6sd1LX0MeT38BYlpeee0q/TGYqJrTOrdNYIpMRhSdgJf
         YWG2Mw2AHjRGlZPCSzlj19UobB/sJWDrwkaKoV7aqUBHvU7eWG/Z+HZuhgubgZbAdPJ4
         0qtHDGpFaXJmK2+VyE4LR7Mim6c6yRGsHOCsobSfw171eV16y6yH27/xNg4/kQT5LLUk
         zqlp1p4VJhRL/noCGj1SiSVcO3Atli/LUMQUIf4fUQGbx+i1zxNVwv+/VApqgecl28Mw
         7UJg==
X-Gm-Message-State: AOJu0YwEiOoyvSksEBy8GgW7SYpsNDSOd0xJmT08EKlLVxTLAVtbGLSB
	LDei/FiGA/+nu+aJ3fPiaHztgFTBeNHY8xhs7wmSqkXs
X-Google-Smtp-Source: AGHT+IHJ/ggvf7E7k/tkVEYX45XupPSzPaD+RZT4l2F+rXR7w9GiHmnEoS07/KTbx0PvS197NlY2/Q==
X-Received: by 2002:a17:906:51d7:b0:a23:3efb:d40a with SMTP id v23-20020a17090651d700b00a233efbd40amr58687ejk.12.1702752026396;
        Sat, 16 Dec 2023 10:40:26 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id vt6-20020a170907a60600b00a1ce98016b6sm12260329ejc.97.2023.12.16.10.40.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 10:40:25 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a23350cd51cso23093166b.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 10:40:25 -0800 (PST)
X-Received: by 2002:a17:906:298f:b0:a00:aa23:34d0 with SMTP id
 x15-20020a170906298f00b00a00aa2334d0mr5960531eje.68.1702752025530; Sat, 16
 Dec 2023 10:40:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213163443.70490-1-brgerst@gmail.com> <20231213163443.70490-2-brgerst@gmail.com>
 <CAHk-=whgooqaEBK27sBMHob9+PwqaZghEsGnSVJsHK=y8U05tw@mail.gmail.com>
 <CAHk-=wib5XLebuEra7y2YH96wxdk=8vJnA8XoVq0FExpzVvN=Q@mail.gmail.com> <ecdf7139-7aae-450e-babb-6d07a14f1f77@oracle.com>
In-Reply-To: <ecdf7139-7aae-450e-babb-6d07a14f1f77@oracle.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sat, 16 Dec 2023 10:40:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj98whYwSnnZsJAXnekVbEftmgzFyCfjFFYtami3RQrJw@mail.gmail.com>
Message-ID: <CAHk-=wj98whYwSnnZsJAXnekVbEftmgzFyCfjFFYtami3RQrJw@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: Move TSS and LDT to end of the GDT
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 16 Dec 2023 at 10:25, Vegard Nossum <vegard.nossum@oracle.com> wrote:
>
> While preparing the patch I also came across some things that are
> unclear to me:
>
> - why do we want some segments with the A (accessed) bit set and some
> with it cleared -- is there an actual reason for the difference, or
> could we just set it for all of them?

I think it's random, and an effect of just having hardcoded numbers
and not having any structure to it.

But I do think you're right that we should just start with all
kernel-created segment descriptors marked as accessed. I do not
believe that we have any actual *use* for the descriptor access bit.

> - why does setup_percpu_segment() want the DB (size) flag clear? This
> seems to indicate that it's a 16-bit segment -- is this correct?

I think it's nonsensical and doesn't matter, and is another mistake
from us just having random numbers.

I don't think the DB bit matters except for when it's used for the
code or stack segment (or, apparently, if it's a grow-down segment).

So I think your patch looks good, and I would keep it in that form if
it makes it easier to just verify that it generates an identical
kernel image.

And then as a separate patch, I would remove that DB bit clear thing.

Anyway, I do like your patch, and I think the fact that you found
those oddities is a good argument *for* the patch, but at the same
time I think I'll just bow to the x86 maintainers who may think that
this is churn in an area that they'd rather not touch any more.

So consider that an "ack" from me, but with that caveat of yes, I
think a binary diff would be a good thing because this is *so* odd and
low-level and maybe people just think it's not worth it.

Thanks,

                  Linus

