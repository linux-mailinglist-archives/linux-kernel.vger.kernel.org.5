Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDFD7E0E9A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 10:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjKDJZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 05:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKDJZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 05:25:48 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540E1B8
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 02:25:45 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-409299277bbso20423755e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 02:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699089944; x=1699694744; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8n8ZiPmB4jr2dMWJOl0l5VVT7a0wTFVPtrw1M6Upy3M=;
        b=eICqnRo64dmbmKHORgaaN4HPedpweDqV+dpmtTZwDITuycpn2xjvgjd5bOvRq/SqVl
         eldIer0PTiA5+1Yo1KXKBMrnBRyyG1m5PfX1oCqI30b0A0e46v94mB8FykjLvD5ctCQH
         b+wkMzon3Lr/n7tYoVl5BwnsBkfLClBP12nDqoVT+9zoZNXOlPJMTIBK+Q5hGMZz3fks
         yWVQAZMRtPJEaOB3ipQ6rnIJjKOOPnc3Ca1PMti1etfxlxmwsdCVJIRHdduSMXMIDYAs
         qGGyBwiJcue4z2REdy3UTgT6PDwoDtyyYbflqiy2LG3/NZ/poj/FxRS9N2MSCz3MSyqG
         wwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699089944; x=1699694744;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8n8ZiPmB4jr2dMWJOl0l5VVT7a0wTFVPtrw1M6Upy3M=;
        b=sExYLXuPCv+9lmS3Yd5vtHjZXqJB2oHnLOt2BFz3Dx0K4kyJy1M+KiMDm2+ye1Wgf0
         jUB3tziPZ3sJwAfQu+A7m9Dp4mE9dn99ZtC8K0nr7Zpw/YGLhq3qwGqDzoodBiRpE+N+
         sML+yEKEoil/zwxZZjsAdvXAYXN2qQfmh0irEXDByTRafjoGdk2JjK9rFKYBr9K8jAIp
         1D1tNr84DlTc2aI1xQD8KE8ATme7cwCH1QyJHdv++h8boeSRaUaetAFTfHVtzqjxDjtm
         Q2F5we/FrdGogG6g8AY6tX//3TrxqpAjX/N+3QOln1BjoQzupm4IAAHIPHl20AOmWdNU
         GLEw==
X-Gm-Message-State: AOJu0YyWbvgOeGLPMI+tq0GTZ5jBlUOix/mBjojtwEYyrP3X5AE4hrn/
        gEYGfioBuqb46Sapnjo5ygA=
X-Google-Smtp-Source: AGHT+IGJsu2qJKTMPj7eKYmqfk0hAA4wVDY3dIZfG79rYGKOvhpMc409fuZYWkfA7PuZmgNg52Ndrw==
X-Received: by 2002:a05:600c:4f92:b0:402:f55c:faee with SMTP id n18-20020a05600c4f9200b00402f55cfaeemr18964536wmq.26.1699089943307;
        Sat, 04 Nov 2023 02:25:43 -0700 (PDT)
Received: from smtpclient.apple ([77.137.74.70])
        by smtp.gmail.com with ESMTPSA id du15-20020a05600c634f00b00405959bbf4fsm5009150wmb.19.2023.11.04.02.25.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Nov 2023 02:25:42 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Missing clobber on alternative use on Linux UM 32-bit
Message-Id: <24BD0906-C6FE-499C-9A4A-00C56E6EE84A@gmail.com>
Date:   Sat, 4 Nov 2023 11:25:31 +0200
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
To:     Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was reading (again) the x86 C macro of =E2=80=9Calternative()=E2=80=9D =
and I was a bit
surprised it does clobber the flags (=E2=80=9Ccc=E2=80=9D) as a =
precaution.

  #define alternative(oldinstr, newinstr, ft_flags) \
	asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, ft_flags) : =
: : "memory")

Actually there seems to be only one instance of problematic cases - in =
um/32-bit:

  #define mb() alternative("lock; addl $0,0(%%esp)", "mfence", =
X86_FEATURE_XMM2)
  #define rmb() alternative("lock; addl $0,0(%%esp)", "lfence", =
X86_FEATURE_XMM2)
  #define wmb() alternative("lock; addl $0,0(%%esp)", "sfence", =
X86_FEATURE_XMM)

Presumably, if XMM or XMM2 are not supported, there would be instances =
where addl
would be able to change eflags arithmetic flags without the compiler =
being aware
of it.

As it only affects 32-bit Linux UM - I don=E2=80=99t easily have an =
environment to test
the fix. An alternative (word-pun unintended) is to add =E2=80=9Ccc=E2=80=9D=
 as a precaution
to the alternative macro.

