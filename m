Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FF1811E40
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbjLMTJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbjLMTJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:09:31 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987DCD47
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:08:47 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a1e2ded3d9fso883710066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702494526; x=1703099326; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=He9LIJAXXmTz6FKO62nb4k03pMOPRlKulCfOI/ivCO4=;
        b=GcY8a3jcWLRDkmiECsPLq4SKLDvQ4EKscmhi/h/Pm7YnInF2EVrJ9maBQmPt7IgpXc
         fve9O2crDKqIeu7K/yIy8GD4DCDF3RvMsd5nI3wxAsD2FPWpXb4E6jbVTrUJWDk5Mx3Y
         Qd7TH1vWVbYbuTKZewA0Axg8Aq1vADFKpjMws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702494526; x=1703099326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=He9LIJAXXmTz6FKO62nb4k03pMOPRlKulCfOI/ivCO4=;
        b=lG6Xaf7B5hDNpo9NZ96B6JE2uC5j2HBXyYBCZBVpUKxO/4wvWU744Jv4C3Mslx7uKP
         XYRdFI0xuX3NKBrG16fAT/unck+E00J1eb1O83kawKVTVx4b8Z6orEEvxbBnsF7E4+b0
         0hNmdhCL65itsRQkfAPDXoygrTTEUvs/6al03b+H2xmkjrDmEsh5sQ0bzLm5NUxV2cih
         zNMGqOpI4z9XXu3DmVebFotsw/Pp5Vq7UVMmO7/La9+jHyaA4neB/nLV3hU9K3IDDwWf
         RKku0lu0NxJzJVkIEyeLMQAL4oQgGWD4XZfWkzFeqYMZdUUW6/cfhwPqndcQHhw6c7+R
         6Phw==
X-Gm-Message-State: AOJu0Yyavw5hnBTTlYWm6K7eJt1SkkdiqgDHg0fAPUAIpX2oJp5dZKIG
        ccy2KESRazG05R3GvyTWrDg7NZZLQm1qxQJMLc1wFAic
X-Google-Smtp-Source: AGHT+IGLOPghPgWqHIZYxkwqI8vGmaLXLRVS76GO4OgHMkDGxxouO+mHTQGm+w9rrbZQvkq5qLTBzg==
X-Received: by 2002:a17:906:934e:b0:a19:a19b:789d with SMTP id p14-20020a170906934e00b00a19a19b789dmr3753248ejw.96.1702494525868;
        Wed, 13 Dec 2023 11:08:45 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id sk13-20020a170906630d00b00a1d232b39b3sm8345663ejc.145.2023.12.13.11.08.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 11:08:45 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40c256ffdbcso74723695e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:08:45 -0800 (PST)
X-Received: by 2002:a05:600c:993:b0:40b:5e21:d356 with SMTP id
 w19-20020a05600c099300b0040b5e21d356mr4369668wmp.95.1702494524867; Wed, 13
 Dec 2023 11:08:44 -0800 (PST)
MIME-Version: 1.0
References: <20231213163443.70490-1-brgerst@gmail.com> <20231213163443.70490-2-brgerst@gmail.com>
 <CAHk-=whgooqaEBK27sBMHob9+PwqaZghEsGnSVJsHK=y8U05tw@mail.gmail.com>
In-Reply-To: <CAHk-=whgooqaEBK27sBMHob9+PwqaZghEsGnSVJsHK=y8U05tw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Wed, 13 Dec 2023 11:08:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wib5XLebuEra7y2YH96wxdk=8vJnA8XoVq0FExpzVvN=Q@mail.gmail.com>
Message-ID: <CAHk-=wib5XLebuEra7y2YH96wxdk=8vJnA8XoVq0FExpzVvN=Q@mail.gmail.com>
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

On Wed, 13 Dec 2023 at 10:51, Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> We have GDT_ENTRY_PERCPU for example, which is a kernel-only segment.
> It also happens to be 32-bit only, it doesn't matter for the thing
> you're trying to fix, but that valid_user_selector() thing is then
> used on x86-32 too.
>
> So the ESPFIX and per-cpu segments are kernel-only, but then the VDSO
> getcpu one is a user segment.
>
> And the PnP and APM BIOS segments are similarly kernel-only.

Final (?) note: when looking at this, I have to say that our
GDT_ENTRY_INIT() and GDT_ENTRY() macros are horrendous.

I know exactly *why* they are horrendous, with all the history of
passing in raw flags values, etc, and you can most certainly see that
whole thing in the GDT_ENTRY() macro. It's used in assembly code in a
couple of cases too.

But then you look at GDT_ENTRY_INIT(), and it turns that illegible
"flags" value into (slightly more) legible S/DPL/etc values. So it
literally makes people use those odd "this is how this is encoded"
values even when the code actually wants to use a structure definition
that has the flags split out.

I guess it's much too much work to really fix things, but maybe we
could at least add #defines and comments for the special values.

So instead of

        GDT_ENTRY_INIT(0xc093, 0, 0xfffff)

we could maybe have

       #define GDT_ENTRY_FLAGS(type,s,dpl,p,avl,l,d,g) \
                ((type) |
                 (s)<<4) | \
                (dpl) << 5) | ....

and have #defines for those 0xc093 values (with comments), so that we'd have

        GDT_ENTRY_INIT(KERNEL_DATA_FLAGS, 0, 0xffff)

instead of a magic 0xc093 number.

This would require some nit-picky "read all those values and know the
crazy descriptor table layout" thing. Maybe somebody has a serious
case of insomnia and boredom?

           Linus
