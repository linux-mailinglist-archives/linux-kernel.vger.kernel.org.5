Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328D2776E78
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 05:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjHJDXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 23:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjHJDXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 23:23:31 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3654AFE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 20:23:28 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9dc1bff38so6684061fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 20:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691637806; x=1692242606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ibKCFMsqr9h7nFVLXHHnq2F8iFv4XT2OsD92lPSW7xk=;
        b=MwybxUlpMzFWs6xgiZQ9eqO40Ixq3vaXfkP6iFPsOsAcCFBD3r1H0Lk6xxUVz/yoQf
         Wms1kmMTZvlR1BQ9jwJq9IQdVDWkXpMCi7zvKGCOzXulqeuHbB/vt0az3QkkSbrjFVbh
         WzvR6zSHl4/SWs3MwMsKZPPs2/dL2J5eatcDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691637806; x=1692242606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ibKCFMsqr9h7nFVLXHHnq2F8iFv4XT2OsD92lPSW7xk=;
        b=Cwjoflj6gifPOBB5IdRZv9K7ohwQaoNPMqO1T4uHCCUVj5v5cj1lKVF2swtrsSl2kF
         kIH9rXDyvUQIaSSByErUtURKCJTj47HBgM2MfqW1tPaFeaq+pm1dKxdBmuKJmhvDQMDd
         79LLr4O0i0IupHFtwdzyxLiVsQmL5v+39LJMc21Wp+cmiaK9BZl1DdAzCSc6TbsJSJn9
         +ZrpJB/vG37W0vsJIEg8euUdjVsEQ+FlbPAAMyXaDg88/ooc7gZpr3HqR0nHnL6ntM0k
         kWSeVbSnrEfY0w9t0gliTlwVGkdvUpuQaxmILfeWMP3/qsvF61fQsLnZP1EDDfdPkvWv
         hWkQ==
X-Gm-Message-State: AOJu0YzSSpZYGEKLfHUpPSV1JfyHEGUqQPDI5JPiagVuDwEhyHe/VPd4
        XgLhOAtd78KI5aHZSL0poy5Lpr4y16ehznblPO/gugTc
X-Google-Smtp-Source: AGHT+IE+5+UVPnXDwYcCC5IJRB2LHGfnPsQ5vGcGO9b+fw7fUn04WloPFELKMMXYYBg60QRDRkePfw==
X-Received: by 2002:a2e:8ed2:0:b0:2b6:3651:f12f with SMTP id e18-20020a2e8ed2000000b002b63651f12fmr786118ljl.3.1691637806073;
        Wed, 09 Aug 2023 20:23:26 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id qt27-20020a170906ecfb00b0099bd046170fsm313292ejb.104.2023.08.09.20.23.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 20:23:25 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-99cbfee358eso65366066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 20:23:25 -0700 (PDT)
X-Received: by 2002:a17:906:5a55:b0:98d:5ae2:f1c with SMTP id
 my21-20020a1709065a5500b0098d5ae20f1cmr754280ejc.34.1691637804869; Wed, 09
 Aug 2023 20:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230809202356.357339-1-andrew.cooper3@citrix.com>
 <CAHk-=wiic4XViHp0=0pjLnQALRpfda+naY0ysZdK6Fia86hh2w@mail.gmail.com> <1e3c8c24-6d94-d325-6661-ee44be073e46@citrix.com>
In-Reply-To: <1e3c8c24-6d94-d325-6661-ee44be073e46@citrix.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Aug 2023 20:23:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjvCmUSD5sqFDgN3QNi1q=C5A=G2xDNToFP-ktCF3UjJg@mail.gmail.com>
Message-ID: <CAHk-=wjvCmUSD5sqFDgN3QNi1q=C5A=G2xDNToFP-ktCF3UjJg@mail.gmail.com>
Subject: Re: [PATCH] x86/AMD: Fix ASM constraints in amd_clear_divider()
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
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

On Wed, 9 Aug 2023 at 16:12, Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>
> But IMO, the risk of someone copy&pasting this as if it were a good
> example, and the debugging thereafter ought to be enough of a reason to
> avoid klever tricks to save 1 line of C.

That's not the point. The point is that this is very special code, and
there's no way you can copy-and-paste it for anything else.

In fact, the very lack of outputs in the asm is part of what makes
such a copy-and-paste impossible.

You copy-and-paste that thing, and you simply don't get any useful
results, because the asm doesn't have any outputs.

There's literally no other possible use of that asm than as a "this
doesn't do anything but write to whatever stale divide buffers".

In other words, you might as well have fun with it. Because it is in
no way useful in any other way.

And I think that's a feature. This is *literally* not a divide that
gives any useful output. Don't try to make it look like it does.

              Linus
