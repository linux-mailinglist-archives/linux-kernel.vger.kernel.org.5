Return-Path: <linux-kernel+bounces-89658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E7C86F3BA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 06:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79179B23405
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 05:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7951F847E;
	Sun,  3 Mar 2024 05:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLrj/do7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD58A7494;
	Sun,  3 Mar 2024 05:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709443624; cv=none; b=RY1XqDO36yvi+bQOPpOjJrv25NHpMapxtJBS2e3W3yejT7uZ394mucdzkYjJqtBQUrpdpAcsgQSz5s+8ByK8P7FKSHAxqQf/VpNvU5CKSywkmO7DCBbwnuMORwA0D5FxyPb9JA5hFuyTvl4SvWsIDU3n2FoBhAokRChv+1ISPDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709443624; c=relaxed/simple;
	bh=SbwC5DYIzEhEfg+itSOhS1E+hnKBAn/SGhRX9oPjDyI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKwdPGyA79ioZObMPD1SVNagJS84d+fTIkscafB945xttYhU80jJaMbs9HcqEbZFqH0mETZkcjqzeMaILki7obpYHEh28GySTFk/fZNNkHCPfxS0dO4X+tKn4mxAx/g64e5SxnQfLJ0MW3oOnQUINInVCn7VKzRdw5miQIwGJR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLrj/do7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D668EC433F1;
	Sun,  3 Mar 2024 05:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709443624;
	bh=SbwC5DYIzEhEfg+itSOhS1E+hnKBAn/SGhRX9oPjDyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aLrj/do7VCBv0e1MON7hI+DYAAz93a6PKNkU5r24/IZVdWCvC6l5N7TKMPGz3n7TU
	 rmkHetrx+6voNx+b00ljuTs/AJkNdbAKi7ELrgvu0nt+TyCJui9nuu7yBWv2BS95H1
	 uK2/4mDacsXKyFtPHto+q6r2flGUywNGMME+czeLuRGx61IkRZqKgUYmz9/zvfR3QG
	 QIA59+7Idy/jlAcRThzlL/W99rsDoCN09cKf7s5YJ9G9sWPUlLjpa469I0W/teWmRi
	 Nk9d8krOA+9ESAJ9I4MO8J0piU6woetqPrURsmh6eu1dfwwvhFKuYEL6inMmbWqhWE
	 Ajnld+mHKj1Nw==
Date: Sat, 2 Mar 2024 21:27:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 18/21] rxrpc: Use ktimes for call timeout
 tracking and set the timer lazily
Message-ID: <20240302212702.15b04552@kernel.org>
In-Reply-To: <20240301163807.385573-19-dhowells@redhat.com>
References: <20240301163807.385573-1-dhowells@redhat.com>
	<20240301163807.385573-19-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Mar 2024 16:37:50 +0000 David Howells wrote:
> Track the call timeouts as ktimes rather than jiffies as the latter's
> granularity is too high and only set the timer at the end of the event
> handling function.

This one has a 64b div somewhere, breaks 32b builds.
-- 
pw-bot: cr

