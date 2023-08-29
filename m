Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED9D78BC49
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 02:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbjH2A5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 20:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbjH2A45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 20:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59AC129
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 17:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693270568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TsCS4Saz7XJ/AO8lGkQ98m+HzcdDjapam8XYjy+GN00=;
        b=IeIZicxIK5x/DDR1FMTKUGonOXmwx6hJSoLFDTLoj8S9vL34fie346KgO+HAbFqLlfJTTt
        Xom/o/qLUqiUB4S1EmZjPHKfxLbntRedkoR2aaGlkFWZS9eOTNuFvI6M8qjEfCdu9JESiI
        mHwcIB2YEdWtfrNRorfbqZICCz/EBDc=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-JaWmMz9dO8OlrbUnonRheA-1; Mon, 28 Aug 2023 20:56:04 -0400
X-MC-Unique: JaWmMz9dO8OlrbUnonRheA-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1ccad88370bso4570776fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 17:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693270563; x=1693875363;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TsCS4Saz7XJ/AO8lGkQ98m+HzcdDjapam8XYjy+GN00=;
        b=kqVODxrSzP0klkz0FgCj81O6L3DWs9ZSY2hjeLOPtzwQS/Wa+gvsFEjt0c2Ql2NZ7U
         zRx+DTU4Hwt1RO8VW+/zJ5OZz7foG09FVK8NcUhyXKKzRAc81ndfAx4LClKTc7Vt5OB3
         tfcsaB+NajBaNTGEAojayMN8/8gFT5/KjX71hY2sF+4SRBtx9MtlREqOJ9V+ArEqFIGf
         ucvoVhjT9aEac9LxgzlnxtQ998gOad4552si4s40Hdc0m7T96jiLVd0kVTzf41smVY7c
         AiamPQ8qKsESOh0vG9yxKaqJuMuiEoCu9DQ72lRf6FzJie2v2GJnaxF8HOE74iaLWTCv
         mDPQ==
X-Gm-Message-State: AOJu0YwPP+Et5HWpMUYbxyg12jOpkq/Ud/UdcZD+6oz5gsOErdswvGPt
        U7RNKMeCmeCTM3JSdQAVMb9mFemJL+/UNxRo2Y0EhjHhgFaHQQs5AyAw3tL0FykR1wjq9UyCg0j
        QjSfklGeb58XOcXyaZvoKyPpy
X-Received: by 2002:a05:6871:6a9:b0:1c8:bfd1:ecb8 with SMTP id l41-20020a05687106a900b001c8bfd1ecb8mr14029322oao.30.1693270563764;
        Mon, 28 Aug 2023 17:56:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH99L/GJlPzzKJakqdR1VW77qqM+gVjCsypWEmExtGalGdQ02IIkeJB2oJ06A5aWe+HL23ziA==
X-Received: by 2002:a05:6871:6a9:b0:1c8:bfd1:ecb8 with SMTP id l41-20020a05687106a900b001c8bfd1ecb8mr14029312oao.30.1693270563512;
        Mon, 28 Aug 2023 17:56:03 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a802:98e3:3c98:3d83:9703:4411? ([2804:1b3:a802:98e3:3c98:3d83:9703:4411])
        by smtp.gmail.com with ESMTPSA id ck3-20020a05687c048300b001b3538afd01sm4905729oac.51.2023.08.28.17.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 17:56:02 -0700 (PDT)
Message-ID: <1cd98cb37dcf621520e52ac7a15513aab5749534.camel@redhat.com>
Subject: Re: [RFC PATCH v2 0/3] Move usages of struct __call_single_data to
 call_single_data_t
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 28 Aug 2023 21:55:58 -0300
In-Reply-To: <b84ad9aa200457b1cbd5c55a7d860e685f068d7a.camel@redhat.com>
References: <20230520052957.798486-1-leobras@redhat.com>
         <CAJ6HWG6dK_-5jjoGJadOXqE=9c0Np-85r9-ymtAt241XrdwW=w@mail.gmail.com>
         <b84ad9aa200457b1cbd5c55a7d860e685f068d7a.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-07-04 at 04:22 -0300, Leonardo Br=C3=A1s wrote:
> On Tue, 2023-06-13 at 00:51 -0300, Leonardo Bras Soares Passos wrote:
> > Friendly ping
> >=20
> > On Sat, May 20, 2023 at 2:30=E2=80=AFAM Leonardo Bras <leobras@redhat.c=
om> wrote:
> > >=20
> > > Changes since RFCv1:
> > > - request->csd moved to the middle of the struct, without size impact
> > > - type change happens in a different patch (thanks Jens Axboe!)
> > > - Improved the third patch to also update the .h file.
> > >=20
> > > Leonardo Bras (3):
> > >   blk-mq: Move csd inside struct request so it's 32-byte aligned
> > >   blk-mq: Change request->csd type to call_single_data_t
> > >   smp: Change signatures to use call_single_data_t
> > >=20
> > >  include/linux/blk-mq.h | 10 +++++-----
> > >  include/linux/smp.h    |  2 +-
> > >  kernel/smp.c           |  4 ++--
> > >  kernel/up.c            |  2 +-
> > >  4 files changed, 9 insertions(+), 9 deletions(-)
> > >=20
> > > --
> > > 2.40.1
> > >=20
>=20
> Hello Jens,
>=20
> I still want your feedback on this series :)
>=20
> I think I addressed every issue of RFCv1, but if you have any other feedb=
ack,
> please let me know.
>=20
> Thanks!
> Leo

Hello Jens Axboe,

Please provide feedback on this series!

Are you ok with those changes?
What's your opinion on them?=20

Thanks!
Leo

