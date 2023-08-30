Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C977178E255
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbjH3Waw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343822AbjH3Wau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:30:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83F6E0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693434587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FYqfRtnQxOV7PByWJqK8y3BA13qWsYODXL0RRw5z4G0=;
        b=d4HpOitWxItuK9VDVALoCSuX2uJqGmgDpH3n6go7cxL5+bVo3TKQJ6sNMUiw+Rs0qRVBmQ
        WsQ9Lrj7v3Lh/FvNKcfmegbUa5Ky9k+P5EhGMM9RhsKAruzTjpxVL2F+6H2ZEYmwWILRxC
        nJBDobGlnX6ba0+rEvTOK09QfUgPtO8=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-KC_9v5ZJM1eg6xglD0pWTQ-1; Wed, 30 Aug 2023 18:29:46 -0400
X-MC-Unique: KC_9v5ZJM1eg6xglD0pWTQ-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a7d6ad5bb7so158850b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693434585; x=1694039385;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FYqfRtnQxOV7PByWJqK8y3BA13qWsYODXL0RRw5z4G0=;
        b=SPYmE1u2do2uEtjUwiiSUzlYrJWC9MGMJEFQmG3RJuaRcRv3+8I8B58dMm09D2Ei9X
         oV8KXZembFfuCby+iS+j8GAb6lHfmV4DkeA13h5g1aEro8cguFCu/whe+qDcIY83tWsZ
         sFW1TZbcLz0D5DEH9uKxY2ZiZCfC7Hh6sPNA6BtnO66Kn5KrE2ODiMbAzDBPrCwy/ARe
         wftfzLDUZjpKRPLfvjjhMmJ5cjpiFKMi8yJhIT3SzECFQCyRAqynLhdpPUGL+kk7dBWo
         BrD1H2JtvJuHj/l6Q+f2b+CG631v7Gj71a/7VMI9CW9GwhpbEovuDUGiLMNdNb2MfAqq
         D9pQ==
X-Gm-Message-State: AOJu0Yxbyd6U2bcCbh/ZGVS3FNLEnYeyv4LWwHiHMkXxF0w6OemExZ5C
        aIYJpi8FA9qz1lDuGKJSAk4rZJRSQ88lpNS2nKHR+3Awv7zFwV/mQ8HvNrPlOQMHqANN881E7OI
        yRa38EQZuD5rrUkjT/rbyE/6Y
X-Received: by 2002:a05:6808:1a04:b0:3a8:4903:5688 with SMTP id bk4-20020a0568081a0400b003a849035688mr3505568oib.34.1693434585742;
        Wed, 30 Aug 2023 15:29:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqqemKSM9xURwBZYJlx1jyubOYrTVHwKDb0ZiV7TlN0z/vk4Ihpk00JCwFASj9ui/sEfBJew==
X-Received: by 2002:a05:6808:1a04:b0:3a8:4903:5688 with SMTP id bk4-20020a0568081a0400b003a849035688mr3505558oib.34.1693434585554;
        Wed, 30 Aug 2023 15:29:45 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a802:98e3:3c98:3d83:9703:4411? ([2804:1b3:a802:98e3:3c98:3d83:9703:4411])
        by smtp.gmail.com with ESMTPSA id a10-20020a544e0a000000b003a8560a9d34sm67503oiy.25.2023.08.30.15.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 15:29:45 -0700 (PDT)
Message-ID: <16efceed0b215ee34cc46ca7bba4a86bcf2d8ad7.camel@redhat.com>
Subject: Re: [RFC PATCH v2 0/3] Move usages of struct __call_single_data to
 call_single_data_t
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Chengming Zhou <chengming.zhou@linux.dev>,
        Jens Axboe <axboe@kernel.dk>,
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
Date:   Wed, 30 Aug 2023 19:29:40 -0300
In-Reply-To: <51cf9db1-4487-4229-4d43-e91268e52125@linux.dev>
References: <20230520052957.798486-1-leobras@redhat.com>
         <CAJ6HWG6dK_-5jjoGJadOXqE=9c0Np-85r9-ymtAt241XrdwW=w@mail.gmail.com>
         <b84ad9aa200457b1cbd5c55a7d860e685f068d7a.camel@redhat.com>
         <1cd98cb37dcf621520e52ac7a15513aab5749534.camel@redhat.com>
         <51cf9db1-4487-4229-4d43-e91268e52125@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-08-29 at 10:29 +0800, Chengming Zhou wrote:
> On 2023/8/29 08:55, Leonardo Br=C3=A1s wrote:
> > On Tue, 2023-07-04 at 04:22 -0300, Leonardo Br=C3=A1s wrote:
> > > On Tue, 2023-06-13 at 00:51 -0300, Leonardo Bras Soares Passos wrote:
> > > > Friendly ping
> > > >=20
> > > > On Sat, May 20, 2023 at 2:30=E2=80=AFAM Leonardo Bras <leobras@redh=
at.com> wrote:
> > > > >=20
> > > > > Changes since RFCv1:
> > > > > - request->csd moved to the middle of the struct, without size im=
pact
> > > > > - type change happens in a different patch (thanks Jens Axboe!)
> > > > > - Improved the third patch to also update the .h file.
> > > > >=20
> > > > > Leonardo Bras (3):
> > > > >   blk-mq: Move csd inside struct request so it's 32-byte aligned
> > > > >   blk-mq: Change request->csd type to call_single_data_t
> > > > >   smp: Change signatures to use call_single_data_t
> > > > >=20
> > > > >  include/linux/blk-mq.h | 10 +++++-----
> > > > >  include/linux/smp.h    |  2 +-
> > > > >  kernel/smp.c           |  4 ++--
> > > > >  kernel/up.c            |  2 +-
> > > > >  4 files changed, 9 insertions(+), 9 deletions(-)
> > > > >=20
> > > > > --
> > > > > 2.40.1
> > > > >=20
> > >=20
> > > Hello Jens,
> > >=20
> > > I still want your feedback on this series :)
> > >=20
> > > I think I addressed every issue of RFCv1, but if you have any other f=
eedback,
> > > please let me know.
> > >=20
> > > Thanks!
> > > Leo
> >=20
> > Hello Jens Axboe,
> >=20
> > Please provide feedback on this series!
> >=20
> > Are you ok with those changes?
> > What's your opinion on them?=20
> >=20
> > Thanks!
> > Leo
> >=20
>=20
> Hello,
>=20
> FYI, there is no csd in struct request anymore in block/for-next branch,
> which is deleted by this commit:
>=20
> commit 660e802c76c89e871c29cd3174c07c8d23e39c35
> Author: Chengming Zhou <zhouchengming@bytedance.com>
> Date:   Mon Jul 17 12:00:55 2023 +0800
>=20
>     blk-mq: use percpu csd to remote complete instead of per-rq csd
>=20
>     If request need to be completed remotely, we insert it into percpu ll=
ist,
>     and smp_call_function_single_async() if llist is empty previously.
>=20
>     We don't need to use per-rq csd, percpu csd is enough. And the size o=
f
>     struct request is decreased by 24 bytes.
>=20
>     This way is cleaner, and looks correct, given block softirq is guaran=
teed
>     to be scheduled to consume the list if one new request is added to th=
is
>     percpu list, either smp_call_function_single_async() returns -EBUSY o=
r 0.
>=20
>     Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>     Reviewed-by: Ming Lei <ming.lei@redhat.com>
>     Reviewed-by: Christoph Hellwig <hch@lst.de>
>     Link: https://lore.kernel.org/r/20230717040058.3993930-2-chengming.zh=
ou@linux.dev
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
>=20


Oh, thanks for the heads-up!
I will send reviewed version of patch 3.

I suppose it can go on top of block/for-next, since the above patch is ther=
e.
Does that work for you Jens Axboe?

Thanks!
Leo

