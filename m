Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35A380F2C3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjLLQdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjLLQdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:33:05 -0500
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862D7E9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3xHlem4pz0D1lBzgxJbJ/CLXkAkREGywHUDBpdVSaUo=;
  b=TV2Pf/7RqkK1z9ROea0bDdumrKniOhv3zJK7ZtXBGkG0ouAuPqTRahdz
   MCe1+XHjlSHYdeCApQEyoUTKZ/2slB0m1SR5/Ic1IDcWhlPFMEFeo2k+Z
   cEFQ2oLpClwVomzWoqieE0FNxbU6hbwdp0X6UaCSx/07j8emZKANLXiKo
   M=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,270,1695679200"; 
   d="scan'208";a="74214030"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 17:33:09 +0100
Date:   Tue, 12 Dec 2023 17:33:08 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Ivan Vecera <ivecera@redhat.com>
cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Failed to start Raise network interfaces error
In-Reply-To: <a79a13b9-b4d1-45ba-a104-01e911631863@redhat.com>
Message-ID: <4c707e3e-a324-a5e6-dc21-833b6d40324d@inria.fr>
References: <alpine.DEB.2.22.394.2312102317350.3198@hadrien> <21977757-3a63-4586-ae03-e6630c1f009d@redhat.com> <d87c79b9-d0d2-2819-030-12c7df86eb38@inria.fr> <a79a13b9-b4d1-45ba-a104-01e911631863@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Dec 2023, Ivan Vecera wrote:

> On 12. 12. 23 16:08, Julia Lawall wrote:
> >
> >
> > On Tue, 12 Dec 2023, Ivan Vecera wrote:
> >
> > > On 10. 12. 23 23:28, Julia Lawall wrote:
> > > > Hello,
> > > >
> > > > Starting with the commit:
> > > >
> > > > commit 9e479d64dc58f11792f638ea2e8eff3304edaabf
> > > > Author: Ivan Vecera <ivecera@redhat.com>
> > > > Date:   Fri Oct 13 19:07:51 2023 +0200
> > > >
> > > >       i40e: Add initial devlink support
> > > >
> > > > I am not able to boot normally.  The console shows the message
> > > >
> > > > Failed to start Raise network interfaces
> > > >
> > > > Searching for this message on th internet produces some old discussions
> > > > that suggest to look at the file /etc/network/interfaces.  That file on
> > > > my
> > > > system contains:
> > > >
> > > > # This file describes the network interfaces available on your system
> > > > # and how to activate them. For more information, see interfaces(5).
> > > >
> > > > source /etc/network/interfaces.d/*
> > > >
> > > > # The loopback network interface
> > > > auto lo
> > > > iface lo inet loopback
> > > >
> > > > auto enp24s0f0
> > > > iface enp24s0f0 inet dhcp
> > >
> > > The problem is maybe with interface name... after this commit the
> > > interface
> > > should contain port_name suffix. In your case the name should be
> > > `enp24s0f0np0`.
> > >
> > > Could you please check it?
> >
> > Thanks for the feedback.  But I'm not clear on how this would work.  Does
> > there have to be one name for kernels before this patch and another name
> > for kernels starting with this patch?  Or is the new name also acceptable
> > for older kernels?
>
> The name of a network interface is configured by udev. And it takes network
> interface attributes and compose a name for it. One of these attributes is
> phys_port_name [1] and if it is provided then its value is appended to the
> name.
>
> Prior this commit the i40e driver didn't provided this attribute so the name
> is (in your case) enp24s0f0. After this commit the value is provided so it is
> appended -> enp24s0f0np0
>
> Look at 'systemd.net-naming-scheme' man page for details how the interface
> names are composed.

After booting into 6.7.0-rc4, I have the following in
/etc/network/interfaces:

# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

auto enp24s0f0
iface enp24s0f0 inet dhcp

----------

So I don't see enp24s0f0np0

/sys/class/net/ contains:

enp24s0f0np0  enp24s0f1np1  ibp94s0  lo

/sys/class/net/enp24s0f0np0/phys_port_name does contain p0.

thanks,
julia


>
> Thanks,
> Ivan
>
> [1] /sys/class/net/enp2s0f0np0/phys_port_name
>
>
