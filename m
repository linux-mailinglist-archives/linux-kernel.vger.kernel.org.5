Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA4E7F4BAA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344434AbjKVPyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjKVPyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:54:21 -0500
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3283F9A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:54:16 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a02d91ab195so250190066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:54:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700668454; x=1701273254;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=88zGKO0u2d1EqGTMiuipUFLdoa0y0OnWP5heo1AegpM=;
        b=G8N+p07f/3XGUC7+C6ikArOhn4djOJjPk/mKaXzr2vF7i8T0wW5ZxQwTbu/75x4bY/
         MisrlfhaaJVB5L4t+rM5E0fflB79i1rhklJjwWgKc5hGKvG6xe34TEJJ/QG9y1CfhfIN
         2aeknUj7P8yRdhqSFmchnjaLvCJMlY5yBFeqS3v6q1sblf16pvOnBNsjGN+4rZrNQkWr
         h4wFyMuEvrBEQYUnX5uXJ+xdngAj1gm8yRFopeHbdOWnQL+9BX1++M1jGenzRZ61+4vW
         e+4HOL1ROy7piAgmORfObEye2Ghdpd8rOw21O4kRaOp/kNCa1d+vBE2kO7UnYQhrT7cs
         cvxA==
X-Gm-Message-State: AOJu0YwuCXs1WNaByiRKk25ZFNVcmI0jHg0TUKaAapfNmULwmrhgn9Rq
        I0z2LOWmeDtfvQJHkhqZJbs=
X-Google-Smtp-Source: AGHT+IHKtwVbEBFJt56M5j6JgEXxkGkuL+8xdA4PplrV+YA6mxTLAf9rCeo3ZDGz47WEufD4IMwZeQ==
X-Received: by 2002:a17:906:60c:b0:9fd:1e2c:bd8a with SMTP id s12-20020a170906060c00b009fd1e2cbd8amr1794436ejb.50.1700668454416;
        Wed, 22 Nov 2023 07:54:14 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-117.fbsv.net. [2a03:2880:31ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id i22-20020a1709063c5600b009e6b6681da7sm6860125ejg.94.2023.11.22.07.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 07:54:13 -0800 (PST)
Date:   Wed, 22 Nov 2023 07:54:11 -0800
From:   Breno Leitao <leitao@debian.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     jpoimboe@kernel.org, mingo@redhat.com, tglx@linutronix.de,
        bp@alien8.de, Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, leit@meta.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Sven Joachim <svenjoac@gmx.de>, Ian Kent <raven@themaw.net>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Juergen Gross <jgross@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jinghao Jia <jinghao@linux.ibm.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v6 10/13] x86/bugs: Rename RETHUNK to MITIGATION_RETHUNK
Message-ID: <ZV4kI2mu6fBVcZn9@gmail.com>
References: <20231121160740.1249350-1-leitao@debian.org>
 <20231121160740.1249350-11-leitao@debian.org>
 <da12ea3e-8fef-49d4-aea1-40a46a5ae056@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da12ea3e-8fef-49d4-aea1-40a46a5ae056@citrix.com>
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On Tue, Nov 21, 2023 at 09:39:47PM +0000, Andrew Cooper wrote:
> On 21/11/2023 4:07 pm, Breno Leitao wrote:
> > CPU mitigations config entries are inconsistent, and names are hard to
> > related. There are concrete benefits for both users and developers of
> > having all the mitigation config options living in the same config
> > namespace.
> >
> > The mitigation options should have consistency and start with
> > MITIGATION.
> >
> > Rename the Kconfig entry from RETHUNK to MITIGATION_RETHUNK.
> >
> > Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> (I'm CC'd on only this single patch so I can't see what's going on, but)
> 
> Really?  Rethunk[sic] isn't a mitigation.  It's just a compiler
> transformation for return instructions upon which various mitigations
> depend.

The MITIGATION namespace is not only for mitigation, but, for "features"
that are available with the only purpose of mitigating speculative
hardware vulnerability. The original suggested namespace was "MITIGATE",
and then it would make no sense for RETHUNK, since, we are not
mitigating RETHUNK per se. Please check the discussion here:

 https://lore.kernel.org/all/20231011044252.42bplzjsam3qsasz@treble/

That said, the way the x86 Kconfig is organized today, CONFIG_RETHUNK is
very focused in solving a mitigations problem, thus, the MITIGATION_
namespace has been added to it.

For instance, CONFIG_RETHUNK is inside the SPECULATION_MITIGATIONS,
thus, it is only enabled if SPECULATION_MITIGATIONS is set.

  menuconfig SPECULATION_MITIGATIONS
  bool "Mitigations for speculative execution vulnerabilities"

	config RETHUNK
		bool "Enable return-thunks"
		depends on MITIGATION_RETPOLINE && CC_HAS_RETURN_THUNK
		help
		  Compile the kernel with the return-thunks compiler option to guard
		  against kernel-to-user data leaks by avoiding return speculation.
		  Requires a compiler with -mfunction-return=thunk-extern
		  support for full protection. The kernel may run slower.

  endif

Thanks for the feedback.
