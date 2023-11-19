Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986CF7F06E6
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 15:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjKSOfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 09:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjKSOfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 09:35:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5B8F2;
        Sun, 19 Nov 2023 06:35:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1B8C433C7;
        Sun, 19 Nov 2023 14:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700404510;
        bh=E6zJHBhYXrmLej8MZ2nYDjFpIEaxCqU2Xw6h3zWA/xM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PtkuutV44momtUH3Bdr0Z5NreXGP10WNAzwIhG3yOGJY+doGyoJeMkPFzAS1F2NxO
         v6TyH+J9XknTcrbnqC1RkeH2v2a9oAKVabQ70071jj0/XeHahDt6KhVLs0irYMpNLv
         piQAUUL3n7J8MSIQWwNkmb1LSQhl2W6DsHrk/OpQ=
Date:   Sun, 19 Nov 2023 15:35:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: Qulcomm Atheros QCA61x4 keeps drawing 0.85 W despite Bluetooth
 being disable in GNOME
Message-ID: <2023111947-levitate-undergo-12d6@gregkh>
References: <d994bd71-8d8b-4b6a-855e-8ea5bfede3ca@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d994bd71-8d8b-4b6a-855e-8ea5bfede3ca@molgen.mpg.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2023 at 02:40:35PM +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On the Dell XPS 13 9360 from 2016, BIOS 2.21.0 06/02/2022, with Debian
> sid/unstable and Debian’s Linux 6.5.10 kernel, I am trying to extend the
> run-time with battery, at under 50 % of it’s original capacity, and I am
> using PowerTOP 2.15.
> 
>     [    0.000000] microcode: updated early: 0xf0 -> 0xf4, date = 2023-02-22
>     [    0.000000] Linux version 6.5.0-4-amd64
> (debian-kernel@lists.debian.org) (gcc-13 (Debian 13.2.0-6) 13.2.0, GNU ld
> (GNU Binutils for Debian) 2.41) #1 SMP PREEMPT_DYNAMIC Debian 6.5.10-1
> (2023-11-03)
>     […]
>     [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
>     […]
>     [   15.646414] usbcore: registered new interface driver btusb
>     [   15.648188] ath10k_pci 0000:3a:00.0: pci irq msi oper_irq_mode 2
> irq_mode 0 reset_mode 0
>     [   15.649555] bluetooth hci0: firmware: direct-loading firmware
> qca/rampatch_usb_00000302.bin
>     [   15.650018] Bluetooth: hci0: using rampatch file:
> qca/rampatch_usb_00000302.bin
>     [   15.650020] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8,
> firmware rome 0x302 build 0x111
> 
> Although radio/wireless devices are turned off in GNOME, PowerTOP shows the
> Bluetooth device drawing 0.85 W of energy:
> 
>     848 mW    100.0%   Device         USB device: usb-device-0cf3-e300
> 
>     $ lsusb -d 0cf3:e300
>     Bus 001 Device 002: ID 0cf3:e300 Qualcomm Atheros Communications QCA61x4
> Bluetooth 4.0
> 
>     $ lspci -nn -s 3a:00.0
>     3a:00.0 Network controller [0280]: Qualcomm Atheros QCA6174 802.11ac
> Wireless Network Adapter [168c:003e] (rev 32)
> 
> After unloading the module `btusb`, the entry disappears from the PowerTOP
> list after a while.
> 
>     usbcore: deregistering interface driver btusb
> 
> Auto-suspend was enabled for the device. (Though it shouldn’t have mattered
> as it was disabled in GNOME?)
> 
> Anyways, have you heard of such an issue? Can I provide more information, to
> get it to not use any energy while being disable in GNOME?

USB devices still can draw power when their "wireless ability" is
disabled, that's up to the hardware to go into lower power states if it
can, or wants to.

So I recommend working with the bluetooth developers, maybe this device
can really not go any lower in power and still work properly when asked
to?  Do you know if the chipset even supports this?  If not, there's not
much the kernel can do about it.

thanks,

greg k-h
