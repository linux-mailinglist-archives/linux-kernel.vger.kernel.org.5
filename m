Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22585789ACB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 03:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjH0B0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 21:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjH0B0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 21:26:12 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656F31B3;
        Sat, 26 Aug 2023 18:26:10 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-48d165bd108so750889e0c.0;
        Sat, 26 Aug 2023 18:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693099569; x=1693704369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xuNUQVzyH4q9w7U5IcaVXKqDoFBqxRmFznUwrjO/e0=;
        b=mMxr0cPde0fK/iVz41ij4KiatKsc3M16NsYEwrO9IKNceAzB0HPgOeHhf1QyiWaBQL
         YUWomRlSjlwF6AS0qY8cvNhoATRw3wJ3Lajon8nPm28a05x5bSCDDbA8J+xLLdIJFgrw
         fM3zmDvWJL8mrg3voyrJqTd26gjsbH9RSVURMtFDco+TlcXfWesH8Agxtn0JZDAO/ySt
         qfi5cHFmm/xknbAnjG+fSWBLiJIxs2pwe4fTEiL1MUja6NQ9WAvQOatq6IPWqLHJ31X8
         2RYx/Qpej6AZ3f/DymDtCETrHqMO8Tf5SMhYKE1UxfuyPQ/jDx2/CN47xly7xp9BaXze
         i6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693099569; x=1693704369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xuNUQVzyH4q9w7U5IcaVXKqDoFBqxRmFznUwrjO/e0=;
        b=TFsYg01Bz/3ha0ZO+7+Wm2anyvaa/CT+vnRqV2G6PIL4ZRlCf8R49CdyB7mfR+r8kC
         LQOOntDmJB7Eii0QsJx4L5Y4ugQzX3ok7MpujNlb9UF0XtSmwuV9ZgRFBFLnkwQJkqVR
         frblnQXh2QV4ozR5PllsMKmWJF0dzdForKGdh4LFJiCLt/oCRmW7TmZgv8DmVaBbZCPC
         wGYrtSGHAnCDxXccHQBN2K7G0dHrLehnsir5Pc466j/hNTVjr/sU8Qdvx00duhjJ5GXs
         MKkH41pQVkJgJ/6VzaWJxVVJAMTmgqUhZzxcX3bl8z+67PPUad+95DKSQ7KJR+bYRDT6
         9g1w==
X-Gm-Message-State: AOJu0YxDEHrfCTJ5jlf/PcvhEWP9ykR6UREnuZtoRRJURoIUOZDJ539k
        TIkh3BEiBG0G5JHDE09NEXLxGLLQNYcQ3rtXYBg=
X-Google-Smtp-Source: AGHT+IHhRnDtR8YyOA5ldzZA5xzHhtH8ifpqM4IyuWPDUX3URZBYZlGS8mnlziK3b7eOZJIkGRPgz9uNFJqrvjUYDS8=
X-Received: by 2002:a05:6102:2446:b0:44d:521b:8ec with SMTP id
 g6-20020a056102244600b0044d521b08ecmr12127978vss.20.1693099569314; Sat, 26
 Aug 2023 18:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <CA+jjjYTk=5wn2o46uNB+bJYX8xLgMP==dsJuvC94DvtN2f_6Yw@mail.gmail.com>
 <ZOqg9VovoVanfuR0@debian.me>
In-Reply-To: <ZOqg9VovoVanfuR0@debian.me>
From:   Joshua Hudson <joshudson@gmail.com>
Date:   Sat, 26 Aug 2023 18:25:58 -0700
Message-ID: <CA+jjjYT6+NJwB2Kn0jWLKtmz3dWH6UnVJNA6vDbPXnnJnHMf9Q@mail.gmail.com>
Subject: Re: Cache coherency bug: stale reads on /dev/sda1
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux IDE and libata <linux-ide@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <dlemoal@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am presuming you mean "Are you sure this not a hardware issue?"

I am sure it is not, for two reasons.

1) If it were a hardware issue I would still expect the two device
nodes (whole disk and partition) to report the *same* data.

2) I have since developed a workaround involving BLKFLSDEV. The
workaround is really ugly.

On Sat, Aug 26, 2023 at 6:03=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> On Sat, Aug 26, 2023 at 02:59:45PM -0700, Joshua Hudson wrote:
> > uname -a
> > Linux nova 6.4.12 #1 SMP PREEMPT_DYNAMIC Sat Aug 26 09:11:27 PDT 2023
> > x86_64 GNU/Linux
> >
> > Kernel source is
> > https://mirrors.edge.kernel.org/pub/linux/kernel/v6.x/linux-6.4.12.tar.=
xz
> >
> > Can reliably reproduce as follows:
> >
> > # hexedit /dev/sda1 (this is my EFI partition)
> > PgDn
> > # hexedit /dev/sda
> > G 100000  (your value may vary--we want to seek to the start of the
> > EFI partition)
> > PgDn
> > PgDn
> > ^C
> > write a marker to the padding between the BPB and the first FAT sector.
> > (If your system doesn't have one, edit an error message in the boot sec=
tor)
> > ^X
> > # hexedit /dev/sda1
> > PgDn
> > Look for marker written above, find it's not there !!!
> > ^C
> >
> > I discovered this one trying to defragment my EFI partition after a
> > grub upgrade left it very fragmented due to replacing logos.
>
> Are you sure this is hardware issue?
>
> --
> An old man doll... just what I always wanted! - Clara
