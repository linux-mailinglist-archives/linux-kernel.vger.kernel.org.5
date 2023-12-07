Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C31F808479
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 10:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjLGI4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLGI4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:56:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B907519A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 00:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701939415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tjb24Mm+TO5MXS0Md6L/Y5JPRs7VNdcjPv1AKibj1Rg=;
        b=JBR1qTCbxRfmnRKLdLUNV5sut/PgNUKG+xV5zZojrOklnSw2Zpzm2a4969EZ4EipeRuOYn
        CTQCryDYKnrMWNv46UFo4N34Q6QFNyIot0ys7J9hJjPmMSJmXWcgzKihwkw434bWqhk0ee
        czN4s8h3TVV5VToI/i3EJZNIIMnIsjw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-Gi43TYfzPmGbppLIR2CGXQ-1; Thu, 07 Dec 2023 03:56:54 -0500
X-MC-Unique: Gi43TYfzPmGbppLIR2CGXQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a1cfd84b473so81816566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 00:56:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701939413; x=1702544213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjb24Mm+TO5MXS0Md6L/Y5JPRs7VNdcjPv1AKibj1Rg=;
        b=IkJzaolX35xwDCBis+B0m7kjywz7x9ytP6TxYziNMcEV749MOjQdIXxiulP09CA48I
         XDWp3FdAKgb8u7uy43WiSxq49Wfrr7q5kkoexnJJvO6EBY2q4Urha0y9aBWyMpT2X20C
         c1TDVIwtG0P9D6gIZhqOKk2q5CaC1Jt2wpzRl8MS2nrgmCMvbqvJV0PjU1Yyh0CM43CS
         cwZaCfsOF2IeJ3wxSKsDdYqINglfg6PMjvhGc+yKP//HUUp9Byw8Ge4EtSG40mcnZEaM
         LiKWabUXOol0Auv6lPwXu2jlTLt5OhuWOG7NB3+KzWS0TWl+Acd1EAJu7r6eFm+wEpBT
         wDjw==
X-Gm-Message-State: AOJu0Yy6gA7a1ElHrUZkp3QniIxMRU5NW4cr2jssDaxHfSr3Ep95NS95
        hhajRG1fOUnWuEOaQAe3MJNaU40+NLxxgxQ6MRDIrO8hsgTAdMHoKWoDtMsCkax4N8Ss+JVcSbv
        6IZTebPk56vyi8VnhuLLZj8tYXSRkHhCsH0ferZgy
X-Received: by 2002:a17:906:51d9:b0:a1d:5483:d152 with SMTP id v25-20020a17090651d900b00a1d5483d152mr3231940ejk.68.1701939413292;
        Thu, 07 Dec 2023 00:56:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKIhhZEKnvU9mv82qAnevu5zZsbtr1NFNSThdCDWarWHBT2exXLQczsV9NjkPIznTWYjB/bhUNP2uGJlaDSUg=
X-Received: by 2002:a17:906:51d9:b0:a1d:5483:d152 with SMTP id
 v25-20020a17090651d900b00a1d5483d152mr3231933ejk.68.1701939413001; Thu, 07
 Dec 2023 00:56:53 -0800 (PST)
MIME-Version: 1.0
References: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org> <170193920703.229356.5910722658341910962.b4-ty@kernel.org>
In-Reply-To: <170193920703.229356.5910722658341910962.b4-ty@kernel.org>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 7 Dec 2023 09:56:40 +0100
Message-ID: <CAO-hwJ+f-qLtcY=A+yVQZA5M4unO6T7ogGK_mvqwAnsViM_+1Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] selftests/hid: tablets fixes
To:     Benjamin Tissoires <bentiss@kernel.org>
Cc:     Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 9:53=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.o=
rg> wrote:
>
> On Wed, 06 Dec 2023 11:45:51 +0100, Benjamin Tissoires wrote:
> > the main trigger of this series was the XP-Pen issue[0].
> > Basically, the tablets tests were good-ish but couldn't
> > handle that tablet both in terms of emulation or in terms
> > of detection of issues.
> >
> > So rework the tablets test a bit to be able to include the
> > XP-Pen patch later, once I have a kernel fix for it (right
> > now I only have a HID-BPF fix, meaning that the test will
> > fail if I include them).
> >
> > [...]
>
> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (f=
or-5.8/selftests), thanks!

of course, it's for-6.8/selftests, not 5.8 :)

Cheers,
Benjamin

>
> [01/15] selftests/hid: vmtest.sh: update vm2c and container
>         https://git.kernel.org/hid/hid/c/887f8094b335
> [02/15] selftests/hid: vmtest.sh: allow finer control on the build steps
>         https://git.kernel.org/hid/hid/c/46bc0277c250
> [03/15] selftests/hid: base: allow for multiple skip_if_uhdev
>         https://git.kernel.org/hid/hid/c/110292a77f7c
> [04/15] selftests/hid: tablets: remove unused class
>         https://git.kernel.org/hid/hid/c/b5edacf79c8e
> [05/15] selftests/hid: tablets: move the transitions to PenState
>         https://git.kernel.org/hid/hid/c/d52f52069fed
> [06/15] selftests/hid: tablets: move move_to function to PenDigitizer
>         https://git.kernel.org/hid/hid/c/881ccc36b426
> [07/15] selftests/hid: tablets: do not set invert when the eraser is used
>         https://git.kernel.org/hid/hid/c/d8d7aa2266a7
> [08/15] selftests/hid: tablets: set initial data for tilt/twist
>         https://git.kernel.org/hid/hid/c/e08e493ff961
> [09/15] selftests/hid: tablets: define the elements of PenState
>         https://git.kernel.org/hid/hid/c/83912f83fabc
> [10/15] selftests/hid: tablets: add variants of states with buttons
>         https://git.kernel.org/hid/hid/c/74452d6329be
> [11/15] selftests/hid: tablets: convert the primary button tests
>         https://git.kernel.org/hid/hid/c/1f01537ef17e
> [12/15] selftests/hid: tablets: add a secondary barrel switch test
>         https://git.kernel.org/hid/hid/c/76df1f72fb25
> [13/15] selftests/hid: tablets: be stricter for some transitions
>         https://git.kernel.org/hid/hid/c/ab9b82909e9b
> [14/15] selftests/hid: fix mypy complains
>         https://git.kernel.org/hid/hid/c/ed5bc56cedca
> [15/15] selftests/hid: fix ruff linter complains
>         https://git.kernel.org/hid/hid/c/f556aa957df8
>
> Cheers,
> --
> Benjamin Tissoires <bentiss@kernel.org>
>

