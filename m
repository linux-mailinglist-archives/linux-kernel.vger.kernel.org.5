Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1598A7940A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241758AbjIFPpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjIFPpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:45:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09714BC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 08:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694015124; x=1725551124;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=gMJj9ZhTD5+aTv5fNtiiPpjZS9j53Cmv9NzZ/yUpJtk=;
  b=CDlsnXPG20ZLWNsdtkR6FsPXxlRm66cx8gSFeTwhro1d61PEYryTy7AG
   oOGwpezh62ZHS8W3b03/o6DVlwwYqi/IjfEOrvW/Pc1nNAHcmGSxmpKtd
   4pFTgKUkGc7Rr00uwvkzT0UCc8sv3coG1uLYoe6rGWQkva4RBUHlcgkgL
   YzWW+K9IhY3B+zLg0llsgyBi4Btp/KQXIIwWsFmrq5gGzw76gqT/Xlpz4
   eWVRkTFZEeQC1T3Axsan5LhtnHh9ONYL58dIWDSOJuKE60Bd7Lc+nkWdd
   /MC0PuGNRFyPVk4UkadbQHTWVgmRaVSAb7z7pHE4suXOjkxBXDGc0aXrP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="362133258"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="362133258"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 08:45:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="691328024"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="691328024"
Received: from cmabraha-mobl1.amr.corp.intel.com (HELO [10.209.95.171]) ([10.209.95.171])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 08:45:22 -0700
Message-ID: <862a50f7a02828c92a19833ea0655da8951ddcd4.camel@linux.intel.com>
Subject: Re: [PATCH] sched/fair: Add SMT4 group_smt_balance handling
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>, bristot@redhat.com,
        bsegall@google.com, dietmar.eggemann@arm.com, hdanton@sina.com,
        ionela.voinescu@arm.com, juri.lelli@redhat.com,
        len.brown@intel.com, linux-kernel@vger.kernel.org, mgorman@suse.de,
        naveen.n.rao@linux.vnet.ibm.com, rafael.j.wysocki@intel.com,
        ravi.v.shankar@intel.com, ricardo.neri@intel.com,
        rostedt@goodmis.org, srikar@linux.vnet.ibm.com,
        srinivas.pandruvada@linux.intel.com, v-songbaohua@oppo.com,
        vincent.guittot@linaro.org, vschneid@redhat.com, x86@kernel.org,
        yangyicong@hisilicon.com, yu.c.chen@intel.com
Date:   Wed, 06 Sep 2023 08:45:22 -0700
In-Reply-To: <20230906082323.GA28941@noisy.programming.kicks-ass.net>
References: <20230717133718.GJ4253@hirez.programming.kicks-ass.net>
         <20230717145823.1531759-1-sshegde@linux.vnet.ibm.com>
         <804548a12363479d41dee19bb843002d9e105afd.camel@linux.intel.com>
         <6b20e0c0cd82d0d1aafc2a7fb14d9456e19c2c85.camel@linux.intel.com>
         <20230905104136.GC28319@noisy.programming.kicks-ass.net>
         <0410f8756bbcb2f893622de4e146c13e9565248e.camel@linux.intel.com>
         <20230906082323.GA28941@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-09-06 at 10:23 +0200, Peter Zijlstra wrote:
> On Tue, Sep 05, 2023 at 10:54:09AM -0700, Tim Chen wrote:
>=20
> > > > +		goto fully_busy;
> > > > +		break;
> > >=20
> > > This is really daft; why can't this simply be: fallthrough; ? At the
> > > very least that break must go.
> > >=20
> > >=20
> >=20
> > Yes, the break should go.  I was adding the goto to prevent compiler
> > from complaining about fall through code.=20
>=20
> But that's what we have the fallthrough keyword for, no?

Okay.  Will update patch to use fallthrough once Shrikanth has
a chance to test the update to use has_spare path for SMT4.

Tim

