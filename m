Return-Path: <linux-kernel+bounces-108700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6DF880ECF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A2D3286F81
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681633BB4B;
	Wed, 20 Mar 2024 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XhFJIV0d"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1652232C60
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710927492; cv=none; b=RrV7oBBvqJoia6MH+VftJ/qWQafrjpEe8Z4eTCoCUFfOU3X6oruLlC9sOCYKklihQ02KM6V5Js1NGLbLBb5KWggP6IP9zHH84hCg3NULBN2rZGVzV3VEwtefOmLPdk19Z90oC+oGxGuWUw4PlLOk56qqBwCumBwfi2uxndpYuUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710927492; c=relaxed/simple;
	bh=LmAk3bVZn8A3NmxiPyik3L9AOXz8NDcKFLPz/XcBXlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkzv9waM2g6V13aD4iqwl70IpvvlRPq3eOTjpZ744j9fWMc5TI6xrR2mm9caqK2kTivIhfwJTySsRV5mYGpvncjVlZLJSlxDhY4KJ4PaQVCrc8WuWxg07OPo0HgtAgoMQ0f7BIawmA1rBBTxNI7frjHbkaU4tmL5cLUJKVjgHCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XhFJIV0d; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B7B9B1DBE7E;
	Wed, 20 Mar 2024 05:38:09 -0400 (EDT)
	(envelope-from adamg@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=LmAk3bVZn8A3NmxiPyik3L9AOXz8NDcKFLPz/Xc
	BXlU=; b=XhFJIV0dcf6dX7mAVMPeukWVemTm3XtiNO8xwiIjfnU8ya3ALVw1mr3
	J3xR/ldynoq1DVJJWkaRSqlVMdl9vhkaNCzhffNVf8JTKIJHfVxQlBMbKpJhVRce
	QvhyCHh+LHJj+pgU3I8zFLgkhhyHS9ptUF8d7Q6HXjSjEN11poYo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AE49E1DBE7C;
	Wed, 20 Mar 2024 05:38:09 -0400 (EDT)
	(envelope-from adamg@pobox.com)
Received: from pogo.deviceside.com (unknown [71.19.144.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E20F41DBE7B;
	Wed, 20 Mar 2024 05:38:08 -0400 (EDT)
	(envelope-from adamg@pobox.com)
Received: from iguana.24-8.net (99-122-168-208.lightspeed.irvnca.sbcglobal.net [99.122.168.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: iguana@pogo.deviceside.com)
	by pogo.deviceside.com (Postfix) with ESMTPSA id B79DDC09A8;
	Wed, 20 Mar 2024 02:38:07 -0700 (PDT)
Date: Wed, 20 Mar 2024 02:38:05 -0700
From: Adam Goldman <adamg@pobox.com>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: use long bus reset on gap count error
Message-ID: <ZfqufddlPhxzcDCN@iguana.24-8.net>
References: <ZdxH-mjmd09jmYZN@iguana.24-8.net>
 <20240228004144.GA72391@workstation.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228004144.GA72391@workstation.local>
X-Pobox-Relay-ID:
 8FA78BC8-E69D-11EE-A798-25B3960A682E-07713566!pb-smtp2.pobox.com

Hi Takashi,

On Wed, Feb 28, 2024 at 09:41:44AM +0900, Takashi Sakamoto wrote:
> Additionally, for your investigation, you added the debug print to get the
> timing of bus reset scheduling. I think it useful for this kind of issue.
> Would I ask you to write another patch to add it? In my opinion, the case
> of mixed versions of 1394 PHYs in the same bus has more quirks and the
> debug print is helpful to investigate it further.

I'm sorry for my delay in preparing a patch.

I've submitted a patch to linux1394-devel to log when we schedule or 
initiate a bus reset. This is enabled with a new parameter to the 
firewire-core module. It provides logging similar to the debug print I 
used to investigate the reset loop.

Also, there is already logging for bus reset interrupts in 
firewire-ohci. This logs all bus resets and does not indicate whether we 
initiated the reset or some other node on the bus initiated it. However, 
the logging in firewire-ohci always froze my computer when I enabled it. 
I've submitted a separate patch to fix the firewire-ohci logging.

I believe both forms of logging can be useful. firewire-ohci logs all 
bus resets, but it doesn't tell where the resets came from. firewire-core 
only logs bus resets we initiate.

I also considered adding an option to firewire-ohci to log PHY register 
access. This would include writes to IBR and ISBR, so it would log when 
we initiate resets. However, this logging would be more complicated to 
add, so I didn't do it.

-- Adam

