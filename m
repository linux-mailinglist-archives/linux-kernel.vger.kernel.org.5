Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15207982AA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 08:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbjIHGrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 02:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbjIHGrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 02:47:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934A01BF0;
        Thu,  7 Sep 2023 23:46:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2B2C433C9;
        Fri,  8 Sep 2023 06:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694155619;
        bh=F/+3AoZMSA6jGzbZvILpyJhqzHBMsKrZoIHomJSa4HI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Digbn9unnTDdYbaZjXuF+eTk9YuXPNpX0HcgtWvI6qysLqfZfbHtE0AqQlEZozKf1
         3DpBxe5JPnXQuE/su+szL/IPjrneBMc9YyAvAwtT/DnfBFs+QZef1Sadb8iX8GcCPA
         V2bo2I0EOag6gTdMy2NQE3in9n9efkPUmMKk0kxA=
Date:   Fri, 8 Sep 2023 07:46:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stefan Lippers-Hollmann <s.l-h@gmx.de>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.5 11/34] modules: only allow symbol_get of
 EXPORT_SYMBOL_GPL modules
Message-ID: <2023090848-chastise-paycheck-6d4d@gregkh>
References: <20230904182948.594404081@linuxfoundation.org>
 <20230904182949.104100132@linuxfoundation.org>
 <20230907084135.02d97441@mir>
 <2023090719-virtuous-snowflake-d015@gregkh>
 <20230907221737.07f12f38@mir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907221737.07f12f38@mir>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 10:17:37PM +0200, Stefan Lippers-Hollmann wrote:
> Hi
> 
> On 2023-09-07, Greg Kroah-Hartman wrote:
> > On Thu, Sep 07, 2023 at 08:41:35AM +0200, Stefan Lippers-Hollmann wrote:
> > > On 2023-09-04, Greg Kroah-Hartman wrote:
> > > > 6.5-stable review patch.  If anyone has any objections, please let me know.
> > > >
> > > > ------------------
> > > >
> > > > From: Christoph Hellwig <hch@lst.de>
> > > >
> > > > commit 9011e49d54dcc7653ebb8a1e05b5badb5ecfa9f9 upstream.
> > > >
> > > > It has recently come to my attention that nvidia is circumventing the
> > > > protection added in 262e6ae7081d ("modules: inherit
> > > > TAINT_PROPRIETARY_MODULE") by importing exports from their proprietary
> > > > modules into an allegedly GPL licensed module and then rexporting them.
> > > >
> > > > Given that symbol_get was only ever intended for tightly cooperating
> > > > modules using very internal symbols it is logical to restrict it to
> > > > being used on EXPORT_SYMBOL_GPL and prevent nvidia from costly DMCA
> > > > Circumvention of Access Controls law suites.
> > > >
> > > > All symbols except for four used through symbol_get were already exported
> > > > as EXPORT_SYMBOL_GPL, and the remaining four ones were switched over in
> > > > the preparation patches.
> > >
> > > This patch, as part of v6.5.2, breaks the in-kernel ds3000 module
> > > (for a TeVii s480 v2 DVB-S2 card, which is a PCIe card attaching two
> > > onboard TeVii s660 cards via an onboard USB2 controller (MCS9990),
> > > https://www.linuxtv.org/wiki/index.php/TeVii_S480) from loading.
> >
> > This is also broken in Linus's tree, right?
> 
> Yes, HEAD as of 6.5.0-12145-g4a0fc73da97e is affected just as well.

Ok, good, thanks for confirming.

> > > [    2.896589] dvbdev: dvb_create_media_entity: media entity 'dvb-demux' registered.
> > > [    2.901085] failing symbol_get of non-GPLONLY symbol ds3000_attach.
> > > [    2.901089] DVB: Unable to find symbol ds3000_attach()
> >
> > This is odd, where is that call coming from?  I don't see any call to
> > symbol_get in the dvb code, where is this happening?
> >
> > Anyway, does the patch below fix this?
> 
> That change alone only moves the issue down to ts2020_attach().
> 
> $ dmesg | grep -i -e dvb -e gpl -e symbol
> [    1.464876] usb 3-1: Product: DVBS2BOX
> [    1.482143] usb 5-1: Product: DVBS2BOX
> [    3.692647] dvb-usb: found a 'TeVii S660 USB' in cold state, will try to load a firmware
> [    3.692951] dvb-usb: downloading firmware from file 'dvb-usb-s660.fw'
> [    3.860571] dvb-usb: found a 'TeVii S660 USB' in warm state.
> [    3.860615] dvb-usb: will pass the complete MPEG2 transport stream to the software demuxer.
> [    3.860944] dvbdev: DVB: registering new adapter (TeVii S660 USB)
> [    4.097144] dvb-usb: MAC address: 00:18:XX:XX:XX:XX
> [    4.097272] dvbdev: dvb_create_media_entity: media entity 'dvb-demux' registered.
> [    4.111792] failing symbol_get of non-GPLONLY symbol ts2020_attach.
> [    4.111795] DVB: Unable to find symbol ts2020_attach()
> [    4.112759] usb 3-1: DVB: registering adapter 0 frontend 0 (Montage Technology DS3000)...
> [    4.112764] dvbdev: dvb_create_media_entity: media entity 'Montage Technology DS3000' registered.
> [    4.138938] dvb-usb: schedule remote query interval to 150 msecs.
> [    4.138942] dvb-usb: TeVii S660 USB successfully initialized and connected.
> [    4.138988] dvb-usb: found a 'TeVii S660 USB' in cold state, will try to load a firmware
> [    4.139016] dvb-usb: downloading firmware from file 'dvb-usb-s660.fw'
> [    4.292614] dvb-usb: found a 'TeVii S660 USB' in warm state.
> [    4.292679] dvb-usb: will pass the complete MPEG2 transport stream to the software demuxer.
> [    4.293075] dvbdev: DVB: registering new adapter (TeVii S660 USB)
> [    4.538876] dvb-usb: MAC address: 00:18:XX:XX:XX:XX
> [    4.539113] dvbdev: dvb_create_media_entity: media entity 'dvb-demux' registered.
> [    4.543738] failing symbol_get of non-GPLONLY symbol ts2020_attach.
> [    4.546349] failing symbol_get of non-GPLONLY symbol ts2020_attach.
> [    4.546354] DVB: Unable to find symbol ts2020_attach()
> [    4.548643] usb 5-1: DVB: registering adapter 1 frontend 0 (Montage Technology DS3000)...
> [    4.548650] dvbdev: dvb_create_media_entity: media entity 'Montage Technology DS3000' registered.
> [    4.549970] dvb-usb: schedule remote query interval to 150 msecs.
> [    4.549973] dvb-usb: TeVii S660 USB successfully initialized and connected.
> [    7.830408] ds3000_firmware_ondemand: Waiting for firmware upload (dvb-fe-ds3000.fw)...
> [    8.367600] ds3000_firmware_ondemand: Waiting for firmware upload (dvb-fe-ds3000.fw)...
> 
> Extending this to approach to ts2020_attach() does fix the problem
> for me. Searching the web for "failing symbol_get of non-GPLONLY
> symbol" suggests that there might be further instances within the
> DVB subsystem https://syzkaller.appspot.com/x/log.txt?x=11faa1eda80000
> (this was merely gathered by a passive web search, I have no contact
> to the poster or any further information about it).

Ugh, it looks like everyone that calls dvb_attach() is going to be
affected.  I can make up a patch for this later today, unless Christoph
beats me to it :)

Also, in commit 8f569c0b4e6b ("media: dvb-core: add helper functions for
I2C binding"), way back in 2018, it says no one should be using this
function anymore, but given I see over 700 uses of it, that's obviously
not changing any time soon :(

> [ now fully functional with EXPORT_SYMBOL_GPL(ds3000_attach) and
>   EXPORT_SYMBOL_GPL(ts2020_attach) ]

Thanks for testing this.

greg k-h
