Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986BA7AD928
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjIYNbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjIYNbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:31:14 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFA010E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:31:05 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d7ecdb99b7aso7242335276.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695648664; x=1696253464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dx0cuMZ0YuASpvGCtMLSsLnfXajgyvJdGZMPWwTyE+c=;
        b=r4OVMyU1a2PKN/56wKaO2/1r2JM85Q/J6xX3Nkj1kLJrGG+uYy98pQ1Us0jYhJ1wiH
         I9ncWWJHw3R2BPSrN91MmTzrQwqC4PvW4v4DJF9n8/wjlQ8x93Kyh1CA/FB9tCnRQklJ
         P8Gizf1zgIyDziTxPmXWp616XXkAa2XpllCzAonWuD+UVtIoLRg/YK0eihfb0FSn0Yk3
         747TTuM2Pplt842KWmkO+Df+Jakpl9HhAq1q5WQAxaR+8zI7j2GIYk+cwTJdt3mjTFiA
         EnMIR8UtjNwjzftCGCtCNB7lJ4BwMdinA5zj9+Ia5hMeQ9uBkJwxcSmUXurP16w42Lwp
         x1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695648664; x=1696253464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dx0cuMZ0YuASpvGCtMLSsLnfXajgyvJdGZMPWwTyE+c=;
        b=gKICP66vVZqNpnd8MFsxOGmmCxj2uGDDEmye6ifcyZOK48xyttX/JA5Owa+BihxUPf
         WX+FDBF5N7lwaCfZ/B20hwX7Enn43AXTZmmZorzOaLfNypRJdnIlWSgRVGJ14FfugZdl
         rGNHCJvPse/s4JvZBop3f5mTSZ5dtwFVUhxu3xW9I2y1ayt6Zebm/dgn5b9VQ6856Jxb
         XQFHfGv5hFkgvvLPvP8xl7RM3nX8T/WHrlR1nF9RigNlQvUdOcz/tHagPxbYNve1+ynl
         MSg9tjEpRBtfIjm46aSOE4A1eAcd0zjipLL24cogfhPyBLKi9l1dC4PN+A9CzsfGtv2G
         FCPw==
X-Gm-Message-State: AOJu0Ywse1uJdmlPoBbBeOxRdGktEwLOIQ1TYwr/KXVpbGvR8h+xn3bH
        oRbbmtkhjFHg+NGuEexui9uDP43fGly1wHDW0SFgGA==
X-Google-Smtp-Source: AGHT+IF4T3RldjnrswDnLCdW2zO37YsRTW+jRjJz/sEOlYabku9rVj0hZiONpvJLKYsrMU2Ba0Eqic2BQlyBd/mmnVw=
X-Received: by 2002:a25:6b45:0:b0:d80:1441:9010 with SMTP id
 o5-20020a256b45000000b00d8014419010mr5402395ybm.26.1695648664346; Mon, 25 Sep
 2023 06:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <ZQs1RgTKg6VJqmPs@google.com>
In-Reply-To: <ZQs1RgTKg6VJqmPs@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Sep 2023 15:30:53 +0200
Message-ID: <CACRpkdbuOn4gKBE-tB4MHQ3mx_ujQZLdPp1hp75ANFgsGb1jQQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: avoid unsafe code pattern in find_pinctrl()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 8:09=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> The code in find_pinctrl() takes a mutex and traverses a list of pinctrl
> structures. Later the caller bumps up reference count on the found
> structure. Such pattern is not safe as pinctrl that was found may get
> deleted before the caller gets around to increasing the reference count.
>
> Fix this by taking the reference count in find_pinctrl(), while it still
> holds the mutex.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

After some thinking, applied for fixes and tagged for stable as
it is a very real problem that can cause random crashes under
the right circumstances.

Thanks for finding this Dmitry!!

Yours,
Linus Walleij
