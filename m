Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2EA7C8C92
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjJMRsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 13:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMRsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:48:41 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF266BB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 10:48:39 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9936b3d0286so396160766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 10:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697219318; x=1697824118; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xDPc1YioSb3KUnMIDBSq84//2Atay2Wv50Tb3yT+Q0Q=;
        b=IAbL9s0oSv63uxy7HvVk3Km1zT9yzKFxA0KQ7u+5D03v0pmqDREYJkThecWgqY3Zgl
         x2yqhITBSI9ZPs9KddFdnh/25aA+KwrGugwWGpeFV89iDtRGiJtNo06G87MT8FJjxRcI
         4hRXDu2psyCmGUXRZr2x0l3K7Suz6Me7Z0hJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697219318; x=1697824118;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xDPc1YioSb3KUnMIDBSq84//2Atay2Wv50Tb3yT+Q0Q=;
        b=FjbzUXZTs+XZ71ud+4q+EuORK3swjYjb+KRyD18vNxl4ICy2fIX1mMxTVqeDGcwFVh
         WAfAtVzKxBZueha1awvGD5wJ0Bm3BWFkWjisvw8epdKEqpbMxOHB/UWXmxYY8/cJzLJm
         CHa9Jp0sILMgBu1UZSaEGoladm77dyCkbv94Ra0InRTbbsADA1sC4hdNbiGuYiXdYWw+
         991x+aWqlpxaBZJC7iCrnBZpBcaMfur/wY1vPxvNpgAPGyx2NXxgViGiB+guSSJRKxbj
         ++tVYP4o6srNqs3Ijmyp7ht+XteyiSXJVCvI7ndZva8GTtle8IrEsMS9GWicyV0fVzJt
         PiaA==
X-Gm-Message-State: AOJu0YySGlXGqbvx9g4G/McMugr16pq7WfC2C+vf6/3G/aFjeQE2QSa/
        nSl/mbgfvp3q9C17MD48voeQmlbVq9NVVS9Y/cuBaQ==
X-Google-Smtp-Source: AGHT+IEp1diNMol+ba2NN4E/d68ZcALq7aK1xCDYre4/Ya5RZYugzBxxhYEBOKFbm8OC0fG9HWEFSA==
X-Received: by 2002:a17:906:10a:b0:9a1:cbe4:d029 with SMTP id 10-20020a170906010a00b009a1cbe4d029mr28246808eje.74.1697219317955;
        Fri, 13 Oct 2023 10:48:37 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id si5-20020a170906cec500b009b97d9ae329sm12656675ejb.198.2023.10.13.10.48.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 10:48:37 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-536b39daec1so3989864a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 10:48:37 -0700 (PDT)
X-Received: by 2002:a17:907:7702:b0:9ae:5523:3f84 with SMTP id
 kw2-20020a170907770200b009ae55233f84mr22085726ejc.72.1697219316989; Fri, 13
 Oct 2023 10:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <e6d1dae8-e28a-455a-a851-661c825fbdcf@gmail.com> <9787bd09-91b3-4a79-9ca9-e7199c925f36@leemhuis.info>
In-Reply-To: <9787bd09-91b3-4a79-9ca9-e7199c925f36@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Oct 2023 10:48:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj99i00K5ZD_OJj3d8rLG07bnTH=0_GxpzxrSzNF-WYQQ@mail.gmail.com>
Message-ID: <CAHk-=wj99i00K5ZD_OJj3d8rLG07bnTH=0_GxpzxrSzNF-WYQQ@mail.gmail.com>
Subject: Re: [regression] some Dell systems hang at shutdown due to "x86/smp:
 Put CPUs into INIT on shutdown if possible" (was Fwd: Kernel 6.5 hangs on shutdown)
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Yanjun Yang <yangyj.ee@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
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

On Fri, 13 Oct 2023 at 05:05, Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> Thomas, turns out that bisection result was slightly wrong: a recheck
> confirmed that the regression is actually caused by 45e34c8af58f23
> ("x86/smp: Put CPUs into INIT on shutdown if possible") [v6.5-rc1] of
> yours. See https://bugzilla.kernel.org/show_bug.cgi?id=217995 for details.

That commit does look pretty dangerous.

If *anything* is done through SMI after the code does that
smp_park_other_cpus_in_init() sequence, I wouldn't be surprised in the
least if the machine is hung.

That's made worse since it looks like the shutdown sequence isn't
necessarily run on the boot CPU, so the boot CPU itself may be in
INIT, and any SMI quite possibly ends up treating that CPU specially.

Who knows what SMI does, but the fact that the affected machines seem
to be mainly from one particular manufacturer does tend to imply it's
something like that.

And the code does do a fair amount *after* shutting down cpu's. Not
just things like calling x86_platform.iommu_shutdown(), but also
things like possibly the tboot shutdown sequence (which almost
*certainly* is some SMI thing).

I dunno. Thomas - I htink the argument for that commit was fairly
theoretical, and reverting it seems the obvious thing, unless you have
some idea of what might be wrong.

               Linus
