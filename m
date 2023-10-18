Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522887CD5CD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344631AbjJRH5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjJRH5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:57:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FC5F7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 00:57:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488D0C433C8;
        Wed, 18 Oct 2023 07:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697615853;
        bh=+Mrul8FDzJtGcrh5YRbVdL5kFqOw6AV3Rg2td373w+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QFRcoudqconpP0opYr9xXtP6vzoY39iQamDCn3d6bnWBWtlmuFXdqce2q1gLF8dtM
         get5IK5YgnASGZLf4njqA7VM60zoqm/kswtdlbSn+dNfUIY1v4nPFI/zsFrXUawTku
         SnjQ0rbEcyOoBFfix7psouWj+xTHyBDfYa3syZ6Y=
Date:   Wed, 18 Oct 2023 09:57:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Max Kellermann <max.kellermann@ionos.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linux-next:master] [drivers/char/mem]  1b057bd800:
 stress-ng.splice.ops_per_sec -99.8% regression
Message-ID: <2023101836-backtalk-mystified-d197@gregkh>
References: <202310172247.b9959bd4-oliver.sang@intel.com>
 <2023101759-front-ember-6354@gregkh>
 <ZS+EKPJA+BMhM0yO@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZS+EKPJA+BMhM0yO@xsang-OptiPlex-9020>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 03:07:20PM +0800, Oliver Sang wrote:
> hi, Greg Kroah-Hartman,
> 
> On Tue, Oct 17, 2023 at 06:56:56PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Oct 17, 2023 at 11:06:42PM +0800, kernel test robot wrote:
> > > 
> > > 
> > > Hello,
> > > 
> > > kernel test robot noticed a -99.8% regression of stress-ng.splice.ops_per_sec on:
> > > 
> > > 
> > > commit: 1b057bd800c3ea0c926191d7950cd2365eddc9bb ("drivers/char/mem: implement splice() for /dev/zero, /dev/full")
> > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > 
> > > testcase: stress-ng
> > > test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> > > parameters:
> > > 
> > > 	nr_threads: 100%
> > > 	testtime: 60s
> > > 	class: pipe
> > > 	test: splice
> > > 	cpufreq_governor: performance
> > > 
> > > 
> > > In addition to that, the commit also has significant impact on the following tests:
> > > 
> > > +------------------+-------------------------------------------------------------------------------------------------+
> > > | testcase: change | stress-ng: stress-ng.splice.ops_per_sec 38.9% improvement                                       |
> > 
> > So everything now goes faster, right?  -99.8% regression means 99.8%
> > faster?
> 
> let me clarify.
> 
> our auto bisect captured this commit as 'first bad commit' in two tests.
> 
> Test 1:
> 
> it found a (very big) regression comparing to parent commit.
> 
> 19e3e6cdfdc73400 1b057bd800c3ea0c926191d7950 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>   12433266           -99.8%      22893 ±  3%  stress-ng.splice.ops_per_sec
> 
> the detail data for parent in multi-runs:
>   "stress-ng.splice.ops_per_sec": [

stress-ng is a performance test?

>     12444442.19,
>     12599010.87,
>     12416009.38,
>     12494132.89,
>     12286766.76,
>     12359235.82
>   ],
> 
> for 1b057bd800:
>   "stress-ng.splice.ops_per_sec": [
>     24055.57,
>     23235.46,
>     22142.13,
>     23782.13,
>     21732.13,
>     22415.46
>   ],
> 
> so this is much slower.

That's odd given that as was pointed out, this test does not even touch
the code paths that this patch changed.

confused,

greg k-h
