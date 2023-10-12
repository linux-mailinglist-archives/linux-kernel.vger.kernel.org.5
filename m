Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01EC7C6551
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377371AbjJLGTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377391AbjJLGTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:19:21 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0535DCC
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:19:20 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53b8f8c6b1fso1077519a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697091558; x=1697696358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OP6CltxnY4Me7Dc35n6Y2Bjbp3x6k8MvTeVPFVgLbUU=;
        b=JrpF20nG0NeQS9N2jllu71jtRtwDuY0MYv1Mx8nIuSFFDK1i+QwOwZdVMhFx2KnLKj
         59fOZY2YutA3x9YcOd6T1G5H1VL+ie6JQ4UZBUnXMwEUK/8SizaXNA4RV+UGevynDWEF
         nC2stWqp99Rl+kj1lhgsrPf942M4wUHaOCrAzldYuThKhrGTm4X2yFjfUJM8ziQ2CG9L
         W8agLKMSftkKNatM6wF6ZucACp0WZEVeUIvix7SW77ZVyQjuz0iF/39MJT5yiOGIMa/h
         msI/guBk/PRJMcsO7TfM0gg+T9zANzD2j5TIw6AXiQCe3ygkHuR1h5WKygLMLOLIMpJL
         VDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697091558; x=1697696358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OP6CltxnY4Me7Dc35n6Y2Bjbp3x6k8MvTeVPFVgLbUU=;
        b=B/CoPNlAvghDP4dJgkoMgH8nCz92uPk0AcUsjjPR14Rur1Lt3ke/M3h4zd1ut1Hcxb
         VPAjQawViyhAhsfXse91vTyolZ8URPmkw4w30KHk8kN1dg+Ja0eMvj5R/XSAQuwNU/2p
         O5nOA0yAI3KiSBEIwqbqLNVNzZip0kOCRKHss2PKYwr2e4+MgKSK77dmkx4Wt/Z2Ar+l
         36MN/s4zrqb+u57uN/RkjV3zABCWop9WcrtcQiDSJvD9HY8nUWPDZDyE2HAbd+qfVDkX
         c+zDRhwG/bm34Q2tiyzYuNEBIaRWABWRejqZoKNanQGdSmhgZkOsTBwEV/jZBPQWp+u/
         dxVQ==
X-Gm-Message-State: AOJu0YzjIlvpVNTwsgH0UpZ+DVmb9aFcVhM6dMAkRNXNE5qsQbVuSFeo
        2IeNFgmyYtL3u3RT8JinPFM=
X-Google-Smtp-Source: AGHT+IFq2FiZlj4uG5+xGmhwb55BL1RglItA0tzU9sTuMidOYUaP2+qnKDe6r7rwkj8VoXLtN8i8kw==
X-Received: by 2002:a17:906:318e:b0:9b2:d554:da0e with SMTP id 14-20020a170906318e00b009b2d554da0emr18382302ejy.69.1697091558223;
        Wed, 11 Oct 2023 23:19:18 -0700 (PDT)
Received: from gmail.com (1F2EF405.nat.pool.telekom.hu. [31.46.244.5])
        by smtp.gmail.com with ESMTPSA id j16-20020a170906051000b0099bcf1c07c6sm10688100eja.138.2023.10.11.23.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 23:19:16 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 12 Oct 2023 08:19:14 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
Message-ID: <ZSeP4vwQ9k/v63Cy@gmail.com>
References: <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <CAFULd4Y8NSArDqH=VMy8F97eNosUUGxrBMEyHH=MytjUBSCmjg@mail.gmail.com>
 <CAHk-=whMr8V_q3dq4iS0dpx4Nssu+aYWz+mA36p2ykA+OXTjXA@mail.gmail.com>
 <CAFULd4afyYK0-wAOo3oJDapX0iyu86m5+vVn9c35gk8fd6iwRQ@mail.gmail.com>
 <CAHk-=wiLyA0g3BvQ_nsF2PWi-FDtcNS5+4-ai1FX-xFzTBeTzg@mail.gmail.com>
 <ZScjptMn3fDmMFdg@gmail.com>
 <9b71932a-d410-4b92-b605-d6acc5d35069@zytor.com>
 <20231012013507.jrqnm35p7az6atov@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012013507.jrqnm35p7az6atov@treble>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> Though, another problem is that .text has a crazy amount of padding
> which makes it always the same size, due to the SRSO alias mitigation
> alignment linker magic.  We should fix that somehow.

We could emit a non-aligned end-of-text symbol (we might have it already),
and have a script or small .c program in scripts/ or tools/ that looks
at vmlinux and displays a user-friendly and accurate list of text and
data sizes in the kernel?

And since objtool is technically an 'object files tool', and it already
looks at sections & symbols, it could also grow a:

	objtool size <objfile>

command that does the sane thing ... I'd definitely start using that, instead of 'size'.

/me runs :-)

Thanks,

	Ingo
