Return-Path: <linux-kernel+bounces-53869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0839A84A771
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DDEB1C2703F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1661581ACE;
	Mon,  5 Feb 2024 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5jDQp7+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDB081AAA;
	Mon,  5 Feb 2024 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162503; cv=none; b=HnnMMNCOVKZE/enlEDMTI4iTSHaAhLU95AeLKu5xNeq5NkWvfNYICfcTTfD1n9Ad5Tik+yV2Wb35na+XCsLlLNFDpoZBHivBYPvtvV63IWvLoWqHHJ1fto6Istjevt6w2yxncY8bqEUX8KjJ+vcLvE8GrbHMVsBMzwwpg/YqQO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162503; c=relaxed/simple;
	bh=rd8tMvV8Wq5qfDFvWyiy9t3y/ONGDRXPFbv8vOaEvCA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WOPoCBp9XANZJ1uHsVev7RLyet/uyKgq8ixeHb9BDplmi3YFcILFibn4wQh0iheSqbhePPjX/AMNuetuo1FDkWHY4fNYj8y913Q1/e73MzubNZkFg2YSU7VTIxmgMgXAJhtsbd/OhOrYKEe5vYVsdS1u8VWU+GRgdgm2a2+P+NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5jDQp7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460FFC433F1;
	Mon,  5 Feb 2024 19:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707162502;
	bh=rd8tMvV8Wq5qfDFvWyiy9t3y/ONGDRXPFbv8vOaEvCA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m5jDQp7+lowH5sOCzZBMoGSOKvVK98UP0ioloOfh7nxmUasTmOa/RXL5StlzL1zoB
	 84LLsqP4xC54EJfMzBNKR2D+eefsW4c2r+Qpzp1WOFaG+4mzFZj13ulrXkH7Ewm6he
	 I9OJ+lQqzQc3U/n3801Gukz/VMuo2u9Z6qFuZb8ZrTcyeaJyAj8ARIoz5qgq85NTIn
	 q2vDgLT87foyTknoWJzP82hl4pxJKNAD8EN71e9/56NjbbTFdGwaE+Y/DFgUod1zIm
	 vBlyAYtXQn7lpeTfd8icL7VrRmkouJczIcJT3LDkR3MfkZlczwck9jrBY2GG5YzNhh
	 BuQRsYAic9cXg==
Date: Mon, 5 Feb 2024 11:48:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Stanislav Fomichev <sdf@google.com>, sridhar.samudrala@intel.com, Eric
 Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
 linux-api@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
 alexander.duyck@gmail.com, Wei Wang <weiwan@google.com>, Amritha Nambiar
 <amritha.nambiar@intel.com>
Subject: Re: [net-next 0/3] Per epoll context busy poll support
Message-ID: <20240205114821.4601ea5b@kernel.org>
In-Reply-To: <20240205185217.GC10463@fastly.com>
References: <CANn89i+YKwrgpt8VnHrw4eeVpqRamLkTSr4u+g1mRDMZa6b+7Q@mail.gmail.com>
	<5faf88de-5063-421f-ad78-ad24d931fd17@intel.com>
	<20240202032806.GA8708@fastly.com>
	<f0b4d813-d7cb-428b-9c41-a2d86684f3f1@intel.com>
	<20240202102239.274ca9bb@kernel.org>
	<20240202193332.GA8932@fastly.com>
	<20240202115828.6fd125bf@kernel.org>
	<20240202202344.GA9283@fastly.com>
	<20240202171539.7347cb01@kernel.org>
	<ZcEmDz3UvAksHFFG@google.com>
	<20240205185217.GC10463@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Feb 2024 10:52:18 -0800 Joe Damato wrote:
> > Should we also add prefer_busy_poll parameter to EPIOCSPARAMS?
> > napi_busy_loop in ep_busy_loop has its prefer_busy_poll argument
> > hard-coded as false.  

Good catch! We only plumbed it thru to socket read busy poll.

> I think making this configurable is a good idea. I can add that in the v6
> in addition to fixing the incorrect commit message in patch 1/3.
> 
> What do you think, Jakub?

SGTM (with the caveat that I'm not epoll expert)

