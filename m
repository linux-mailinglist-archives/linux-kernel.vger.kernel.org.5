Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C686F79C408
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbjILDUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239986AbjILCg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:36:28 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D74F108ABF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 17:07:55 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-401b3ea0656so53555125e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 17:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1694477212; x=1695082012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzkVzEFydtkz5bajW6TvmTAgwsFOtxXYQqSDn5oNDRM=;
        b=IivDI/+9Cmq2y2j0QNHq30mW8aoG0s7pyjWDOzzDIr6JZHURdNHPSEYWQ2QPq/WcjM
         5pNDRgWZjm+lEuvgIyc8GgnxQ4Nl7i9QEUQ44jA8R9UrT/ScsWiXHpVOIfPYAVhw+WAQ
         rISjbPBbLbSYLVAmKg5T2T5vPeSSfgTWAJyDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694477212; x=1695082012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SzkVzEFydtkz5bajW6TvmTAgwsFOtxXYQqSDn5oNDRM=;
        b=DY+ZMzQKmaJLTClB3r9gJoVeYIzkWz1lNqPP4vZLFI9H7buxqp/NTLj4NUbhRw1XkW
         mt5jVLv4BEeSJiPkCVMWkLqOes9PIBiAsj/Lhzq4YLGbw/iYY2pVGMQPMNwV66BZdAo/
         zlcKN+PM26UUKaB3+wTdkDyfva7T/dkIM/bL8IwlEPwLDjwTjE4GE3xrzX6ENhs837E7
         xI/L7aZFywL19zhXadQflgiSSgRYl09ADTOrLetmXXnlLrVlBDN9WRE27AjaB4v9TcaK
         KFjlZKjzPRG/MUg4lH7YhEzIDCfuB9Y2dmLPVlGnVcyvg03m0EtvNjyPkGxzzeP5YeAc
         2PBg==
X-Gm-Message-State: AOJu0Yz9EprtofoSIhBeSmMFer+Vcra2To3sZ3drmh6wNzKrz5un6fjR
        pWQqA4BG4VsaM/XJmxkGyQ1a15uPxw7C1lJtqEaDU7Rofko=
X-Google-Smtp-Source: AGHT+IF7ksTV8qwio+85u2DQ/ZjrYytMmIwozByj3MlCaQT0+WMy1JpnYbnKi5iErqqhGtywER5Abw==
X-Received: by 2002:ac2:5629:0:b0:4fb:8f79:631 with SMTP id b9-20020ac25629000000b004fb8f790631mr8664681lff.46.1694472128682;
        Mon, 11 Sep 2023 15:42:08 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 8-20020ac24848000000b005009f7d9401sm1500440lfy.64.2023.09.11.15.42.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 15:42:08 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-500a398cda5so8260291e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 15:42:08 -0700 (PDT)
X-Received: by 2002:a17:906:1db2:b0:99c:85af:7aa6 with SMTP id
 u18-20020a1709061db200b0099c85af7aa6mr10588202ejh.28.1694471683161; Mon, 11
 Sep 2023 15:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230908140629.2930150-1-jforbes@fedoraproject.org> <CVGF71DQQCJ2.1XC0V5TKKRX5R@suppilovahvero>
In-Reply-To: <CVGF71DQQCJ2.1XC0V5TKKRX5R@suppilovahvero>
From:   Justin Forbes <jforbes@fedoraproject.org>
Date:   Mon, 11 Sep 2023 17:34:31 -0500
X-Gmail-Original-Message-ID: <CAFbkSA3gBfA8rqoyV6qqyuOLdAOReK+j+B1gZA+96DqcOrP5XQ@mail.gmail.com>
Message-ID: <CAFbkSA3gBfA8rqoyV6qqyuOLdAOReK+j+B1gZA+96DqcOrP5XQ@mail.gmail.com>
Subject: Re: [PATCH] Fix typo in tpmrm class definition
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmforbes@linuxtx.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 5:09=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Fri Sep 8, 2023 at 5:06 PM EEST, Justin M. Forbes wrote:
> > Commit d2e8071bed0be ("tpm: make all 'class' structures const")
> > unfortunately had a typo for the name on tpmrm.
> >
> > Fixes: d2e8071bed0b ("tpm: make all 'class' structures const")
> > Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
> > ---
> >  drivers/char/tpm/tpm-chip.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > index 23f6f2eda84c..42b1062e33cd 100644
> > --- a/drivers/char/tpm/tpm-chip.c
> > +++ b/drivers/char/tpm/tpm-chip.c
> > @@ -33,7 +33,7 @@ const struct class tpm_class =3D {
> >       .shutdown_pre =3D tpm_class_shutdown,
> >  };
> >  const struct class tpmrm_class =3D {
> > -     .name =3D "tmprm",
> > +     .name =3D "tpmrm",
> >  };
> >  dev_t tpm_devt;
> >
> > --
> > 2.41.0
>
> I have issues applying the patch:

Sorry, not sure what the issue is, but I did a git am of it myself to
a fresh checkout of linus' tree and just recreated and sent it. So,
new thread, but hopefully the patch will apply

Justin

>
> $ git am -3 20230908_jforbes_fix_typo_in_tpmrm_class_definition.mbx
> Applying: Fix typo in tpmrm class definition
> error: corrupt patch at line 18
> error: could not build fake ancestor
> Patch failed at 0001 Fix typo in tpmrm class definition
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> $ git log -2
> commit ba46245183940de39e42c8456b85ceaf3519b764 (HEAD -> master, origin/m=
aster, origin/HEAD)
> Author: Sumit Garg <sumit.garg@linaro.org>
> Date:   Tue Aug 22 16:59:33 2023 +0530
>
>     KEYS: trusted: tee: Refactor register SHM usage
>
>     The OP-TEE driver using the old SMC based ABI permits overlapping sha=
red
>     buffers, but with the new FF-A based ABI each physical page may only
>     be registered once.
>
>     As the key and blob buffer are allocated adjancently, there is no nee=
d
>     for redundant register shared memory invocation. Also, it is incompat=
ibile
>     with FF-A based ABI limitation. So refactor register shared memory
>     implementation to use only single invocation to register both key and=
 blob
>     buffers.
>
>     [jarkko: Added cc to stable.]
>     Cc: stable@vger.kernel.org # v5.16+
>     Fixes: 4615e5a34b95 ("optee: add FF-A support")
>     Reported-by: Jens Wiklander <jens.wiklander@linaro.org>
>     Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>     Tested-by: Jens Wiklander <jens.wiklander@linaro.org>
>     Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
>     Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d (tag: v6.6-rc1, upstream/=
master, origin/next, next)
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sun Sep 10 16:28:41 2023 -0700
>
>     Linux 6.6-rc1
>
> BR, Jarkko
>
