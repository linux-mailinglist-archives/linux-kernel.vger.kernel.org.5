Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E038278E0FE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240322AbjH3Uvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238405AbjH3Uvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:51:42 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEFEC0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:51:13 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-401b3ea0656so947495e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693428577; x=1694033377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjZbtMDwHgL6rOhEs0+hOR39TSbPZ+yWdgFCyClCTgM=;
        b=DgPBn2P+CqJfaEWTvcwXA9fxlxRC6r9bzxjOC4rFleOkSpioVAlp/CcN1fIeMz7UOt
         /31nHafienSF78tr+NXgVYfEB52v9bguQ75XyaD3SyxTTzoWrntvpIygC24BqA/OxOMd
         OQUng+LVR39xZ5X3PMnBadP0sGuqCNl0UVSrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693428577; x=1694033377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjZbtMDwHgL6rOhEs0+hOR39TSbPZ+yWdgFCyClCTgM=;
        b=E2jYqknA0j8P89aCwzBBKuFbobCLXNEAyirFOQ0e22cPlmrTmcBEIX97v1ewR7SQ2U
         KZF5zvNdnkE7XZEKc2E0H47zcaN6uqMRGT75IEicrxSw/Z0TB+ZSS/C7tXGkRMC44ifD
         Qt0E3cLNrR22jRpaNRga5YZwexPKqIb/5pcJ6d8r6n0CreESNlu+5F9cIU9jSYPUgX/q
         plV3GskDAOFCGsx8QYG6ItrXhaJMbFwz0r9RlJaip7+9Hi374pxJtZ+d7Yytew1aajaC
         YuFWAnrwtXnSofVUfFgDZ22J6T5xcCKR8igqQ7k4KiIqArqNdfCKTdWmHrTTicHfUjAB
         Kmrw==
X-Gm-Message-State: AOJu0YwzGxCQlnTuThtkEeqCjtKaIgL6ukzS1oY4nAJUZHWS+DwWBeB0
        9hd2UFqVZm7a7Lx8GJ8A72723EIVr+KjfI+9R5dWq8hA
X-Google-Smtp-Source: AGHT+IHg7BLyyrwKYEqmnFe60kmZepuGCBlvTOKt45zJeCBpZg097BtNDuy8Us5zOsquQvoCluFpGw==
X-Received: by 2002:a17:907:75cd:b0:9a2:739:3aa1 with SMTP id jl13-20020a17090775cd00b009a207393aa1mr2673432ejc.61.1693427651407;
        Wed, 30 Aug 2023 13:34:11 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id li22-20020a170906f99600b009a198078c53sm7533315ejb.214.2023.08.30.13.34.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 13:34:10 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-52c1d861c5eso1075a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:34:10 -0700 (PDT)
X-Received: by 2002:a50:935e:0:b0:522:4741:d992 with SMTP id
 n30-20020a50935e000000b005224741d992mr34289eda.4.1693427650661; Wed, 30 Aug
 2023 13:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693416477.git.mirq-linux@rere.qmqm.pl> <711d447ac7160ca275975f6aba51e19bfcb4f742.1693416477.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <711d447ac7160ca275975f6aba51e19bfcb4f742.1693416477.git.mirq-linux@rere.qmqm.pl>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 30 Aug 2023 13:33:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UekHUmY5u=mhx9XE8o8bU65ACkjEeao8bhWArqXMZWng@mail.gmail.com>
Message-ID: <CAD=FV=UekHUmY5u=mhx9XE8o8bU65ACkjEeao8bhWArqXMZWng@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] regulator/core: regulator_lock_two: remove
 duplicate locking code
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 30, 2023 at 10:35=E2=80=AFAM Micha=C5=82 Miros=C5=82aw
<mirq-linux@rere.qmqm.pl> wrote:
>
> Make regulator_lock_two() shorter by observing that we have only two
> locks and when swapped earlier the retry code becomes identical to the
> normal (optimistic) path.
>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/regulator/core.c | 30 +++++++++-------------------
>  1 file changed, 11 insertions(+), 19 deletions(-)

FWIW, I'm leaving this one to Stephen to review since he had strong
opinions on some of the style issues here.

-Doug
