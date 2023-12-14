Return-Path: <linux-kernel+bounces-123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C9B813C81
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B429D1F2240D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0733854279;
	Thu, 14 Dec 2023 21:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="W+/h5yrQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999EA2BCF6
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=87QCYFMZnTzVDhauQj7APRl9gZQp7z+Dll8f1MxFP68=;
  b=W+/h5yrQzfyASJhiS8Y6xsStOWS6EFGql3DwgR7frKvmHerhmG/r4+5z
   CAmP+Kf4hu9/YF0Hcg2CcXOmu5YGZdGMvuAP+d0lNdMO+NyS+B53S93gn
   Aj/Ni0I+tiSegVMwbfAXANdHTTuKCnFYZNcEY7L71qdbYLdneB7PFZjYW
   M=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=lucas.nussbaum@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,276,1695679200"; 
   d="scan'208";a="142395013"
Received: from xanadu.blop.info ([178.79.145.134])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 22:19:34 +0100
Date: Thu, 14 Dec 2023 21:55:10 +0100
From: Lucas Nussbaum <lucas.nussbaum@inria.fr>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Julia Lawall <julia.lawall@inria.fr>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: Failed to start Raise network interfaces error
Message-ID: <ZXtrrhul4td1VlTt@grub.nussbaum.fr>
References: <alpine.DEB.2.22.394.2312102317350.3198@hadrien>
 <21977757-3a63-4586-ae03-e6630c1f009d@redhat.com>
 <d87c79b9-d0d2-2819-030-12c7df86eb38@inria.fr>
 <a79a13b9-b4d1-45ba-a104-01e911631863@redhat.com>
 <4c707e3e-a324-a5e6-dc21-833b6d40324d@inria.fr>
 <88a7a623-ad80-406c-a63b-3136df963888@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88a7a623-ad80-406c-a63b-3136df963888@redhat.com>

Hi,

On 12/12/23 at 17:44 +0100, Ivan Vecera wrote:
> 
> 
> On 12. 12. 23 17:33, Julia Lawall wrote:
> > > Look at 'systemd.net-naming-scheme' man page for details how the interface
> > > names are composed.
> > After booting into 6.7.0-rc4, I have the following in
> > /etc/network/interfaces:
> > 
> > # This file describes the network interfaces available on your system
> > # and how to activate them. For more information, see interfaces(5).
> > 
> > source/etc/network/interfaces.d/*
> > 
> > # The loopback network interface
> > auto lo
> > iface lo inet loopback
> > 
> > auto enp24s0f0
> > iface enp24s0f0 inet dhcp
> 
> Just change 'enp24s0f0' in /etc/network/interfaces to 'enp24s0f0np0'

But is this change of interface naming really the desired behaviour?

From a user point of view, this is likely to cause hassle during upgrades
from older kernels (or generally when switching between kernel versions
-- think bisecting).

Is there really a benefit to that change? On a dual-port XXV710 NIC, the
naming changes from e.g. enp98s0f0 / enp98s0f1 to enp98s0f0np0 /
enp98s0f1np1, because udev previously computed the name using:
enp98s0f0: PCI path identifier: domain=0 bus=98 slot=0 func=0 phys_port= dev_port=0 → p98s0f0
and now uses:
enp98s0f0np0: PCI path identifier: domain=0 bus=98 slot=0 func=0 phys_port=p0 dev_port=0 → p98s0f0np0

Are there NICs using i40e where the function number is different from
the physical port number?

Best,

Lucas

