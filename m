Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168B2790DA5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 21:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346332AbjICTPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 15:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346274AbjICTPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 15:15:12 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7624094
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 12:15:08 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52a1ce52ef4so964307a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 12:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693768506; x=1694373306; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wcdyOmYjlq1qQSUduy29DqZHuKGmSdrVaWwcehhzxKg=;
        b=NYN3Ltb0TvQ4v3jy0h1sy9bg4psCDtCCbEALOkvA9BcZVmbH/iDNMw4EeQ+ETBeMxF
         OuCe8FSjDjaL/e7EylYfZiqnU1MiC3Pf+kBYPr1KnalOh/6Rm+4nMAjcoirnBuQ92wwi
         OxBfc12+ai942Ot1g9IP8fpnq7pNL/7ie1Rd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693768506; x=1694373306;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcdyOmYjlq1qQSUduy29DqZHuKGmSdrVaWwcehhzxKg=;
        b=NdVWpU3p7P6l4N74VtLEhBAC5QwSQYtYIM9hDGpcL2ZmSscvdLBZLwlZve/4vjSC5E
         zUsm9WMgfFpabw0oTchv4WWwQl9Uzk6+sOtXElurPAx1U9+X0E4Fci369QujRf29zJiM
         1oI0A8PRDu3pmev6HYllOHR8zT9jpgZEcSFoBzFSciclfIhC5ytIDkJKdc+LXjjXufrv
         m6cQ8N+77h6Hl/BmptdVyziPbvsprexHxdJEiVDjJDpDOQHrcNdgCEoSm5j9zwedIn4r
         LfzkHujjXdNqx1CCmL1sdwCQiQxEONoCNRzzWBAjGVVFpDrdrI4YjcHd1iU3G2dlbEDz
         CoTA==
X-Gm-Message-State: AOJu0YzmQuMJOBajm231u9zytPOlki/fkd9WWEF/+Yz0gU/jsZ5NmviZ
        SJjU6EdPxXSRh49Pn6z32J3LSoxXEehLOgTDm2egxA==
X-Google-Smtp-Source: AGHT+IH404tjULTg/mNM4tZuPxQ72PFsZYKyo2dm1URnOZnSLlFa9mHvf0kjhHGeTptqvLtGYTKP4Q==
X-Received: by 2002:a17:907:75f4:b0:9a2:232f:6f85 with SMTP id jz20-20020a17090775f400b009a2232f6f85mr5639886ejc.52.1693768506565;
        Sun, 03 Sep 2023 12:15:06 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id z17-20020a170906241100b0099bd7b26639sm5136459eja.6.2023.09.03.12.15.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 12:15:04 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so980122a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 12:15:04 -0700 (PDT)
X-Received: by 2002:aa7:d3cc:0:b0:52b:d169:b37b with SMTP id
 o12-20020aa7d3cc000000b0052bd169b37bmr5223697edr.35.1693768504178; Sun, 03
 Sep 2023 12:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230830140315.2666490-1-mjguzik@gmail.com> <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
 <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com> <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
In-Reply-To: <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Sep 2023 12:14:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjrvn+J=z0_schGSROK0HCK-xs4wgky6pRKy7kVLhDeLg@mail.gmail.com>
Message-ID: <CAHk-=wjrvn+J=z0_schGSROK0HCK-xs4wgky6pRKy7kVLhDeLg@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Sept 2023 at 11:49, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Why _is_ glibc doing that thing?

Oh, I think I may see where the confusion may come from.

The glibc people found a "__NR_newfstatat", and thought it was a newer
version of 'stat', and didn't find any new versions of the basic
stat/fstat/lstat functions at all. So they thought that everything
else was implemented using that 'newfstatat()' entrypoint.

But on x86-64 (and most half-way newer architectures), the regular
__NR_stat *is* that "new" stat.

After all, it was only "new" in 1992, long before x86-64 even existed.

So maybe somebody noticed that "__NR_newfstatat" is the only system
call number that has that "new" in the stat name, and didn't realize
that that was just an odd naming thing for strange historical reasons.

The relevant system call numbers are

  #define __NR_stat 4
  #define __NR_fstat 5
  #define __NR_lstat 6
  #define __NR_newfstatat 262
  #define __NR_statx 332

and the numbering very much is about when they were added.

And yes, that "new" in "newfstatat" is misleading, it's the same
'struct stat' as those stat/fstat/lstat system calls (but not the
'statx' one, that has 'struct statx', of course).

On x86-32, which has that extra decade of history, you end up with

  #define __NR_oldstat 18
  #define __NR_oldfstat 28
  #define __NR_oldlstat 84
  #define __NR_stat 106
  #define __NR_lstat 107
  #define __NR_fstat 108
  #define __NR_stat64 195
  #define __NR_lstat64 196
  #define __NR_fstat64 197
  #define __NR_fstatat64 300
  #define __NR_statx 383

where 106-108 are those "new" stat calls.  And then the stat64 ones
are the "new new" ones and the only version that was relevant by the
time we got the 'at()' version.

              Linus
