Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616A2790860
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 17:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbjIBPPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 11:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjIBPPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 11:15:09 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1C6A1B6
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 08:15:04 -0700 (PDT)
Received: (qmail 545133 invoked by uid 1000); 2 Sep 2023 11:15:04 -0400
Date:   Sat, 2 Sep 2023 11:15:04 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
Message-ID: <0b8abec0-c422-45f8-a8d6-998f33080373@rowland.harvard.edu>
References: <9b175f9e-ab70-47a3-a943-bfd05601aa23@rowland.harvard.edu>
 <20230826012024.mboftu3wk7fsrslp@synopsys.com>
 <ba06679f-93d2-4cb4-9218-9e288065bdfb@rowland.harvard.edu>
 <20230830013222.ukw5dtburjnrrjko@synopsys.com>
 <61cf24db-9dbb-4bf3-aafe-d515fc37cca8@rowland.harvard.edu>
 <20230831024345.lwd6ehcbjdlczjpa@synopsys.com>
 <1a66bb8f-9680-424a-a051-27353b8a4130@rowland.harvard.edu>
 <20230901012322.rwpj32rx36xjtlb6@synopsys.com>
 <4e67f96d-250a-4ee1-9f2c-ad321fa50fdc@rowland.harvard.edu>
 <20230901211410.u444xy5rou6ibg2d@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901211410.u444xy5rou6ibg2d@synopsys.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 09:14:19PM +0000, Thinh Nguyen wrote:
> There's no Task Management transfer. All the packets are captured, but
> it's not easy to show in a single email as I need to manually export
> which view to see. Some view level (such as SCSI) would group the
> transfers, which may not show the entire picture. But it helps with the
> high level view. If there's Task Management command, then you would see
> it from the SCSI level.

Okay.

> Actually, something else was probably happened here.
> 
> Some context:
> * Bulk OUT endp 4 is for command endpoint
> * Bulk IN endp 1 is for data endpoint
> * Bulk IN endp 3 is for status endpoint
> 
> _______|_______________________________________________________________________
> Transfer(261) Left("Left") G2(x1) Bulk(OUT) ADDR(3) ENDP(4) UASP  Command IU 
> _______| Tag(0x0002) Logical Unit Number(0x 0000 0000 0000 0000) SCSI CDB 
> _______| READ(10) Time(184.510 us) Time Stamp(10 . 005 791 128) 
> _______|_______________________________________________________________________
> Transfer(264) Left("Left") G2(x1) Bulk(IN) ADDR(3) ENDP(1) Stream ID(0x0002) 
> _______| UASP  Data IN Bytes Transferred(524288) Time(945.654 us) 
> _______| Time Stamp(10 . 005 975 638) 
> _______|_______________________________________________________________________
> Transfer(266) Left("Left") G2(x1) Bulk(IN) ADDR(3) ENDP(3) Stream ID(0x0002) 
> _______| UASP Sense IU  Tag(0x0002) STATUS(GOOD) Time( 47.370 us) 
> _______| Time Stamp(10 . 006 921 292) 
> _______|_______________________________________________________________________
> Transfer(267) Left("Left") G2(x1) Bulk(OUT) ADDR(3) ENDP(4) UASP  Command IU 
> _______| Tag(0x0002) Logical Unit Number(0x 0000 0000 0000 0000) SCSI CDB 
> _______| READ(10) Time(161.454 us) Time Stamp(10 . 006 968 662) 
> _______|_______________________________________________________________________
> Transfer(272) Left("Left") G2(x1) Bulk(IN) ADDR(3) ENDP(1) Stream ID(0x0002) 
> _______| UASP  Data IN Bytes Transferred(146432) Time(  2.519 ms) 
> _______| Time Stamp(10 . 007 130 116) 
> _______|_______________________________________________________________________
> 
> 
> ## Transaction error occurs, the transfer stopped short at 146432 bytes
> ## instead of 512K.
> 
> 
> Transfer(289) Left("Left") G2(x1) Control(SET) ADDR(3) ENDP(0) 
> _______| bRequest(CLEAR_FEATURE) wValue(ENDPOINT_HALT) wLength(0) 
> _______| Time(166.322 us) Time Stamp(10 . 009 649 516) 
> _______|_______________________________________________________________________
> 
> 
> # Host issues CLEAR_FEATURE(halt_ep)

We don't really know how the device responds to this request, other 
than resetting the endpoint's sequence number to 0.

> Transfer(291) Left("Left") G2(x1) Bulk(OUT) ADDR(3) ENDP(4) UASP  Command IU 
> _______| Tag(0x0002) Logical Unit Number(0x 0000 0000 0000 0000) SCSI CDB 
> _______| READ(10) Time(158.848 us) Time Stamp(10 . 009 815 838) 
> _______|_______________________________________________________________________
> 
> 
> # Host completely dropped the SCSI command with transaction error. It
> # doesn't request for the status. Since it's dropped, tag 2 is
> # available. Now, a new SCSI command can use Tag 2.

That is what this looks like.  I'm not aware of any place in the UAS 
spec where it says that a host is allowed to do this.

It would be very interesting to know at this point if the host tried to 
read more data on the data endpoint during the 160-microsecond period 
before transfer 292.  Does the full log show whether this happened?  
Does the fact that the transfers have consecutive numbers mean that 
nothing happened on the bus during this time?  Was the device waiting 
for the host before sending more data, or did it cancel the data that 
was already queued?

> Transfer(292) Left("Left") G2(x1) Bulk(IN) ADDR(3) ENDP(3) Stream ID(0x0002) 
> _______| UASP Response IU  Tag(0x0002) RESPONSE_CODE(OVERLAPPED TAG) 
> _______| Time(207.006 us) Time Stamp(10 . 009 974 686) 
> _______|_______________________________________________________________________
> 
> 
> # Thinking that the previous Tag 2 command was still active and
> # responded with an OVERLAPPED TAG. This probably causes the gadget to
> # cancel the transfer and drop the command so it can be in sync again.

Indeed.  If the Clear-Halt had caused the device to abort the ongoing 
transfer, would it have responded this way?  Wouldn't it have thought 
that the previous Tag 2 command was completely finished?  Or would it 
have cancelled just the data part of the transfer, while keeping track 
of the fact that the status part still needed to be sent?

To put it another way, it seems that the OVERLAPPED TAG response was 
caused by the fact that the status was never sent.  So whether or not 
the device responded to the Clear-Halt by cancelling anything, it 
became aware that something was wrong when it received this duplicate 
tag.

> Transfer(295) Left("Left") G2(x1) Bulk(OUT) ADDR(3) ENDP(4) UASP  Command IU 
> _______| Tag(0x0002) Logical Unit Number(0x 0000 0000 0000 0000) SCSI CDB 
> _______| READ(10) Time(884.218 ms) Time Stamp(10 . 010 181 692) 
> _______|_______________________________________________________________________
> Transfer(313) Left("Left") G2(x1) Bulk(IN) ADDR(3) ENDP(1) Stream ID(0x0002) 
> _______| UASP  Data IN Bytes Transferred(524288) Time(554.648 us) 
> _______| Time Stamp(10 . 894 399 886) 
> _______|_______________________________________________________________________
> Transfer(314) Left("Left") G2(x1) Bulk(IN) ADDR(3) ENDP(3) Stream ID(0x0002) 
> _______| UASP Sense IU  Tag(0x0002) STATUS(GOOD) Time(127.515 ms) 
> _______| Time Stamp(10 . 894 954 534) 
> _______|_______________________________________________________________________
> Transfer(315) Left("Left") G2(x1) Bulk(OUT) ADDR(3) ENDP(4) UASP  Command IU 
> _______| Tag(0x0002) Logical Unit Number(0x 0000 0000 0000 0000) SCSI CDB 
> _______| READ(10) Time(278.770 us) Time Stamp(11 . 022 469 104) 
> _______|_______________________________________________________________________
> Transfer(316) Left("Left") G2(x1) Bulk(IN) ADDR(3) ENDP(1) Stream ID(0x0002) 
> _______| UASP  Data IN Bytes Transferred(524288) Time(554.236 us) 
> _______| Time Stamp(11 . 022 747 874) 
> _______|_______________________________________________________________________
> Transfer(317) Left("Left") G2(x1) Bulk(IN) ADDR(3) ENDP(3) Stream ID(0x0002) 
> _______| UASP Sense IU  Tag(0x0002) STATUS(GOOD) Time( 49.406 us) 
> _______| Time Stamp(11 . 023 302 110) 
> _______|_______________________________________________________________________
> 
> 
> So, for this scenario, the host was probably stay in sync with the
> device due to the overlap command tag id canceling the transfer. I'm not
> sure if this is the intent of the Windows UASP class driver, which seems
> like a non-conventional way of synchronization. Perhaps it was done
> because some devices may not support TASK_MANAGEMENT(Abort_task)?

That's possible.  Windows seems to use a non-conventional approach to 
many things.

> Regardless, if the host resets the endpoint, the transfer must be
> canceled otherwise we risk data corruption.

Do we?  What would have happened if the transfer had not been 
cancelled?  The device might have sent some data left over from the 
original command and the host might have misinterpreted it as belong to 
the new command.  But when the device sent the OVERLAPPED TAG response, 
the host would have realized that any data it received for the 
new command was invalid and abandoned the command.

In fact, that's what it did do in transfer 295.  As far as I can tell 
from the log, the Clear-Halt didn't cause the device to fully cancel 
the transfer.

> Also whenever there's a OVERLAPPED tag error, Windows host takes a long
> time (~1 sec) to send a new command (check delta time of Transfer 295
> and 313). If the gadget driver can base off of the
> CLEAR_FEATURE(halt_ep), this improves performance.

Okay, that's a good point.

However, since not cancelling the transfer apparently did not lead to 
corruption, I think it's okay to allow UDC drivers not to cancel 
requests when they receive a Clear-Halt.  This decision could be left 
up to the driver.

Alan Stern
