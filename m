Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4A77F3054
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbjKUOJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbjKUOJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:09:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438EA10C1;
        Tue, 21 Nov 2023 06:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700575740; x=1732111740;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S7FWmcXN79Vx+j4cixX7ygbYhrBJf1bmjbAASxLRWaA=;
  b=VOS1oT+AvYN/oyzLTQ65zmwmD7T4jnfU6j1oqG49nU2SEeUhiHwQ1xqT
   Kd/0cKMt8HVt0ccs1uJu1qi1D9h+DnHmoNKiq24kjZcRN/rdTGT1xtl6V
   Ew9K8oevx+nWo6EEtVoP/24ewcPHbvmFYSwG6oyRiqIuQPAoxvi6x6yC+
   Q9gAMyIOcNDoKthF4/mvAuHWeHGSGXTH6dGRlWuzr0vQkzqjvZTtbLb1X
   bpstuLXAw1zXzyhjKmy7LHvm2vXQG3NXu3MTy/OBArTGVdeKuxY8ej3aM
   UwHTQnw1teMFTGrUqPeSZ95BFczekpjJEv83KxxVc+y2ROsamxcxGocNK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="382242013"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="382242013"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 06:08:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="766660042"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="766660042"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga002.jf.intel.com with SMTP; 21 Nov 2023 06:08:57 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 21 Nov 2023 16:08:56 +0200
Date:   Tue, 21 Nov 2023 16:08:56 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: Unplugging USB-C charger cable causes `ucsi_acpi USBC000:00:
 ucsi_handle_connector_change: ACK failed (-110)`
Message-ID: <ZVy5+AxnOZNmUZ15@kuha.fi.intel.com>
References: <b2466bc2-b62c-4328-94a4-b60af4135ba7@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2466bc2-b62c-4328-94a4-b60af4135ba7@molgen.mpg.de>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 12:50:43PM +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On the Dell XPS 13, BIOS 2.21.0 06/02/2022, with Debian sid/unstable and
> Linux 6.5.10, when unplugging the (Dell) USB Type-C charger cable, Linux
> logs the error below:
> 
>     ucsi_acpi USBC000:00: ucsi_handle_connector_change: ACK failed (-110)
> 
> As this is logged with level error, can this be somehow fixed?
> 
>     drivers/usb/typec/ucsi/ucsi.c: dev_err(ucsi->dev, "%s: ACK failed (%d)",
> __func__, ret);
> 
> Please find the output of `dmesg` attached.

Thanks. The firmware not reacting to the ACK command is weird, but I'm
not sure if it's critical. Does the interface continue working after
that? Do you see the partner devices appearing under /sys/class/typec/
when you plug them, and disappearing when you unplug them?

thanks,

-- 
heikki
