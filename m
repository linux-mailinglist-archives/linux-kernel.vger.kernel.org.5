Return-Path: <linux-kernel+bounces-37082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6618E83AB3F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 981451C217B1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD5B77F3E;
	Wed, 24 Jan 2024 13:58:13 +0000 (UTC)
Received: from mail.wantstofly.org (hmm.wantstofly.org [213.239.204.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCA377658;
	Wed, 24 Jan 2024 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.239.204.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706104693; cv=none; b=F1SNGpKWyks0zO8/3N/FJV96GGSWX6BvOa/WLnL3F1NDmn6vrdW/9E8xNwE4UBMku6IMAUkzAGHLs4PExM3XmQS2ALxoxuKbD2gS1dnC6GQb8TZ6yq4dpOFoZ6cRuVSr+/iIMLngjenRU7te39eTGQyDTG2syeX9JHkmcbnjSf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706104693; c=relaxed/simple;
	bh=q/2/V58ITZlDDjL2VM6IfKb7G4x7oTR6z6aY16ImCkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/cBE641TscChXDNAUbG+64BIEafA2KmYnrc38qYLkBt70WjIdQTvgbzfbvQFZwfZ/4RPOblCaNI+BKz7qUMpjvgI+p6R91Z2kcbpAWFboKecwesMVDHKAuUtfAtuSoAbbw8zMknW0YuUmuLZe26bEWF3+XpPVnvr0ej926bITM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wantstofly.org; spf=pass smtp.mailfrom=wantstofly.org; arc=none smtp.client-ip=213.239.204.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wantstofly.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wantstofly.org
Received: by mail.wantstofly.org (Postfix, from userid 1000)
	id 8EDCB7F712; Wed, 24 Jan 2024 15:58:08 +0200 (EET)
Date: Wed, 24 Jan 2024 15:58:08 +0200
From: Lennert Buytenhek <kernel@wantstofly.org>
To: Niklas Cassel <nks@flawful.org>
Cc: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ASMedia ASM1062 (AHCI) hang after "ahci 0000:28:00.0: Using
 64-bit DMA addresses"
Message-ID: <ZbEXcFJkw4zXKxqb@wantstofly.org>
References: <ZaZ2PIpEId-rl6jv@wantstofly.org>
 <ZaaQpiW3OOZTSyXw@x1-carbon>
 <ZahDNr97MSPNSHW_@wantstofly.org>
 <ZahaKaV1jlHQ0sUx@x1-carbon>
 <ZbAo_LqpbiGMfTtW@wantstofly.org>
 <ZbDjL0TDnUfzknZS@x1-carbon>
 <ZbEFU-rycTXxOtfW@wantstofly.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbEFU-rycTXxOtfW@wantstofly.org>

On Wed, Jan 24, 2024 at 02:40:51PM +0200, Lennert Buytenhek wrote:

> > > There are two ways to handle this -- either set the DMA mask for ASM106x
> > > parts to 43 bits, or take the lazy route and just use AHCI_HFLAG_32BIT_ONLY
> > > for these parts.  I feel that the former would be more appropriate, as
> > > there seem to be plenty of bits beyond bit 31 that do work, but I will
> > > defer to your judgement on this matter.  What do you think the right way
> > > to handle this apparent hardware quirk is?
> > 
> > I've seen something similar for NVMe, where some NVMe controllers from
> > Amazon was violating the spec, and only supported 48-bit DMA addresses,
> > even though NVMe spec requires you to support 64-bit DMA addresses, see:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4bdf260362b3be529d170b04662638fd6dc52241
> > 
> > It is possible that ASMedia ASM1061 has a similar problem (but for AHCI)
> > and only supports 43-bit DMA addresses, even though it sets AHCI CAP.S64A,
> > which says "Indicates whether the HBA can access 64-bit data structures.".
> > 
> > I think the best thing is to do a similar quirk, where we set the dma_mask
> > accordingly.
> 
> I'll give that a try.

I've sent out a patch that appears (from printk debugging) to do the
right thing, but I haven't validated that that patch fixes the original
issue, as the original issue is not trivial to trigger, and the hardware
that it triggered on is currently unavailable.

I've also made the quirk apply to all ASMedia ASM106x parts, because I
expect them to be affected by the same issue, but let's see what the
ASMedia folks have to say about that.

Thanks for your help!


Kind regards,
Lennert

