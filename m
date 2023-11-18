Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856AC7F01BC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 18:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjKRR5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 12:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjKRR5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 12:57:23 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218EAAA
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 09:57:20 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9f26ee4a6e5so422528766b.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 09:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700330238; x=1700935038; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eduw7ZGLL5eENX3+AcWvHdPEGppFMGVV13Yx0vFVox0=;
        b=RHTYULPADunx/kNpYRdFn2trk89MqvzIEwy3gxnkQh6r9sollWjeI7XJ7Ca4YySUhI
         U9pilWNFof+0V8YfwM4WQLhQSrg/6uRqywl+jdR7TcFoCrHsB1XPxokyC/sMPuVxDx81
         I3hE92342075xFLHifE/lR4cLN/XEpft7lQCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700330238; x=1700935038;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eduw7ZGLL5eENX3+AcWvHdPEGppFMGVV13Yx0vFVox0=;
        b=pP9qAqcBA2SFTCkAckytOwese5J1yX6kD1mKLUJx5wzUwN79pDPCPoQjP/eah85NIr
         rKWH111sxybcI/+fIW8sEizFS87Cea5WaZGyVyLPA5Apfo8TfGbh65H5pDsiQoxmmFby
         jM9mmF9d21xdkBpKwO0VaVyOwdTo7addiEtFQPVTDYWPi/uyk0AeSoCwgjFwq7iXw7O9
         /MNKPRNQveAUVKB4vat2RMMKiIm2GR437CxisWNsN4pMS6M+t0jAVbpEdeCWVE17R9B5
         1lD7pgYul8HKlG9JwFCGe3GZaM5gwKRgqBIorpO7F1oHZl2kE5QJwMVI4DlRt5idiId1
         iLaA==
X-Gm-Message-State: AOJu0YzLn8zSw9MZegiNRLLyuPmSOzgCP3Fz+QBDM9cCp/wRq/ucHvbJ
        LiyfiAxCNdeWimqICWk756fXyuJCcQEiQzrN1PB1wJAk
X-Google-Smtp-Source: AGHT+IFsPAfMpSafV94LTUdzK2E7qpRSnWLcwwtOqS6gN5Ax66m8tusfAuCDO9Q6kX3u3k0CcEdZHg==
X-Received: by 2002:a17:906:f54:b0:9d0:2da2:ee64 with SMTP id h20-20020a1709060f5400b009d02da2ee64mr1971745ejj.70.1700330238469;
        Sat, 18 Nov 2023 09:57:18 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id j12-20020a170906410c00b009f293faf75asm2092776ejk.97.2023.11.18.09.57.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Nov 2023 09:57:17 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-545ed16b137so4191858a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 09:57:16 -0800 (PST)
X-Received: by 2002:a05:6402:26d4:b0:548:7a3a:ef39 with SMTP id
 x20-20020a05640226d400b005487a3aef39mr1440410edd.35.1700330236507; Sat, 18
 Nov 2023 09:57:16 -0800 (PST)
MIME-Version: 1.0
References: <ZVf/pqw5YcF7sldg@shikoro>
In-Reply-To: <ZVf/pqw5YcF7sldg@shikoro>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Nov 2023 09:56:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi9a9u+1cAxxHw7KxXsfPvdWCbhatK7enFSjgwjrovCZA@mail.gmail.com>
Message-ID: <CAHk-=wi9a9u+1cAxxHw7KxXsfPvdWCbhatK7enFSjgwjrovCZA@mail.gmail.com>
Subject: Re: [PULL REQUEST] i2c-for-6.7-rc2
To:     Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andi Shyti <andi.shyti@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2023 at 16:05, Wolfram Sang <wsa@kernel.org> wrote:
>
> Jan Bottorff (1):
>       i2c: designware: Fix corrupted memory seen in the ISR

I have pulled this, but honestly, looking at the patch, I really get
the feeling that there's some deeper problem going on.

Either the designware driver doesn't do the right locking, or the
relaxed IO accesses improperly are escaping the locks that do exist.

Either way, just changing "writel_relaxed()" to "writel()" seems to be wrong.

Of course, it is entirely possible that those accesses should never
have been relaxed in the first place, and that the actual access
ordering between two accesses in the same thread matters. For example,
the code did

        *val = readw_relaxed(dev->base + reg) |
                (readw_relaxed(dev->base + reg + 2) << 16);

and if the order of those two readw's mattered, then the "relaxed" was
always entirely wrong.

But the commit message seems to very much imply a multi-thread issue,
and for *that* issue, doing "writel_relaxed" -> "writel" is very much
wrong. The only thing fixing threading issues is proper locks (or
_working_ locks).

Removing the "relaxed" may *hide* the issue, but doesn't really fix it.

For the arm64 people I brought in: this is now commit f726eaa787e9
("i2c: designware: Fix corrupted memory seen in the ISR") upstream.
I've done the pull, because even if this is purely a "hide the
problem" fix, it's better than what the code did. I'm just asking that
people look at this a bit more.

                   Linus
