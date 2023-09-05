Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94ACD792A85
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241566AbjIEQio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354802AbjIEOaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 10:30:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FB3194;
        Tue,  5 Sep 2023 07:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693924199; x=1725460199;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=8JItpMSLSaTCr2Sftp87ptn/XmH0APOBllAIBBHUkC0=;
  b=SkhvXTmeFRUFFAeGzkLJCOh827ipbnSqweQAVX4iPV0PfwD4X+uh+dJJ
   36wyoe+hjE83nF8QNrGjYTcm5DH78et6ACmPOiuTBqINk46q/vkr9J6FW
   MN3loFjbppw0lUStHwO+ivrq3Y329OYbH6ojTCUTzhXH1l8VDlXbZuD47
   Zn27tSBTt8LrqUrp5tjJ437g5iBggn8ORicVv8DyzZ9uhPS42k30pWohs
   gqRh4Yo8k3MO5aouOQjTWSVG4zkZ0n+dgpEphLgODtE2g2KUmoCwRU6cS
   i+TYRKboRDIr7Qs6hCTVmy4beI+YyhU8T4sXG7seEjy+BfB9w4CzO2IIZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="357114868"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="357114868"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 07:29:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="734663895"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="734663895"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga007.jf.intel.com with ESMTP; 05 Sep 2023 07:29:53 -0700
Message-ID: <862738cd-7a48-345e-3663-5d8e7127712b@linux.intel.com>
Date:   Tue, 5 Sep 2023 17:31:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To:     Hardik Gajjar <hgajjar@de.adit-jv.com>
Cc:     gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        stern@rowland.harvard.edu, yangyingliang@huawei.com,
        jinpu.wang@ionos.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, erosca@de.adit-jv.com
References: <20230818092353.124658-1-hgajjar@de.adit-jv.com>
 <2c029018-a926-6fda-ed71-937ac74d00b0@linux.intel.com>
 <20230821095547.GA9820@vmlxhi-118.adit-jv.com>
 <d88dbe7e-4558-970d-5601-d4d906829d47@linux.intel.com>
 <20230904095738.GA5312@vmlxhi-118.adit-jv.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] usb: hcd: xhci: Add set command timer delay API
In-Reply-To: <20230904095738.GA5312@vmlxhi-118.adit-jv.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4.9.2023 12.57, Hardik Gajjar wrote:
> 
> In our setup, we have a arm64 target with a DWC3 USB3 IP core,
> connected through a USB hub (specifically designed for automotive use)
> to the Android phone. Interestingly,when replicating this setup with
> the x86 Ubuntu machine, we encountered a discrepancy.
> 
> The primary difference between the two setups lies in the utilization
> of the DWC3 USB IP core.

Because of the SPLIT transactions seen below it looks like phone is being
enumerated at Full or Low speed behind the automotive High-speed HUB.

> 
> Working Case:
> 
> 0,HS,202,0:17.672.512,1.333 us,8 B,I,00,00,SETUP txn (SPLIT),80 06 00 01 00 00 40 00
> 1,HS,203,0:17.672.512,83 ns,4 B,,00,00,   SPLIT packet,78 0D 03 70
> 1,HS,204,0:17.672.513,66 ns,3 B,,00,00,   SETUP packet,2D 00 10
> 1,HS,205,0:17.672.513,200 ns,11 B,,00,00,   DATA0 packet,C3 80 06 00 01 00 00 40 00 DD 94
> 1,HS,206,0:17.672.514,33 ns,1 B,,00,00,   ACK packet,D2
> 0,HS,207,0:17.672.535,5.625.983 ms,,I,00,00,[256 CSPLIT-SETUP-NYET],
> 

The working case shows a GET_DESCRIPTOR DEVICE request (80 06 00 01).
Was the SET ADDRESS request (00 05) seen before or after this?

> Non-Working Case:
> 
> 0,HS,164,0:10.982.303,3.116 us,8 B,I,00,00,SETUP txn (SPLIT-STALL),00 05 04 00 00 00 00 00
> 1,HS,165,0:10.982.303,83 ns,4 B,,00,00,   SPLIT packet,78 01 02 A0
> 1,HS,166,0:10.982.303,66 ns,3 B,,00,00,   SETUP packet,2D 00 10
> 1,HS,167,0:10.982.304,200 ns,11 B,,00,00,   DATA0 packet,C3 00 05 04 00 00 00 00 00 EB 70
> 1,HS,168,0:10.982.304,50 ns,1 B,,00,00,   ACK packet,D2
> 1,HS,169,0:10.982.305,866 ns,,,00,00,   CSPLIT-SETUP-STALL,
> 2,HS,170,0:10.982.305,83 ns,4 B,,00,00,      SPLIT packet,78 81 02 78
> 2,HS,171,0:10.982.306,66 ns,3 B,,00,00,      SETUP packet,2D 00 10
> 2,HS,172,0:10.982.306,50 ns,1 B,,00,00,      STALL packet,1E

In the failing case the SET ADDRESS (00 05) request STALLs.
Was there a GET_DESCRIPOR request before this?

This could still be a case where the order of SET ADDRES and GET DESCRIPTOR
requests matter.

See if you can force new scheme enumeration, it should make hub driver issue
a GET_DESCRIPTOR request before SET ADDRESS.

Probably testable with some quick hack that forces use_new_scheme() to return
  "true" in hub.c

> 
> Upon close inspection of the USB analyzer data for both cases,
> it becomes evident that a STALL packet consistently appears in
> the non-working scenario.
> 
> This stands in contrast to the working case, where the channel
> remains open, allowing for the successful execution of the following
> high-speed enumeration commands.
> 
> In the event of a stall, we require an interruption from the host to
> resume communication.
> Given that there is a fixed 5-second command delay, this interruption
> can only occur after this timeout period.
> 
> Therefore, I would like to propose a solution: providing an additional
> API to control this command timeout or as you suggested, adding a timeout
> parameter to struct xhci_command, and use that when calling xhci_mod_cmd_timer()
> without the need to address any potential bugs in the xHCI driver.

Lets first see if changing enumeration scheme helps.

If not, and the enumeration issue is only seen for devices behind this specific
automotive hub, then a quirk could be set for it that adjusts the timeout.

Also let me know if you find xhci driver bugs, those need to be fixed anyway.

Thanks
-Mathias
