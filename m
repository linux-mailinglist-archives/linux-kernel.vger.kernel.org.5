Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E4A7FD416
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjK2K0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjK2K0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:26:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53408BA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701253611; x=1732789611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BJxYP16lOxo2zmWtEP5drYB30Z4f3hd1h6W3Mdtes9Y=;
  b=Xk75wjw+k7G0cywweCScaHn0fTsiRpuyXWXbiHfKCGz0t4EuiJ1yqUg/
   vtJRf1Vp6xIPDvSme83eVbNN8XouJf9n3wpmTlI20TRHeMNJLCRANgrHh
   fjFFhXbG8hUDpVOkMAY5uIgHH2H826ZjGEEER6KbJ1Zbx4mjcxqOLEpTf
   SVu8EaW3MqiN/M7scf5HKqf6jzfzfXZhA0grfkpZAiqOmQtyODRpSz1yw
   PrcmcnVewQRZgNGeAalDeMs3JkSkRPvxB9iEigHTiduqylCLATwZRs18z
   zftmITCwhdb+fG4VlcBJpIZgYLhATCOCYnfWEk/OWrcq+FMy0LWvllbqs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="6406768"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="6406768"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 02:26:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="797874676"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="797874676"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 02:26:48 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 0221411FBF0;
        Wed, 29 Nov 2023 12:26:45 +0200 (EET)
Date:   Wed, 29 Nov 2023 10:26:44 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wentong Wu <wentong.wu@intel.com>, gregkh@linuxfoundation.org,
        tomas.winkler@intel.com, hdegoede@redhat.com,
        alexander.usyskin@intel.com, zhifeng.wang@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mei: Add MEI hardware support for IVSC device
Message-ID: <ZWcR5EUADPkGSXng@kekkonen.localdomain>
References: <1701174846-16316-1-git-send-email-wentong.wu@intel.com>
 <1701174846-16316-3-git-send-email-wentong.wu@intel.com>
 <ZWcD18B916Xs1JiU@kekkonen.localdomain>
 <ZWcQrHs_fpqo80iX@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWcQrHs_fpqo80iX@smile.fi.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 12:21:32PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 29, 2023 at 09:26:47AM +0000, Sakari Ailus wrote:
> > On Tue, Nov 28, 2023 at 08:34:06PM +0800, Wentong Wu wrote:
> 
> ...
> 
> > I wouldn't mind having a single Kconfig option for the two drivers either.
> > They're always used together, aren't they?
> 
> As far as I understand the topology, here we have one "core" driver and
> one "leaf" driver. So, in my understanding they may not go together as
> it will bring unneeded code in the future in some configurations.

Yes, that is possible in the future if other clients appear. But will there
be any? Both drivers appear to be related to IVSC.

-- 
Sakari Ailus
