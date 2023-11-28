Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E807FC92E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 23:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346505AbjK1WMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 17:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346396AbjK1WMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 17:12:30 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C89C1BE;
        Tue, 28 Nov 2023 14:12:37 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cfc1512df1so23922425ad.2;
        Tue, 28 Nov 2023 14:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701209557; x=1701814357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5I66GKMyHIAzQzEFHOFjQNCjRFg2F9svSI9vls2sh8=;
        b=AKj4GR8BPlrMHzazayJ4fyLtUEb7E+2NRht5f8janzFIFxRu3PIZWSLKhJRL01mL/u
         3cLMJ/tyKMlPmevlpA95KyHnl8pXJFnXJloDQreZaEq7nJcfPdLxj4WXpdOcrIm7gFR1
         L3/HWHEiurqvkTW6BVUESVi2umYONUdVMX9G/hmF+RA05ScjQra0dSbKTyb3jgZSXY8q
         3aTtdCOpQ6WT1RlLYd3/U43ObPz/jZVOCIGtZCS2YUOEJmJO4wGWTwLY+M5yH28twQXq
         Gbfz48Y69YL3utKtxPtSKXS82TzxIYbqu/Hx13ly2dBlcsbLt0Ah9F1VqVj6QcB8V3Io
         lfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701209557; x=1701814357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5I66GKMyHIAzQzEFHOFjQNCjRFg2F9svSI9vls2sh8=;
        b=KYN4u7eWCiCuyfYRhNzqi2bNNhRwJwg4O3wszy52zj7wdeUhMDiaGHdBOiHZtV9fQX
         xUkQtiIuRS7opympl39lEMuXGlhn6quwyckmOwyP9VcP6vowA3U3PJrjcQAkW1YihaZS
         rL01p1aL0J9D+0K74S90S/2T6CR60nQVqbKV1k7mtyYBKy59WftbPFWOPGh6tMju70ei
         AbNe2S+yvJvCXffi2K6bH+zCVz9dEFl6XZ8bWDXK+xV0FbqfznInau6fsIf8Vhy3znXF
         7Iv3257CxT+h/YU7MbcKwcSOsAXqijZIRd0A0OH7pOxMYNTPA9i+x0+5IvxNpkz6JVwP
         eICw==
X-Gm-Message-State: AOJu0YxaUaZoSEs1jCmBUPL0Zl0tlrj7E44kWYOAvezhS7rfLCe7VVp4
        PL3PYULpXW7ZB6cogqZSLur0WbDWOtY=
X-Google-Smtp-Source: AGHT+IFGJ8iP+dhVGsRkWkrvv/IjMnIxZmDH5GBgTTWOYL1NVdlhvG0a2qahr5Vi4U3HMDN48PuHSA==
X-Received: by 2002:a17:902:c3c1:b0:1cc:4a23:c5fc with SMTP id j1-20020a170902c3c100b001cc4a23c5fcmr14950863plj.2.1701209556484;
        Tue, 28 Nov 2023 14:12:36 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:c50b])
        by smtp.gmail.com with ESMTPSA id ix4-20020a170902f80400b001cfba9dac6esm6541523plb.115.2023.11.28.14.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 14:12:36 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 28 Nov 2023 12:12:34 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mrunal Patel <mpatel@redhat.com>,
        Ryan Phillips <rphillips@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>
Subject: Re: [PATCH-cgroup 2/2] cgroup/cpuset: Include isolated cpuset CPUs
 in cpu_is_isolated() check
Message-ID: <ZWZl0uvqeZ-fR1O9@slm.duckdns.org>
References: <20231127041956.266026-1-longman@redhat.com>
 <20231127041956.266026-3-longman@redhat.com>
 <ZWYbqNnnt6gQOssK@slm.duckdns.org>
 <8de482b5-1942-4312-8de4-6f54565ab517@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8de482b5-1942-4312-8de4-6f54565ab517@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Nov 28, 2023 at 01:32:53PM -0500, Waiman Long wrote:
> On 11/28/23 11:56, Tejun Heo wrote:
> > Hello,
> > 
> > On Sun, Nov 26, 2023 at 11:19:56PM -0500, Waiman Long wrote:
> > > +bool cpuset_cpu_is_isolated(int cpu)
> > > +{
> > > +	unsigned int seq;
> > > +	bool ret;
> > > +
> > > +	do {
> > > +		seq = read_seqcount_begin(&isolcpus_seq);
> > > +		ret = cpumask_test_cpu(cpu, isolated_cpus);
> > > +	} while (read_seqcount_retry(&isolcpus_seq, seq));
> > > +	return ret;
> > > +}
> > > +EXPORT_SYMBOL_GPL(cpuset_cpu_is_isolated);
> > We're testing a bit in a bitmask. I don't think we need to worry about value
> > integrity from RMW updates being broken up. ie. We can just test the bit
> > without seqlock and drop the first patch?
> 
> My concern is that if we have an isolated partition with a set of isolated
> CPUs (say 2-4), I don't want any addition, deletion of changes made to
> another isolated partition affects the test of the pre-existing one. Testing
> result of the partition being change is fair game.
> 
> Depending on how the cpumask operators are implemented, we may not have a
> guarantee that testing CPU 2, for instance, will always return true. That is

Can you please elaborate this part a bit? I'm having a difficult time
imagining the sequence of operations where this would matter but that could
easily be me not being familiar with the details.

Thanks.

-- 
tejun
