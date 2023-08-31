Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA2A78E564
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 06:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245204AbjHaEWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 00:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjHaEWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 00:22:05 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CBABC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 21:21:51 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c93638322so70925666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 21:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693455709; x=1694060509; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PHb9iCWiCKsZWNp88MghqnJTU1cLcLheiIAV94LFPoE=;
        b=PkyLz0ZBV+qp8OBntWAZCNEyRFJrzgNgDajgxmi45wiC/JKm2qWMF7FRTCd4qIw6kZ
         XlfbQ7TyWrvPFUDygTWUN/DiBUb5ZqYEv08cnutWEoALfhveb76UjVy38g/TD6htSfqv
         vCXpmJgon0j4fSjfTNNZfCknRjGAGjwSI3rNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693455709; x=1694060509;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PHb9iCWiCKsZWNp88MghqnJTU1cLcLheiIAV94LFPoE=;
        b=htW+P5OmM+pOJIi7UP5GaNwGkOnw2ICQOjJHQ1K8VhbYsRBJYGqfE7pjJtoXjpxoZv
         VmeelU9tUkQPvgPJPIqpl2x4zFJuuzXQCoY42A0R4/DFypAfV0x3JP3joHDeAHy40pNc
         QcGzJys/Nra/lKIJqVPOiCe3Gy1jdjKcDvPBqZNX66CW/lFWZi6duJBoe0x6T164Qj36
         GudGXZCbGOkumhZYEYiZmy+FLVxF962noQR7NTV487hJ8eHZrahaHgmsSU0UPyBMQOzX
         uJxO7xRL8q3WPmWsgBei371Lt4NeEDAOQw7PNjVsZKv28EfqDSm3TTdCqxt0aTJaQ/qe
         reig==
X-Gm-Message-State: AOJu0YzOITMJMRpLxB6wgSLR4Tfbid8MyrSqNDOGGDsW8VytXXouyJpK
        06YVeKOgseABKXj09vKAWd2fRa7Ks2qSUGEnHHyyiQ==
X-Google-Smtp-Source: AGHT+IGch6fKWQjcQ6+9vWBM1kX2eH5S26z6YWc4o1CLnpG5dFGil64kwjmL2Yfscfn6x2EiigotZQ==
X-Received: by 2002:a17:906:f49:b0:98e:4f1:f987 with SMTP id h9-20020a1709060f4900b0098e04f1f987mr1290374ejj.3.1693455709413;
        Wed, 30 Aug 2023 21:21:49 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id t11-20020a1709064f0b00b009932337747esm288260eju.86.2023.08.30.21.21.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 21:21:48 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-9a1de3417acso343575366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 21:21:48 -0700 (PDT)
X-Received: by 2002:a17:906:310a:b0:9a5:f038:a4c1 with SMTP id
 10-20020a170906310a00b009a5f038a4c1mr1825108ejx.26.1693455708372; Wed, 30 Aug
 2023 21:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mtpOtiP3Hk6FJPav8tYDhKJTQmELP31zYzVxf4DPNKbiQ@mail.gmail.com>
In-Reply-To: <CAH2r5mtpOtiP3Hk6FJPav8tYDhKJTQmELP31zYzVxf4DPNKbiQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Aug 2023 21:21:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiCPoGieS-hkV+ze6UqvzNyPNT7WoD_v54ZuVwi-d5Bmw@mail.gmail.com>
Message-ID: <CAHk-=wiCPoGieS-hkV+ze6UqvzNyPNT7WoD_v54ZuVwi-d5Bmw@mail.gmail.com>
Subject: Re: [GIT PULL] smb3 client fixes
To:     Steve French <smfrench@gmail.com>
Cc:     Dave Kleikamp <shaggy@kernel.org>,
        "Dr. David Alan Gilbert" <linux@treblig.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, 30 Aug 2023 at 13:48, Steve French <smfrench@gmail.com> wrote:
>
> - move UCS-2 conversion code to fs/nls and update cifs.ko and jfs.ko to use them

I've pulled this, but I think the new NLS_UCS2_UTILS config option
shouldn't be something that is asked about. The filesystems that want
it already select it, and users shouldn't be asked about a module with
no use.

The way to do that is to simply not have a user query string for it,
ie instead of

  config NLS_UCS2_UTILS
          tristate "NLS UCS-2 UTILS"

it could be (an dI think should be) just

  config NLS_UCS2_UTILS
          tristate

which tells the config system not to ask users about it.

Because users really shouldn't be asked questions that there is no point in.

And then, on a purely visual commentary about your pull request -
lines like these are just noise:

>  fs/{smb/server/uniupr.h => nls/nls_ucs2_utils.c} | 156
> +++++-------------------------------------
>  fs/nls/nls_ucs2_utils.h                          | 285
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

and the problem seems to be that you generate the diffstat in a very
wide terminal (where git tries to be helpful and give you lots of
detail), and then you cut-and-paste the result.

If you pipe it to a tool instead (xsel, perhaps), git will limit the
width of the diffstat to something sane.

Or, if you really want to use a terminal and cut-and-paste it
manually, you could try to tell git to use '--stat=72' to limit the
stat to 72 characters (which is the canonical "width for email", as
the Lord spake unto us all in rfc822, even if the Lord was confused
and also mentioned the number 65).

                         Linus
