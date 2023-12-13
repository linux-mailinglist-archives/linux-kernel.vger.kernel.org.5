Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13368115E9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442278AbjLMPPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442172AbjLMPPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:15:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85661F7;
        Wed, 13 Dec 2023 07:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702480558; x=1734016558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ga/06Gm65DZz6cxBTRPoAOr5ox5/yudCTiMMj5NoYNM=;
  b=WuyxeKSDenD+U7sk1EJ3VZZUldlxwQTI0rb0ZQaNOF49XfJZ1XGZW2Zu
   jHwCFeW5xL1Is1IBcZ+awz/WctrYr6RjOmDQDegOlKvKVnqymhIKlJxxW
   2foi+Szr8Ju2g7ZWiNWkeSQ4QYR3HMfoZ3hdxUZOqbqW7gkZYWSgX3Rzv
   OTnn2Si7eBQp5Cj77JofMPs8ywAHgVKEu1n4CUUmm6DUrawjKEXASea0G
   WdyDhuBIvbqsCnxLAT0+fzm6sXU8gmaZZXJxllAFXrsedxsO29BJoEBFA
   2qk8j7LCuaLiBUECmPn8pVvo0joBVbwMyUl4tvhnf/NliP/UhCS3wxTbk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="398820987"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="398820987"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 07:15:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="750150031"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="750150031"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga006.jf.intel.com with SMTP; 13 Dec 2023 07:15:55 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 13 Dec 2023 17:15:54 +0200
Date:   Wed, 13 Dec 2023 17:15:54 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Javier Carrasco <javier.carrasco@wolfvision.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] usb: typec: tipd: add function to request firmware
Message-ID: <ZXnKqsy2rEJxmXhG@kuha.fi.intel.com>
References: <20231207-tps6598x_update-v1-0-dc21b5301d91@wolfvision.net>
 <20231207-tps6598x_update-v1-2-dc21b5301d91@wolfvision.net>
 <ZXMudF++A9/y4TNk@kuha.fi.intel.com>
 <196acb44-fb0d-45b6-a9c3-b5a289a41917@wolfvision.net>
 <ZXhq/IJp9KVCkQYb@kuha.fi.intel.com>
 <f942ad57-e2e1-4896-83f5-a1acc0805afa@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f942ad57-e2e1-4896-83f5-a1acc0805afa@wolfvision.net>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 03:41:35PM +0100, Javier Carrasco wrote:
> 
> 
> On 12.12.23 15:15, Heikki Krogerus wrote:
> > Hi,
> > 
> > On Fri, Dec 08, 2023 at 07:58:52PM +0100, Javier Carrasco wrote:
> >> Hi Heikki,
> >>
> >> On 08.12.23 15:55, Heikki Krogerus wrote:
> >>
> >>>> +	ret = request_firmware(fw, firmware_name, tps->dev);
> >>>> +	if (ret) {
> >>>> +		dev_err(tps->dev, "failed to retrieve \"%s\"\n", firmware_name);
> >>>> +		/* probe deferring in case the file system is not ready */
> >>>> +		return (ret == -ENOENT) ? -EPROBE_DEFER : ret;
> >>>
> >>> It's more likely that the firmware really isn't available, and it will
> >>> never be available in this case. I think there is only one place in
> >>> kernel where failing request_firmware() can lead to deferred probe
> >>> (drivers/tee/optee/smc_abi.c) and there the code can actually see the
> >>> system state - that's actually the condition.
> >>>
> >>> So just return dev_err_probe() here:
> >>>
> >>> 	ret = request_firmware(fw, firmware_name, tps->dev);
> >>> 	if (ret)
> >>>                 return dev_err_probe(tps->dev, ret, "failed to retrieve \"%s\"", firmware_name);
> >>>
> >> Thank you for your feedback.
> >>
> >> This solution arose from a real use case: in the system I am using to
> >> test the tps65987d, the filesystem is not ready when the probe function
> >> is called. If I just return on -ENOENT, the device will never get the
> >> update.
> > 
> > Just like all the other devices that require firmware. This driver is
> > no different from the others, and it is also not the only one that
> > needs the firmware only in special cases. Just make the firmware part
> > of your ramdisk, or build the driver as a module.
> 
> I wonder why then there is no general solution that does not force the
> driver to be built as a module.

Why would you need anything like that? Are you saying that even if you
put the firmware into your ramdisk, the driver still fails to find the
firmware if it's statically build? If so, then there is something else
wrong.

> If there is none, the documentation
> should mention that somehow (sorry if it does, I missed it). Actually a
> solution like the one implemented in the driver you mentioned could be
> used by any driver that can wait to be updated when the system is
> running.
> 
> > Are these firmwares available linux-firmware (or are the going to be)?
> > https://git.kernel.org/?p=linux/kernel/git/firmware/linux-firmware.git
> > 
> > thanks,
> > 
> The firmware (at least for the tps6598x) can be tailored with a TI
> specific tool and it depends on the use case, so I suppose making it
> public does not make much sense.

Okay.

thanks,

-- 
heikki
