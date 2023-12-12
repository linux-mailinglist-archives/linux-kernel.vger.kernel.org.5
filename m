Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362FB80F412
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjLLRJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjLLRJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:09:07 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA3EA8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:09:12 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7c522ea69e8so1521697241.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702400951; x=1703005751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upBnebOqwsJ597ZlmCLWx528Yzi3Wcu30Pu2fcleukU=;
        b=rAWyGhEl5QZfENy+2tW1KWXOJt9iy4tJAm3F8/l0IKbulyyqMgyS5WlFH2XYZN9ph4
         yXM+LTOPpboux6iMsqxOlKiI2A3LOrn2aAwpdOph9tJ51eptXZcBkYw3VRH5TZYBIjk6
         IwiPxV0dn9/wKrj8bOFzpxKiLuy+ZIQjz7owiV2GbGoh/HuaaUBmNtndOZiHUtqBYOIJ
         RufYfAN/rbvMYFxEXcThRSGZf8qGSERM2mMEomhH9WBcbMSaYCdXCQQ1RHmJ2gMAp3z8
         qaC1Ucy4rN79qHxJCz9pxxqkwB8NOhICKOR+i89PxyuUzPBczjXki6m6OT/VDmMcUoSN
         7iAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702400951; x=1703005751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upBnebOqwsJ597ZlmCLWx528Yzi3Wcu30Pu2fcleukU=;
        b=w2eOoAxXsLjdO2S9bKMW/3FizMvvDKyRXbc88CK46dle3PVIHrIRzg1aiVOXBvEgvJ
         tAKJtL2UVOMz9+8QtGHHekgw7djEd0I6xcOSNgmpb8xpCQnYK/QF5a3dZHnii+BtiXKP
         wFtid9UceeRewr+Aj+NuysQwX+h07QnQUg8JZaCmsHN1vljwb08a34q8hJ793cryCXy1
         7+R4YvFRtvrUK9tV7jf4wp4SHDgVoreyTBvZ4igAoGfppJo5ViVTOMQCVJgNfSgRvwb2
         x4eFGdOcLQV/RoWFcCUNaMc+3zmAvF1Es0Zov8wb0nzHRFHzvu0umFS3qci96b+GJotj
         /vXA==
X-Gm-Message-State: AOJu0Yw4OFSVXk9DQeNM7ijlReVKCsGmiZEVzL8W61Wx93nozn9OsjtC
        MQpNIb0Iy4LvEHizpcPVnmM61Ce7mPI99dVAjjLxAQ==
X-Google-Smtp-Source: AGHT+IHWPQk3/S1nqdVFY2SvYM4mv4RMcFM6GJosPjrDfPNXU9stefweNMroytoNPvvl5pcUN2P754MhzBIe3u4BaAY=
X-Received: by 2002:a05:6122:2897:b0:4b2:acda:e1e4 with SMTP id
 fl23-20020a056122289700b004b2acdae1e4mr5776460vkb.6.1702400951144; Tue, 12
 Dec 2023 09:09:11 -0800 (PST)
MIME-Version: 1.0
References: <20231212054253.50094-1-warthog618@gmail.com>
In-Reply-To: <20231212054253.50094-1-warthog618@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 12 Dec 2023 18:09:00 +0100
Message-ID: <CAMRc=Me90Lu7Duc8-4xSfDcHQd6M7+0t0O8FAa6jiizp-OO5=Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] gpiolib: cdev: relocate debounce_period_us
To:     Kent Gibson <warthog618@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, andy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 6:43=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> This series contains minor improvements to gpiolib-cdev.
>
> The banner change is relocating the debounce_period_us from gpiolib's
> struct gpio_desc to cdev's struct line.  The first patch stores the
> field locally in cdev.  The second removes the now unused field from
> gpiolib.
>
> The third patch is somewhat related and removes a FIXME from
> gpio_desc_to_lineinfo().  The FIXME relates to a race condition in
> the calculation of the used  flag, but I would assert that from
> the userspace perspective the read operation itself is inherently racy.
> The line being reported as unused in the info provides no guarantee -
> it just an indicator that requesting the line is likely to succeed -
> assuming the line is not otherwise requested in the meantime.
> Give the overall operation is racy, trying to stamp out an unlikely
> race within the operation is pointless. Accept it as a possibility
> that has negligible side-effects and reduce the number of locks held
> simultaneously and the duration that the gpio_lock is held.
>
> The fourth patch is unrelated to debounce or info, but addresses Andy's
> recent assertion that the linereq get/set values functions are confusing
> and under documented.  Figured I may as well add that while I was in
> there.
>
> Kent Gibson (4):
>   gpiolib: cdev: relocate debounce_period_us from struct gpio_desc
>   gpiolib: remove debounce_period_us from struct gpio_desc
>   gpiolib: cdev: reduce locking in gpio_desc_to_lineinfo()
>   gpiolib: cdev: improve documentation of get/set values
>
>  drivers/gpio/gpiolib-cdev.c | 257 ++++++++++++++++++++++++++++--------
>  drivers/gpio/gpiolib.c      |   3 -
>  drivers/gpio/gpiolib.h      |   5 -
>  3 files changed, 201 insertions(+), 64 deletions(-)
>
> --
> 2.39.2
>

Patches 2-4 look fine, I was about to review patch 1 in detail but I
thought I'd just throw this one in here before we commit to a specific
solution.

For some reason I thought this would not work but I'm now considering
it as an alternative approach: is there anything wrong with adding
struct kref to struct line, allocating it separately per-line when
gpio_chardev_data is created, referencing it from struct linereq when
the line is being requested, and dropping the reference from
gpio_chardev_data and linereq when either is being removed? Other than
the increased number of allocations?

Bartosz
