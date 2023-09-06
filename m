Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D010F7940DB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242721AbjIFP5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjIFP5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:57:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEA61724
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 08:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694015822; x=1725551822;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=WTJy4nCixQhmdq/JDl9WVDNY1+EvoSFiN6YhPNx+E3o=;
  b=nglK32du0CUi0ak4zQRe8xOkqoEX4cdab9sm4gZLH1gQWLDiq98P/q40
   WZJ2w5e+vhYrhdaldHHg6SiQlYfov5n723sbTuj0PhLLoUTmkXI3+xeiN
   MhIGNwfKkImOVbjJa0e+zCXaxPqQzY1b3SVojanbyLHyoJ4rF+pfPbN3n
   1yYL3Iv6i7T+1qIT/29km/6BT14rAlmQSRZ0cTaHmErQla8wu+sGxo3Zm
   AhOf6SN93JVA/5ACt+bSmhEY18Bw8xQfPAHuW3YL/4rQ2mgov9KW63vZT
   QppmvXFue6fsrn3vxHeanj+JHOhMoMzkSG2xk4tuVkAwCWvkBVsflNsQu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="379814410"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="379814410"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 08:56:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="718315439"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="718315439"
Received: from cmabraha-mobl1.amr.corp.intel.com (HELO [10.209.95.171]) ([10.209.95.171])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 08:56:55 -0700
Message-ID: <da676f991cd2818bcb234ac4e70c3e56c5407167.camel@linux.intel.com>
Subject: Re: [PATCH] sched/fair: optimize should_we_balance for higher SMT
 systems
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     dietmar.eggemann@arm.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, srikar@linux.vnet.ibm.com,
        mgorman@techsingularity.net, mingo@kernel.org, yu.c.chen@intel.com,
        ricardo.neri-calderon@linux.intel.com, iamjoonsoo.kim@lge.com,
        juri.lelli@redhat.com, rocking@linux.alibaba.com,
        joshdon@google.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org
Date:   Wed, 06 Sep 2023 08:56:55 -0700
In-Reply-To: <6d958bf0-d0e9-ab6f-944f-62a123adf98d@linux.vnet.ibm.com>
References: <20230902081204.232218-1-sshegde@linux.vnet.ibm.com>
         <925bbda25461035fdec1bebf8487f84f9a3852a7.camel@linux.intel.com>
         <6d958bf0-d0e9-ab6f-944f-62a123adf98d@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-09-06 at 07:36 +0530, Shrikanth Hegde wrote:
>=20
> Hi Tim,
>=20
> Thanks for taking a look at this patch.
>=20
> > Wonder if we can avoid allocating the=20
> > should_we_balance_tmpmask for SMT2 case to save memory
> > for system with large number of cores.
> >=20
> > The new mask and logic I think is only needed for more than 2 threads i=
n a core.
>=20
> Code would have to be refactored quite a bit if one needs to take
> different approach for specific SMT setting.=20
>=20
> I think there would some cases in SMT2 that will benefit as well.=20
> Lets say 1 cpu in each core is busy. the busy CPU happens to be second=
=20
> CPU in the core. In that case, this approach would skip that instead of=
=20
> checking if that is idle or not.=20
>=20
>=20
That's true. This change could skip the sibling for SMT2.

Tim
