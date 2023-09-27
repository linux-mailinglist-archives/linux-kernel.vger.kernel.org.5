Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5FC7B0658
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 16:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjI0OPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 10:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjI0OO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:14:58 -0400
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D8CF3;
        Wed, 27 Sep 2023 07:14:55 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id 7B0C4520173;
        Wed, 27 Sep 2023 16:14:53 +0200 (CEST)
Received: from vmlxhi-118.adit-jv.com (10.72.93.77) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.32; Wed, 27 Sep
 2023 16:14:53 +0200
Date:   Wed, 27 Sep 2023 16:14:44 +0200
From:   Hardik Gajjar <hgajjar@de.adit-jv.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
CC:     Hardik Gajjar <hgajjar@de.adit-jv.com>,
        <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <stern@rowland.harvard.edu>, <yangyingliang@huawei.com>,
        <jinpu.wang@ionos.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <erosca@de.adit-jv.com>
Subject: Re: [PATCH] usb: hcd: xhci: Add set command timer delay API
Message-ID: <20230927141444.GA7390@vmlxhi-118.adit-jv.com>
References: <20230818092353.124658-1-hgajjar@de.adit-jv.com>
 <2c029018-a926-6fda-ed71-937ac74d00b0@linux.intel.com>
 <20230821095547.GA9820@vmlxhi-118.adit-jv.com>
 <d88dbe7e-4558-970d-5601-d4d906829d47@linux.intel.com>
 <20230904095738.GA5312@vmlxhi-118.adit-jv.com>
 <862738cd-7a48-345e-3663-5d8e7127712b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <862738cd-7a48-345e-3663-5d8e7127712b@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.72.93.77]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 05:31:12PM +0300, Mathias Nyman wrote:
> On 4.9.2023 12.57, Hardik Gajjar wrote:
> > 
> > In our setup, we have a arm64 target with a DWC3 USB3 IP core,
> > connected through a USB hub (specifically designed for automotive use)
> > to the Android phone. Interestingly,when replicating this setup with
> > the x86 Ubuntu machine, we encountered a discrepancy.
> > 
> > The primary difference between the two setups lies in the utilization
> > of the DWC3 USB IP core.
> 
> Because of the SPLIT transactions seen below it looks like phone is being
> enumerated at Full or Low speed behind the automotive High-speed HUB.
> 
> > 
> > Working Case:
> > 
> > 0,HS,202,0:17.672.512,1.333 us,8 B,I,00,00,SETUP txn (SPLIT),80 06 00 01 00 00 40 00
> > 1,HS,203,0:17.672.512,83 ns,4 B,,00,00,   SPLIT packet,78 0D 03 70
> > 1,HS,204,0:17.672.513,66 ns,3 B,,00,00,   SETUP packet,2D 00 10
> > 1,HS,205,0:17.672.513,200 ns,11 B,,00,00,   DATA0 packet,C3 80 06 00 01 00 00 40 00 DD 94
> > 1,HS,206,0:17.672.514,33 ns,1 B,,00,00,   ACK packet,D2
> > 0,HS,207,0:17.672.535,5.625.983 ms,,I,00,00,[256 CSPLIT-SETUP-NYET],
> > 
> 
> The working case shows a GET_DESCRIPTOR DEVICE request (80 06 00 01).
> Was the SET ADDRESS request (00 05) seen before or after this?
> 
> > Non-Working Case:
> > 
> > 0,HS,164,0:10.982.303,3.116 us,8 B,I,00,00,SETUP txn (SPLIT-STALL),00 05 04 00 00 00 00 00
> > 1,HS,165,0:10.982.303,83 ns,4 B,,00,00,   SPLIT packet,78 01 02 A0
> > 1,HS,166,0:10.982.303,66 ns,3 B,,00,00,   SETUP packet,2D 00 10
> > 1,HS,167,0:10.982.304,200 ns,11 B,,00,00,   DATA0 packet,C3 00 05 04 00 00 00 00 00 EB 70
> > 1,HS,168,0:10.982.304,50 ns,1 B,,00,00,   ACK packet,D2
> > 1,HS,169,0:10.982.305,866 ns,,,00,00,   CSPLIT-SETUP-STALL,
> > 2,HS,170,0:10.982.305,83 ns,4 B,,00,00,      SPLIT packet,78 81 02 78
> > 2,HS,171,0:10.982.306,66 ns,3 B,,00,00,      SETUP packet,2D 00 10
> > 2,HS,172,0:10.982.306,50 ns,1 B,,00,00,      STALL packet,1E
> 
> In the failing case the SET ADDRESS (00 05) request STALLs.
> Was there a GET_DESCRIPOR request before this?
> 
> This could still be a case where the order of SET ADDRES and GET DESCRIPTOR
> requests matter.
> 
> See if you can force new scheme enumeration, it should make hub driver issue
> a GET_DESCRIPTOR request before SET ADDRESS.
> 
> Probably testable with some quick hack that forces use_new_scheme() to return
>  "true" in hub.c
In failing case, there is no GET_DESCRIPTOR DEVICE request.

The result is even worse when enabling the 'new_scheme.'
Instead of a timeout, it directly crashes and restarts the USB subsystem.

In any case, we cannot use the 'new_scheme' because it exposes additional transactions
in USB enumeration. This leads to additional delays in the enumeration of all devices,
potentially exceeding the suggested time limit
> 
> > 
> > Upon close inspection of the USB analyzer data for both cases,
> > it becomes evident that a STALL packet consistently appears in
> > the non-working scenario.
> > 
> > This stands in contrast to the working case, where the channel
> > remains open, allowing for the successful execution of the following
> > high-speed enumeration commands.
> > 
> > In the event of a stall, we require an interruption from the host to
> > resume communication.
> > Given that there is a fixed 5-second command delay, this interruption
> > can only occur after this timeout period.
> > 
> > Therefore, I would like to propose a solution: providing an additional
> > API to control this command timeout or as you suggested, adding a timeout
> > parameter to struct xhci_command, and use that when calling xhci_mod_cmd_timer()
> > without the need to address any potential bugs in the xHCI driver.
> 
> Lets first see if changing enumeration scheme helps.
> 
> If not, and the enumeration issue is only seen for devices behind this specific
> automotive hub, then a quirk could be set for it that adjusts the timeout.
> 
> Also let me know if you find xhci driver bugs, those need to be fixed anyway.
>
I couldn't identify any issues with the xHCI driver either. However, I'd like
to propose the implementation of a more generic mechanism to control the 5-second
(HZ*5) timeout. This would offer better flexibility and help reduce enumeration
time in case of bus errors.

As of now, following your suggestion, I will add a parameter in the set_address
API and use the Quirk in hub.c to pass either the default or customized timeout
to the xHCI driver. However, in that case also we may need minor modifications in
xhci driver.

soon will submit Patch-v2

Thanks,
Hardik

> Thanks
> -Mathias
