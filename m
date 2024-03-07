Return-Path: <linux-kernel+bounces-95855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E36875424
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7F0528521E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AECF12F5AE;
	Thu,  7 Mar 2024 16:22:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA9512F380
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709828564; cv=none; b=iEgR54etXwOhXtzwttIxrZ/nOQVr6fhjN8LOa/sp3tYUV97vdiJtgLP0Xmore+s18nd5azW0ERQiye66hgj6D3SZKUWIjLW2xihO+d27GXUOsI7zaRqYkJQV5NLGaZXqIhJVtOf4C3Fi5JSbr4Xnc+llMEaoEkma5i9ZDBxyZnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709828564; c=relaxed/simple;
	bh=4oPjcnjn26IOGeNhsxOu5LTPTbW8Z/s+3Bx9zIyPZxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdKR+pAUQ+gTPMNpZJJyyykZ3cq/IMNNftQH0zhqisqqYUzIrk+iIUEoqbJLcpkRC9AmNqeMx0m6SUhPbvtSHQ8D0XlBMeFVh0isV+B5gonYi4PnlIyblXpiQDX4IIWup1DsFUMs9qakjq39BQsf5589AgY2058JFfJtx3Wy2jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C97C1C15;
	Thu,  7 Mar 2024 08:23:14 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A223A3F73F;
	Thu,  7 Mar 2024 08:22:36 -0800 (PST)
Date: Thu, 7 Mar 2024 16:22:34 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Flash Liu =?utf-8?B?KOWKieeCs+WCsyk=?= <Flash.Liu@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	wsd_upstream <wsd_upstream@mediatek.com>,
	Cylen Yao =?utf-8?B?KOWnmueri+S4iSk=?= <cylen.yao@mediatek.com>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2] firmware: arm_scmi: Avoid to call mbox_client_txdone
 on txdone_irq mode
Message-ID: <ZenpykCOYjsH_sdd@pluto>
References: <20240201095754.25374-1-flash.liu@mediatek.com>
 <ZbzKckIhn8HQv5pW@pluto>
 <053cb4a2edfe576412942daed2f7055b2ba9e207.camel@mediatek.com>
 <56e1b2f5adbca437a14b738e1c58a054f6302fcd.camel@mediatek.com>
 <Zeg8F6VVaZtpmH8n@pluto>
 <ZeiU5_k7s-31A93h@pluto>
 <c6a24e4c9b97b8a47a822fb4fcbc4b955ac5fbc5.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6a24e4c9b97b8a47a822fb4fcbc4b955ac5fbc5.camel@mediatek.com>

On Thu, Mar 07, 2024 at 12:31:02PM +0000, Flash Liu (劉炳傳) wrote:
> Hi Cristian,
> 
> Thanks for reply. :)
> 
> The uploaded patch is just to avoid getting error logs, since
> mbox_client_txdone() will check the mode.

.. yes right, the controller will detect the mode indeed based on how
it is configured on the DT and issue the tx_tick() when the TxAck is
received....your patch avoids the error when the SCMI stack tries to
issue a mbox_client_txdone() and it is not expected to do so...

..what I am saying is that the TxAck txdone_irq mode is not compatible
with how SCMI is designed to work in terms of transmission on the a2p
channel...even if you make it work properly without any errors with your
patch...

..so you will avoid the errors and make it work BUT it does not work
realiably in case of multiple concurrent TX attempts...in my setup I see
anomalies and loss of packets if I enable TxAck mode...

> About your mentioned scenario of TxACK irq mode, not sure, but do you
> mean that mbox driver may not "copy out" the REPLY mesg-X at shmem,

the copy out of the REPLY is done by the SCNI layer, but anyway once the
TxAck has been received there is nothing ready to be copied-out...the
TxAck just means the requested message has been transmitted and it has
been successfully received by the receiver (at least in my MBOX IP .. :P)

> before it calls to mbox_chan_txdone()?
> Could it become safe if we copy the REPLY mesg to a buffer and then
> issue the tx_tick?

In my understanding, the packet flow is as follows

1. Linux sends a new cmd with mbox_send_message()
   mbox subsys
    - queueus msg
    - submit:
      - tx_prepare
        - wait for FREE_bit on channel
	- copies msg in shmem area
      - ring doorbell

2. FW see the doorbell IRQ, a message has arrived
   - FW reads the incoming cmd message from shmem
   - FW rings the TxAck doorbell

3. Linux see the TxAck: at this point it knows that the message just
   sent has been received by FW...nothing more, NO reply is available
   to be read back at this point...Linux wait_for_completion

4. FW prepares the reply
   - FW writes reply to the shmem
   - FW sets the FREE bit in the shmem, channel ownership goes back to
     agent
   - FW rings the Doorbell

5. Linux see the RX doorbell IRQ and wakes up
   - reply is copied out and delivered to caller
   - mbox_client_txdone is called from mark_tx_done

..when TxAck ack is received at 3, there is nothing we can do Linux
side because there is ONE only shmem area per-chandle both for cmd and
related replies....so we cannot really do anything useful by knowing
that the command we just sent was read successfully from the FW
server..

..moreover if the MBOX controller is in TxAck mode since it was
configured like that by the DT, it will kick itself the tx_tick when the
TxAck is received...

.. that means that if you had another previous mbox_send_message() issued,
 that message would have been queued by mbox_subsys but not sent since
 a TX was already inflight, BUT now after the TxAck the tx_tick/msg_submit is
 called and the next message transmission is attempeted AND such request
 will now spin waiting for the FREE bit in cl->tx_prepare: this happens
 because we are at 3. and FW has still to send any reply...

 ..so you have one message sent and waited-for AND a new cmd queued for TX
 and spinning on FREE_bit waiting for the channel...so far so good

..but now in this situation imagine what will happen when finally FW
 replies in 4: as soon as the FREE_bit is flipped the above new transmission
 spinning inside tx_prepare will acquire the channel and write its payload in
 it, so OVERWRITING the previous reply that the FW has just written in shmem...

 In a nutshell, since we only have one shmem for cmd and reply in the
 a2p channel, we have to wait for the full SCMI transaction to be
 completed, and the reply to be retrieved, before writing the next command
 into shmem, BUT this is a knowledge that only the SCMI stack has...the mbox
 controller just know that a TxAck has been received, it cannot know
 that it is NOT allowed anyway to send the next...

 ..so basically in mailbox transport instead of using a lock to protect the
 channel (like in other transports) till the reply has been read, we let
 the SCMI agent client to issue the tx_tick only after the transmission has
 completed...this way no lock is needed because the mbox_subsys wont
 tx_tick and submit the next transmission till we are done...since the SCMI
 agent is the only one that can possibly know when it is safe to proceeed with
 another transmission

 when the TxAck is received there is nothing that we can copy-out...the
 reply is not available and there is nothing we can do...and in case of
 multiple concurrent transmissions you will have lost packets (as I see
 in my setup)...

I would say that the check in your patch for txdone_irq could somehow
become a check instead inside the mailbox_chan_setup() to detect such an
unsupported controller configuration and bail out.

The alternative would be to put a lock on the channel so that we can
neutralized the effect of the TxAck ... but what;s the point of having it
at this point :P

> In addition, considering the following scenario:
> 
> mesg-X (thread-X: low priority)
> mesg-Y (thread-Y: high priority)
> mesg-Z (thread-Z: high priority)
> 
> 1. scmi: thread-X calls mbox_send_message(X) to send mesg-X, and goes
> to wait_completion()
> 
> 2. mbox: mesg-X is sent
> 
> 3. scmi: ANOTHER mesg-Y tx is attempted via mbox_send_message(Y),
> thread-Y goest to wait_completion()

..this does not even reach wat_for_completion, it will spin on the
FREE_bit in tx_prepare trying to acquire the channel...so it wont even
return from mailbox_send_message()

> 3'. scmi: ANOTHER mesg-Z tx is attempted via mbox_send_message(Z),
> thread-Z goest to wait_completion()
> 

same .. queud on tx_prepare

> 4. mbox: mesg-Y is queued
> 4'. mbox: mesg-Z is queued
> 
> 5. mbox irq received, ISR notify complete to thread-X, however system
> is busy on other high priority threads,
> so, thread-X doesn't back soon
> 

..mmm... one thing to consider indeed is what happens if I have 2 pending
high-prio threads spinning on tx_prepare while the mesg-X IRQ arrives...would we
be able to serve mesg-X IRQ if the cores are busy-waiting on mesg-Y / mesg-Z ?

> 6. mesg-Y, mesg-Z get timed-out.
> 
> Could the timeout situtaion of mesg-Y and Z be reduced, if tx_tick in
> ISR?
> 
> ... explains something might for TxACK irq mode... maybe you have other
> observation or suggestions about this priority scenario.
> 

I want to think about the threads prio you raised....

Thanks,
Cristian

> Thanks again,
> Pin-Chuan
> 
> On Wed, 2024-03-06 at 16:08 +0000, Cristian Marussi wrote:
> > On Wed, Mar 06, 2024 at 09:49:16AM +0000, Cristian Marussi wrote:
> > > On Wed, Mar 06, 2024 at 06:13:48AM +0000, Flash Liu (劉炳傳) wrote:
> > > > Hi Cristian,
> > > >
> > > > Kindly ping :)
> > > >
> > >
> > > Hi Pin-Chuan,
> > >
> > > sorry for the delay...I have NOT forgot :D, indeed I was just
> > > testing
> > > yesterday with some mailbox IP of ours equipped with a TxAck IRQ
> > > and I
> > > would have some question for you because I've seen some anomalies
> > > while
> > > using this: does your solution work reliably in your setup ALSO
> > > when
> > > multiple SCMI transactions are attempted ? (like cpufreq issuing
> > > cmds
> > > while polling a sensor from some other thread)
> > >
> > > ...I'll dig deeper today in this matter, but my current suspect is
> > > that
> > > using the mailbox TXAck IRQ to let the controller tick the internal
> > > mailbox
> > > queues does not play well with SCMI, since the SCMI TX channel is
> > > really the
> > > SCMI "a2p" bidirectional channel and it is associated with just
> > > only one shmem
> > > area used to hold both the egressing CMD and to receive the
> > > incoming REPLY
> > > from the platform: so if you let the controller tick the queues as
> > > soon as you
> > > received the TXAck you are telling the mailbox subsystem to queue
> > > another message
> > > on the same area while you are not really done, since only the
> > > client know
> > > when it's done with the whole SCMI transaction and the reply has
> > > been fetched.
> > >
> > > Indeed, for these reasons we have the BUSY/FREE bit in the shmem to
> > > protect it
> > > from pending new requests until the previous one has completed, but
> > > when the
> > > waited-for reply comes in, the platform would have cleared the BUSY
> > > bit and
> > > let the new queued message overwrite the pending reply prematurely,
> > > and one
> > > message is lost...
> > >
> > > ...but as said I want to delve deeper into this, as of now just
> > > suppositions
> > > and maybe I am just missing something more that has to be
> > > configured
> > > properly...
> > >
> > > Thanks,
> > > Cristian
> > >
> >
> > Hi again :D,
> >
> > so articulating more on my supposition that TxAck-capable mailboxes
> > and
> > SCMI do not play well together (and would not be worth either
> > really...)
> >
> > Consider the following scenario.
> >
> > 1. scmi: mbox_send_message(X) is called from SCMI stack to send mesg-
> > X
> >          on the a2p channel (a command)
> >
> > 2. mbox: mesg-X is
> >   2a. queued by mbox subsystem [add_to_rbuf(X)]
> >   2b. submitted for transmission [msg_submit(X)]
> >   2c. prepared by SCMI clk->tx_prepare
> >   2d. finally sent via mhu driver .send_data
> >   2e. mesg-X is now an active_req for mbox and in-flight for SCMI
> >
> > 3. scmi: ANOTHER mesg-Y tx is attempted via mbox_send_message(Y)
> >
> > 4. mbox: mesg-Y is
> >   4a. queued by mbox_subsys [add_to_rbuf()]
> >   4b. NOT submitted since there is already an active_req=mesg-X
> > pending
> >
> > Any further SCMI mesg TX attempt will behave similarly:
> > queued/not_submitted
> > till at some in the future someone calls the txdone routines, which
> > in turn
> > calls tx_tick()...this SOMEONE can be the client, like it is now, or
> > the
> > controller if it is configured to use the TxAck IRQ (as per-your-
> > patch)...
> > ...so lets see what happen in your TxAck enabled case.
> >
> > 5. TxAck IRQ received, transmission of mesg-X has been successfull
> >   (NOTE that SCMI at this point is still waiting for a reply to mesg-
> > X..)
> >
> >   5a. controller calls mbox_chan_txdone()
> >   5b. mbox in turn calls tx_tick
> >   5c. active_req is cleared and next queued mesg-Y is submitted
> >   5d. mesg-Y transmission gets anyway stuck on cl->tx_prepare since
> >       we check the SCMI shmem BUSY bit and busy-loop there till it
> >       clears: this clearing can happen ONLY after the mesg-X reply
> >       has come through, since it is the platform SCMI server that
> >       clears it having delivered the reply in the shmem.
> >
> > 6. platform SCMI server replies to mesg-X finally:
> >   6a. platform writes reply in shmem
> >   6b. platform clears BUSY bit
> >
> >   -- note SCMI stack is still waiting for a reply at this point...
> >      so waiting for an IRQ OR by simply spinning on that same BUSY
> > bit
> >      if polling mode was requested for the transaction....
> >
> >      ...lets assume you are in IRQ mode:
> >
> > 7. mesg-Y sender which was spinning on BUSY bit (blocked on
> > tx_prepare)
> >    is immediately cleared to send and so tx_prepare can proceed
> > further
> >    and completely overwrite the just received mesg-X, which is now
> > LOST
> >
> > ..in case you were polling I guess you will have anyway some
> > corruption
> > due to the race between the polling-mesg-X-receiver retrieving the
> > reply
> > and the same tx_prepare codeflow as above...
> >
> > Indeed, the spec says that you should protect the channel till the
> > reply
> > has been retrieved from the SCMI (even after the BUSY bit is
> > cleared), and
> > in other transport we DO have some form of locks, BUT here in
> > mailboxes
> > there is not since it is NOT needed IF you stick to the non-TxAck
> > original
> > behaviour, since the tx_tick, as it is now, will be run by the SCMI
> > stack
> > ONLY after it has waited for mesg-X and retrieved the mesg-X-reply
> > payload
> > ...not before.
> >
> > Instead, if you enable the TxAck mode you are basically letting the
> > controller
> > itself issue the tx_tick(), which means "previous TX is done, please
> > proceed
> > with the next", BUT the current TX is really NOT done at all as
> > intended
> > by the client (SCMI), since the reply is missing and the only entity
> > which
> > can have the whole picture about when a transaction is completed (or
> > timed-out)
> > is the SCMI client.
> >
> > As said, I think the fundamental clash is between what the mailbox
> > subsystem considers a TXDONE event (and related actions) and what
> > instead is considered a completed transaction on the SCMI a2p
> > channel:
> > i.e. CMD_sent + REPLY_retrieved.
> >
> > At the end, anyway, would it be worth in any way to leverage such
> > TxAck
> > capabilities (somehow) of a mailbox in the SCMI world ?
> >
> > I mean, even if we make this work, what is supposed to happen better
> > and faster
> > when using a TxAck instead of a TX_polling mode like it is now ?
> >
> > ...because the SCMI stack cannot really do anything with this
> > information in
> > this case, given that there is just one single a2p_shem area for
> > sending command
> > and receiving replies...it has just to wait anyway even after the
> > TxAck...
> >
> > ..maybe it is a bit more power-favourable to sleep_wait for the TxAck
> > IRQ
> > instead of polling the MHU regs ?... other than this the TxAck means
> > nothing
> > really in the context of the SCMI world, since you cannot safely
> > queue anything
> > more till the previous exchange has fully completed...
> >
> > ...in other non-SCMI scenarios that I experimented with, it really
> > makes a
> > difference havig the TxAck since it avoids all the internal
> > polling/requeueing
> > dance in the mailbox subsystem, but in this case I think is all made
> > useless by
> > the way SCMI/SMT based transport works...i.e. using a single shmem
> > area for
> > the a2p channel..
> >
> > ...not really a short and sweet email... :P ... any feedback or
> > further
> > ideas are welcome anyway...especially if you can prove that all of
> > the
> > above is somehow wrong, or that there is a good reason to leverage
> > the
> > TxAck capable mailboxes  :D
> >
> > Thanks,
> > Cristian
> 
> 
> ************* MEDIATEK Confidentiality Notice ********************
> The information contained in this e-mail message (including any
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be
> conveyed only to the designated recipient(s). Any use, dissemination,
> distribution, printing, retaining or copying of this e-mail (including its
> attachments) by unintended recipient(s) is strictly prohibited and may
> be unlawful. If you are not an intended recipient of this e-mail, or believe
> that you have received this e-mail in error, please notify the sender
> immediately (by replying to this e-mail), delete any and all copies of
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!

