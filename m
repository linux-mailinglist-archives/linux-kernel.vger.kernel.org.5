Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6976575AEE4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjGTM5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjGTM5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:57:05 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0F7269E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:56:44 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-48137084a66so333634e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1689857803; x=1690462603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1ZGppFUGoT15EF4YCw8tI150/zjcmWJj2k2NeFQg9w=;
        b=es0BgeZaDaDOKqofQU0YHlAOa+KzCTxpREmCuxqWHQtEkfGhmDdxb7N5cUZJTGgMvx
         xMw9eFq+UZ86AKpp5hN/YnRtAuHi/UOqxhNZEc+5zikZVHRPSyAO5roxPCpH6cCTJ47U
         7iiH8DkYAsiIeyNfME+fDNAsOIVby8Xbooiw1MDp+iquFx23/TVerqTlvCw6AHD/gHf/
         Za/chXdMetU6rmRSlu0Oaa8ls9PFUMxAcQCVN6p/0jR6wSL1LVUW2o5K0b2un+wGgrwK
         r1LxlIcX/bB0QRy8XyTF2wz8b/0qcqfMtNSeSQrDqE6tEJqI3uns8+/tKYlWUfXj9YZT
         C+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689857803; x=1690462603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1ZGppFUGoT15EF4YCw8tI150/zjcmWJj2k2NeFQg9w=;
        b=XymSc15/lkpIr4P6B98kx3WGOHMJnQsTUuI+O+QvmOTH19FVVpDG/wz4jNTTwqgfm2
         jzG8BMgbkbagjSUw4T5madmNbPw/gWlPlbi7OBgerB1l9mkypO21Co5rBUD2SUXse71v
         e5Tn/o2MiuWQAMSEY/2+WqvH3n4VGUBrAQF1ktrqFyt2YoWJj4tCPf0R5Dii+q83FSRw
         WDKWSq+3n9PC8SmN2oNir5hH+J8hLUfMboXFvma9yh/6zWXR4C1PxK6mDiwN1id8htTC
         +xmwHTxEEIASSYK2881iVVHqnG0UeZ9MSze5nu7GKcRJ3TX2MZD4NlFkI6H06UsZELVR
         tzvA==
X-Gm-Message-State: ABy/qLb58CXZ5ZPfZKOK1xc9ZUlXj2qqpDjIYa5G3Dee2l443dqJ51PH
        OGt65pMdqJlVOtiFGCLfVn1PJcLInOoXWakRLF6/oQ==
X-Google-Smtp-Source: APBJJlEee1o0YKvrMhtsL8MF+yRoXumnj5SDxTztT8XCVutkM3cq6ZpTzwL4P1daguUDMQI5ldv8Cm3SKluYLA9wjIc=
X-Received: by 2002:a1f:cc86:0:b0:481:388e:b908 with SMTP id
 c128-20020a1fcc86000000b00481388eb908mr5707827vkg.6.1689857803203; Thu, 20
 Jul 2023 05:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230720061105.154821-1-victor.liu@nxp.com> <20230720112742.GA2525277@aspen.lan>
In-Reply-To: <20230720112742.GA2525277@aspen.lan>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 20 Jul 2023 14:56:32 +0200
Message-ID: <CAMRc=MfbWjWTdU4ToFMp_ZV6eGdRnjD--Y+qsN329TsLFGQYxg@mail.gmail.com>
Subject: Re: [PATCH] backlight: gpio_backlight: Drop output gpio direction
 check for initial power state
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Ying Liu <victor.liu@nxp.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "deller@gmx.de" <deller@gmx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 1:27=E2=80=AFPM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Thu, Jul 20, 2023 at 06:06:27AM +0000, Ying Liu wrote:
> > Bootloader may leave gpio direction as input and gpio value as logical =
low.
> > It hints that initial backlight power state should be FB_BLANK_POWERDOW=
N
> > since the gpio value is literally logical low.
>
> To be honest this probably "hints" that the bootloader simply didn't
> consider the backlight at all :-) . I'd rather the patch description
> focus on what circumstances lead to the current code making a bad
> decision. More like:
>
>   If the GPIO pin is in the input state but the backlight is currently
>   off due to default pull downs then ...
>
> > So, let's drop output gpio
> > direction check and only check gpio value to set the initial power stat=
e.
>
> This check was specifically added by Bartosz so I'd be interested in his
> opinion of this change (especially since he is now a GPIO maintainer)!
>
> What motivates (or motivated) the need to check the direction rather
> than just read that current logic level on the pin?
>
>
> Daniel.
> [I'm done but since Bartosz and Linus were not on copy of the original
> thread I've left the rest of the patch below as a convenience ;-) ]
>

This was done in commit: 706dc68102bc ("backlight: gpio: Explicitly
set the direction of the GPIO").

Let me quote myself from it:

--
The GPIO backlight driver currently requests the line 'as is', without
actively setting its direction. This can lead to problems: if the line
is in input mode by default, we won't be able to drive it later when
updating the status and also reading its initial value doesn't make
sense for backlight setting.
--

I agree with Thomas that it's highly unlikely the bootloader "hints"
at any specific backlight settings. That being said, the change itself
looks correct to me. The other branch of that if will always unblank
the backlight if the GPIO is in input mode which may not be desirable.
I don't see any obvious problem with this change, just make sure the
commit message makes more sense.

Bartosz
