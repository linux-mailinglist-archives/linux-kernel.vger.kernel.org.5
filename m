Return-Path: <linux-kernel+bounces-51456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA09848B78
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE4B1F21E9A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 06:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC08747C;
	Sun,  4 Feb 2024 06:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jgHGOvgV"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB206FA8
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 06:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707027755; cv=none; b=Hzl9lsBVeFNpqV1SrogaVlFZgW0LYRpDXvd9iheavKBGm7XoTC+jkkLmL435jWVOJ31LKgzs8Hz3D+TOwOPRrAstwPXg5ASerRiDJfFj2UHkwK/623lS85hecMAtoEGwhlpGf4lgwpav3vUCwGKH8vYcmFUMyKPNQAMbXrMllis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707027755; c=relaxed/simple;
	bh=Ivcae1sfCiwh3asxtu/ucVxviQTlilRsKiCM9IPtg+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXhaUJJqU2MuPqST58g0Q76vcmxHxPed0+DupS2sudutF+ycnLLSNUn7Px7gXO4uJddy4l84cNgD80mE2DoX8hTPQUAKVXSrnv/ckzS/Bv6bupD2AFOIIlTWNOtoil2dNhTePXibUD5Xv5QuoLKs4PokbT/jJwRa83CInMA1FJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jgHGOvgV; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CE06029B55;
	Sun,  4 Feb 2024 01:22:32 -0500 (EST)
	(envelope-from adamg@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=Ivcae1sfCiwh3asxtu/ucVxviQTlilRsKiCM9IP
	tg+c=; b=jgHGOvgVrYOfy5nkDgNlVvW9IkWV80t5py1NVqcz/S6mK7NZx88DO8K
	7wc+Fg5XWmpi8Fhf+/8SsenRK6c52qLrmp89EtGr+JtFqiqiP3twLgVGGRv4Vsvs
	vMhKqWnyNuoYnEoNWQym36IQXwDfc0aCNHw0R7bmabzs+Hwm5544=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C6E8229B54;
	Sun,  4 Feb 2024 01:22:32 -0500 (EST)
	(envelope-from adamg@pobox.com)
Received: from pogo.deviceside.com (unknown [71.19.144.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A514E29B53;
	Sun,  4 Feb 2024 01:22:29 -0500 (EST)
	(envelope-from adamg@pobox.com)
Received: from iguana.24-8.net (99-122-168-208.lightspeed.irvnca.sbcglobal.net [99.122.168.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: iguana@pogo.deviceside.com)
	by pogo.deviceside.com (Postfix) with ESMTPSA id 1E392C08C4;
	Sat,  3 Feb 2024 22:22:28 -0800 (PST)
Date: Sat, 3 Feb 2024 22:22:26 -0800
From: Adam Goldman <adamg@pobox.com>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: send bus reset promptly on gap count
 error
Message-ID: <Zb8tId0k1iNqFstx@iguana.24-8.net>
References: <Za90vAQlDhbLpY67@iguana.24-8.net>
 <20240127083730.GA159729@workstation.local>
 <ZbTlaCCbpxQoqo0i@iguana.24-8.net>
 <20240131142714.GA60028@workstation.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131142714.GA60028@workstation.local>
X-Pobox-Relay-ID:
 C5ED49A2-C325-11EE-842E-A19503B9AAD1-07713566!pb-smtp21.pobox.com

Hi,

On Wed, Jan 31, 2024 at 11:27:14PM +0900, Takashi Sakamoto wrote:
> I'd like to apply your patch for v6.9 kernel, while the patch
> description is not suffice, as I address. I'm sorry to ask you more
> work, but would I ask you to repost your patch with any detail
> description? The description should include enough information for
> developers inner/outer this subsystem to understand its background
> and intention.

Is the following description acceptable?

If we are bus manager and the bus has inconsistent gap counts, send a bus 
reset immediately instead of trying to read the root node's config ROM 
first. Otherwise, we could spend a lot of time trying to read the config 
ROM but never succeeding.

This eliminates a 50+ second delay before the FireWire bus is usable after 
a newly connected device is powered on in certain circumstances.

The delay occurs if a gap count inconsistency occurs, we are not the root 
node, and we become bus manager. One scenario that causes this is with a TI 
XIO2213B OHCI, the first time a Sony DSR-25 is powered on after being 
connected to the FireWire cable. In this configuration, the Linux box will 
not receive the initial PHY configuration packet sent by the DSR-25 as IRM, 
resulting in the DSR-25 having a gap count of 44 while the Linux box has a 
gap count of 63.

FireWire devices have a gap count parameter, which is set to 63 on power-up 
and can be changed with a PHY configuration packet. This determines the 
duration of the subaction and arbitration gaps. For reliable communication, 
all nodes on a FireWire bus must have the same gap count.

A node may have one or more of the following roles: root node, bus manager 
(BM), isochronous resource manager (IRM), and cycle master. Unless a root 
node was forced with a PHY configuration packet, any node might become root 
node after a bus reset. Only the root node can become cycle master. If the 
root node is not cycle master capable, the BM or IRM should force a change 
of root node.

After a bus reset, each node sends a self-ID packet, which contains its 
current gap count. A single bus reset does not change the gap count, but 
two bus resets in a row will set the gap count to 63. Because a consistent 
gap count is required for reliable communication, IEEE 1394a-2000 requires 
that the bus manager generate a bus reset if it detects that the gap count 
is inconsistent.

When the gap count is inconsistent, build_tree() will notice this after the 
self identification process. It will set card->gap_count to the invalid 
value 0. If we become bus master, this will force bm_work() to send a bus 
reset when it performs gap count optimization.

After a bus reset, there is no bus manager. We will almost always try to 
become bus manager. Once we become bus manager, we will first determine 
whether the root node is cycle master capable. Then, we will determine if 
the gap count should be changed. If either the root node or the gap count 
should be changed, we will generate a bus reset.

To determine if the root node is cycle master capable, we read its 
configuration ROM. bm_work() will wait until we have finished trying to 
read the configuration ROM.

However, an inconsistent gap count can make this take a long time. 
read_config_rom() will read the first few quadlets from the config ROM. Due 
to the gap count inconsistency, eventually one of the reads will time out. 
When read_config_rom() fails, fw_device_init() calls it again until 
MAX_RETRIES is reached. This takes 50+ seconds.

Once we give up trying to read the configuration ROM, bm_work() will wake 
up, assume that the root node is not cycle master capable, and do a bus 
reset. Hopefully, this will resolve the gap count inconsistency.

This change makes bm_work() check for an inconsistent gap count before 
waiting for the root node's configuration ROM. If the gap count is 
inconsistent, bm_work() will immediately do a bus reset. This eliminates 
the 50+ second delay and rapidly brings the bus to a working state.

I considered that if the gap count is inconsistent, a PHY configuration 
packet might not be successful, so it could be desirable to skip the PHY 
configuration packet before the bus reset in this case. However, IEEE 
1394a-2000 and IEEE 1394-2008 say that the bus manager may transmit a PHY 
configuration packet before a bus reset when correcting a gap count error. 
Since the standard endorses this, I decided it's safe to retain the PHY 
configuration packet transmission.

Normally, after a topology change, we will reset the bus a maximum of 5 
times to change the root node and perform gap count optimization. However, 
if there is a gap count inconsistency, we must always generate a bus reset. 
Otherwise the gap count inconsistency will persist and communication will 
be unreliable. For that reason, if there is a gap count inconstency, we 
generate a bus reset even if we already reached the 5 reset limit.

-- Adam

