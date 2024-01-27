Return-Path: <linux-kernel+bounces-41169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5C183ECD3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 12:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696D11C21B70
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 11:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC14200CC;
	Sat, 27 Jan 2024 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QCp/yRnB"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3FF200AE
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706354034; cv=none; b=E2FfjcjSZ96JjxNQgxX67DoKx0LBUdsHUgwxUNDbegqybAbyXpt8sptphzl2KZ/O98Gsnd8nGb+Fupx1yN6B3Oc8AnUlrisEfQZQjp3lN9UCIorJmGYV/8Tu38CM/X5gmyFo2MZkWsMy+5DswdSbN+qarPcvirPYA5IqROqxISY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706354034; c=relaxed/simple;
	bh=9kyiI9H7qRjBxoFZ0xNHu3XWQXm7Ns+lYZ/lWQuJGSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIYr4g+NAv3ihmM2QTXXwOJiy6Z9oYKHFo/aoWeT7jfBtTRxhuNUWyNU1tVGDxX5WuhN9GmWuOv16TRqQZEmxhwqmrTgVdL7mIF1/o+2vJjlzxx1DtQXW3PhSWr/Yaarc9CqqN+WgMT/X4WeMxyRG6/7E6Ys7AD03ItzYI5MYF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QCp/yRnB; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DE74F39D72;
	Sat, 27 Jan 2024 06:13:51 -0500 (EST)
	(envelope-from adamg@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=9kyiI9H7qRjBxoFZ0xNHu3XWQXm7Ns+lYZ/lWQu
	JGSE=; b=QCp/yRnBejPpctSrHLpXnjkiGKYGZPEY7s+KZmpLCkqMND+w/Fc3M68
	CkzAvgS1r7Ug0ekws6LiKK6yjkAs2m10rCGWdpkrPNShqd/pe+Pu/QMQL3DbmTqo
	GzNcGpeKyZqpqXcyEn1LOEnPGJu9QMCP+FKyrZy6OrTssVSiolr0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D724E39D71;
	Sat, 27 Jan 2024 06:13:51 -0500 (EST)
	(envelope-from adamg@pobox.com)
Received: from pogo.deviceside.com (unknown [71.19.144.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AFEF339D70;
	Sat, 27 Jan 2024 06:13:48 -0500 (EST)
	(envelope-from adamg@pobox.com)
Received: from iguana.24-8.net (99-122-168-208.lightspeed.irvnca.sbcglobal.net [99.122.168.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: iguana@pogo.deviceside.com)
	by pogo.deviceside.com (Postfix) with ESMTPSA id 22255C08DB;
	Sat, 27 Jan 2024 03:13:47 -0800 (PST)
Date: Sat, 27 Jan 2024 03:13:45 -0800
From: Adam Goldman <adamg@pobox.com>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: send bus reset promptly on gap count
 error
Message-ID: <ZbTlaCCbpxQoqo0i@iguana.24-8.net>
References: <Za90vAQlDhbLpY67@iguana.24-8.net>
 <20240127083730.GA159729@workstation.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127083730.GA159729@workstation.local>
X-Pobox-Relay-ID:
 24F1B694-BD05-11EE-A21C-F515D2CDFF5E-07713566!pb-smtp20.pobox.com

Hi,

On Sat, Jan 27, 2024 at 05:37:30PM +0900, Takashi Sakamoto wrote:
> On Tue, Jan 23, 2024 at 12:11:40AM -0800, Adam Goldman wrote:
> > If we are bus manager and the bus has inconsistent gap counts, send a 
> > bus reset immediately instead of trying to read the root node's config 
> > ROM first. Otherwise, we could spend a lot of time trying to read the 
> > config ROM but never succeeding.
> > 
> > This eliminates a 50+ second delay before the FireWire bus is usable 
> > after a newly connected device is powered on in certain circumstances.
> 
> At first, would I request you to explain about the certain
> circumstances in the patch comment? It is really helpful to understand
> the change itself.

The delay occurs if a gap count inconsistency occurs, we are not the 
root node, and we become bus manager. One scenario that causes this is 
with a TI XIO2213B OHCI, the first time a Sony DSR-25 is powered on 
after being connected to the FireWire cable.

> > Link: https://sourceforge.net/p/linux1394/mailman/message/58727806/

This link has a longer description and kernel logs.


> > --- linux-source-6.1.orig/drivers/firewire/core-card.c	2023-09-23 02:11:13.000000000 -0700
> > +++ linux-source-6.1/drivers/firewire/core-card.c	2024-01-22 04:23:06.000000000 -0800
> > @@ -435,6 +435,16 @@
> >  		 * config rom.  In either case, pick another root.
> >  		 */
> >  		new_root_id = local_id;
> > +	} else if (card->gap_count == 0) {
> > +		/* 
> > +		 * If self IDs have inconsistent gap counts, do a
> > +		 * bus reset ASAP. The config rom read might never
> > +		 * complete, so don't wait for it. However, still
> > +		 * send a PHY configuration packet prior to the bus
> > +		 * reset, as permitted by IEEE 1394-2008 8.4.5.2.
> > +		 */
> > +		new_root_id = local_id;
> > +		card->bm_retries = 0;
> >  	} else if (!root_device_is_running) {
> >  		/*
> > 		 * If we haven't probed this device yet, bail out now
> 
> Next, after the condition branches, we can see below lines:
> 
> ```
> 	/*
> 	 * Finally, figure out if we should do a reset or not.  If we have
> 	 * done less than 5 resets with the same physical topology and we
> 	 * have either a new root or a new gap count setting, let's do it.
> 	 */
> 
> 	if (card->bm_retries++ < 5 &&
> 	    (card->gap_count != gap_count || new_root_id != root_id))
> 		do_reset = true;
> ```
> 
> When the value of "card->gap_count" is zero, it would hit the condition of
> "card->gap_count != gap_count". I think the transmission of phy config
> packet and scheduling of short bus reset would be done, regardless of the
> change. Would I ask the main intention to the additional branch?

Without the additional branch, the !root_device_is_running branch will 
be taken (because the root node's config ROM hasn't been read yet), and 
bm_work will go to sleep. Eventually we will give up trying to read the 
config ROM, the root_device==NULL branch will be taken, and the bus 
reset will be done. The additional branch eliminates waiting for the 
config ROM read when gap_count is zero.

Here is the full sequence of events:

1. Bus reset occurs due to newly active device.

2. Self identification process completes. We are not root node. Gap 
counts are inconsistent.

3. build_tree() notices the gap count error and sets gap_count to 0:

> 		/*
> 		 * If PHYs report different gap counts, set an invalid count
> 		 * which will force a gap count reconfiguration and a reset.
> 		 */
> 		if (SELF_ID_GAP_COUNT(q) != gap_count)
> 			gap_count = 0;

4. bm_work() starts and makes us bus manager:

> 		rcode = fw_run_transaction(card, TCODE_LOCK_COMPARE_SWAP,
> 				irm_id, generation, SCODE_100,
> 				CSR_REGISTER_BASE + CSR_BUS_MANAGER_ID,
> 				transaction_data, 8);

5. read_config_rom() starts reading the root node's config ROM.

6. bm_work() wants to know if the root node is cycle master capable. If 
the root node is cycle master capable, we will leave it as the root 
node. Otherwise, we will make ourself the root node. To determine if the 
root node is cycle master capable, we must wait until its config ROM has 
been read:

> 	} else if (!root_device_is_running) {
> 		/*
> 		 * If we haven't probed this device yet, bail out now
> 		 * and let's try again once that's done.
> 		 */
> 		spin_unlock_irq(&card->lock);
> 		goto out;

7a. Without the patch: read_config_rom() reads the first few quadlets 
from the config ROM. Due to the gap count inconsistency, eventually one 
of the reads times out. When read_config_rom() fails, fw_device_init() 
calls it again until MAX_RETRIES is reached. This takes 50+ seconds.

8a. bm_work() sees that we have given up trying to read the config ROM. 
It makes us the root node and does a bus reset:

> 	if (root_device == NULL) {
> 		/*
> 		 * Either link_on is false, or we failed to read the
> 		 * config rom.  In either case, pick another root.
> 		 */
> 		new_root_id = local_id;
> ...
> 	if (card->bm_retries++ < 5 &&
> 	    (card->gap_count != gap_count || new_root_id != root_id))
> 		do_reset = true;

7b. With the patch: Because of the gap count inconsistency, bm_work() 
does not wait for the config ROM to be read. It makes us the root node 
and does a bus reset immediately:

> 	} else if (card->gap_count == 0) {
> 		/*
> 		 * If self IDs have inconsistent gap counts, do a
> 		 * bus reset ASAP. The config rom read might never
> 		 * complete, so don't wait for it. However, still
> 		 * send a PHY configuration packet prior to the
> 		 * bus reset, as permitted by 1394-2008 8.4.5.2.
> 		 */
> 		new_root_id = local_id;
> 		card->bm_retries = 0;
> ...
> 	if (card->bm_retries++ < 5 &&
> 	    (card->gap_count != gap_count || new_root_id != root_id))
> 		do_reset = true;

-- Adam

