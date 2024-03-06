Return-Path: <linux-kernel+bounces-93666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F7287330B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0EE2859C9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B445F560;
	Wed,  6 Mar 2024 09:49:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D0C5F482
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 09:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718558; cv=none; b=GZWcKQaBe4XbJhBBEckq5VIWCQs6Eoo4cYYPTEVq4E5q4c9DEOCnrL0P3U6CnrUCjVlYGfHA+Hd8rLg+Hi/WbnTO0g0aP8UI9kN1mZz6XFoOyCcnB8pifurVQNiiTB8CRCnDp3/7ya5i9xzV/WbnzSkHT8DPXdRssDle9C+Z8y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718558; c=relaxed/simple;
	bh=pDhUaw0Qyk9kv1ernxyMikPoGbQHgva5XGcSyyJILQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1APQ4USJfhJ5269UG/0/hJFz8az3d9RrInZSy9dYAJXcvXiiNgaFcSTe1+x5S1MQInJP4ypuv4XCumH8eGnzXmRoONMZfzp8BT3AuI1JDaV0fhSCEGiZPQ2sCohGjitwJ9DerUymRPyNm9Szisw2k53+Xe7M2iVv6Ame3vArT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 101F21FB;
	Wed,  6 Mar 2024 01:49:53 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A8093F738;
	Wed,  6 Mar 2024 01:49:14 -0800 (PST)
Date: Wed, 6 Mar 2024 09:49:11 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Flash Liu =?utf-8?B?KOWKieeCs+WCsyk=?= <Flash.Liu@mediatek.com>
Cc: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	wsd_upstream <wsd_upstream@mediatek.com>,
	Cylen Yao =?utf-8?B?KOWnmueri+S4iSk=?= <cylen.yao@mediatek.com>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2] firmware: arm_scmi: Avoid to call mbox_client_txdone
 on txdone_irq mode
Message-ID: <Zeg8F6VVaZtpmH8n@pluto>
References: <20240201095754.25374-1-flash.liu@mediatek.com>
 <ZbzKckIhn8HQv5pW@pluto>
 <053cb4a2edfe576412942daed2f7055b2ba9e207.camel@mediatek.com>
 <56e1b2f5adbca437a14b738e1c58a054f6302fcd.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56e1b2f5adbca437a14b738e1c58a054f6302fcd.camel@mediatek.com>

On Wed, Mar 06, 2024 at 06:13:48AM +0000, Flash Liu (劉炳傳) wrote:
> Hi Cristian,
> 
> Kindly ping :)
> 

Hi Pin-Chuan,

sorry for the delay...I have NOT forgot :D, indeed I was just testing
yesterday with some mailbox IP of ours equipped with a TxAck IRQ and I
would have some question for you because I've seen some anomalies while
using this: does your solution work reliably in your setup ALSO when
multiple SCMI transactions are attempted ? (like cpufreq issuing cmds
while polling a sensor from some other thread)

..I'll dig deeper today in this matter, but my current suspect is that
using the mailbox TXAck IRQ to let the controller tick the internal mailbox
queues does not play well with SCMI, since the SCMI TX channel is really the
SCMI "a2p" bidirectional channel and it is associated with just only one shmem
area used to hold both the egressing CMD and to receive the incoming REPLY
from the platform: so if you let the controller tick the queues as soon as you
received the TXAck you are telling the mailbox subsystem to queue another message
on the same area while you are not really done, since only the client know
when it's done with the whole SCMI transaction and the reply has been fetched.

Indeed, for these reasons we have the BUSY/FREE bit in the shmem to protect it
from pending new requests until the previous one has completed, but when the
waited-for reply comes in, the platform would have cleared the BUSY bit and
let the new queued message overwrite the pending reply prematurely, and one
message is lost...

..but as said I want to delve deeper into this, as of now just suppositions
and maybe I am just missing something more that has to be configured
properly...

Thanks,
Cristian

> Thanks.
> Pin-Chuan
> 
> On Fri, 2024-02-02 at 20:36 +0800, Pin-Chuan Liu wrote:
> > Hi Cristian,
> >
> > Thanks for kindly review and explains. Yeah, I have ever tried
> > another
> > way to skip the call (i.e. let mark_txdone be null). However, it
> > looks
> > not easy and also to backport.
> >
> > Awaiting your test results and further suggestions, thanks.
> >
> > Regards,
> > Pin-Chuan
> >
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

