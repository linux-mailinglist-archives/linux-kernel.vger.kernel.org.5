Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515917A1DA6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbjIOLqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjIOLqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:46:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6217E1FE8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:46:48 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694778407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YG5tIhlgvyo3E2tjtK9k1O7Vx/acrwOqVX1en+myyIc=;
        b=WQD1btgzpHrZE05x8H0EU9fVY4/RfeMU6hKI9C7seofOSQFiv36F50tKMqSmnHCLYAR6Ej
        YWj030j95Khtp80CzGcfGpbELdbh/q9M9WA/uF/zY9J7jRvG0Nzb0/UV5aB5Hw4HWaXn6p
        umHz0N3904QvLqwe3kuif5wj3zNcKtS/UveElGr/7yhmsnugbXIMh8fXooxABvymAXw2D9
        gljXo9BQxITCyDzGcrdRgoR81d1C2kYGXV4AF35GCV7zLf2+9wCORUj70/A/8wgN7RDuzY
        40U9aPye58ppeVjZFpizpt5RnrzS+NWS3dvU4+2egnhakP+pGdVyr0CUCtE9Hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694778407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YG5tIhlgvyo3E2tjtK9k1O7Vx/acrwOqVX1en+myyIc=;
        b=jN8OWU7nyAokpykn7mI1AbzgD2mAE+5MLwjHo6zaEyL8DYNnY8lR17YZEe8DvWVaQThjqa
        IEnaNxCYpIjAlMDg==
To:     K Prateek Nayak <kprateek.nayak@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Pu Wen <puwen@hygon.cn>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>
Subject: Re: [patch V4 24/41] x86/cpu: Provide cpu_init/parse_topology()
In-Reply-To: <011011ee-4f83-3545-4ca2-55bc0bef284a@amd.com>
References: <20230814085006.593997112@linutronix.de>
 <20230814085113.471353147@linutronix.de>
 <934072fe-eca2-44df-94e7-9fed1dc8b502@amd.com> <87r0nn8ots.ffs@tglx>
 <4a4d5a89-b024-ea49-8740-1f3aef412c15@amd.com>
 <011011ee-4f83-3545-4ca2-55bc0bef284a@amd.com>
Date:   Fri, 15 Sep 2023 13:46:46 +0200
Message-ID: <87led71wwp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prateek!

On Thu, Sep 14 2023 at 14:50, K. Prateek Nayak wrote:
> On 8/28/2023 7:58 PM, K Prateek Nayak wrote:
> o Logical Processor : A processor core provides one or more logical
> 	    processors sharing execution resources. The
> 	    LOGICAL_PROCESSOR_ID sub-field distinguishes logical
> 	    processors in a core. The width of this bit field is
> 	    non-zero if a processor core provides more than one logical
> 	    processors.
> """
>
> So some questions to Intel folks to determine whether mapping AMD's
> Complex to Tile makes sense or not:
>
> - What are the "certain resources" a group of module / tile share?
>
> - Module and Tile both use the phrase "set of cores" in their
>   description. Does this mean their existence is mutually exclusive?

That's definitely a good question.

> AMD's Complex (CCX) marks the L3 cache boundary. If either of the
> "certain resources" refer to L3 cache, then Complex can be safely mapped
> to the respective level without any fear of misinterpretation of the
> characteristics.

I don't think it's a good idea to try deducing cache hierarchy from the
basic topology. The boundaries have changed over time and AMD has made
it impossible on older CPUs to use the CPU topology for that.

I tried to do that and gave up because I realized that we need both and
then do the proper association by combining the information.

> Also, I do not see a "DieGrp" domain in the "x86_topology_domains". Is
> this because of the lack of "software visible" aspect of it despite its
> possible existence?

No. It's subsumed by the package domain. Let me look at the mechanics
some more to make this more obvious.

Thanks,

        tglx
