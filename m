Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077E1791566
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 11:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbjIDJ6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 05:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236678AbjIDJ6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 05:58:11 -0400
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C5A1729;
        Mon,  4 Sep 2023 02:57:48 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id 4BFAF52016A;
        Mon,  4 Sep 2023 11:57:46 +0200 (CEST)
Received: from vmlxhi-118.adit-jv.com (10.72.93.77) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.32; Mon, 4 Sep
 2023 11:57:46 +0200
Date:   Mon, 4 Sep 2023 11:57:38 +0200
From:   Hardik Gajjar <hgajjar@de.adit-jv.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
CC:     Hardik Gajjar <hgajjar@de.adit-jv.com>,
        <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <stern@rowland.harvard.edu>, <yangyingliang@huawei.com>,
        <jinpu.wang@ionos.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <erosca@de.adit-jv.com>
Subject: Re: [PATCH] usb: hcd: xhci: Add set command timer delay API
Message-ID: <20230904095738.GA5312@vmlxhi-118.adit-jv.com>
References: <20230818092353.124658-1-hgajjar@de.adit-jv.com>
 <2c029018-a926-6fda-ed71-937ac74d00b0@linux.intel.com>
 <20230821095547.GA9820@vmlxhi-118.adit-jv.com>
 <d88dbe7e-4558-970d-5601-d4d906829d47@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d88dbe7e-4558-970d-5601-d4d906829d47@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.72.93.77]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 04:57:54PM +0300, Mathias Nyman wrote:
> On 21.8.2023 12.55, Hardik Gajjar wrote:
> > On Fri, Aug 18, 2023 at 04:18:30PM +0300, Mathias Nyman wrote:
> > > On 18.8.2023 12.23, Hardik Gajjar wrote:
> > > > xHCI driver starts the response timer after sending each
> > > > command to the device. The default value of this timer is
> > > > 5 seconds (XHCI_CMD_DEFAULT_TIMEOUT = HZ*5). This seems
> > > > too high in time crtical use case.
> > > > 
> > > > This patch provides an API to change the default value of
> > > > the timer from the vendor USB driver.
> > > > 
> > > > The default value will be XHCI_CMD_DEFAULT_TIMEOUT (5 sec)
> > > > 
> > > > Use case:
> > > > According to the Smartphone integration certification
> > > > requirement in the automotive, the phone connected via USB
> > > > should complete enumeration and user space handshake
> > > > within 3 sec.
> > > 
> > > The above incorrectly makes it sound as if the command timeout
> > > timer causes the delay.
> > > 
> > Thank you, Mathias, for your prompt response. I will enhance the message
> > to provide more specificity in the subsequent patch.
> > > > 
> > > > Reducing the response waiting time by setting the smaller
> > > > command timer delay helps to speed up overall re-enumeration
> > > > process of the USB device in case of device is not responding
> > > > properly in first enumeration iteration.
> > > 
> > > So is this a case where addressing a usb device behind xHC always
> > > fail on the first attempt, i.e. address device command in xhci
> > > never completes. Solution proposed here is to fail faster and
> > > retry?
> > > 
> > > Is the rootcause known why first enumeration fails?
> > > 
> > > Does setting old_scheme_first module parameter help?
> > > 
> > Yes, you are correct. The problem occurs when setting the address,
> > and in such cases, this patch helps to fail faster and retry.
> > 
> > Unfortunately, the root cause is unknown. This problem is mainly
> > observed with Android phones. Upon analyzing the USB analyzer logs,
> > it seems that the device is not responding to the SET_ADDRESS request.
> 
> Is this only seen when connecting the device to a Linux xHCI host at USB 3 speeds?
> How about connecting to a windows machine? or USB 2 Linux machine with a EHCI host?
I could not able to reproduce the issue when connecting the
phone to x86 Ubuntu20.04 machine.

In our setup, we have a arm64 target with a DWC3 USB3 IP core,
connected through a USB hub (specifically designed for automotive use)
to the Android phone. Interestingly,when replicating this setup with
the x86 Ubuntu machine, we encountered a discrepancy.

The primary difference between the two setups lies in the utilization
of the DWC3 USB IP core.

Working Case:

0,HS,202,0:17.672.512,1.333 us,8 B,I,00,00,SETUP txn (SPLIT),80 06 00 01 00 00 40 00
1,HS,203,0:17.672.512,83 ns,4 B,,00,00,   SPLIT packet,78 0D 03 70
1,HS,204,0:17.672.513,66 ns,3 B,,00,00,   SETUP packet,2D 00 10
1,HS,205,0:17.672.513,200 ns,11 B,,00,00,   DATA0 packet,C3 80 06 00 01 00 00 40 00 DD 94
1,HS,206,0:17.672.514,33 ns,1 B,,00,00,   ACK packet,D2
0,HS,207,0:17.672.535,5.625.983 ms,,I,00,00,[256 CSPLIT-SETUP-NYET],

Non-Working Case:

0,HS,164,0:10.982.303,3.116 us,8 B,I,00,00,SETUP txn (SPLIT-STALL),00 05 04 00 00 00 00 00
1,HS,165,0:10.982.303,83 ns,4 B,,00,00,   SPLIT packet,78 01 02 A0
1,HS,166,0:10.982.303,66 ns,3 B,,00,00,   SETUP packet,2D 00 10
1,HS,167,0:10.982.304,200 ns,11 B,,00,00,   DATA0 packet,C3 00 05 04 00 00 00 00 00 EB 70
1,HS,168,0:10.982.304,50 ns,1 B,,00,00,   ACK packet,D2
1,HS,169,0:10.982.305,866 ns,,,00,00,   CSPLIT-SETUP-STALL,
2,HS,170,0:10.982.305,83 ns,4 B,,00,00,      SPLIT packet,78 81 02 78
2,HS,171,0:10.982.306,66 ns,3 B,,00,00,      SETUP packet,2D 00 10
2,HS,172,0:10.982.306,50 ns,1 B,,00,00,      STALL packet,1E

Upon close inspection of the USB analyzer data for both cases,
it becomes evident that a STALL packet consistently appears in
the non-working scenario.

This stands in contrast to the working case, where the channel
remains open, allowing for the successful execution of the following
high-speed enumeration commands.

In the event of a stall, we require an interruption from the host to
resume communication.
Given that there is a fixed 5-second command delay, this interruption
can only occur after this timeout period.

Therefore, I would like to propose a solution: providing an additional
API to control this command timeout or as you suggested, adding a timeout
parameter to struct xhci_command, and use that when calling xhci_mod_cmd_timer()
without the need to address any potential bugs in the xHCI driver.
> 
> > 
> > I tried using "old_scheme_first=Y," but that did not help. Below are
> > the short logs of the first iteration enumeration failure.
> > > 
> > > The xhci command timeout is more of a xhci internal thing, not sure it's a good
> > > idea to add this to hcd.
> > > 
> > > Would it make sense to add a timeout parameter to hcd->driver->address_device(hcd, udev)
> > > instead?
> > > 
> > > First priority should of course be finding out why the first enumeration fails,
> > > and solve that.
> > > 
> > > Thanks
> > > Mathias
> > Thanks for the suggestion to modify hcd->driver->address_device.
> > I will definitely implement it.However to confirm.
> > 
> > So, if I understand correctly, the idea is to avoid exposing any
> > API from the xhci driver, but instead, create an interface in hcd.c (such as sysfs or API)
> > and incorporate the delay in address_device as an additional parameter.
> 
> On second thought it only makes sense to do this if we can identify the device in advance
> and make a quirk for it. But at this stage we don't know anything about the device.
> 
> So I guess this depends on the width of the problem.
> 
> If this works on windows then we need to figure out what we do differently.
> 
> If this fails with all hosts (well xHCI and EHCI) then hcd level change is probably needed.
> For xhci we would pass timeout parameter when calling address_device, for other hosts
> the timeout for the SET_ADDRESS control transfer would be adjusted.
> 
> If this only fails when connected behind a xHCI host then a local xHCI change should do.
> 
> > However, in that case, modifying xhci is still necessary as the timer is controlled from there.
> 
> Yes, xhci changes will be needed.
> 
> I suggest adding a timeout parameter to struct xhci_command, and use that when calling
> xhci_mod_cmd_timer(). This way we can tailor different timeouts for different commands.
> 
> -Mathias
Thank you, Mathias. I plan to proceed with the recommended approach and prepare the second
version of the upstream patch for review

Hardik
