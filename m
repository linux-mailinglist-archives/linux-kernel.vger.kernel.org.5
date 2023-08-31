Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D017378EF28
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 16:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344555AbjHaOCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 10:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjHaOCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:02:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9706CF;
        Thu, 31 Aug 2023 07:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693490550; x=1725026550;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=19BMzLvzIAcODxvVYIwHyw4tdWHI//iDLgoLUB2RU3s=;
  b=Thbrkxv+o6tqPZ2Vpf5Uniom1mfBjqYXxK6mVsQIpM7uTU/hFbiBbi0B
   AWTq75RLzGSZg7BBykjRtZefroMPV3IgUqNkkBf2cJeXaJtcZXQoHLiwF
   vaxUG/3j7YiPRT1jcXoEA/qt6gJgHiI0SpR0cfuJiabr2mxZFchZf/svT
   jI46OZeh0hBkiLX2H+8SMbWLkrqIugWzz8QaQvna9UzhxS5dYiCh56rHL
   5Ph4AIkX67xElLs04c8snP17dbw4OOX8tof9+Ve/x1lxHlWlSaBVBKVMT
   Ua7yFLaSi+opAsv0WVQMfkg3qEOdmyzKlMFXrqh/p1d/LIwLtmGj9AcrF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="366169038"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="366169038"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 06:41:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="863078295"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="863078295"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga004.jf.intel.com with SMTP; 31 Aug 2023 06:41:29 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 31 Aug 2023 16:41:28 +0300
Date:   Thu, 31 Aug 2023 16:41:28 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Nikolay Borisov <nik.borisov@suse.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Anthony Iliopoulos <ailiopoulos@suse.com>
Subject: Re: [RESEND] USB PD broken on Lenovo P15gen2
Message-ID: <ZPCYiMEzEUZrv2OR@kuha.fi.intel.com>
References: <0da9d8a4-1761-20a3-ebd6-a47fe48b94f8@suse.com>
 <04e8de7a-55e3-4d12-921d-537750fe6217@suse.com>
 <9841c4f5-614e-bfff-e725-2398fad4e927@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9841c4f5-614e-bfff-e725-2398fad4e927@suse.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolay,

Thanks for the report.

On Wed, Aug 30, 2023 at 04:07:55PM +0300, Nikolay Borisov wrote:
> 
> 
> On 28.08.23 г. 17:52 ч., Nikolay Borisov wrote:
> > 
> > [Resending as I had initially attached  a full acpi dump and it got
> > bounced from the usb mailing list]
> > 
> > Hello,
> > 
> > I'm not able to use usb PD on a Lenovo Thinkpad P15gen2 laptop. It's
> > equipped with 2 thunderbolt ports and a usb 3.2 gen2 usb port, all of
> > which are supposed to support PD 2.0:
> 
> <snip>
> So I've been debugging this and what the PPM reports is the following:
> 
> modprobe-529501  [004] ..... 33507.058332: ucsi_register: Supported UCSI spec: 100
>      kworker/4:0-524223  [004] ..... 33507.486591: ucsi_init_work: Connectors supported: 3
>      kworker/4:0-524223  [004] ..... 33507.486592: ucsi_init_work: GET_CAP: USB_PD: 0 TYPEC_CURRENT: 1 POWER_VBUS: 0, POWER_OTHER: 0, POWER_AC_SUPPLY: 1, BATTERY_CHARGING: 0 bcVersion: 0x102 typec_version: 0x100 pd_version: 0x200 PDO_DETAILS: 0
>      kworker/4:0-524223  [004] ..... 33507.682726: ucsi_init_work: [Register port 1]: OPMODE: E4 flag:1
>      kworker/4:0-524223  [004] ..... 33508.850438: ucsi_init_work: [Register port 2]: OPMODE: E4 flag:1
>      kworker/4:0-524223  [004] ..... 33509.986672: ucsi_init_work: [Register port 3]: OPMODE: E4 flag:1
> 
> 
> So all three ports support DRP/USB2/USB3/ALT_MODE and they can be a provider.
> 
> 
> I find it strange that USB_PD is reported as 0 yet pd_version is reported as 2. I contacted Lenovo's support and they confirmed that this particular model indeed supports PD 3.0 on all USBC ports.
> 
> I see a couple of problems with the current upstream code:
> 
> 1. It assumes that USB_PD is valid because the PD version from pd_version is being propagated to several places (like in ucsi_register_port() cap->pd_revision = ucsi->cap.pd_version;)

This part should be fixed.

> 2. When typec_register_port() is called from ucsi_register_port() cap->pd is 0 hence the port->pd = cap->pd; assignment in typec_register_port is a noop. In fact I don't see where cap->pd is being initialized since we initialize con->pd when we call usb_power_delivery_register in ucsi_register_port().

That "pd" member in struct typec_capability is optional. It can be
used if the driver has a set of USB PD capabilities meant for USB
Type-C port ready before the port is registered, but in UCSI driver
the PD stuff are registered after the port.

So I'm not sure there is anything wrong here.

> Is it mandatory that GET_PDOS is supported if PD is supported, the UCSI spec doesn't say anything other than GET_PDOS is optional and signaled by bit in the GET_CAP call ?

It looks like nobody ever checked is the command supported or not
before using it. That's a bug.

thanks,

-- 
heikki
