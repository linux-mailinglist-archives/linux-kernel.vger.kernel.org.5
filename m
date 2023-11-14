Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD217EB058
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjKNMx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbjKNMxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:53:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79F11A4;
        Tue, 14 Nov 2023 04:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699966425; x=1731502425;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Kz92UTQM38hm45Yzql0q2iZjHJv9ZJ5h/3LRMWYuIVo=;
  b=C+ZuNEcHAh2Q0ik6rgjrMfBn8Sp8iGCAGNQHBDiC/miGPnjPg5jkaemT
   tt+L/BsgF7TCE27ZD1VNZnjhhiQgYBfylWIVO553PZ2E9lPL3oWPQuhwD
   WXFJp/M3SpdDE0Mh5IA5DxmYYrVhTebA8feDJFqC05t053tmlVrrTXVDp
   stZ+nMUVBL4mqoIo0se1m/oVRffLjW7PhwBtvOVF8/U2Y3Ybh/AMR+eQQ
   f6jKzrBnBxFSkqYCwhJUopLjJ+VC/2NpIBGHljhFoBrRaMjRf6yUWD3YN
   fvjIL7UAUY68ik3EQq0Bu5vWqLS/FoCTyQlm80ZYfiBhgEgsM/IxUeBgs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="12193723"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="12193723"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 04:53:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="908352573"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="908352573"
Received: from rauhjoha-mobl2.ger.corp.intel.com ([10.251.217.194])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 04:53:42 -0800
Date:   Tue, 14 Nov 2023 14:53:39 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
cc:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Jorge Lopez <jorge.lopez2@hp.com>,
        Mark Gross <markgross@kernel.org>,
        =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, dan.carpenter@linaro.org,
        kernel-janitors@vger.kernel.org, error27@gmail.com,
        vegard.nossum@oracle.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4 3/4] platform/x86: hp-bioscfg: Fix error handling in
 hp_add_other_attributes()
In-Reply-To: <b3d2f6aa-4dc4-4570-9c00-54b7211fb851@redhat.com>
Message-ID: <7884dff1-c2b9-8b8a-8ca-7a5cb28530f7@linux.intel.com>
References: <20231113200742.3593548-1-harshit.m.mogalapalli@oracle.com> <20231113200742.3593548-3-harshit.m.mogalapalli@oracle.com> <36e7a170-bd87-4462-fc6b-eec446fbb551@linux.intel.com> <b3d2f6aa-4dc4-4570-9c00-54b7211fb851@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2073173931-1699966424=:1748"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2073173931-1699966424=:1748
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 14 Nov 2023, Hans de Goede wrote:
> On 11/14/23 11:31, Ilpo Järvinen wrote:
> > On Mon, 13 Nov 2023, Harshit Mogalapalli wrote:
> > 
> >> 'attr_name_kobj' is allocated using kzalloc, but on all the error paths
> >> it is not freed, hence we have a memory leak.
> >>
> >> Fix the error path before kobject_init_and_add() by adding kfree().
> >>
> >> kobject_put() must be always called after passing the object to
> >> kobject_init_and_add(). Only the error path which is immediately next
> >> to kobject_init_and_add() calls kobject_put() and not any other error
> >> path after it.
> >>
> >> Fix the error handling after kobject_init_and_add() by moving the
> >> kobject_put() into the goto label err_other_attr_init that is already
> >> used by all the error paths after kobject_init_and_add().
> >>
> >> Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Reported-by: Dan Carpenter <error27@gmail.com>
> >> Closes: https://lore.kernel.org/r/202309201412.on0VXJGo-lkp@intel.com/
> >> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> >> ---
> >> This is based on static analysis, only compile tested.
> >>
> >> v3->v4: Add more explicit statement on how we are fixing it, suggested
> >> by Ilpo
> > 
> > Thanks a lot, this looks fine too now.
> > 
> > Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> Thank you for reviewing this series. I believe that it is best
> to submit this as fixes for the current cycle.
> 
> Under the assumption that you agree with this I've delegated
> these 4 patches to you (Ilpo) in patchwork.

Yes, I'll take care of it later this week.

-- 
 i.

--8323329-2073173931-1699966424=:1748--
