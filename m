Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEE17BD88A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345772AbjJIKaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345759AbjJIKaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:30:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC55D6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 03:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sJEtCfIFnov/stsABCAdFZMChSbaTsEubRk0VjEl124=; b=UDPS/+fuIVNJf9C8lwCiAlTKCs
        9M3IGQlsGdcehCpl6hdKpVDAc4yRC1JSnNTNPYvTwdSBbOQFf0hukExuu0Gnfjab415zWznJDu5zE
        h91eWQg+StJEvqmmv8ulQ0VRu1VoM93eMhxBq4khB+sE2iMaCjtdVkKEPDwCN/lxlw7Qq86w/mqDZ
        tDCTsjgQQzW+jr/pxIfm1XmcvajSytY5gSPIi8aaANR8sGsAOanSRZEbo6E5xRD7KAh0WSIGByrJY
        m7W9I1RIVIhnRLAbgXsXF4Wx9S/EB3KsLHzPRjfcNJ0WDDfGrhKeb1BIfcA+ruI1JOBrRPx/yG3hP
        jC67bAwg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qpnWH-00FJ2O-Fg; Mon, 09 Oct 2023 10:29:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2BEE3300365; Mon,  9 Oct 2023 12:29:49 +0200 (CEST)
Date:   Mon, 9 Oct 2023 12:29:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: EEVDF and NUMA balancing
Message-ID: <20231009102949.GC14330@noisy.programming.kicks-ass.net>
References: <alpine.DEB.2.22.394.2310032059060.3220@hadrien>
 <20231003215159.GJ1539@noisy.programming.kicks-ass.net>
 <alpine.DEB.2.22.394.2310041358420.3108@hadrien>
 <20231004120544.GA6307@noisy.programming.kicks-ass.net>
 <alpine.DEB.2.22.394.2310041822170.3108@hadrien>
 <20231004174801.GE19999@noisy.programming.kicks-ass.net>
 <alpine.DEB.2.22.394.2310041958380.3108@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2310041958380.3108@hadrien>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 08:04:34PM +0200, Julia Lawall wrote:
> > I'll go build the benchmark thing tomorrow, if I can figure out how that
> > works, this NAS stuff looked 'special'. Nothing simple like ./configure;
> > make -j$lots :/
> 
> Starting from git clone, I had to do:
> 
> cd NPB3.4-OMP
> mkdir bin
> cd config
> cp make.def.template make.def
> cd ..
> make ua CLASS=C
> 
> You also need gfortran to be installed.

W00t, that worked like a charm.

The sad new is that I can't seem to reproduce the issue:

So my (freshly re-installed with debian testing) 4 socket Intel(R)
Xeon(R) CPU E7-8890 v3 machine gives me:

root@hsw-ex:/usr/local/src/nas-parallel-benchmarks/NPB3.4-OMP/bin# uname -a
Linux hsw-ex 6.6.0-rc4+ #2 SMP PREEMPT_DYNAMIC Mon Oct  9 11:14:21 CEST 2023 x86_64 GNU/Linux
root@hsw-ex:/usr/local/src/nas-parallel-benchmarks/NPB3.4-OMP/bin# cat /proc/sys/kernel/numa_balancing
1
root@hsw-ex:/usr/local/src/nas-parallel-benchmarks/NPB3.4-OMP/bin# ./ua.C.x | grep "Time in seconds"
 Time in seconds =                    26.69
root@hsw-ex:/usr/local/src/nas-parallel-benchmarks/NPB3.4-OMP/bin# ./ua.C.x | grep "Time in seconds"
 Time in seconds =                    26.31
root@hsw-ex:/usr/local/src/nas-parallel-benchmarks/NPB3.4-OMP/bin# ./ua.C.x | grep "Time in seconds"
 Time in seconds =                    25.43


And this is using a .config very near what Debian ships for 6.5 (make
olddefconfig -CONFIG_DEBUG_INFO_BTF)

I'll try again in a little bit, perhaps I'm suffering PEBKAC :-)


