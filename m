Return-Path: <linux-kernel+bounces-19172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF174826915
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FF70B2124B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE39946C;
	Mon,  8 Jan 2024 08:05:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E6A8F47;
	Mon,  8 Jan 2024 08:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=27517e8fb8=fe@dev.tdt.de>)
	id 1rMkLl-000MIh-Ss; Mon, 08 Jan 2024 08:47:09 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1rMkLk-000MHO-E1; Mon, 08 Jan 2024 08:47:08 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 14224240049;
	Mon,  8 Jan 2024 08:47:08 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id A7D1C240040;
	Mon,  8 Jan 2024 08:47:07 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 54D7534839;
	Mon,  8 Jan 2024 08:47:07 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 08 Jan 2024 08:47:07 +0100
From: Florian Eckert <fe@dev.tdt.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Lee Jones <lee@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the leds-lj tree
In-Reply-To: <20240105173352.6ce1a546@canb.auug.org.au>
References: <20240105173352.6ce1a546@canb.auug.org.au>
Message-ID: <17b4305d9fe1fbed3e39597f0767f7bd@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-type: clean
X-purgate-ID: 151534::1704700028-9767C464-91F02735/0/0
X-purgate: clean

Hello Stephen,

thanks for your hint

On 2024-01-05 07:33, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the leds-lj tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> Warning: /sys/class/leds/<led>/rx is defined 2 times:
> Documentation/ABI/testing/sysfs-class-led-trigger-tty:7
> Documentation/ABI/testing/sysfs-class-led-trigger-netdev:49
> Warning: /sys/class/leds/<led>/tx is defined 2 times:
> Documentation/ABI/testing/sysfs-class-led-trigger-tty:15
> Documentation/ABI/testing/sysfs-class-led-trigger-netdev:34

The behavior of the tty trigger can be controlled via the Rx and Tx 
file.
If a value is set in Rx or Tx, the LED flashes when data is transmitted 
in
this direction. The same behavior is used for the netdev trigger.
I have therefore used the same pattern for the new tty trigger as well.

I didn't know that the names have to be unique!

I'm a bit at a loss as to what to do now. Should I put a prefix "tty_"
in front of the names so that we have "tty_rx", "tty_tx"?

If we do it this way, however, the general question arises as to whether
we do have to use a prefix everywhere! If new triggers are added, then 
the
names for a config file are already used up and anyone who then wants to 
use
the same name for an other trigger with the same config file because it 
describe
the same function must then work with a prefix!

Best regards

Florian

