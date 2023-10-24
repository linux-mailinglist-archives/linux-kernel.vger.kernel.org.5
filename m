Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AAB7D5697
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343839AbjJXPfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343829AbjJXPfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:35:24 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0C3DB171A
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:35:19 -0700 (PDT)
Received: (qmail 461087 invoked by uid 1000); 24 Oct 2023 11:35:19 -0400
Date:   Tue, 24 Oct 2023 11:35:19 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Li, Meng" <Meng.Li@windriver.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "usb-storage@lists.one-eyed-alien.net" 
        <usb-storage@lists.one-eyed-alien.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: storage: add shutdown function for usb storage
 driver
Message-ID: <3fe5b43c-a5aa-4c6a-8614-03a4d9dd53e2@rowland.harvard.edu>
References: <20231023054111.2744872-1-Meng.Li@windriver.com>
 <33bd0779-bfe7-4c87-8fe6-ea8455df3b6b@rowland.harvard.edu>
 <PH0PR11MB51918DD50651DB6BE937BEA3F1DFA@PH0PR11MB5191.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB51918DD50651DB6BE937BEA3F1DFA@PH0PR11MB5191.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 03:43:56AM +0000, Li, Meng wrote:
> 
> 
> > -----Original Message-----
> > From: Alan Stern <stern@rowland.harvard.edu>

> > On Mon, Oct 23, 2023 at 01:41:11PM +0800, Meng Li wrote:
> > > On ls1043/ls1046 rdb platform, if a PCIe-USB host controller is
> > > installed, and an USB disk is also installed on the PCIe card, when
> > > executing "reboot -f" to reset the board, there will be below error reported:
> > > usb 2-2: device not accepting address 2, error -108

> > > This issue is introduced by linux-yocto commit 837547b64a34("driver: net:
> > > dpaa: release resource when executing kexec") that cause to spend more
> > > time on shutdown operation. So, the 2 platforms with DPAA are not
> > > reset immediately after executing force reboot command. Moreover, the
> > > usb-storage thread is still in active status, there is still control
> > > data transferred between USB disk and PCIe host controller. But now
> > > the shutdown callback of usb pci driver had been invoked to stop the
> > > PCIe host controller completely. In this situation, the data transferring failed
> > and report error.
> > 
> > That's _supposed_ to happen.  By design, the "reboot -f" command is meant
> > to carry out an immediate reboot, without using the init system, unmounting
> > filesystems, or doing other cleanup operations.
> > 
> 
> As my above said, I understand what you mean. I also thought over what you said.
> I am not sure, but I still sent patch to upstream community, and want to get some suggest from more authoritative maintainer.
> 
> > If you want a clean reboot with no errors, don't use the "-f" option.
> > 
> 
> There is also error report even if I use command "reboot"

Okay, that's a different matter.  In fact, I don't know what is supposed 
to happen during a clean reboot.

Greg, do you know?  Should we take the time to disconnect all the USB 
devices during a system shutdown?  What happens with non-USB disk 
drives?  Or other removable devices?

Alan Stern
