Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2CB79B3CF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355327AbjIKV5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236383AbjIKKcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:32:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B736E5F;
        Mon, 11 Sep 2023 03:32:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F4FC433C7;
        Mon, 11 Sep 2023 10:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694428336;
        bh=NxlAgdm0zBlYQHGHYk0vtHQiaU9QKg+ESRgOgI623QA=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=YPRP152AYRqv5SeEqG2TuzRr1x/m+fO7cpvR0iJom99pBq3WtSTzem7asxaeCIOiW
         F4fdOOx0PKr1+kqKegAMJTDs1mk2xBUpZ6j0hXL4kThf7PdV2mINHs2l3DVIRwB1Ig
         +/bx2ApTF8w9Yl5RPIIVNymDA9D0St3XrQ1YGG3bOEy+m845bowZZz03NcoxwDfZcU
         PY1Pi3XcSq0XAfQdAEnIj/+0RytcIMw/OkEkJxXVLHr0fAGcJXFsFvUlyYWKKZ9a8a
         l5bcQrdTAv6s3sqwir8369BhcVy8BEvq8LXWA2ZxiOFgcrVq2OYRzALNDk2e28f1oF
         g5oh1VYx8KEQg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 11 Sep 2023 13:32:12 +0300
Message-Id: <CVG0PQ1NV1XZ.1R2BD85Z1M3FO@suppilovahvero>
Cc:     <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
        "Jens Wiklander" <jens.wiklander@linaro.org>, <jejb@linux.ibm.com>,
        <zohar@linux.ibm.com>, <sudeep.holla@arm.com>,
        <achin.gupta@arm.com>, <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KEYS: trusted: tee: Refactor register SHM usage
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Sumit Garg" <sumit.garg@linaro.org>
X-Mailer: aerc 0.14.0
References: <20230822112933.1550062-1-sumit.garg@linaro.org>
 <20230822125555.GA82256@rayden>
 <CAFA6WYPy=yxGg1HbT+ipWJFpxiJeUGK6BSgMhtRPd=zmKef-cw@mail.gmail.com>
 <CAHUa44G9jCeHcRq=AZeieaTPWN_tpOVKeJNY=777QAh-bw1QNg@mail.gmail.com>
 <CAFA6WYPY70iYCmQhzCkATGinqK_C1i4SEZzTdv4yDwntpGNzew@mail.gmail.com>
 <CAHUa44H5eG6N0M_aAiWsYJorWVt4pYEZPWXgOJHgXAYVmR=cww@mail.gmail.com>
 <CAFA6WYNAifDVZy-pLSTJWonGTJBECijsTFw4OQdqToW3u6Lj_Q@mail.gmail.com>
In-Reply-To: <CAFA6WYNAifDVZy-pLSTJWonGTJBECijsTFw4OQdqToW3u6Lj_Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Sep 5, 2023 at 2:04 PM EEST, Sumit Garg wrote:
> Hi Jarkko,
>
> On Wed, 23 Aug 2023 at 19:58, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > On Wed, Aug 23, 2023 at 3:04=E2=80=AFPM Sumit Garg <sumit.garg@linaro.o=
rg> wrote:
> > >
> > > On Wed, 23 Aug 2023 at 13:32, Jens Wiklander <jens.wiklander@linaro.o=
rg> wrote:
> > > >
> > > > On Wed, Aug 23, 2023 at 8:55=E2=80=AFAM Sumit Garg <sumit.garg@lina=
ro.org> wrote:
> > > > >
> > > > > On Tue, 22 Aug 2023 at 18:25, Jens Wiklander <jens.wiklander@lina=
ro.org> wrote:
> > > > > >
> > > > > > On Tue, Aug 22, 2023 at 04:59:33PM +0530, Sumit Garg wrote:
> > > > > > > The OP-TEE driver using the old SMC based ABI permits overlap=
ping shared
> > > > > > > buffers, but with the new FF-A based ABI each physical page m=
ay only
> > > > > > > be registered once.
> > > > > > >
> > > > > > > As the key and blob buffer are allocated adjancently, there i=
s no need
> > > > > > > for redundant register shared memory invocation. Also, it is =
incompatibile
> > > > > > > with FF-A based ABI limitation. So refactor register shared m=
emory
> > > > > > > implementation to use only single invocation to register both=
 key and blob
> > > > > > > buffers.
> > > > > > >
> > > > > > > Fixes: 4615e5a34b95 ("optee: add FF-A support")
> > > > > > > Reported-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > > ---
> > > > > > >  security/keys/trusted-keys/trusted_tee.c | 64 ++++++++------=
----------
> > > > > > >  1 file changed, 20 insertions(+), 44 deletions(-)
> > > > > > >
> > > > > > > diff --git a/security/keys/trusted-keys/trusted_tee.c b/secur=
ity/keys/trusted-keys/trusted_tee.c
> > > > > > > index ac3e270ade69..aa3d477de6db 100644
> > > > > > > --- a/security/keys/trusted-keys/trusted_tee.c
> > > > > > > +++ b/security/keys/trusted-keys/trusted_tee.c
> > > > > > > @@ -65,24 +65,16 @@ static int trusted_tee_seal(struct truste=
d_key_payload *p, char *datablob)
> > > > > > >       int ret;
> > > > > > >       struct tee_ioctl_invoke_arg inv_arg;
> > > > > > >       struct tee_param param[4];
> > > > > > > -     struct tee_shm *reg_shm_in =3D NULL, *reg_shm_out =3D N=
ULL;
> > > > > > > +     struct tee_shm *reg_shm =3D NULL;
> > > > > > >
> > > > > > >       memset(&inv_arg, 0, sizeof(inv_arg));
> > > > > > >       memset(&param, 0, sizeof(param));
> > > > > > >
> > > > > > > -     reg_shm_in =3D tee_shm_register_kernel_buf(pvt_data.ctx=
, p->key,
> > > > > > > -                                              p->key_len);
> > > > > > > -     if (IS_ERR(reg_shm_in)) {
> > > > > > > -             dev_err(pvt_data.dev, "key shm register failed\=
n");
> > > > > > > -             return PTR_ERR(reg_shm_in);
> > > > > > > -     }
> > > > > > > -
> > > > > > > -     reg_shm_out =3D tee_shm_register_kernel_buf(pvt_data.ct=
x, p->blob,
> > > > > > > -                                               sizeof(p->blo=
b));
> > > > > > > -     if (IS_ERR(reg_shm_out)) {
> > > > > > > -             dev_err(pvt_data.dev, "blob shm register failed=
\n");
> > > > > > > -             ret =3D PTR_ERR(reg_shm_out);
> > > > > > > -             goto out;
> > > > > > > +     reg_shm =3D tee_shm_register_kernel_buf(pvt_data.ctx, p=
->key,
> > > > > > > +                                           sizeof(p->key) + =
sizeof(p->blob));
> > > > > >
> > > > > > This is somewhat fragile. What if struct trusted_key_payload ha=
s a small
> > > > > > unexpected change in layout?
> > > > >
> > > > > key and blob buffers are just two adjacent fixed sized byte array=
s. So
> > > > > I am not worried here as long as they stay adjacent (which has be=
en
> > > > > the case since trusted keys were introduced in the kernel).
> > > >
> > > > Yeah, that was my point, but fine if you don't believe it's an issu=
e.
> > > >
> > >
> > > Does it resolve the issue with FFA ABI for you? It would be good to
> > > have your Tested-by tag.
> >
> > It does:
> > Tested-by: Jens Wiklander <jens.wiklander@linaro.org>
> > Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
> >
>
> Can you help pick up this fix for v6.6 kernel release?

I pushed it and also added the missing stable tag:

commit 1037d6ec29cdfaaec5277c194b0278eb0a30c3f8 (HEAD -> master, origin/mas=
ter, origin/HEAD)
Author: Sumit Garg <sumit.garg@linaro.org>
Date:   Tue Aug 22 16:59:33 2023 +0530

    KEYS: trusted: tee: Refactor register SHM usage

    The OP-TEE driver using the old SMC based ABI permits overlapping share=
d
    buffers, but with the new FF-A based ABI each physical page may only
    be registered once.

    As the key and blob buffer are allocated adjancently, there is no need
    for redundant register shared memory invocation. Also, it is incompatib=
ile
    with FF-A based ABI limitation. So refactor register shared memory
    implementation to use only single invocation to register both key and b=
lob
    buffers.

    [jarkko: Added cc to stable.]
    Cc: stable@vger.kernel.org # v5.16+
    Fixes: 4615e5a34b95 ("optee: add FF-A support")
    Reported-by: Jens Wiklander <jens.wiklander@linaro.org>
    Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
    Tested-by: Jens Wiklander <jens.wiklander@linaro.org>
    Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
    Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>


BR, Jarkko
