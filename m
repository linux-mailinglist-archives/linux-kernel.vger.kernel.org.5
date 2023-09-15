Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA807A1DB5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbjIOLzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjIOLzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:55:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5B41FE5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=/RxvKXw5LCvs9VzyQVNGEEv5eVMaMqXh7WPSl2/wUg4=; b=e3nCxingkDr8K6/H1VHAWzXzlA
        N1ADg4WS82N5F4O4Jqi/10Nru2fF01VPRfdp4DNHPt8SYhba2bRr+VHs9zL7QK8Dgv5qAMtqhnJbJ
        gSPBfTJHQzSofvjr2LkXnUWdpbViD0yt6yplGmRnN8s/SqqLYAwWNoyk14C92L4O1P6JuqD5sih/r
        9tWIapQQsV0tKrz2kdKrhvT5X7t24XBrYcZbr8lfvFFBnsjlB8s+MSgrS1lWUM7O5lJXjoTlm3uMt
        HeGKr6RENc4uTUMO3kMVH4lOFmyjT16ygGPLz/NRSQSQEsRKpPY8OHEkSHN5TX4Nk4OSwp0e68AzX
        LpTHhCeg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qh7P2-009WVN-L2; Fri, 15 Sep 2023 11:54:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5068E3003F2; Fri, 15 Sep 2023 13:54:28 +0200 (CEST)
Date:   Fri, 15 Sep 2023 13:54:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     Arjan van de Ven <arjan@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Pu Wen <puwen@hygon.cn>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>
Subject: Re: [patch V4 24/41] x86/cpu: Provide cpu_init/parse_topology()
Message-ID: <20230915115428.GD6721@noisy.programming.kicks-ass.net>
References: <20230814085006.593997112@linutronix.de>
 <20230814085113.471353147@linutronix.de>
 <934072fe-eca2-44df-94e7-9fed1dc8b502@amd.com>
 <87r0nn8ots.ffs@tglx>
 <4a4d5a89-b024-ea49-8740-1f3aef412c15@amd.com>
 <abb65e60-4e8b-7036-4401-d21b273b6d67@linux.intel.com>
 <6f101718-7ee1-1c3d-3e0a-3aa708928ecd@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f101718-7ee1-1c3d-3e0a-3aa708928ecd@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 08:46:14AM +0530, K Prateek Nayak wrote:
> Hello Arjan,
> 
> On 8/28/2023 8:04 PM, Arjan van de Ven wrote:
> > On 8/28/2023 7:28 AM, K Prateek Nayak wrote:
> >>>     - Are these really different between AMD and Intel or is this some
> >>>       naming convention issue which needs to be resolved?
> >>     They do have different characteristics since, on Sapphire
> >>     Rapids, the LLC is at a socket boundary despite having multiple
> >>     tiles. (Please correct me if I'm wrong, I'm going off of
> >>     llc_id shared in this report by Qiuxu Zhuo -
> >>     https://lore.kernel.org/all/20230809161219.83084-1-qiuxu.zhuo@intel.com/)
> >>
> > 
> > Sapphire reports itself as 1 tile though (since logically it is) as far as I know
> > 
> 
> I believe there are some variants with multiple tiles, at least the
> following press-release suggests that:
> 
>   https://www.intc.com/news-events/press-releases/detail/1598/intel-launches-4th-gen-xeon-scalable-processors-max-series
> 
> specifically "... combining up to four Intel 7-built tiles on a single
> package, connected using Intel EMIB ...". Perhaps the one from Qiuxu
> Zhuo's report does not contain multiple tiles.

I think what Arjan was saying that despite them being build using
multipe physical tiles, they describe themselves, in the topology leave,
as being a single tile.
