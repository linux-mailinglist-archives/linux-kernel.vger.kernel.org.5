Return-Path: <linux-kernel+bounces-33819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8962C836EF4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9E9B280FAF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A80C657A2;
	Mon, 22 Jan 2024 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5Whsgbe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAD1651AE;
	Mon, 22 Jan 2024 17:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944486; cv=none; b=EZVGwLJTsaAQ1ZOfkBPxQTCm//fji549OJXxA65laHcOIHSZbjWbfgpG0ZLW3PFYQahEgPFkVnUT6KVQeb/7p7/hYEdA2uI+CgyQD3atXSSi1CtwUg0zHYludQSkXJOtXdv1VB+WI3rt8dTOloyN2BGve7fTxK2xRKs5O/DIZBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944486; c=relaxed/simple;
	bh=52IzLNkZxh7QhXFoV4ABbKrbI7QGTj3FNCgGcZDHDww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYPoBqgvMTnLEeEkHFGPDdNF7K2kxB+szXCr8nINy6JejawB4IVbRs7/UpZketMybAb2RmOopjI3O1QqSrb3JE2811prLFNMbIKq1ueS5J2QYGGj2D1wfQSF3GMsZltUZzoAg8Z44o8tqtH9X3LSf1MZq180d13ncTiAi0rKCIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5Whsgbe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B031BC43394;
	Mon, 22 Jan 2024 17:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705944485;
	bh=52IzLNkZxh7QhXFoV4ABbKrbI7QGTj3FNCgGcZDHDww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T5WhsgbeEW3ZXKO2vbH5I1UYpsnZqe5JDc8V6Rov7Jf2+l7MdWyUX0FPeZTcL43/V
	 +bkrnIMdKgWhiI3urV/0L9JZh2amhfdc1SG/luKrsXSXFt7W1n/Mqs3onHkPBPRqYX
	 /aHnuQgdbuRFSPSipZZkoQwANsE8D31l/IDFtLMLCX8J5jsxfiyMdq6hLFM8ZOZI8A
	 mwaMppQ+KKZOTO2fJS/zyc22CimfJRAiDoM3WMTZ9q9LuUntyG7ik9oNwrjjK39U5Y
	 04oemuiJf5uWFZBlzTSl/BusxVckG0a9XPhwztucndTp9wnxq0Pu2dpK+mMNzO0Fyf
	 KtN7EOem8qN1w==
Date: Mon, 22 Jan 2024 09:28:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Netdev <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: Kernel panic in netif_rx_internal after v6 pings between netns
Message-ID: <20240122092804.3535b652@kernel.org>
In-Reply-To: <5340b60d-a09a-4865-a648-d1a45e9e6d5f@kernel.org>
References: <98724dcd-ddf3-4f78-a386-f966ffbc9528@kernel.org>
	<CANn89iLAYXpRiGaGi+rvOZyxMfpUmW2cOg6hLhqE=+2JJS8rkw@mail.gmail.com>
	<65c4f6a2-207f-45e0-9ec3-bad81a05b196@kernel.org>
	<5340b60d-a09a-4865-a648-d1a45e9e6d5f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Jan 2024 18:53:50 +0100 Matthieu Baerts wrote:
> FYI, I managed to find a commit that seems to be causing the issue:
> 
>   8e791f7eba4c ("x86/kprobes: Drop removed INT3 handling code")
> 
> It is not clear why, but if I revert it, I can no longer reproduce the
> issue. I reported the issue to the patch's author and the x86's ML:
> 
> https://lore.kernel.org/r/06cb540e-34ff-4dcd-b936-19d4d14378c9@kernel.org
> 
> Thank you again for your help.

Hi Matthieu!

Somewhat related. What do you do currently to ignore crashes?
I was seeing a lot of:
https://netdev-2.bots.linux.dev/vmksft-net-mp/results/431181/vm-crash-thr0-2

So I hacked up this function to filter the crash from NIPA CI:
https://github.com/kuba-moo/nipa/blob/master/contest/remote/lib/vm.py#L50
It tries to get first 5 function names from the stack, to form 
a "fingerprint". But I seem to recall a discussion at LPC's testing
track that there are existing solutions for generating fingerprints.
Are you aware of any?

(FWIW the crash from above seems to be gone on latest linux.git,
this night's CIs run are crash-free.)

