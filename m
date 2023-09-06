Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E352793EE9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241654AbjIFOcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241666AbjIFOcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:32:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A21B198D;
        Wed,  6 Sep 2023 07:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694010757; x=1725546757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V5V26GejPVyOSxfUjPT2mOYUtjVt5U4tPwu4TvOFpFo=;
  b=DGcdpouBJM6X78hmVQXFs0SGvjbjaHu8Eq4J+vAMr3cvb85yzqSyzF6i
   vK9aUlLiOVeaYSLvbW+kjMrrWIbVT87hJQGKm35QTq0fVsNrlcrH0X4Zb
   izVDhTHbMH3z2cgREvr5jgXb/sJHkmIwlmaLJOOfS1XTIptXSmR2sbSR9
   juqZVze/SbpA6OrzG4Ja4x8eyvDk72lxzcmdb+HNaVJytZbGkg2/sJk3T
   PKmpr90+fUBSacei9zZlDw7C7BxUEpNLX+J5E9XGwJ3kw4JSDaqujvBT+
   z6o9dAoj70IK8GxutcccTh67FsaVWKq7g4+8JgMrQRxPSTl2e0mQ3k9ul
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="441055375"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="441055375"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 07:31:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="811685411"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="811685411"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 06 Sep 2023 07:31:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id BCEB017D; Wed,  6 Sep 2023 17:31:47 +0300 (EEST)
Date:   Wed, 6 Sep 2023 17:31:47 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH 1/3] platform/x86: intel_scu_ipc: Check status after
 timeouts in busy_loop()
Message-ID: <20230906143147.GD1599918@black.fi.intel.com>
References: <20230831011405.3246849-1-swboyd@chromium.org>
 <20230831011405.3246849-2-swboyd@chromium.org>
 <20230901055011.GT3465@black.fi.intel.com>
 <CAE-0n50XCw7ugkoTAUfb5Jrr6-Vh=bvXfTOSeHV_ymyOQfRB2g@mail.gmail.com>
 <ZPiCz6AaLc4mqGH8@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZPiCz6AaLc4mqGH8@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 04:46:55PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 05, 2023 at 05:27:23PM -0500, Stephen Boyd wrote:
> > Quoting Mika Westerberg (2023-08-31 22:50:11)
> > > On Wed, Aug 30, 2023 at 06:14:01PM -0700, Stephen Boyd wrote:
> > > > It's possible for the polling loop in busy_loop() to get scheduled away
> > > > for a long time.
> > > >
> > > >   status = ipc_read_status(scu);
> > > >   <long time scheduled away>
> > > >   if (!(status & IPC_STATUS_BUSY))
> > >
> > > How can the status bit change here as we are the only user and the SCU
> > > access is serialized by ipclock?
> > 
> > I don't know how the SCU works. I thought that IPC_STATUS_BUSY bit was
> > cleared by the SCU when it was done processing. With that assumption, I
> > tried to show that the status is read and then the process schedules
> > away for a long time and has an outdated view of the busy bit.
> 
> We probably have different versions of firmwares for the different SoC
> generations. But I _think_ that you are right, the SCU firmware should
> clear the bit when it's done.

Yes, IIRC it does. Okay I see the (potential, although quite unlikely)
problem now. Thanks!
