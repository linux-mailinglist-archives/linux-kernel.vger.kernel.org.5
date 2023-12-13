Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8EF811D73
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379190AbjLMSv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbjLMSvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:51:25 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A61DC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:51:31 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5522bfba795so1062513a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702493489; x=1703098289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MFfWf1vauyvhY08vT1vgdH/GPjFu/+lr+ROytlm3Xds=;
        b=a1sVU6/uZtCz1DlI7/ALrPNwMwLRwexR5KVndO3Zns05GoFk7JqwI7H4X/s1601XRt
         3BW1k/atw9IplqAIAYhd3UeQpLNV2Tklm2v0Dt+46KnkdDma41j9S1Jsx/N1oIDC+jgi
         KuxixL+4h2C459+e8iQXiKQh3gU7NTr++ADl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702493489; x=1703098289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MFfWf1vauyvhY08vT1vgdH/GPjFu/+lr+ROytlm3Xds=;
        b=mt0+FOcKlPD1MNj7iMuwNKNlJutKl52numaOA3fgDIxEvi7erQI/nnRERnHe9RE+Tv
         lSH19ZaiIOo/GC/ugnNjo0BNjDOKJALs8h90j+lqDYfZvhHXZo6O4bH6BYSIUxGiUvds
         SdshKKtqY0LVctt1b10deQTw38o2AR5LzprQl0fzEWn8f8D4AGHmh8bF7R1jX2v8QTH2
         E8+ta1BZIwi2IokplfBu0Wqtbk1A59hJDxWkosO44OkPqCVAUOF7FvaoCtgepKCewaVn
         UMUff03/yB46e4paUUtstQdjcIso+WwANw63q202s4A4bZvLYpNQZT1i/jCTGiHrgKbo
         riiw==
X-Gm-Message-State: AOJu0YzZEUMvFQSDlscQmPyZvIfMQHcU+cq1x44uSgLlu2kkV4P5GX7x
        KSiZtX6MTUSbcs+Y+p0um1Xw47Gs4/CSUGoCENF5Oas0
X-Google-Smtp-Source: AGHT+IEmrm6hylljXIeqYxReyzTP1UZPHzuKL2NDaMdjL3d/tP/hwSIPdcSEI63M/5xez3nv1dfP/g==
X-Received: by 2002:a50:858d:0:b0:551:1775:207 with SMTP id a13-20020a50858d000000b0055117750207mr3347894edh.17.1702493489221;
        Wed, 13 Dec 2023 10:51:29 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id dh7-20020a0564021d2700b0054c76d0f755sm5935444edb.42.2023.12.13.10.51.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 10:51:28 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-54c67b0da54so9334263a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:51:28 -0800 (PST)
X-Received: by 2002:a50:a41a:0:b0:551:e52c:3ffd with SMTP id
 u26-20020a50a41a000000b00551e52c3ffdmr1032316edb.6.1702493487931; Wed, 13 Dec
 2023 10:51:27 -0800 (PST)
MIME-Version: 1.0
References: <20231213163443.70490-1-brgerst@gmail.com> <20231213163443.70490-2-brgerst@gmail.com>
In-Reply-To: <20231213163443.70490-2-brgerst@gmail.com>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Wed, 13 Dec 2023 10:51:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=whgooqaEBK27sBMHob9+PwqaZghEsGnSVJsHK=y8U05tw@mail.gmail.com>
Message-ID: <CAHk-=whgooqaEBK27sBMHob9+PwqaZghEsGnSVJsHK=y8U05tw@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: Move TSS and LDT to end of the GDT
To:     Brian Gerst <brgerst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023 at 08:34, Brian Gerst <brgerst@gmail.com> wrote:
>
> This will make testing for system segments easier.

It seems to make more sense organizationally too, with the special
non-data/code segments clearly separate at the end.

So I think this is fine conceptually.

HOWEVER, I think that you might want to expand on this a bit more,
because there are other special segments selectors that might not be
thing you want to expose to user space.

We have GDT_ENTRY_PERCPU for example, which is a kernel-only segment.
It also happens to be 32-bit only, it doesn't matter for the thing
you're trying to fix, but that valid_user_selector() thing is then
used on x86-32 too.

So the ESPFIX and per-cpu segments are kernel-only, but then the VDSO
getcpu one is a user segment.

And the PnP and APM BIOS segments are similarly kernel-only.

But then the VDSO getcpu segment is user-visible, in the middle, and
again, it's 32-bit only but that whole GDT_SYSTEM_START thing is
supposed to work there too.

End result: this seems incomplete and not really fully baked.

I wonder if instead of GDT_SYSTEM_START, you'd be better off just
making a trivial constant bitmap of "these are user visible segments
in the GDT". No need to re-order things, just have something like

   #define USER_SEGMENTS_MASK \
        ((1ul << GDT_ENTRY_DEFAULT_USER_CS) |
         ,,,,

and use that for the test (remember to check for GDT_ENTRIES as the max).

Hmm?

             Linus
