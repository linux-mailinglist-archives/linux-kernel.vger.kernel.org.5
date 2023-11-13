Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D8E7EA171
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 17:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjKMQok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 11:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMQoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 11:44:39 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA1FD53;
        Mon, 13 Nov 2023 08:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699893876; x=1731429876;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=38xyA1hoInxlMYX/sULzWuQ/eDkx63Ca3OYIXvdtBvE=;
  b=lUx5luUVATokApnjabxG760tjOmcKv8G09n4SNNFoFkbEZxxWvQku8RQ
   YsZ0s8Jij1u86oGrUGe8RoGBk47KkEuYUhMQ9O8m5hfhXPNxsg5oNBS+X
   ugEz0zWEU1UVSyN6EsGZ5QnjWvksTTuLsh2z5t72V3UEjHC39YvK8eKz0
   1Lj+W7BdkJDffhK0BYozx2jCb96icEIqDHMrgtBfPOUkYMGEfWlDUci5i
   19Dgo4u0y3G3EK5czRfMs6hVntld5Bf03S/qbqAm2mia/17gu4SmQUZyD
   zXe3oyuzIWLAcT38Y1oSo9cLMJeWFEo1oXdH/G/ltif/F7obS1KkaakwM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="393329742"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="393329742"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 08:44:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="887966790"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="887966790"
Received: from alexdsou-mobl3.gar.corp.intel.com ([10.249.44.83])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 08:44:31 -0800
Date:   Mon, 13 Nov 2023 18:44:28 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
cc:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Jorge Lopez <jorge.lopez2@hp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, error27@gmail.com,
        vegard.nossum@oracle.com, darren.kenny@oracle.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 4/4] platform/x86: hp-bioscfg: Fix error handling in
 hp_add_other_attributes()
In-Reply-To: <bd9e80db-a80f-44d1-bcb9-a14ec0abc64f@suswa.mountain>
Message-ID: <24d6b879-6874-22f7-c8e6-90f3f0968d9f@linux.intel.com>
References: <20231110142921.3398072-1-harshit.m.mogalapalli@oracle.com> <20231110142921.3398072-4-harshit.m.mogalapalli@oracle.com> <211e6c1e-9bfa-ac29-b6ba-e198c4f36688@linux.intel.com> <fb97e3ea-1bee-4d7d-a8d4-dd76107f75ef@oracle.com>
 <1b58df2d-b444-ddb7-7533-9911d35f8f7@linux.intel.com> <c3b821fb-5df1-4c58-99bc-f3e99a6d1d94@oracle.com> <a0b5d36a-aad8-eaf5-7241-85d1c874ff8@linux.intel.com> <bd9e80db-a80f-44d1-bcb9-a14ec0abc64f@suswa.mountain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1784220200-1699893875=:1867"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1784220200-1699893875=:1867
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Mon, 13 Nov 2023, Dan Carpenter wrote:

> On Mon, Nov 13, 2023 at 04:15:50PM +0200, Ilpo Järvinen wrote:
> > This relates to the 2nd problem (missing kobject_put()) and will be 
> > covered by the other patch. Don't try to solve this in the first patch
> > at all!
> > 
> > There are two indepedent problems:
> > - Before kobject_init_and_add(), kfree() is missing
> > - After kobject_init_and_add(), kobject_put() is missing
> 
> It's the same problem, though. The attr_name_kobj is leaked on all the
> error paths. 

I'll have politely disagree beyond that the symptoms are indeed about the 
same, the problem is clearly different like you immediately admit even 
yourself by stating this: ;-)

> It's just that it needs to be freed different ways depending on where 
> you are.

...And that's because "it" actually changed in between so the problem 
became a different one.

> To me splitting it up makes it harder to review

This has already been proven incorrect in the context of this patch so 
your argument is rather weak... While reviewing it I clearly noted that 
the different way of handling things was not properly covered, and that 
was because what needs to be "freed" was changed by 
kobject_init_and_add(). If one would have done them separately, each 
commit message would have been more to the point and it would have been 
simpler to review which is exactly the opposite to your claim. But I guess 
we'll end up disagreing on this too :-).

> and I would not allow it in Staging. You can't fix half the problem.

I don't have that strong opinion on this so Harshit please follow what 
Dan is suggesting, just fix the changelog to clearly cover both cases.


-- 
 i.

--8323329-1784220200-1699893875=:1867--
