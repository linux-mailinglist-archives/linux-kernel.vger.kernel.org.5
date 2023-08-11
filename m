Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F5177962D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbjHKRe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjHKRez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:34:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DC5A8;
        Fri, 11 Aug 2023 10:34:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A06F67803;
        Fri, 11 Aug 2023 17:34:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3F3C433C8;
        Fri, 11 Aug 2023 17:34:52 +0000 (UTC)
Date:   Fri, 11 Aug 2023 13:34:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Ajay Kaher <akaher@vmware.com>, <oe-lkp@lists.linux.dev>,
        <lkp@intel.com>, Linux Memory Management List <linux-mm@kvack.org>,
        Ching-lin Yu <chinglinyu@google.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>
Subject: Re: [linux-next:master] [eventfs]  27152bceea:
 stress-ng.getdent.ops_per_sec -8.4% regression
Message-ID: <20230811133450.08cfa609@gandalf.local.home>
In-Reply-To: <202308101425.8416d10d-oliver.sang@intel.com>
References: <202308101425.8416d10d-oliver.sang@intel.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 16:35:17 +0800
kernel test robot <oliver.sang@intel.com> wrote:

> Hello,
> 
> kernel test robot noticed a -8.4% regression of stress-ng.getdent.ops_per_sec on:
> 
> 
> commit: 27152bceea1df27ffebb12ac9cd9adbf2c4c3f35 ("eventfs: Move tracing/events to eventfs")

This is a feature ;-)

Looking at what stress-ng --getdent does (from the man page:)

       --getdent N
              start N workers that recursively read directories /proc, /dev/, /tmp, /sys and /run
              using getdents and getdents64 (Linux only).

So when it looks at /sys/kernel/tracing/events

The event inodes and dentries are now dynamically created (like /proc
does), and thus will take more time to look up. This is expected behavior
as the pro to doing this is the 20 megs of memory saved (per tracing
instance). And this savings will grow as more events are introduced.

-- Steve


> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> testcase: stress-ng
> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> parameters:
> 
> 	nr_threads: 10%
> 	disk: 1HDD
> 	testtime: 60s
> 	fs: xfs
> 	class: filesystem
> 	test: getdent
> 	cpufreq_governor: performance
> 
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202308101425.8416d10d-oliver.sang@intel.com
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->  
> 
> 
