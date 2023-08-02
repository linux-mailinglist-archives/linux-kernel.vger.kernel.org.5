Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B0C76D9FA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 23:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjHBVwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 17:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjHBVwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:52:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230F8173A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 14:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691013113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WPlGYk9DpKaFa+HTTbJErYVJ3cCFtjdP9KNGf5Y9bG4=;
        b=RqZ97bHSSghDu+VYEt8CYCKqN5PwJPMK74twspl+bR9rfo3G4ATNl1P2YC9XzpVQWYgABt
        s2Kd8K/YIiV/juziaQ+ZEbloooEy+4fSL0fROpbekVCfxVZPRyC/SWqondFYNfTMyYWFFd
        i8F4Ig9e40zBqyw1X/iJv4jNo80HCHc=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-CprmSLwzNm2C9bIAbj1Gyg-1; Wed, 02 Aug 2023 17:51:52 -0400
X-MC-Unique: CprmSLwzNm2C9bIAbj1Gyg-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1bb67d16387so278331fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 14:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691013111; x=1691617911;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WPlGYk9DpKaFa+HTTbJErYVJ3cCFtjdP9KNGf5Y9bG4=;
        b=ZsgIHZKUvDNXuFQccEJVKLzxWo3xsKhs8YbjOveNDmVnPi87fsFIGKRDmiTCdbNHyq
         FX7ycXZLgaBmuyLlJI7KxCG1dci3NNUmBqtnOQPB2KkcIL7R+ZcBqxe+DfRbQEatjW03
         QTawAk89TtrIyz0oznE9mR60xkRu990jmANyFEXpf6gKAW7jYmvNOjIVk8nDoN5zotHY
         4nG9A278KtK0HVA+hh4ocBZu1yAxLiArdWh5eXZomWOdl8UkqLFa1IEIfr3nYQd7oenY
         MA9YR4NoQKooTM/oYNqSKDqCy91kAMheadeF+YFFajBw5a8eqoyinSgoEc9ExU+FSyR0
         0KBw==
X-Gm-Message-State: ABy/qLY6a6ph5mexjjTMXcjlbyCIsK5fhH4IHUnuEFy6CuZ1QVY6LXMd
        ivuBKahOOEUuFboxgM6qlGrNkuHBfmLnsJVI7JeaXsW4nOCHblUpn8lbd2llkLT8CwvFTxgxd/b
        rlTqxT7d5Yx554FXOerLFxMkr
X-Received: by 2002:a05:6870:e2d3:b0:1b0:653a:af92 with SMTP id w19-20020a056870e2d300b001b0653aaf92mr17824511oad.8.1691013111442;
        Wed, 02 Aug 2023 14:51:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF5KEDj4/5iS2/i2P4JdBomYzLc/eiuCylrdImcbQYPMJQP0JmjmfkiJ/DzDceqBKm3D1JXYA==
X-Received: by 2002:a05:6870:e2d3:b0:1b0:653a:af92 with SMTP id w19-20020a056870e2d300b001b0653aaf92mr17824507oad.8.1691013111247;
        Wed, 02 Aug 2023 14:51:51 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a801:d380:694f:4f52:764c:4b7f? ([2804:1b3:a801:d380:694f:4f52:764c:4b7f])
        by smtp.gmail.com with ESMTPSA id v2-20020a4a5a02000000b005660ed0becesm6759353ooa.39.2023.08.02.14.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 14:51:50 -0700 (PDT)
Message-ID: <2f301cd6c4009248c5eb6af00f12f36f3127ca10.camel@redhat.com>
Subject: Re: [RFC PATCH v1 0/2] Deduplicating RISCV cmpxchg.h macros
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 02 Aug 2023 18:51:47 -0300
In-Reply-To: <ZC7/LzV53KsZ/cSn@andrea>
References: <20230406082018.70367-1-leobras@redhat.com>
         <ZC7/LzV53KsZ/cSn@andrea>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-04-06 at 19:19 +0200, Andrea Parri wrote:
> On Thu, Apr 06, 2023 at 05:20:17AM -0300, Leonardo Bras wrote:
> > While studying riscv's cmpxchg.h file, I got really interested in
> > understanding how RISCV asm implemented the different versions of
> > {cmp,}xchg.
> >=20
> > When I understood the pattern, it made sense for me to remove the
> > duplications and create macros to make it easier to understand what exa=
ctly
> > changes between the versions: Instruction sufixes & barriers.
> >=20
> > Thanks!
> > Leo
> >=20
> > Changes since RFCv3:
> > - Squashed the 6 original patches in 2: one for cmpxchg and one for xch=
g
> > https://lore.kernel.org/all/20230404163741.2762165-1-leobras@redhat.com=
/
> >=20
> > Changes since RFCv2:
> > - Fixed  macros that depend on having a local variable with a magic nam=
e
> > - Previous cast to (long) is now only applied on 4-bytes cmpxchg
> > https://lore.kernel.org/all/20230321074249.2221674-1-leobras@redhat.com=
/
> >=20
> > Changes since RFCv1:
> > - Fixed patch 4/6 suffix from 'w.aqrl' to '.w.aqrl', to avoid build err=
or
> > https://lore.kernel.org/all/20230318080059.1109286-1-leobras@redhat.com=
/
> >=20
> > Leonardo Bras (2):
> >   riscv/cmpxchg: Deduplicate cmpxchg() asm and macros
> >   riscv/cmpxchg: Deduplicate xchg() asm functions
> >=20
> >  arch/riscv/include/asm/cmpxchg.h | 319 +++++++------------------------
> >  1 file changed, 67 insertions(+), 252 deletions(-)
>=20
> LGTM.  AFAICT, this would need to be rebased, cf. e.g.
>=20
>   a8596dda1fbf7e ("arch: rename all internal names __xchg to __arch_xchg"=
)
>=20
> from the tip tree.
>=20
>   Andrea

Thanks for the heads up!
I will update this and re-send!


And sorry about the delay :(
For some weird reason neither the cover letter, nor your message reached my
gmail, and just now looking at lore I could find your message.=20


