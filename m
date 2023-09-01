Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5395790184
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 19:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350433AbjIARhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 13:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345699AbjIARhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 13:37:34 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 2CC87E5A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 10:37:30 -0700 (PDT)
Received: (qmail 520676 invoked by uid 1000); 1 Sep 2023 13:37:28 -0400
Date:   Fri, 1 Sep 2023 13:37:28 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
Message-ID: <4e67f96d-250a-4ee1-9f2c-ad321fa50fdc@rowland.harvard.edu>
References: <08a3759d-4c6b-4034-8516-685e4d96a41e@rowland.harvard.edu>
 <20230823222202.k7y7hxndsbi7h4x7@synopsys.com>
 <9b175f9e-ab70-47a3-a943-bfd05601aa23@rowland.harvard.edu>
 <20230826012024.mboftu3wk7fsrslp@synopsys.com>
 <ba06679f-93d2-4cb4-9218-9e288065bdfb@rowland.harvard.edu>
 <20230830013222.ukw5dtburjnrrjko@synopsys.com>
 <61cf24db-9dbb-4bf3-aafe-d515fc37cca8@rowland.harvard.edu>
 <20230831024345.lwd6ehcbjdlczjpa@synopsys.com>
 <1a66bb8f-9680-424a-a051-27353b8a4130@rowland.harvard.edu>
 <20230901012322.rwpj32rx36xjtlb6@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901012322.rwpj32rx36xjtlb6@synopsys.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 01:27:34AM +0000, Thinh Nguyen wrote:
> > Does Windows really work this way?  Does it not send a task management 
> > request?  That would definitely seem to be against the intent of the 
> > spec, if not against the letter.
> 
> Unfortunately yes, I don't see any Task Management request aborting the
> transfer.

Is it possible that the packets are there but you don't see them because 
of the filtering or data presentation done by the USB analyzer?

> Here's a snippet captured at the SCSI level from Samsung T7 device
> response to CLEAR_FEATURE(halt-ep) to IN data endpoint from host
> (Windows 10). Similar behavior is observed for OUT endpoint.

Hmmm.  The SCSI level may not provide enough detail.

> _______|_______________________________________________________________________
> SCSI Op(80) ADDR(3) Tag(0x0002) SCSI CDB READ(10) 
> _______| Logical Block Addr(0x0928E800) STATUS(GOOD) Data(524288 bytes) 
> _______| Time(  1.335 ms) Time Stamp(10 . 000 538 006) Metrics #Xfers(3) 
> _______|_______________________________________________________________________
> SCSI Op(81) ADDR(3) Tag(0x0002) SCSI CDB READ(10) 
> _______| Logical Block Addr(0x0928EC00) STATUS(GOOD) Data(524288 bytes) 
> _______| Time(  1.318 ms) Time Stamp(10 . 001 872 988) Metrics #Xfers(3) 
> _______|_______________________________________________________________________
> SCSI Op(82) ADDR(3) Tag(0x0002) SCSI CDB READ(10) 
> _______| Logical Block Addr(0x0928F000) STATUS(GOOD) Data(524288 bytes) 
> _______| Time(  1.343 ms) Time Stamp(10 . 003 191 188) Metrics #Xfers(3) 
> _______|_______________________________________________________________________
> SCSI Op(83) ADDR(3) Tag(0x0002) SCSI CDB READ(10) 
> _______| Logical Block Addr(0x0928F400) STATUS(GOOD) Data(524288 bytes) 
> _______| Time(  1.256 ms) Time Stamp(10 . 004 534 630) Metrics #Xfers(3) 
> _______|_______________________________________________________________________
> SCSI Op(84) ADDR(3) Tag(0x0002) SCSI CDB READ(10) 
> _______| Logical Block Addr(0x0928F800) STATUS(GOOD) Data(524288 bytes) 
> _______| Time(  1.178 ms) Time Stamp(10 . 005 791 128) Metrics #Xfers(3) 
> _______|_______________________________________________________________________
> SCSI Op(85) ADDR(3) Tag(0x0002) SCSI CDB READ(10) 
> _______| Logical Block Addr(0x0928FC00) Data(146432 bytes) Status(Missing)-BAD 
> _______| Time(  2.681 ms) Time Stamp(10 . 006 968 662) Metrics #Xfers(2) 
> _______|_______________________________________________________________________
> 
> 
> ## Transaction eror occurs here.
> 
> Transfer(289) Left("Left") G2(x1) Control(SET) ADDR(3) ENDP(0) 
> _______| bRequest(CLEAR_FEATURE) wValue(ENDPOINT_HALT) wLength(0) 
> _______| Time(166.322 us) Time Stamp(10 . 009 649 516) 
> _______|_______________________________________________________________________
> 
> ## CLEAR_FEATURE happens here.
> 
> SCSI Op(99) ADDR(3) Tag(0x0002) SCSI CDB READ(10) 
> _______| Logical Block Addr(0x09290000) RESPONSE_CODE(OVERLAPPED TAG) 
> _______| Time(365.854 us) Time Stamp(10 . 009 815 838) Metrics #Xfers(2) 
> _______|_______________________________________________________________________
> SCSI Op(100) ADDR(3) Tag(0x0002) SCSI CDB READ(10) 
> _______| Logical Block Addr(0x09290400) STATUS(GOOD) Data(524288 bytes) 
> _______| Time(  1.012 sec) Time Stamp(10 . 010 181 692) Metrics #Xfers(3) 
> _______|_______________________________________________________________________
> SCSI Op(101) ADDR(3) Tag(0x0002) SCSI CDB READ(10) 
> _______| Logical Block Addr(0x0928FC00) STATUS(GOOD) Data(524288 bytes) 
> _______| Time(882.412 us) Time Stamp(11 . 022 469 104) Metrics #Xfers(3) 
> _______|_______________________________________________________________________
> 
> ## Host retries transfer here. Check logical block address.
> 
> SCSI Op(102) ADDR(3) Tag(0x0002) SCSI CDB READ(10) 
> _______| Logical Block Addr(0x09290000) STATUS(GOOD) Data(524288 bytes) 
> _______| Time(  1.060 ms) Time Stamp(11 . 023 351 516) Metrics #Xfers(3) 
> _______|_______________________________________________________________________
> SCSI Op(103) ADDR(3) Tag(0x0002) SCSI CDB READ(10) 
> _______| Logical Block Addr(0x09290800) STATUS(GOOD) Data(524288 bytes) 
> _______| Time(  1.013 ms) Time Stamp(11 . 024 411 510) Metrics #Xfers(3) 
> _______|_______________________________________________________________________
> SCSI Op(104) ADDR(3) Tag(0x0002) SCSI CDB READ(10) 
> _______| Logical Block Addr(0x09290C00) STATUS(GOOD) Data(524288 bytes) 
> _______| Time(816.594 us) Time Stamp(11 . 025 424 600) Metrics #Xfers(3) 
> _______|_______________________________________________________________________
> SCSI Op(105) ADDR(3) Tag(0x0002) SCSI CDB READ(10) 
> _______| Logical Block Addr(0x09291000) STATUS(GOOD) Data(524288 bytes) 
> _______| Time(762.286 us) Time Stamp(11 . 026 241 194) Metrics #Xfers(3) 
> _______|_______________________________________________________________________
> SCSI Op(106) ADDR(3) Tag(0x0002) SCSI CDB READ(10) 
> _______| Logical Block Addr(0x09291400) STATUS(GOOD) Data(524288 bytes) 
> _______| Time(768.696 us) Time Stamp(11 . 027 003 480) Metrics #Xfers(3) 
> _______|_______________________________________________________________________

Is is possible to show all the data packets (not the token or 
handshaking ones) for both the command and status endpoints?  I'm 
particularly interested in seeing what sort of status message the device 
sends for the failed command, and where it occurs in relation to the 
other transfers.

I wouldn't mind seeing a summary of the packets on the data-IN endpoint 
as well.  Not a detailed view -- multiple 500-KB transfers aren't very 
interesting -- but just to see what happens in the vicinity of the 
transaction error.

Alan Stern
