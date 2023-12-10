Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0577D80BCCA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 20:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjLJTql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 14:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJTqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 14:46:40 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0C4ED
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 11:46:46 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5cfc3a48ab2so30865897b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 11:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702237606; x=1702842406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfL3WzEuDXRtc2Yx9DpKvEpshQljhBnqTFJily+P2J4=;
        b=mk/pk7j2XNoWRptCydmxvtQoifeIfk5lXV8i3x87X7XPcTt2Zv629mUAWoA4hCow0L
         ZmpXSeKsB9jLwcg/cHVVVxmZv1XoolzR3ga6ZWdhX313iIsDB4GlFqEH5Ou8sH2oZGGz
         lFbNvdlf3NuTL2Lt9Xdo0GdYQcv4AAcGYg6NHPiWm/l6aXUSifM/N++7Px6yAG8KcnZd
         IUzc0O4VGJd1OhHxrSDXqzNGhhBelmRY3L+kmepjvh6Oi3sq4uPpqX+gwKBV3oqpRpBD
         c34uogyu1H/Gshum5NDM58PhgY9Ns7EVvtYDquF+fiVdq+P26vIoQFAhtIE11z7LeeP+
         Qr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702237606; x=1702842406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zfL3WzEuDXRtc2Yx9DpKvEpshQljhBnqTFJily+P2J4=;
        b=ZQURhsO2ycYrZRXbPmj6RRDvM8RTHOVEtjkdXvlb8Q7qqMFnjSMKr/aI8HMODmkX24
         xzXXXQFkOjqMHQnhtenWHBSJ3Fm2KBNRUqgBcTxgx3nBw2OL0Bg/4zarxB+Vi2dGOUGn
         4/NFrMW6AuuQoG5AN82d9zPmzfkLdpOMAkf0BpC043KEpKtmvVVAkXrBb4aVfsphy2++
         5LxV4SqNaYHwog5NxdbGTPv3zE5ETx3OofQkPw5gNiejMErvaveTzYP6ouU8EI61lOHL
         W+PxFtLVAGMduwUoiXpCriXPNmfGvQScnUqDWzscF+3z44I7HO/0ubJ5A3E97YphmpYx
         COrg==
X-Gm-Message-State: AOJu0YybSdw7lWyjEoVX6MeobKD1VYxr2QSDDSz8D10acU0Wq4dFZQje
        rsHZYh8GFGH01YaTH9Fm/H8Rf2BsXh/48vZzhO5R3A==
X-Google-Smtp-Source: AGHT+IGkSafvzKSd9XrQiQnLAXp/AYZlAzkqTQNLQinImuLSVyYAumPVpSBhPCumrQMH+fplSJPGlMdPFGDW4+HPe5g=
X-Received: by 2002:a81:4fc7:0:b0:5d7:1941:abb with SMTP id
 d190-20020a814fc7000000b005d719410abbmr2574429ywb.86.1702237605793; Sun, 10
 Dec 2023 11:46:45 -0800 (PST)
MIME-Version: 1.0
References: <87dfa523-1882-417d-97b5-f606ff0099f9@moroto.mountain>
In-Reply-To: <87dfa523-1882-417d-97b5-f606ff0099f9@moroto.mountain>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 10 Dec 2023 20:46:34 +0100
Message-ID: <CACRpkdbu=pkACc+gmBa_nCrYOwhXi77FzHwwUfd8A0sREPaM9w@mail.gmail.com>
Subject: Re: [PATCH] usb: fotg210-hcd: delete an incorrect bounds test
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Lee Jones <lee@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

thanks for your patch!

On Fri, Dec 8, 2023 at 10:23=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:

> Here "temp" is the number of characters that we have written and "size"
> is the size of the buffer.  The intent was clearly to say that if we have
> written to the end of the buffer then stop.
>
> However, for that to work the comparison should have been done on the
> original "size" value instead of the "size -=3D temp" value.  Not only
> will that not trigger when we want to, but there is a small chance that
> it will trigger incorrectly before we want it to and we break from the
> loop slightly earlier than intended.
>
> This code was recently changed from using snprintf() to scnprintf().  Wit=
h
> snprintf() we likely would have continued looping and passed a negative
> size parameter to snprintf().  This would have triggered an annoying
> WARN().  Now that we have converted to scnprintf() "size" will never
> drop below 1 and there is no real need for this test.  We could change
> the condition to "if (temp <=3D 1) goto done;" but just deleting the test
> is cleanest.

This is a great fix! Thanks for going the extra mile and fix this
when looking at the code.

> Fixes: 1dd33a9f1b95 ("usb: fotg210: Collect pieces of dual mode controlle=
r")

That's the wrong commit.
This commit just brings stuff together from old code...

I believe it should be:
Fixes: 7d50195f6c50 ("usb: host: Faraday fotg210-hcd driver")

It won't backport cleanly but it's the right commit.

> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

With the right Fixes:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
