Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66A078BB59
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 01:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbjH1XKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 19:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbjH1XKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 19:10:01 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E2D11C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 16:09:58 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52bcb8b199aso803788a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 16:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693264197; x=1693868997;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fFckp5W8sKS5vhwIF1lyeyi4w6qS96hoCmy4zB/z3t8=;
        b=Am9Cc7rYsoLBswLjcDgFukMpVqC08ZxdsRDGnSTPHPmqJwpWQXftB+fSwhwoRRVJ3R
         7sE//AJbAy3E0VKJeJZW4n/joMRGOzrTYMGPyx1I/YOaiw6Pl77Rb9Um4fokGu1kDjAC
         0qcOaVFZrT3AEdu3WRhNWpwYheOhdughqdiMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693264197; x=1693868997;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fFckp5W8sKS5vhwIF1lyeyi4w6qS96hoCmy4zB/z3t8=;
        b=LjL4VyjhDTPycgR3RMKFVxXmPP1Lio6oHM4XSerw5fm8CXvgtKCut/HQWCfyEqFbdM
         VzqAAG2GHLPuJU/0QyAdizufDKZ02Ck6ACOs4VLX7CHznTk3leU7EjBNBYAdZnqbNBIw
         x3xGy51GTb64lp5lY6xRTv6pvMFQ6t/KtvVefnwzkHB8fMbz/ifVXtYuTTeXajV4vA6l
         /8IaKOxvSVzrIK9pg2O0pXSmgS3MN/aMIwPJoTKc7/IcNZHgcHGfKUlb+YuHgz7Y+pfo
         lIoPEZwK15vPBeSYkiE60U3BGKdft6MgXN3bBIkzNSRNHoUeYCtQicnw7wqm5bL7N5o4
         AaHQ==
X-Gm-Message-State: AOJu0YyXRBgBqKbUN98WNsOJAOiu3uylTuOiHbd2P6KlAEG6a/rM2EJT
        O2PSYVaXcdp8l053ivpJyB8NMIQbSeUIOxdEnqu/5g==
X-Google-Smtp-Source: AGHT+IGpPeVS/Lz27WSntxBUxlm4tWnObKo/TNK4U85b0rzIk7DiNITrIm8wdLDcl08P3eioej8G1g==
X-Received: by 2002:aa7:db58:0:b0:523:3631:876c with SMTP id n24-20020aa7db58000000b005233631876cmr19431061edt.18.1693264197203;
        Mon, 28 Aug 2023 16:09:57 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id n20-20020a056402515400b00525bc41b406sm4987967edd.44.2023.08.28.16.09.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 16:09:56 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-98377c5d53eso482152166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 16:09:56 -0700 (PDT)
X-Received: by 2002:a17:906:5307:b0:9a5:9f3c:9615 with SMTP id
 h7-20020a170906530700b009a59f3c9615mr4246118ejo.63.1693264196404; Mon, 28 Aug
 2023 16:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230828122533.GBZOySPQIjw25NiUqI@fat_crate.local>
In-Reply-To: <20230828122533.GBZOySPQIjw25NiUqI@fat_crate.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Aug 2023 16:09:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjPNoHZm4ukpSXRCpxoCSb59GLgiDZBTgs-yn0=082TFw@mail.gmail.com>
Message-ID: <CAHk-=wjPNoHZm4ukpSXRCpxoCSb59GLgiDZBTgs-yn0=082TFw@mail.gmail.com>
Subject: Re: [GIT PULL] x86/microcode for v6.6-rc1
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 at 05:25, Borislav Petkov <bp@alien8.de> wrote:
>
> please pull the first part of Thomas' microcode loader work, for 6.6.

Bah.

The Zenbleed fix conflicted with this because of how it declared the
amd_check_microcode() function.

The natural way to do it would have been in the new
microcode/internal.h file, but that isn't included by the caller, and
while I could have just done something like

    #include "microcode/internal.h"

in the common.c file, that seemed to be against the spirit here.

So I hacked something up in <asm/microcode.h> instead.

That is probably not what either you or Thomas wanted, but the Intel
code has some similar hacks in that header, so it's not _entirely_ out
of line.

Please just let me know how much I messed up.

I apologize in advance.

                 Linus
