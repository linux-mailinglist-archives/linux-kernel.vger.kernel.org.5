Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C327BA3E0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239583AbjJEP7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235183AbjJEP5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:57:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC455273C;
        Thu,  5 Oct 2023 06:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696514066; x=1728050066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WT2vF2g6ySQ88OnBsaROozLS1/K+Uk2umLsgnTugo4g=;
  b=HikMK4ts2LgVHHpFAoKBy/afRCgUWTyNkt7XIvTxTbctujN9aqgBhYvJ
   N0XR6P8DPcUyG1fwfyBLudGQkcEJbwQ+mKXBQc0BREv+dxdsc5tn5FucB
   SDX3D2JjjTxV/VhMASL9QRuDe4wzQkkIQvitylHdvyC8wAmloYmhGsiA5
   1obxGhvooAhmjZzlaSjWAOMfyMP01PRHaD9NsyKBPPAPgJa/qaCZ7+gNY
   N4HgYAwb5tdqldphW8xYfoXBkJUppzkxc42/LT77z3WSiyuzNTwXu8bAx
   AqMxOBNyQFO7hIyWWc5gLGH9ZfFXip/MTE0hkz94pezNeBeMx1mfGLZLa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="414443730"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="414443730"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 05:15:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="728425237"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="728425237"
Received: from ppglcf2090.png.intel.com ([10.126.160.96])
  by orsmga006.jf.intel.com with ESMTP; 05 Oct 2023 05:14:59 -0700
From:   Rohan G Thomas <rohan.g.thomas@intel.com>
To:     kuba@kernel.org
Cc:     alexandre.torgue@foss.st.com, andriy.shevchenko@linux.intel.com,
        davem@davemloft.net, devicetree@vger.kernel.org,
        edumazet@google.com, fancer.lancer@gmail.com, joabreu@synopsys.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
        pabeni@redhat.com, rohan.g.thomas@intel.com
Subject: Re: [PATCH net-next 1/1] net: stmmac: xgmac: EST interrupts handling
Date:   Thu,  5 Oct 2023 20:14:41 +0800
Message-Id: <20231005121441.22916-1-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20231004092613.07cb393f@kernel.org>
References: <20231004092613.07cb393f@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2023 09:26:13 -0700 Jakub Kicinski wrote:
> On Tue, 3 Oct 2023 14:12:15 +0300 Serge Semin wrote:
> > If I didn't miss some details after that we'll have a common EST
> > module utilized for both DW QoS Eth and DW XGMAC IP-cores.
> 
> So the question now is whether we want Rohan to do this conversion _first_,
> in DW QoS 5, and then add xgmac part. Or the patch should go in as is and
> you'll follow up with the conversion?

Hi Jakub, Serge,

If agreed, this commit can go in. I can submit another patch with the
refactoring suggested by Serge.

Again, thanks Serge for the prompt response. Regarding the below point in your
earlier response,

> > 2. PTP time offset setup performed by means of the
> > MTL_EST_CONTROL.PTOV field. DW QoS Eth v5.x HW manual claims it's "The
> > value of PTP Clock period multiplied by 6 in nanoseconds." So either Jose got
> > mistaken by using _9_ for DW XGMAC v3.x or the DW XGMAC indeed is
> > different in that aspect.

This is a little confusing...
I referred databooks for DW QoS Eth v5.30a and DW XGMAC v3.10a. In both this is
mentioned as "The value of PTP Clock period multiplied by 9 in nanoseconds".

Best Regards,
Rohan
