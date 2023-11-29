Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E487FDAE4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbjK2PNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbjK2PNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:13:50 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA2DD5D;
        Wed, 29 Nov 2023 07:13:56 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5bdfbd69bd5so779647a12.1;
        Wed, 29 Nov 2023 07:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701270836; x=1701875636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iIKWxGyiRbf3SG4rKDTOqBlNDSA1cc3f6H9uieYbWQ=;
        b=cKrlOYww7cA9oC9eVtKWVO866JjR4DizsLqiWArerFVlB4p3vTGDlnoA2hQ8FuHyeS
         uydfCRImVLOf7TZP2fxOjXFXEsnbqTjTBt29tBkl8qCym/EHJLqQqbuU7FV0pyalum4V
         oEKw2RF/Kl718uN/Ij8Z58xwZsj+sXjuuSPaBMJw/mUAlGE/j43wL6nD0iEu7lRpJ5qQ
         rRojGhhBzHSuGWgNMAIgfKsgLaVtQxm9Sx9N5Ipz6Xq9nys7iEuynJUPtw8o1ONbZcDQ
         Brsvqq/d+DKWhnG0Y5rwGjoN0TXliFxpYoPJ8RlKU1A9rhsy7M5jm1JaoD+4mW0ABad/
         OExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701270836; x=1701875636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0iIKWxGyiRbf3SG4rKDTOqBlNDSA1cc3f6H9uieYbWQ=;
        b=ufaLlVf6Q2xA9e0pWddQoBks3GwiC3xzoy3Ax/ggGef50aZn7Z2fputDHc3cWvFVSc
         6+qFVPlgd5fszGQOfZOp80ez5C4I8NKzFSS3atpIvAlH/GtJeixSCS1uOe+MJsQW3iyQ
         oY7tMMyOJnBxs8AA8BKiMQCzZoFX4QRfKgmIrvJDfaSiz22wxIBdhE+plznlHYf/cAS3
         IS/t1eoDhBAQETHxrSDA0N2f6H1xdGHR3JPOwvh2Db15g7YenvifFsJv+veC0KvAjTbX
         OfQBw15A2gf7FjBWblN91cFq4Nmf1Sn3gTM2n1oCJAoyiOlef44t+eGi+Y2FkzQUy6lk
         trgw==
X-Gm-Message-State: AOJu0Ywl7k3ua4e5xv4BnRptfOQkErmE7XGzrrIIZGdYGvRmrGT4uEJI
        5OYOJN3HC53ziVe/0ALosLPVEukp3/LRn0r0vUI=
X-Google-Smtp-Source: AGHT+IGefgEeFVwSE2YE0tvnc8G4Kez5vym0kVbW57S7KbimWr8xl59X64QhhOD/XIjQvIgaf5ts76/7Wg7OVUe/1HM=
X-Received: by 2002:a17:90a:ad04:b0:285:a161:ad8f with SMTP id
 r4-20020a17090aad0400b00285a161ad8fmr19998927pjq.21.1701270835659; Wed, 29
 Nov 2023 07:13:55 -0800 (PST)
MIME-Version: 1.0
References: <20231128141321.51669-1-boerge.struempfel@gmail.com> <ZWYVVvB0O-CBIbos@smile.fi.intel.com>
In-Reply-To: <ZWYVVvB0O-CBIbos@smile.fi.intel.com>
From:   =?UTF-8?B?QsO2cmdlIFN0csO8bXBmZWw=?= <boerge.struempfel@gmail.com>
Date:   Wed, 29 Nov 2023 16:13:44 +0100
Message-ID: <CAEktqcv8NC0Cy+wo7nRGOp9USoBdta=n=mrbo-WomxgcmWN5nQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: sysfs: Fix error handling on failed export
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        bstruempfel@ultratronik.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy

Thanks again for your feedback.

On Tue, Nov 28, 2023 at 5:29=E2=80=AFPM Andy Shevchenko <andy@kernel.org> w=
rote:
>
> On Tue, Nov 28, 2023 at 03:13:21PM +0100, Boerge Struempfel wrote:
> > If gpio_set_transitory() fails, we should free the gpio again. Most
>
> gpio --> GPIO descriptor
> (I already mentioned capitalization in v1 review)
>

I'm sorry, I misunderstood your comment "GPIO" in the v1 review. I fixed it=
 for
the next version.

> > notably, the flag FLAG_REQUESTED has previously been set in
> > gpiod_request_commit(), and should be reset on failure.
> >
> > To my knowledge, this does not affect any current users, since the
> > gpio_set_transitory() mainly returns 0 and -ENOTSUPP, which is converte=
d
> > to 0. However the gpio_set_transitory() function calles the .set_config=
()
> > function of the corresponding gpio chip and there are some gpio drivers=
 in
>
> gpio --> GPIO
>

thanks

> > which some (unlikely) branches return other values like -EPROBE_DEFER,
> > and EINVAL. In these cases, the above mentioned FLAG_REQUESTED would no=
t
>
> -EINVAL
>

thanks, I missed that, when I added the minus to all the other Error codes.

> > be reset, which results in the pin being blocked until the next reboot.
>
> Fixes tag?
> (`git log --no-merges --grep "Fixes:" will show you examples)
>

I thought it was optional. But I have added it for the next version.

> --
> With Best Regards,
> Andy Shevchenko
>
>
