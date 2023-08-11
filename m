Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B21C778855
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbjHKHiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjHKHiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:38:22 -0400
X-Greylist: delayed 46964 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Aug 2023 00:38:19 PDT
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E41E73;
        Fri, 11 Aug 2023 00:38:19 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id D7179206D9;
        Fri, 11 Aug 2023 09:38:16 +0200 (CEST)
Date:   Fri, 11 Aug 2023 09:38:15 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Neeraj sanjay kale <neeraj.sanjaykale@nxp.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Rohit Fule <rohit.fule@nxp.com>,
        Sherry Sun <sherry.sun@nxp.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] Bluetooth: btnxpuart: Add support for IW624 chipset
Message-ID: <ZNXlZymt59+Cykqd@francesco-nb.int.toradex.com>
References: <20230810094802.832652-1-neeraj.sanjaykale@nxp.com>
 <ZNUUeD2Zr1SfTODT@francesco-nb.int.toradex.com>
 <DU2PR04MB860074DF11676414E57A5904E713A@DU2PR04MB8600.eurprd04.prod.outlook.com>
 <ZNUt9V2WCS/ZCavl@livingston.pivistrello.it>
 <AM9PR04MB8603F338D7C1511C3E0269C9E710A@AM9PR04MB8603.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR04MB8603F338D7C1511C3E0269C9E710A@AM9PR04MB8603.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Neeraj,

On Fri, Aug 11, 2023 at 06:19:12AM +0000, Neeraj sanjay kale wrote:
> > > > > --- a/drivers/bluetooth/btnxpuart.c
> > > > > +++ b/drivers/bluetooth/btnxpuart.c
> > > > ...
> > > > > @@ -547,7 +553,7 @@ static int nxp_download_firmware(struct
> > > > > hci_dev
> > > > *hdev)
> > > > >       serdev_device_set_flow_control(nxpdev->serdev, false);
> > > > >       nxpdev->current_baudrate = HCI_NXP_PRI_BAUDRATE;
> > > > >
> > > > > -     /* Wait till FW is downloaded and CTS becomes low */
> > > > > +     /* Wait till FW is downloaded */
> > > > >       err = wait_event_interruptible_timeout(nxpdev-
> > >fw_dnld_done_wait_q,
> > > > >
> > > > > !test_bit(BTNXPUART_FW_DOWNLOADING,
> > > > >
> > > > > &nxpdev->tx_state), @@ -558,16 +564,11 @@ static int
> > > > nxp_download_firmware(struct hci_dev *hdev)
> > > > >       }
> > > > >
> > > > >       serdev_device_set_flow_control(nxpdev->serdev, true);
> > > > > -     err = serdev_device_wait_for_cts(nxpdev->serdev, 1, 60000);
> > > > > -     if (err < 0) {
> > > > > -             bt_dev_err(hdev, "CTS is still high. FW Download failed.");
> > > > > -             return err;
> > > > > -     }
> > > > this seems like an unrelated change, and it's moving from a 60secs
> > > > timeout polling CTS to nothing.
> > > >
> > > > What's the reason for this? Should be this a separate commit with a
> > > > proper explanation?
> > > >
> > > While working on integrating IW624 in btnxpuart driver, I observed
> > > that the first reset command was getting timed out, after FW download
> > > was complete 2 out of 10 times. On further timing analysis, I noticed
> > > that this wait for CTS code did not actually help much, since CTS is
> > > already low after FW download, and becomes high after few more
> > > milli-seconds, and then low again after FW is initialized.  So it was
> > > either adding a "wait for CTS high" followed by "wait for CTS low", or
> > simply increasing the sleep delay from 1000msec to 1200msec.
> > > I chose the later as it seemed more cleaner, and did the job
> > > perfectly, and tested all previously supported chipsets to make sure
> > > nothing is broke.  But you are right, I should add an explanation for
> > > this change in the commit message in the v2 patch.
> > 
> > This should be a separate commit, and probably it should have a fixes tag,
> > since this is solving a bug. I recently noted some bugs around this, I just did
> > not have the time to reproduce on the latest mainline kernel to report those.
> Sure I will revert this change and add the wait for CTS back. I will
> remove it later in a separate fixes patch.  Please do let us know if
> you encounter any issues here.

I would probably do the other way around, first the fix, and then the
IW624 addition. You can just send a single series with both patches.

BTW: your email client is somehow messing up the email, you should do
something on that regards, it makes more difficult to reply to your
emails.

Francesco

