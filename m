Return-Path: <linux-kernel+bounces-19903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0BE827675
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114CD1C2281E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BFA55C27;
	Mon,  8 Jan 2024 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="AEyM6MNg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDCE55C1E;
	Mon,  8 Jan 2024 17:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=/86wAp1vDbK5HGmaArqGdII71sc3/1E+elZpU3gRjz0=; b=AEyM6MNgZRaEy3QvwWKPiCrbW+
	6RaTXoaaQcaUbw0qEqF/TMKnQFaqT3R3gLWXYP6nrtew6pppzbEj99buU4KSaV68Q5Y6xSYwQlX2M
	vkIG6h8nQ9Apq55KNeyZmr8y1S89UcFBZYNaJTTbvl1NquypDqyfue8cHez2MZQYX5qI=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:34896 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rMsqz-0002Gk-5b; Mon, 08 Jan 2024 11:51:57 -0500
Date: Mon, 8 Jan 2024 11:51:55 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Greg KH <greg@kroah.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Yury Norov
 <yury.norov@gmail.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Message-Id: <20240108115155.f2d2f1e5789d74b90d1b7426@hugovil.com>
In-Reply-To: <2024010830-swimsuit-ferment-8b88@gregkh>
References: <20240108143627.29ac91fe@canb.auug.org.au>
	<2024010830-swimsuit-ferment-8b88@gregkh>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	* -1.4 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: linux-next: manual merge of the bitmap tree with the tty tree
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Mon, 8 Jan 2024 08:53:40 +0100
Greg KH <greg@kroah.com> wrote:

> On Mon, Jan 08, 2024 at 02:36:27PM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the bitmap tree got a conflict in:
> > 
> >   drivers/tty/serial/sc16is7xx.c
> > 
> > between commits:
> > 
> >   8a1060ce9749 ("serial: sc16is7xx: fix invalid sc16is7xx_lines bitfield in case of probe error")
> >   3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port")
> > 
> > from the tty tree and commit:
> > 
> >   e63a961be48f ("serial: sc12is7xx: optimize sc16is7xx_alloc_line()")
> > 
> > from the bitmap tree.
> > 
> > I fixed it up (the former removed the function updated by the latter) and
> > can carry the fix as necessary. This is now fixed as far as linux-next
> > is concerned, but any non trivial conflicts should be mentioned to your
> > upstream maintainer when your tree is submitted for merging.  You may
> > also want to consider cooperating with the maintainer of the conflicting
> > tree to minimise any particularly complex conflicts.
> 
> Fix looks coks correct, thanks.

Yes, I confirm patch:
    e63a961be48f ("serial: sc12is7xx: optimize sc16is7xx_alloc_line()")

is now obsoleted by patch:
    8a1060ce9749 ("serial: sc16is7xx: fix invalid sc16is7xx_lines
bitfield in case of probe error")

Thank you,
Hugo Villeneuve

