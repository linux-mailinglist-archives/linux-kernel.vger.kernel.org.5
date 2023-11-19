Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBC47F073D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 16:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjKSPnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 10:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjKSPni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 10:43:38 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D5239128
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 07:43:33 -0800 (PST)
Received: (qmail 1418121 invoked by uid 1000); 19 Nov 2023 10:43:32 -0500
Date:   Sun, 19 Nov 2023 10:43:32 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: Qualcomm Atheros QCA61x4 keeps drawing 0.85 W despite Bluetooth
 being disable in GNOME
Message-ID: <1f3cb0cc-4bb0-471f-a785-a5d237cd46a3@rowland.harvard.edu>
References: <d994bd71-8d8b-4b6a-855e-8ea5bfede3ca@molgen.mpg.de>
 <22494842-a785-4151-915d-6f3a677d96cb@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22494842-a785-4151-915d-6f3a677d96cb@molgen.mpg.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2023 at 02:42:58PM +0100, Paul Menzel wrote:
> [Fix typo in subject line]
> 
> Dear Linux folks,
> 
> 
> On the Dell XPS 13 9360 from 2016, BIOS 2.21.0 06/02/2022, with Debian
> sid/unstable and Debian’s Linux 6.5.10 kernel, I am trying to extend the
> run-time with battery, at under 50 % of it’s original capacity, and I am
> using PowerTOP 2.15.

> Although radio/wireless devices are turned off in GNOME, PowerTOP shows the
> Bluetooth device drawing 0.85 W of energy:
> 
>     848 mW    100.0%   Device         USB device: usb-device-0cf3-e300
> 
>     $ lsusb -d 0cf3:e300
>     Bus 001 Device 002: ID 0cf3:e300 Qualcomm Atheros Communications QCA61x4
> Bluetooth 4.0

> After unloading the module `btusb`, the entry disappears from the PowerTOP
> list after a while.
> 
>     usbcore: deregistering interface driver btusb
> 
> Auto-suspend was enabled for the device. (Though it shouldn’t have mattered
> as it was disabled in GNOME?)

Enabling autosuspend means that the device _may_ go into runtime suspend 
when it's not being used.  Whether it _will_ do so depends on the driver 
(btusb in this case).

> Anyways, have you heard of such an issue? Can I provide more information, to
> get it to not use any energy while being disable in GNOME?

What is the output from

	grep . /sys/bus/usb/devices/1-3/power/*

both with and without the btusb module loaded?

Alan Stern

> $ lsusb -t
> /:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 10000M
>     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 10000M
>         |__ Port 2: Dev 3, If 0, Class=Vendor Specific Class, Driver=r8152,
> 5000M
> /:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 480M
>     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/5p, 480M
>         |__ Port 1: Dev 3, If 0, Class=Human Interface Device,
> Driver=usbhid, 12M
> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/6p, 5000M
> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/12p, 480M
>     |__ Port 3: Dev 2, If 0, Class=Wireless, Driver=, 12M
>     |__ Port 3: Dev 2, If 1, Class=Wireless, Driver=, 12M
>     |__ Port 4: Dev 3, If 0, Class=Human Interface Device, Driver=usbhid,
> 12M
>     |__ Port 5: Dev 4, If 0, Class=Video, Driver=uvcvideo, 480M
>     |__ Port 5: Dev 4, If 1, Class=Video, Driver=uvcvideo, 480M
> ```
