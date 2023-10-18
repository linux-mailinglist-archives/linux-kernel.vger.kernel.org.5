Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8841A7CDB4B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjJRMHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjJRMHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:07:52 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78FDBA;
        Wed, 18 Oct 2023 05:07:49 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso1093442866b.1;
        Wed, 18 Oct 2023 05:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697630868; x=1698235668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34canogPms5qIpzbgYLbZvTo7CKSJTUSgOrKFfdlG9Y=;
        b=By2eJKRShKymo7WV3jSvqvFWnzZDuPSFA26xMqTBjHG81J41yr6NOkz/aSmp2qOAvA
         FLp12btX/8mLsf2EZ/VyeWL24y1AhaM+KuMvPuTEwsgNW3DpjOaKIXXPH0oRKmkStO0L
         Mi55/ITRLDC7QJdprufhqwlSsHX6iRcPMlASjFDjBM45iQDMyLinmD26IFH9bKCq4y79
         SGKoUp4dbMhmJ3ka5l9Tq56vfMMk8qWJp6gBLfblu9d5nsm7J+M2aVMftocCFJ2O9PPH
         +H/MU+ExnrsbiwIak88z4Je6pZArAJZLOM0cOPyh6nQ+K514W9otlm6mrnnVgAdz5dKs
         eErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697630868; x=1698235668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=34canogPms5qIpzbgYLbZvTo7CKSJTUSgOrKFfdlG9Y=;
        b=bQTiaiTb8Xw+diZAfo3I/G790XxYeBCw7TIwMUZ7qxADCciIOFrO315He3osyRfPKT
         pEe2eJDJ24W8VWlZLH4wW9BB1v4kc9fLsFXxLssNpbta086ZvT3dllyHH1mBt7s6+wqx
         rMKulYDFKGRAkw4t1romYpHMEu0o6TqzJ9/qIgkRnzVfrNJ4RErDHnfF0DnTCRJ4pU/6
         AHRFJ7THaOrbhWol39mXOsEcpivECQpzVXzk0ZrOymU0SBH0Ks4YCDdyA/JZVaOXP6pW
         VTTWpaK98SdVMs/MRu+wADJ0UtnALpiYDygee5WeY7GZlFvasWf4FCTB0e8EugkTLatO
         fXMw==
X-Gm-Message-State: AOJu0YxbbqssNOXF67w5xkRfSmq9W/dNmdFPbyDEbXASQvs4nGr/0ZsP
        9Lw0DpKGkizzI/cXuxBoNHo=
X-Google-Smtp-Source: AGHT+IElxjo10kp4swEmg7wdBENFyCwPc02UN0dnhqEEo6GbbrpHj5xH29tAUm5ANJC+MESORdcAVQ==
X-Received: by 2002:a17:906:c4c2:b0:9c6:1143:b73 with SMTP id cl2-20020a170906c4c200b009c611430b73mr2721811ejb.51.1697630867888;
        Wed, 18 Oct 2023 05:07:47 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id 27-20020a170906225b00b00997d76981e0sm1528584ejr.208.2023.10.18.05.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:07:47 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 18 Oct 2023 14:07:45 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [perf stat] Extend --cpu to non-system-wide runs too? was Re:
 [PATCH v3] perf bench sched pipe: Add -G/--cgroups option
Message-ID: <ZS/KkfjUdnUPcnVB@gmail.com>
References: <ZS0D53ckVx356k4o@gmail.com>
 <ZS1Y5PhXhp384ynY@kernel.org>
 <ZS1ajf/9HmgUyyCl@kernel.org>
 <ZS1cGMgyEDJQbwq9@kernel.org>
 <ZS1c9RCh9MkzPbFG@kernel.org>
 <ZS2ecyCVpK8B2cQq@kernel.org>
 <ZS5yl3RzVGKBkCvY@gmail.com>
 <ZS592qxF3YxmCoG1@kernel.org>
 <ZS6BgfOUeWQnI1mS@gmail.com>
 <ZS7TAr1bpOfkeNuv@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS7TAr1bpOfkeNuv@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Tue, Oct 17, 2023 at 02:43:45PM +0200, Ingo Molnar escreveu:
> > * Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > Em Tue, Oct 17, 2023 at 01:40:07PM +0200, Ingo Molnar escreveu:
> > > > Side note: it might make sense to add a sane cpumask/affinity setting 
> > > > option to perf stat itself:
> 
> > > >   perf stat --cpumask 
> 
> > > > ... or so?
> 
> > > > We do have -C:
> 
> > > >     -C, --cpu <cpu>       list of cpus to monitor in system-wide
> 
> > > > ... but that's limited to --all-cpus, right?
> 
> > > > Perhaps we could extend --cpu to non-system-wide runs too?
> 
> > > Maybe I misunderstood your question, but its a list of cpus to limit the
> > > counting:
>  
> > Ok.
>  
> > So I thought that "--cpumask mask/list/etc" should simply do what 'taskset' 
> > is doing: using the sched_setaffinity() syscall to make the current 
> > workload and all its children.
>  
> > There's impact on perf stat itself: it could just call sched_setaffinity() 
> > early on, and not bother about it?
> 
> > Having it built-in into perf would simply make it easier to not forget 
> > running 'taskset'. :-)
> 
> Would that be the only advantage?

1)

Another advantage would be that perf stat could itself bind itself to the 
inverse affinity mask.

This means the workload that is being executed is disturbed by perf as 
little as possible.

That's not possible with 'taskset'.

2)

Plus taskset's syntax is arguably silly: why does it need a separate -c 
option for a CPU list, why doesn't it figure it out by itself when there's 
a comma or dash in the mask string?

A better syntax that perf could use would be to interpret it as a CPU mask 
only when presented with a '0x' or '0b' prefix for a binary mask which is 
IMO much more logical if we are talking masks. For example, to run on 8 
full cores, using the '0b' GCC extension to specify binary literals:

	perf stat --cpus 0b101010101010101

'taskset' has other syntax idiosyncracies, such as the weird inverted 
argument order of PID and CPU list:

  kepler:~/tip> taskset -p $$ 0b101010101010101
  taskset: invalid PID argument: '0b101010101010101'

  # .... erm, what??
  # .... oh, taskset expects the PID argument last:

  kepler:~/tip> taskset -p 0b101010101010101 $$
  pid 195878's current affinity mask: ffffffffffffffff
  pid 195878's new affinity mask: b101010101010101

  # ... damn: taskset doesn't know the 0b prefix and blindly assumed it's 
  # hexadecimal ...

So I'd love it if perf stat grew a sane CPU-affinity option.

3)

As a bonus perf stat could later also grow matching memory-node-affinity 
features that 'taskset' doesn't have ...

Anyway, that's my attempt to convince you guys that it's a good idea to 
have this feature. :-)

Thanks,

	Ingo
