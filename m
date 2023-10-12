Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09257C6805
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343609AbjJLIGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343583AbjJLIGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:06:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D3DB7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wS5wbeE8HORT89LJUnHJlGT1PNl1CklP2HirCYswW+w=; b=DSvs/7xJ4x4VxwR5zBDg/IE2EN
        VUjzVoXqzZ26J6D47dG271tnyWMOprCF1er6YBBLjLFgcfaglrGF2cV17GAv6f/cZhzFH+9Ihwl2s
        u9eI5O1qrXL3e5L8UIiqvdvUXVrmdQNhFEeHp1G+XmfkW/Ot3UyDE9/efEoQ9raa/T3LkbkB913yO
        UJkA2f4pEcQjb0NBw5FJJpsk/epLwjO8d0uaM522BtVAqFB7eStyXKFyHvshoydiKwA62hbJpx3Aa
        o5O4fbNIvc72oS7IMtL0+wSLnet5nezpuT/hHJJoZkfTMe4K0T6nWiL38ebgziYjPAlTNzLRVtlE0
        EOorhfyw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qqqhW-00FkTd-Uh; Thu, 12 Oct 2023 08:05:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9C4A830036C; Thu, 12 Oct 2023 10:05:46 +0200 (CEST)
Date:   Thu, 12 Oct 2023 10:05:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ankit Jain <ankitja@vmware.com>, yury.norov@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        qyousef@layalina.io, pjt@google.com, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        namit@vmware.com, amakhalov@vmware.com, srinidhir@vmware.com,
        vsirnapalli@vmware.com, vbrahmajosyula@vmware.com,
        akaher@vmware.com, srivatsa@csail.mit.edu
Subject: Re: [PATCH RFC] cpumask: Randomly distribute the tasks within
 affinity mask
Message-ID: <20231012080546.GI6307@noisy.programming.kicks-ass.net>
References: <20231011071925.761590-1-ankitja@vmware.com>
 <20231011105329.GA17066@noisy.programming.kicks-ass.net>
 <20231011114642.GA36521@noisy.programming.kicks-ass.net>
 <20231011135238.GG6337@noisy.programming.kicks-ass.net>
 <CABk29NvHx2saNLdYmQgt31R8W28p7=GUtXiiupgE5czXRBAx5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29NvHx2saNLdYmQgt31R8W28p7=GUtXiiupgE5czXRBAx5g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 04:55:35PM -0700, Josh Don wrote:
> Hey Peter,
> 
> > +static struct cpumask *root_domain_allowed(struct cpumask *newmask,
> > +                                          struct cpumask *scratch,
> > +                                          struct cpumask *valid)
> > +{
> > +       struct root_domain *rd;
> > +       struct cpumask *mask;
> > +       struct rq *rq;
> > +
> > +       int first = cpumask_first_and(newmask, valid);
> > +       if (first >= nr_cpu_ids)
> > +               return NULL;
> 
> This picks the first arbitrarily, but isn't it possible for the mask
> to span both isolated and non-isolated cpus? In which case, the rest
> of this just boils down to chance (ie. whatever the span happens to be
> for the first cpu here)?

Yes, but it matches historical behaviour :/

Like I said, ideally we'd flat out reject masks like this, but...
