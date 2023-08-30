Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600A078DF0E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241481AbjH3TTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243200AbjH3KSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:18:39 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7E41B7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:18:35 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7923ae72111so194718139f.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693390715; x=1693995515; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OP1LgWzoGhEjsjDMUhRzMucVKH/U+zqBw+ArzgUhqBs=;
        b=EI/w92x72VOPT4SZD/7eh/4otRlHkg81LbDubr4RBX+fJ5tA8GkEcJLpYZFTr4LBSF
         48AouyCjnhXWClT8R9566ieZ9TUy8olFxfEqKXWb7WhInSfDp7BVkPCObbRhh44tPr9O
         SmibuHnFjmH20RO/+m/97G9gYv2RLMDaCNd4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693390715; x=1693995515;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OP1LgWzoGhEjsjDMUhRzMucVKH/U+zqBw+ArzgUhqBs=;
        b=XB21VAQHFFk/XWuuDKeahRdpfgPG49j1GHtDNR9g9aZ4O0htU9g+oqEcsgEKxTgGkt
         r6So2M9QbPfs6ZMrwVOFvYAguhmechFT6wnSV5Us8Fx+VbbtvPNa58BX1xh1nRqS1d9+
         jzLcH8cd975Y9vsCMQnHp5Aw4Qc2YTmUN/FHFz9zYR/xZrABXjzcTsSCCRXxM5R1fieC
         zjbQ282vZpLhYGQiFWiTZy/cKBDbXL2C20D/U7wmMH73jhtifGi8wVBYgz+RXJYd3Pgv
         Z9xeA7WevOGjjD0AclleiBLP4xH3a2jUy2V8Cqaw9DF1prholVHakwRnxe1qBwIj2vsV
         pfmg==
X-Gm-Message-State: AOJu0YyttmoeFt28B8Wl28nqVRR8+ji45cENNbvNVuIIfkwac93DT4Y7
        SaCj/OiXXaory0P2TZU0sGvLWQ==
X-Google-Smtp-Source: AGHT+IG3k2+yMtXHAP9nLcsR9EPP888/ZCoqSPE1tFAcn3dj8YgJkcEF/dU7zXKS4kNi7fSDVC2vRw==
X-Received: by 2002:a05:6602:19da:b0:786:71d0:ff9b with SMTP id ba26-20020a05660219da00b0078671d0ff9bmr2199117iob.10.1693390714826;
        Wed, 30 Aug 2023 03:18:34 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id i15-20020a02cc4f000000b0039deb26853csm3800016jaq.10.2023.08.30.03.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 03:18:34 -0700 (PDT)
Date:   Wed, 30 Aug 2023 10:18:33 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     paulmck@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Z qiang <qiang.zhang1211@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>
Subject: Re: [PATCH V4 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
Message-ID: <20230830101833.GA310377@google.com>
References: <2681134d-cc88-49a0-a1bc-4ec0816288f6@paulmck-laptop>
 <20230828133348.GA1553000@google.com>
 <142b4bff-6a2e-4ea0-928c-3cfe9befa403@paulmck-laptop>
 <CAAhV-H4MrUm2xZdZyAALV-r+aKMRQ50v6me6hybpR1pRijirqw@mail.gmail.com>
 <CAEXW_YT-z6s+4MnxTnwFk2-mPba65dbnZogdPDSr14LmOW-h-g@mail.gmail.com>
 <CAAhV-H5tYV=ezPY_O7c=sd3DULB6BjoiYnw9nE2EzDFaBHcKPw@mail.gmail.com>
 <CAEXW_YTfV1NVb3tOhunHZK_6oeUHxz_azv6uVq3k0O2UEAX5OQ@mail.gmail.com>
 <CAAhV-H6oN69rV2OyGzUganRv4KbS7a3_gNyWhCqVp51Ay9Q_=g@mail.gmail.com>
 <CAEXW_YRpT8wcLmsaHA6yMQ-ZCNYG7v4b4m-qvLHVxcbOJJcrPg@mail.gmail.com>
 <CAAhV-H62o96sgwWK7JAh+GOP=KNtZGS0HjVgHR19jJS1ONJW2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H62o96sgwWK7JAh+GOP=KNtZGS0HjVgHR19jJS1ONJW2Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 12:25:56PM +0800, Huacai Chen wrote:
> On Tue, Aug 29, 2023 at 10:46 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Tue, Aug 29, 2023 at 12:08 AM Huacai Chen <chenhuacai@kernel.org> wrote:
> > >
> > > Hi, Joel,
> > >
> > > On Tue, Aug 29, 2023 at 4:47 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > >
> > > > Hi Huacai,
> > > >
> > > > On Mon, Aug 28, 2023 at 11:13 AM Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > >
> > > > [...]
> > > > > >
> > > > > > > [Huacai]
> > > > > > > I also think the original patch should be OK, but I have another
> > > > > > > question: what will happen if the current GP ends before
> > > > > > > nr_fqs_jiffies_stall reaches zero?
> > > > > >
> > > > > > Nothing should happen. Stall detection only happens when a GP is in
> > > > > > progress. If a new GP starts, it resets nr_fqs_jiffies_stall.
> > > > > >
> > > > > > Or can you elaborate your concern more?
> > > > > OK, I will test your patch these days. Maybe putting
> > > > > nr_fqs_jiffies_stall before jiffies_force_qs is better, because I
> > > > > think putting an 'int' between two 'long' is wasting space. :)
> > > >
> > > > That's a good point and I'll look into that.
> > > Another point, is it better to replace ULONG_MAX with ULONG_MAX/4 as
> > > Paul suggested?
> > >
> >
> > I could do that but I don't feel too strongly about it. I will keep it
> > at ULONG_MAX if it's OK with everyone.
> >
> > > > Meanwhile I pushed the patch out to my 6.4 stable tree for testing on my fleet.
> > > >
> > > > Ideally, I'd like to change the stall detection test in the rcutorture
> > > > to actually fail rcutorture if stalls don't happen in time. But at
> > > > least I verified this manually using rcutorture.
> > > >
> > > > I should also add a documentation patch for stallwarn.rst to document
> > > > the understandable sensitivity of RCU stall detection to jiffies
> > > > updates (or lack thereof). Or if you have time, I'd appreciate support
> > > > on such a patch (not mandatory but I thought it would not hurt to
> > > > ask).
> > > >
> > > > Looking forward to how your testing goes as well!
> > > I have tested, it works for KGDB.
> >
> > Thanks! If you don't mind, I will add your Tested-by tag to the patch
> > and send it out soon. My tests also look good!
>
> You can add my Tested-by, but Reported-by should be "Binbin Zhou
> <zhoubinbin@loongson.cn>"

Thanks, if/when Paul takes it, he could kindly change the Reported-by, or I
could.

thanks,

 - Joel

