Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7567B78F4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 09:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241568AbjJDHqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 03:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbjJDHqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 03:46:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC344AB;
        Wed,  4 Oct 2023 00:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696405563; x=1727941563;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=974rj3EyGxfTh2NYrV/jXFxkHHfopZDkLckm6W8XSs4=;
  b=ON0kaBOyW7x+xL/jEh7kIugDSws8mB4jlTYZDzgCTxPoerTawzjzr+xe
   LeRVuyHqVFLAHzl1nDQ0AVTJ3UihFy4i9NoWK1+KSOQ4vTXypOhUQMCeS
   bIDWijlBdoFSSbv4aGiOgMXfMbAtkgrFy9NeSUCipLXOj5fapnLjFXBhv
   CmXlZG8qmo9yaO4kPUnt/9KaSky0TdpzkbS7bV9lt0+q82dw2SCHEFY0i
   WfSmEUyUfQQ3GD02CTO9zsQdyFF2wt42fBED9R/hnTEBYwBT7enej/biX
   HGHbdLbSXAUuevpupLuQ75X1QR3cR3tjoqlFajC7EvsK+//lFw3BO1BYa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="385911301"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="385911301"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 00:46:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="998360203"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="998360203"
Received: from cyrillet-mobl.ger.corp.intel.com ([10.252.55.203])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 00:46:01 -0700
Date:   Wed, 4 Oct 2023 10:45:59 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH V2 07/13] platform/x86:intel/pmc: Call pmc_get_low_power_modes
 from platform init
In-Reply-To: <20231004020222.193445-8-david.e.box@linux.intel.com>
Message-ID: <2c14ad0-706b-c97-3152-ae42e1fab521@linux.intel.com>
References: <20231004020222.193445-1-david.e.box@linux.intel.com> <20231004020222.193445-8-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-66187646-1696405562=:1931"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-66187646-1696405562=:1931
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 3 Oct 2023, David E. Box wrote:

> From: Xi Pardee <xi.pardee@intel.com>
> 
> In order to setup a table of low power mode requirements for Meteor Lake,
> pmc_core_get_low_power_modes() will need to be run from platform init code
> so that the enabled modes are known, allowing the use of the
> pmc_for_each_mode helper. Make the function global and call it from the
> platform init code.
> 
> Signed-off-by: Xi Pardee <xi.pardee@intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

Thanks for the update.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-66187646-1696405562=:1931--
