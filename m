Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2BA7D76E0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 23:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjJYVfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 17:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjJYVfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 17:35:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A83D132
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 14:35:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE8FC433C8;
        Wed, 25 Oct 2023 21:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1698269742;
        bh=IS28A/VyLk5I38SKgMfcQn09iILXb887HXHzcLznG8g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gvc31YCpv+Y7y0YjUqk94gbhBtUUU0P1IMbjAwMKx6kH8R/tWBMgC+N4v3FSdU2sv
         9x94CASS+zC889ij66qaaceSvGl7tDRXGSUEfEiu9QknBLeB08+2AUo46wlN2I/q2P
         FpKJIh/hiRpGDm//nPazoePJ4cqxZ5bb57RftGCs=
Date:   Wed, 25 Oct 2023 14:35:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     Pavan Kondeti <quic_pkondeti@quicinc.com>, <osalvador@suse.de>,
        <dan.j.williams@intel.com>, <david@redhat.com>, <vbabka@suse.cz>,
        <mgorman@techsingularity.net>, <aneesh.kumar@linux.ibm.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/sparsemem: fix race in accessing
 memory_section->usage
Message-Id: <20231025143541.e7cf114239b84105711a5f70@linux-foundation.org>
In-Reply-To: <b4a2bbe8-4181-68ad-1a6c-463fbe64d8f8@quicinc.com>
References: <1697202267-23600-1-git-send-email-quic_charante@quicinc.com>
        <e1102c1b-1773-4e59-8a70-00a7deff2bde@quicinc.com>
        <b4a2bbe8-4181-68ad-1a6c-463fbe64d8f8@quicinc.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023 19:40:15 +0530 Charan Teja Kalla <quic_charante@quicinc.com> wrote:

> >>  		 * was allocated during boot.
> >>  		 */
> >>  		if (!PageReserved(virt_to_page(ms->usage))) {
> >> +			synchronize_rcu();
> >>  			kfree(ms->usage);
> >>  			ms->usage = NULL;
> >>  		}
> > If we add NULL checks around ms->usage, this becomes
> > 
> > tmp = rcu_replace_pointer(ms->usage, NULL, hotplug_locked());
> > syncrhonize_rcu();
> > kfree(tmp);
> Per David input, I am working on using kfree_rcu().

How's it coming along?

Given that we're at 6.6-rc7 and given that this issue is causing
daily crashes in your device farm, I'm thinking that we use the current
version of your patch for 6.6 and for -stable.  We can look at the
kfree_rcu() optimization for later kernel releases?
