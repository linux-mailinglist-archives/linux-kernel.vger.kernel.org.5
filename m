Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0277E5ADE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjKHQMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjKHQMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:12:07 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id C4B671BDD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 08:12:04 -0800 (PST)
Received: (qmail 1022492 invoked by uid 1000); 8 Nov 2023 11:12:04 -0500
Date:   Wed, 8 Nov 2023 11:12:04 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     syzbot <syzbot+b6f11035e572f08bc20f@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] INFO: task hung in hub_port_init (3)
Message-ID: <bd9c6508-0a99-432a-bf59-33440c5e12e4@rowland.harvard.edu>
References: <000000000000704d6305fdb75642@google.com>
 <88cc734c-2a88-4495-aa1e-f16294eb6cea@collabora.com>
 <ff0083c2-249e-4c1e-9546-0b81cf2c6e6f@rowland.harvard.edu>
 <722c5417-d76a-44f3-b6d4-f585f54a3e02@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <722c5417-d76a-44f3-b6d4-f585f54a3e02@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 04:25:45PM +0500, Muhammad Usama Anjum wrote:
> I've confirmed locally again that the logs belong to same urb. This kworker
> gets stuck:
> 
> [  131.064283] usb_control_msg
> [  131.065326] usb_internal_control_msg, urb: FFFF88814CC2AE00
> urb->use_count: 0
> [  131.066320] usb_start_wait_urb urb: FFFF88814CC2AE00 urb->use_count: 0
> [  131.069988] usb_submit_urb urb: FFFF88814CC2AE00 urb->use_count: 0
> [  131.070881] usb_hcd_submit_urb urb: FFFF88814CC2AE00 urb->use_count 1
> [  131.072268] usb_submit_urb 0 urb: FFFF88814CC2AE00 urb->use_count: 1
> [  131.073186] usb_start_wait_urb urb: FFFF88814CC2AE00 urb->use_count: 1
> [  136.151750] usb_start_wait_urb wait_for_completion
> [  136.153286] usb_kill_urb might_sleep
> [  136.153859] vhci_hcd: vhci_urb_dequeue:875: vhci_urb_dequeue
> [  136.154853] vhci_hcd: vhci_urb_dequeue:952: vhci_urb_dequeue return
> [  136.155773] usb_kill_urb usb_hcd_unlink_urb use_count: 1
> [  285.831355] INFO: task kworker/0:4:1586 blocked for more than 143 seconds.

Of course.  It's waiting for the vhci_urb_dequeue() call to finish 
unlinking the URB.

> > If you want to fix this problem (and probably a bunch of other ones in
> > syzbot's list of pending bugs), figure out what's wrong with the
> > ->urb_dequeue() callback routine in the usbip driver and fix it.
> I'm looking at it, haven't found anything yet.

I took a very quick look just now, and one thing stands out.  If 
vhci_urb_dequeue() is unable to allocate a vhci_unlink structure, it 
calls usbip_event_add() and then returns without doing anything else.  

But one of the things usbip_event_add() does is try to allocate a 
usbip_event structure, and if that allocation fails then it returns 
without doing anything.  Now, if the memory allocation attempt in 
vhci_urb_dequeue() fails then it seems quite likely that the attempt in 
usbip_event_add() will also fail.  Which means that nothing will happen 
-- and that is a bug.  URB-dequeue calls are not allowed to fail because 
of memory pressure.

Now, I don't know if this is the cause of the trouble in the syzbot 
test.  You should trace what's going on in vhci_urb_dequeue() to see 
exactly what it does.

Alan Stern
