Return-Path: <linux-kernel+bounces-28633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F20830117
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE038287B36
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9587D11707;
	Wed, 17 Jan 2024 08:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="YIR6mCeG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ACBCQ8n3"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D110D517;
	Wed, 17 Jan 2024 08:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705479304; cv=none; b=Ec8eGJKfHqUcDcqTFkr+lL37RP0AcalOhExceOuYKYF+9RlWyoBvHuy970WxNq1ixIei2wn6O/4JSlNkKLICRvmuAJwwBMfe6smj5a+6s+yU7POP5FUf6LJn4In7clC1fQNyTyXoOhNzvF2sZjTImw1k2Wx6VDM84ddmLn45dGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705479304; c=relaxed/simple;
	bh=t4mHHLSq55lGanfkEFrXkLee3Yubj41DA3jrIyijz8Q=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To; b=tK2wzrGz2ENtsQPZRtxnRwE+M8av+ZYQX67RoY3VOmDNaSd0v+SZJsNlp28vQmMf+QwSOmnSsFy7iqboU3icyxOFbtLTkG8HD98Yt2X45OsNPz9SHd0oJrw/wo/5SOEkjkGRk/FalWh4LODdjX2WQB6ouLUj9dizh9fq/qaODS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=YIR6mCeG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ACBCQ8n3; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 8E11C3200AFC;
	Wed, 17 Jan 2024 03:15:00 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 17 Jan 2024 03:15:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1705479300;
	 x=1705565700; bh=DtQJWuA9g7T/MEuHRd++pePtePMGPRL7QcNqZkPs70M=; b=
	YIR6mCeGcpMgn59e6PaNExkhZFV0KHyegf/6VrYkEbj1Df4yTLj++XEWUGtLddr4
	F6ke5owMmEs/jVsMC4zxTBujtKu69vU2nl4whPSI0bl5+HdopqSwRvdWQ3/cBSeg
	9db2I8HdbI5h9+XXihdKXe9/a+i/CiLIZjd9x+KMWRSDRgPuipMO/BXliPtEj/vt
	e4P03N8egay0BV9odWfboGXnlNuwIYsYj4msTWtX4jh5g7g3lmxoNTXdG+K0VLpF
	PPfrARc7ixJHbK8D+FdjOkSH6mnkBYrKgE2sKlGRZ8cFiPXT3akfqCXxByHmnw7B
	DBL2n0h7AmP7C/HkVA8wJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705479300; x=
	1705565700; bh=DtQJWuA9g7T/MEuHRd++pePtePMGPRL7QcNqZkPs70M=; b=A
	CBCQ8n3JaSWnE/DXMcs31oq14PXnKQJh7VWreJlKSGaokb0rwfEkcFlbg7qpRJSJ
	KhB/HeEOfJxysxl6YEkAHG1qEhXMInLZrk4Ahk2C8Z/HkFYPHH0oM3PA+E5SFYaP
	1X2yXJJE6UGP74fkYKcRCsKaF0ZD0RDQFGu/sA3nE3NlQCr5xOq2CS36WTv2fa2U
	pKS5MRN8L0vdmH+3ulqHW0TxdcOAyTOCF+OHsdkKUnonUbPwq/0DxOKyuQp8AAmB
	5aCJSjKt/slxcHhCltaGCxPbJDvBiJRXnmUooArqa5TG/PXytk2EE7ZEjE4O8f70
	gM8sN6inoFqmgZQ/UCl+w==
X-ME-Sender: <xms:g4ynZQsRbyCS2QsubL-srYcRlchAusMF-5LUDRt2Go8_lXnER_TgcA>
    <xme:g4ynZdc_tCDWey-m9tUoUuIujgcGVqmToGd3JSJcsP40ljhAd3vrOHVZw8GoSs9HE
    sZ8ST4Do8NJkg>
X-ME-Received: <xmr:g4ynZbywriHKkvCsmusunxcQRcdUNtUigEIfI3onMQ4ODaMpWsCU8pfrYLuDW15WUv4PzLqOK_3QWMWIGPJQctLvKYcv1qNDBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejgedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepifhr
    vghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgf
    ekffeifeeiveekleetjedvtedvtdeludfgvdfhteejjeeiudeltdefffefvdeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrh
    horghhrdgtohhm
X-ME-Proxy: <xmx:g4ynZTOUXYSPt8vUptm3BQk8QKZ9LtAKLG8JfdsTLQj4JncB0lpJLA>
    <xmx:g4ynZQ-wRYS9ft0xuPLJoy9YEGB6aRdNoUHD4otRXI1AhoXPVTiMCg>
    <xmx:g4ynZbUMlL6wWCNrBjjo1rQcBUs7Bls3W9F6O03rLhPtkW3txzZ3bA>
    <xmx:hIynZR1kRBhTMh8YB-qkv8umlftdJk9muYwsjr_o5rSxPPebsOM-zw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jan 2024 03:14:59 -0500 (EST)
Date: Wed, 17 Jan 2024 09:14:57 +0100
From: Greg KH <greg@kroah.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Hugo Villeneuve <hugo@hugovil.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the bitmap tree with the tty tree
Message-ID: <2024011734-subside-attach-53ea@gregkh>
References: <20240108143627.29ac91fe@canb.auug.org.au>
 <2024010830-swimsuit-ferment-8b88@gregkh>
 <20240108115155.f2d2f1e5789d74b90d1b7426@hugovil.com>
 <CAAH8bW-eLNebwabvvJeos4XbB77p4vGsutkwGtKMxR5-HpzTDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAH8bW-eLNebwabvvJeos4XbB77p4vGsutkwGtKMxR5-HpzTDA@mail.gmail.com>

On Thu, Jan 11, 2024 at 06:39:49AM -0800, Yury Norov wrote:
> On Mon, Jan 8, 2024 at 8:52 AM Hugo Villeneuve <hugo@hugovil.com> wrote:
> >
> > On Mon, 8 Jan 2024 08:53:40 +0100
> > Greg KH <greg@kroah.com> wrote:
> >
> > > On Mon, Jan 08, 2024 at 02:36:27PM +1100, Stephen Rothwell wrote:
> > > > Hi all,
> > > >
> > > > Today's linux-next merge of the bitmap tree got a conflict in:
> > > >
> > > >   drivers/tty/serial/sc16is7xx.c
> > > >
> > > > between commits:
> > > >
> > > >   8a1060ce9749 ("serial: sc16is7xx: fix invalid sc16is7xx_lines bitfield in case of probe error")
> > > >   3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port")
> > > >
> > > > from the tty tree and commit:
> > > >
> > > >   e63a961be48f ("serial: sc12is7xx: optimize sc16is7xx_alloc_line()")
> > > >
> > > > from the bitmap tree.
> > > >
> > > > I fixed it up (the former removed the function updated by the latter) and
> > > > can carry the fix as necessary. This is now fixed as far as linux-next
> > > > is concerned, but any non trivial conflicts should be mentioned to your
> > > > upstream maintainer when your tree is submitted for merging.  You may
> > > > also want to consider cooperating with the maintainer of the conflicting
> > > > tree to minimise any particularly complex conflicts.
> > >
> > > Fix looks coks correct, thanks.
> >
> > Yes, I confirm patch:
> >     e63a961be48f ("serial: sc12is7xx: optimize sc16is7xx_alloc_line()")
> >
> > is now obsoleted by patch:
> >     8a1060ce9749 ("serial: sc16is7xx: fix invalid sc16is7xx_lines
> > bitfield in case of probe error")
> 
> Hi guys,
> 
> I've already sent a pull request that includes the e63a961be48f. If I'll have to
> re-send it, I'll exclude the obsolete patch. Otherwise, can you adjust the
> 8a1060ce9749?

We can not "adjust" anything, as I can't rebase a public tree, sorry.

greg k-h

