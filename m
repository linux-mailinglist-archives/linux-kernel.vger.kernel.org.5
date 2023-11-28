Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BDD7FCA98
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 00:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjK1XKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 18:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjK1XKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 18:10:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27DE183;
        Tue, 28 Nov 2023 15:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701213049; x=1732749049;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ZQ7pjobZBzmg6qSv+zQYyIgwTJqgQXzpkZP/AuJ21dE=;
  b=CsNWgoX+w05LGvvSfxs19/yGqGSsvdqAyYbBxdyeb2cBB8iiNePdnZtE
   Hk6t1LsYOiSlSMxFY9o3GBYwjNGHy/MKC8IiDctGq9PGSiVuJvBl424d9
   Z/nW+aQYzmS50MOpr1ETkv/WUikIPCZC5ioNphLbKuCJsHewOOV43R4oH
   9hS5OGDIUV1oiHoLInRdSLSROMR8kloK8OP4YmO7cx312ooxuYV8Jl7Ne
   dZX+duwURImGKq8SvWOQM8Sfx+xyzdU1Y0cFNxwK1mI7NZVSrDmeBzQ83
   CsITKXrG7IsdFxJd+L2kJ/QLMmHYkpIAwesnpdTfNrycVIu2PnYMlSLac
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="479245605"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="479245605"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 15:10:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="892236858"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="892236858"
Received: from bmnolan-mobl.amr.corp.intel.com (HELO [10.209.106.201]) ([10.209.106.201])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 15:10:48 -0800
Message-ID: <c2a9ceb3d7b1f384ad94d10b7058bb1cebea3d07.camel@linux.intel.com>
Subject: Re: Fwd: Intel hybrid CPU scheduler always prefers E cores
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Ramses <ramses@well-founded.dev>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Yu Chen <yu.c.chen@intel.com>,
        srinivas.pandruvada@linux.intel.com
Date:   Tue, 28 Nov 2023 15:10:48 -0800
In-Reply-To: <NkN3JYx--3-9@well-founded.dev>
References: <01df8329-06d7-4fd1-9c7a-05296f33231e@gmail.com>
         <b2b9121c6d2003b45f7fde6a97bb479a1ed634c7.camel@linux.intel.com>
         <NkN3JYx--3-9@well-founded.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-11-28 at 23:33 +0100, Ramses wrote:

> I applied the patch on top of 6.6.2, but unfortunately I see more or less=
 the same behaviour as before, with single-threaded CPU-bound tasks running=
 almost exclusively on E cores.
>
> Ramses

I suspect that you may have other issues. I wonder if CPU priorities are ge=
tting
assigned properly on your system.

Saw in the original bugzilla=20
https://bugzilla.kernel.org/show_bug.cgi?id=3D218195
that you don't see /proc/sys/kernel/sched_itmt_enabled which
may be a symptom of such a problem.

+Srinivas, is there something Ramses can do to help
find out if there are issues with cppc?

Tim
