Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AF675171F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjGMEF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjGMEF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:05:27 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0A61FD2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:05:23 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-403c6a0f3aaso3020771cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689221122; x=1691813122;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GajuMt+6Q9tx2blQfMfUh9E0E/uqR27CkP+42hN7Tqs=;
        b=gDvLB3r3V86ko8I3G39vt7W+qJo+S3sOTVVFqP3XCfCbqjaPg5qCUxk0pT1ZKpssjU
         fiZYWWXBwJU+Xi64SlLWHhAxcEzNMXvoglzhcLFu+lYSSeVVx60VShxcy6VHPcWz8KpF
         +F1LJgxdmMG1RfHd1Gag8WxDXBybpgz3u0t9BANn9SrlrkmXnegfGnApn0rdh+grsu+Y
         1g8dd25RPy4zSOJbv1GZDMvi+3MShTzKTbsg1Z/uI1xSO9Fh6gWWY6HtjiBOdQ4tONwC
         t+TVyecBjSZ1j2RHyxCbdhvnLYBbh31RYT/930chbQtzcrILNK2IaW4EcKDXIAcshuEk
         ZctQ==
X-Gm-Message-State: ABy/qLZ+IuKRbePuu5H2F0VqrEnsdj2fEXF3IAXWFJ74021+ZeL3EcBU
        LZaNnscVv4u7uCM8+cuIvj0=
X-Google-Smtp-Source: APBJJlH5v1OSRqsqRlexTyIn2nsZxnDKmUSQVKyFEh7GmRRs22EZf3ya4EGSH0DBMcTuscbv1AoeEg==
X-Received: by 2002:a05:622a:11:b0:403:2842:4d09 with SMTP id x17-20020a05622a001100b0040328424d09mr595554qtw.26.1689221122338;
        Wed, 12 Jul 2023 21:05:22 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:38a5])
        by smtp.gmail.com with ESMTPSA id bv11-20020a05622a0a0b00b003fdebf1a634sm2771183qtb.75.2023.07.12.21.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 21:05:21 -0700 (PDT)
Date:   Wed, 12 Jul 2023 23:05:19 -0500
From:   David Vernet <void@manifault.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, aaron.lu@intel.com, clm@meta.com,
        tj@kernel.org, roman.gushchin@linux.dev, kernel-team@meta.com,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v2 5/7] sched: Implement shared runqueue in CFS
Message-ID: <20230713040519.GB260054@maniforge>
References: <20230710200342.358255-1-void@manifault.com>
 <20230710200342.358255-6-void@manifault.com>
 <93260dd9-818a-7f98-e030-635e0dc8cad8@bytedance.com>
 <20230712221657.GF12207@maniforge>
 <a70eaa87-2afa-a5c7-a463-7199744cefa4@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a70eaa87-2afa-a5c7-a463-7199744cefa4@bytedance.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 11:43:50AM +0800, Abel Wu wrote:
> On 7/13/23 6:16 AM, David Vernet wrote:
> > On Wed, Jul 12, 2023 at 06:47:26PM +0800, Abel Wu wrote:
> > > > + *
> > > > + * HOW
> > > > + * ===
> > > > + *
> > > > + * An shared_runq is comprised of a list, and a spinlock for synchronization.
> > > > + * Given that the critical section for a shared_runq is typically a fast list
> > > > + * operation, and that the shared_runq is localized to a single LLC, the
> > > > + * spinlock will typically only be contended on workloads that do little else
> > > > + * other than hammer the runqueue.
> > > 
> > > Would there be scalability issues on large LLCs?
> > 
> > See the next patch in the series [0] where we shard the per-LLC shared
> > runqueues to avoid contention.
> > 
> > [0]: https://lore.kernel.org/lkml/20230710200342.358255-7-void@manifault.com/
> 
> Sorry, I should have read the cover letter more carefully. By sharding,
> the LLC is partitioned into several zones, hence contention is relieved.
> But sharding itself might be tricky. Making the SMT siblings not cross
> shards, as suggested by Peter, is generally a good thing. But I wonder
> if there is any workload might benefit from other sharding form.

IMO for now the best thing to do is keep things simple until we observe
it being a problem in practice. Or to at least plan to address it in a
follow-on patch set when we add support for a dynamic shard sizing.
Proper shard sizing is required to do optimal SMT placement anyways, and
in general will likely have more of an impact on performance.

> > > 
> > > > +
> > > > +	task_rq_unlock(src_rq, p, &src_rf);
> > > > +
> > > > +	raw_spin_rq_lock(rq);
> > > > +	rq_repin_lock(rq, rf);
> > > 
> > > By making it looks more ugly, we can save some cycles..
> > > 
> > > 	if (src_rq != rq) {
> > > 		task_rq_unlock(src_rq, p, &src_rf);
> > > 	} else {
> > > 		rq_unpin_lock(src_rq, src_rf);
> > > 		raw_spin_unlock_irqrestore(&p->pi_lock, src_rf.flags);
> > > 		rq_repin_lock(rq, rf);
> > > 	}
> 
> I forgot the repin part when src_rq != rq, but I'm sure you already got
> my point :)

Yep, I got your main point which was to avoid the extra dropping and
acquiring of the same rq spinlock. FYI for posterity / anyone else
reading, the missing repin isn't sufficient on its own for the src_rq !=
rq path. We also need to reacquire the rq lock.

Thanks again for the helpful reviews.

- David
