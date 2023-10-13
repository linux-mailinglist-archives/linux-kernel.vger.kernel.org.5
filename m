Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D9E7C8DB4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 21:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjJMTWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 15:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjJMTWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 15:22:23 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A213A95
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 12:22:21 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9ba081173a3so404022766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 12:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697224940; x=1697829740; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yMlHIs+RXRwcCam9b7W7YcpdMJXw0XO1+U1rinkBh7Y=;
        b=B2UXJ/8UW+lWrvcfgGZ79/xVAgiwWwCcEzlsu5QD4aRfSd0ppsdnw/aHTXkDVhK1+p
         erS3XncMNha87j7pXShBzshTdQGxAoq9oXXwYo7SD0Xmi9WNomuuVkuS43f6j20tFFEW
         uuQDwbsKi2hSojyJsSd/39B9If/BlzqXP0nT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697224940; x=1697829740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMlHIs+RXRwcCam9b7W7YcpdMJXw0XO1+U1rinkBh7Y=;
        b=Nu9iXPqzBZXCsOgxyAxjcziBQJ2DcT7uFyeSCJi9hItzaFa4YdjdjyCgghcV3kCvjs
         2HVkBeruXJ1joDnUdlTGRQXSF/VE9MrmXtdLp1VcTkPWd5aNnRBX4RiVm4lhzD4DxuRx
         rzwroo4DbmQsr8JV5O65LHi4VyBJ1azwyFVBPNUzu19ZPDaaxH/JecMDQoky4Aq6hSD0
         bi1kO+9UVJQJ1pdbg2r+qhNbo26jjPSDCY24+8CM/5Ec2iiMyShow/MaETlHyb8tvODY
         krUBJ9ddmkgPsylkI0nfDO/lL8QaHs6XvXBlJ0WaNHiQsEkjei3MUOhBRRsxwr/feoqJ
         sa0w==
X-Gm-Message-State: AOJu0YwbZJLiMIcz7E6exJNS2/94V/GRrDJJnBXNWwVTVWcq8PTcEWZD
        ABJ9/4vMcWkAUS6YolTH4NT2pSyvlubwjcOTuA9tVxi7
X-Google-Smtp-Source: AGHT+IGzm52kbpIluUC9fFpPd+zxi0YOO+fM8SIN/PYQU1XKPC4QbXS31Vo7iG/3MRKSZM+BCFfX2g==
X-Received: by 2002:a17:906:99c2:b0:9be:7b67:1674 with SMTP id s2-20020a17090699c200b009be7b671674mr40974ejn.3.1697224940182;
        Fri, 13 Oct 2023 12:22:20 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906349500b0099290e2c163sm12607067ejb.204.2023.10.13.12.22.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 12:22:19 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-9ba1eb73c27so403547066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 12:22:19 -0700 (PDT)
X-Received: by 2002:a17:907:7790:b0:9b9:facb:d950 with SMTP id
 ky16-20020a170907779000b009b9facbd950mr17575861ejc.72.1697224939431; Fri, 13
 Oct 2023 12:22:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220927131518.30000-1-ojeda@kernel.org> <20220927131518.30000-26-ojeda@kernel.org>
 <Y0BfN1BdVCWssvEu@hirez.programming.kicks-ass.net> <CABCJKuenkHXtbWOLZ0_isGewxd19qkM7OcLeE2NzM6dSkXS4mQ@mail.gmail.com>
 <CANiq72k6s4=0E_AHv7FPsCQhkyxf7c-b+wUtzfjf+Spehe9Fmg@mail.gmail.com>
 <CABCJKuca0fOAs=E6LeHJiT2LOXEoPvLVKztA=u+ARcw=tbT=tw@mail.gmail.com>
 <20231012104741.GN6307@noisy.programming.kicks-ass.net> <CABCJKufEagwJ=TQnmVSK07RDjsPUt=3JGtwnK9ASmFqb7Vx8JQ@mail.gmail.com>
 <202310121130.256F581823@keescook> <CAOcBZOTed1a1yOimdUN9yuuysZ1h6VXa57+5fLAE99SZxCwBMQ@mail.gmail.com>
 <20231013075005.GB12118@noisy.programming.kicks-ass.net> <CAOcBZOTP_vQuFaqREqy-hkG69aBvJ+xrhEQi_EFKvtsNjne1dw@mail.gmail.com>
 <CAHk-=wjLUit_gae7anFNz4sV0o2Uc=TD_9P8sYeqMSeW_UG2Rg@mail.gmail.com> <5D8CA5EF-F5B0-4911-85B8-A363D9344FA7@zytor.com>
In-Reply-To: <5D8CA5EF-F5B0-4911-85B8-A363D9344FA7@zytor.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Oct 2023 12:22:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiiBpw-0MKBbPkvo54=Cvyi0b3_1bDtqbgiD4ixd+OPow@mail.gmail.com>
Message-ID: <CAHk-=wiiBpw-0MKBbPkvo54=Cvyi0b3_1bDtqbgiD4ixd+OPow@mail.gmail.com>
Subject: Re: [PATCH v10 25/27] x86: enable initial Rust support
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Ramon de C Valle <rcvalle@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        David Gow <davidgow@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-doc@vger.kernel.org
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

On Fri, 13 Oct 2023 at 12:01, H. Peter Anvin <hpa@zytor.com> wrote:
>
> Transparent unions have been standard C since C99.

Ahh, I didn't realize they made it into the standard.

In gcc, they've been usable for a lot longer (ie --std=gnu89 certainly
is happy with them), but the kernel never really picked up on them.

I think they've mainly been used by glibc for a couple of functions
that can take a couple of different types without complaining.

           Linus
