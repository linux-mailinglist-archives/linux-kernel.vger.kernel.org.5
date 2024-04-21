Return-Path: <linux-kernel+bounces-152523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9308ABFF8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 17:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BFD92819B4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 15:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9B01BDCE;
	Sun, 21 Apr 2024 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssi.bg header.i=@ssi.bg header.b="Q8KrmCo4"
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CF91BC2A;
	Sun, 21 Apr 2024 15:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.238.174.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713715104; cv=none; b=hdW3WHocENoQrgfiujqWb5XSuHlbDjbKOXLcuqJ+0ntmftHK0NKP7wM8XA9WDnzDxIQ+oD9nxwM55JFXU31UJyz/cDTRqTX8E5fPAFdCWG/4p0gnaV6yAlVSCK3AXrxNGmgHantA8qkje634HU/He36te0faHnt+Y8GnpL3Y9Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713715104; c=relaxed/simple;
	bh=O3g/dwNbPOlGeREP5DLztRfYyrPB9K8uTpS/h1FUspI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fzW6aHJJif4oxZoP8tof90u12W+L1oA7Q531NmKodcoU/+db1yRWVrUaAdWJEx305q1L5CcOOtd3hOMexX8E7vn4VRaZ5UnidwLcmXyi/axHI/B/2V6trbVlafn+qfSPJa/aWulUG6xHGc15QSIHlAC7GPHX+vZaFsINU1wSOas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (1024-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=Q8KrmCo4; arc=none smtp.client-ip=193.238.174.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Received: from mg.ssi.bg (localhost [127.0.0.1])
	by mg.ssi.bg (Proxmox) with ESMTP id 708C122CE3;
	Sun, 21 Apr 2024 18:58:18 +0300 (EEST)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
	by mg.ssi.bg (Proxmox) with ESMTPS;
	Sun, 21 Apr 2024 18:58:17 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by ink.ssi.bg (Postfix) with ESMTPSA id 8C3AB9003A6;
	Sun, 21 Apr 2024 18:58:13 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ssi.bg; s=ink;
	t=1713715093; bh=O3g/dwNbPOlGeREP5DLztRfYyrPB9K8uTpS/h1FUspI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Q8KrmCo46WvXg/DCTE8uZcW0Aq6r5YH34HeegfnQhfFrYiPvEB973HpGOXl5uRAYx
	 UFlzKg6UomPiBjDgm+W78HUPI1r585vxhkAHn+SZtJwZQVPOPAp+Ben1O54k2AlaGN
	 xVG7fOODeJnQIryRCz+BrgXSkEhSLKkmcSUvzzoA=
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.17.1/8.17.1) with ESMTP id 43LFwBYu079854;
	Sun, 21 Apr 2024 18:58:11 +0300
Date: Sun, 21 Apr 2024 18:58:11 +0300 (EEST)
From: Julian Anastasov <ja@ssi.bg>
To: Ismael Luceno <iluceno@suse.de>
cc: linux-kernel@vger.kernel.org, Firo Yang <firo.yang@suse.com>,
        Andreas Taschner <andreas.taschner@suse.com>,
        =?UTF-8?Q?Michal_Kube=C4=8Dek?= <mkubecek@suse.com>,
        Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
        coreteam@netfilter.org
Subject: Re: [PATCH] ipvs: Fix checksumming on GSO of SCTP packets
In-Reply-To: <ZiUiM1tlM3smXSsR@pirotess>
Message-ID: <f73be54f-8d91-bf51-f297-caba9f8fd598@ssi.bg>
References: <20240418144434.16407-1-iluceno@suse.de> <fd234180-4d6f-313a-0edd-13c821bd4423@ssi.bg> <ZiUiM1tlM3smXSsR@pirotess>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


	Hello,

On Sun, 21 Apr 2024, Ismael Luceno wrote:

> On 21/Apr/2024 14:01, Julian Anastasov wrote:
> 
> > 	I'm guessing what should be the Fixes line, may be?:
> > 
> > Fixes: 90017accff61 ("sctp: Add GSO support")
> 
> This seems like the right one.
> 
> > 	because SCTP GSO was added after the IPVS code? Or the
> > more recent commit d02f51cbcf12 which adds skb_is_gso_sctp ?
> 
> That doesn't seem related at all.
> 
> Do we need to check .gso_type in cases like this?

	Just skb_is_gso(skb) ? IMHO, this should work.

Regards

--
Julian Anastasov <ja@ssi.bg>


