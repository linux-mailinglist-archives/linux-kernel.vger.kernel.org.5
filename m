Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971CE791FC8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 02:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbjIEANA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 20:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237503AbjIEAM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 20:12:59 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CCFE4D;
        Mon,  4 Sep 2023 17:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1693872761; bh=BdHr5xYzJaXpVVjrVQyCyMhqKo0QPrh0h1mxW+BeCdk=;
        h=Date:From:To:Subject:X-My-GPG-KeyId:References:From;
        b=sCAZbCxG4vDYd8PkSat1sRd/mrRSogl2lERQpDPcT0EpkfGeutxnj0JDslll30xMP
         SUFbCkURxw4uAOAP+fSPk7VL24AZe+I1tyxIfgR1rhN8JlSWFFqNMgqUyJewpC+lih
         w28bXq0ZLiHQhLX5YFnqIIDZjFwmoPkDKwqWh6M0=
Date:   Tue, 5 Sep 2023 02:12:40 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Sascha Hauer <s.hauer@pengutronix.de>, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/2] usb: gadget: u_ether: Do not make UDC parent of the
 net device
Message-ID: <gu73djslgompoxoouph337njqoe67mntrneupbqwdoy7b2sf7e@zdj5bncze6q2>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
        Sascha Hauer <s.hauer@pengutronix.de>, linux-usb@vger.kernel.org, 
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, kernel@pengutronix.de
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20221104131031.850850-1-s.hauer@pengutronix.de>
 <20221104131031.850850-2-s.hauer@pengutronix.de>
 <miiwk4pah7tgdszugqmhnnaweyt7wrw3bxmuliyva3k7nccyab@lsyhvutbuzx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <miiwk4pah7tgdszugqmhnnaweyt7wrw3bxmuliyva3k7nccyab@lsyhvutbuzx2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 03:14:30PM +0200, megi xff wrote:
> 
> Hi,
> 
> On Fri, Nov 04, 2022 at 02:10:30PM +0100, Sascha Hauer wrote:
> > ing-List: linux-kernel@vger.kernel.org
> > 
> > The UDC is not a suitable parent of the net device as the UDC can
> > change or vanish during the lifecycle of the ethernet gadget. This
> > can be illustrated with the following:
> > 
> > mkdir -p /sys/kernel/config/usb_gadget/mygadget
> > cd /sys/kernel/config/usb_gadget/mygadget
> > mkdir -p configs/c.1/strings/0x409
> > echo "C1:Composite Device" > configs/c.1/strings/0x409/configuration
> > mkdir -p functions/ecm.usb0
> > ln -s functions/ecm.usb0 configs/c.1/
> > echo "dummy_udc.0" > UDC
> > rmmod dummy_hcd
> > 
> > The 'rmmod' removes the UDC from the just created gadget, leaving
> > the still existing net device with a no longer existing parent.
> 
> I have an even simpler reproducer on Pinephone Pro/RK3399 SoC. All it takes to
> trigger the use after free and kernel panic in my case is to plug in a USB dock
> to make DWC3 DRD switch to host mode and then unplug it to make it switch back to
> peripheral mode.
> 
> This triggers a call to dwc3_gadget_exit and then to dwc3_gadget_init later on
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/usb/dwc3/gadget.c#L4546
> 
> Then symlink to the net device becames broken in sysfs:
> 
>   https://megous.com/dl/tmp/3d8061f1749a7b2b.png
> 
> And after this happens, there's a kernel panic when removing the rndis gadget
> configuration from configfs: https://paste.mozilla.org/Z5DFP9BV
> (and possibly other issues, but the kernel panic is the most noticable :))
> 
> Applaying this patch makes the issue go away. So there definitely seems to
> be some device lifetime issue somewhere in there.

Looks like this patch just masks an underlying issue. Eg. with DWC3 as UDC,
rndis_bind/rndis_unbind is called multiple times (each time USB role switches
from host to peripheral). This is because DWC3 re-creates the gadget device
each time. During every call rndis_bind gets a pointer to a newly created
gadget, but gether_set_gadget() is only called:

  if (!rndis_opts->bound) {
  	...
  }

which only happens on the first call to rndis_bind.

On any further calls to rndis_bind(), gether_set_gadget is not called, because
rndis_opts->bound is already set and thus netdev private data keep pointing to
some old, deleted gadget device.

https://elixir.bootlin.com/linux/latest/source/drivers/usb/gadget/function/f_rndis.c#L704
https://elixir.bootlin.com/linux/latest/source/drivers/usb/gadget/function/u_ether.c#L890

It looks like this whole code was not really written with assumption that
gadget devices can be deleted and re-added like this.

Not sure where the bug really is... if f_* drivers should better handle gadget changes,
or DWC3 should not re-create the gadget like it does on mode changes, or
elsewhere.

kind regards,
	o.

> kind regards,
> 	o.
> 
> > Accessing the ethernet device with commands like:
> > 
> > ip --details link show usb0
> > 
> > will result in a KASAN splat:
> > 
> > ==================================================================
> > BUG: KASAN: use-after-free in if_nlmsg_size+0x3e8/0x528
> > Read of size 4 at addr c5c84754 by task ip/357
> > 
> > CPU: 3 PID: 357 Comm: ip Not tainted 6.1.0-rc3-00013-gd14953726b24-dirty #324
> > Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> >  unwind_backtrace from show_stack+0x10/0x14
> >  show_stack from dump_stack_lvl+0x58/0x70
> >  dump_stack_lvl from print_report+0x134/0x4d4
> >  print_report from kasan_report+0x78/0x10c
> >  kasan_report from if_nlmsg_size+0x3e8/0x528
> >  if_nlmsg_size from rtnl_getlink+0x2b4/0x4d0
> >  rtnl_getlink from rtnetlink_rcv_msg+0x1f4/0x674
> >  rtnetlink_rcv_msg from netlink_rcv_skb+0xb4/0x1f8
> >  netlink_rcv_skb from netlink_unicast+0x294/0x478
> >  netlink_unicast from netlink_sendmsg+0x328/0x640
> >  netlink_sendmsg from ____sys_sendmsg+0x2a4/0x3b4
> >  ____sys_sendmsg from ___sys_sendmsg+0xc8/0x12c
> >  ___sys_sendmsg from sys_sendmsg+0xa0/0x120
> >  sys_sendmsg from ret_fast_syscall+0x0/0x1c
> > 
> > Solve this by not setting the parent of the ethernet device.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/usb/gadget/function/u_ether.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
> > index e06022873df16..8f12f3f8f6eeb 100644
> > --- a/drivers/usb/gadget/function/u_ether.c
> > +++ b/drivers/usb/gadget/function/u_ether.c
> > @@ -798,7 +798,6 @@ struct eth_dev *gether_setup_name(struct usb_gadget *g,
> >  	net->max_mtu = GETHER_MAX_MTU_SIZE;
> >  
> >  	dev->gadget = g;
> > -	SET_NETDEV_DEV(net, &g->dev);
> >  	SET_NETDEV_DEVTYPE(net, &gadget_type);
> >  
> >  	status = register_netdev(net);
> > @@ -873,8 +872,6 @@ int gether_register_netdev(struct net_device *net)
> >  	struct usb_gadget *g;
> >  	int status;
> >  
> > -	if (!net->dev.parent)
> > -		return -EINVAL;
> >  	dev = netdev_priv(net);
> >  	g = dev->gadget;
> >  
> > @@ -905,7 +902,6 @@ void gether_set_gadget(struct net_device *net, struct usb_gadget *g)
> >  
> >  	dev = netdev_priv(net);
> >  	dev->gadget = g;
> > -	SET_NETDEV_DEV(net, &g->dev);
> >  }
> >  EXPORT_SYMBOL_GPL(gether_set_gadget);
> >  
> > -- 
> > 2.30.2
> > 
