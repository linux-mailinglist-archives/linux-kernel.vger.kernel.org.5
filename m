Return-Path: <linux-kernel+bounces-55347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D244E84BB8A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C49285D9F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6377FC142;
	Tue,  6 Feb 2024 17:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="RzH+usjA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XjRWJj1P"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F09B660
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707239026; cv=none; b=QNWMdnfIhZq3CZVS7MI+knujM6dYgf5OyJXRqGcs+SPkF7z2MZGAOdjyrtfBYDPZ3wOMxGbwThwoIqyww/9lGaLse+VvwvT9EFSuMpScubjoVmJW2IGn/cn2c9wteIjbSPt4QVsoLgDRMA6+UF7eseHisdoWtvuY1gogHs+uQGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707239026; c=relaxed/simple;
	bh=Pi2bQyjd4JrcnKiKXNf22cV4BhWExRbLQiYFOeF0mQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2Y3vq/LcaZhl9e6zTenuiiEyzGwPvyozKd3t21/8ASUyDk4X1TI2ZRhtJJoCr23ej4n1PcyxlIduaOPZddUKMoqeiYMCmIh714a8RtdkdGzK8LumZ+IrydMKowocJYGF3/PBbTdkEuhgnffNijp50SRLUt9DknWrka2pm6hqCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=RzH+usjA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XjRWJj1P; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 7F13D5C01DF;
	Tue,  6 Feb 2024 12:03:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 06 Feb 2024 12:03:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1707239023; x=1707325423; bh=rncCsbijlK
	W5bm+uOCXcgesm6PuvgxlxVPQRyDZ1S1c=; b=RzH+usjAWVRDh+Cti/pnzv9Pmr
	jqG5J6X0+aqdbqnl5jP/QeAhVR2cZ3rzV7PuvvC04IuefVFP5itdV/UbeeG19OnZ
	EhPTP7FxhPBqvVeTxnDzNaAZ+fkQw3ggBg0D212fPpn6jsFhH1Pg6cKCHHtoZxxK
	35Z4fXk1NevZvnvXtvjLVXqG2eh2l0+d9m4V3Sn86ak33Ei5QXXNfltKXpFnvKTL
	gtyw2rdZQbyHooZj/xDrQ21yR6dupSYZ2jdGqs8w0tkvRs6CriI65S/+HC+HJ0Lx
	uYR+quUB1hMcNHrdMTrw4NPadie6yFfxYmKMFaAvxETTUpUQl9+Y/KhNrSow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707239023; x=1707325423; bh=rncCsbijlKW5bm+uOCXcgesm6Puv
	gxlxVPQRyDZ1S1c=; b=XjRWJj1P5dv9c6+k43wQ7sBpjgWKPTmR1+uMvYjlul8H
	j8tz4AH4rNkCQsm+i53EWf6j2J/xMsOVeJrABQ7M3fnXLE99gjHsUYzYq7CzxZVs
	XVfxDqB1oWOWKTLq1AUczai70MkcK5umrDqfxFao03Vm26SwzUVfR9uFdCPyAHTK
	z91vYIkHRaKhF0z68doHY9NuovW4noBHSYmDOG2htfoL3bCX7TxPekbdIcPCiO8h
	TkIhkmzBTZD3MvZEUDpsbcs9Pz0XOF7UQbMKF0pihkPAzpRpgFCkvE2dPjW56U5J
	cpW3QhCNBwmxja33Tgj4i4T6LzE3BIm7XB0IYitGwg==
X-ME-Sender: <xms:bmbCZc5eyvQblUGZQFzcL-uPQUWQfQPiNvxEuxNxUpzCp-H7ipnX9g>
    <xme:bmbCZd6NNV2lcgx-MnJPoTx9pn-TqLooP-uo7n2GRJfCzaVeaOjBaX1DcBqCr07Hy
    wxOkGJ1bjWg8ViTX0Q>
X-ME-Received: <xmr:bmbCZbczSxFtBsIxZIFRryFbFEWJOBGJ4UFPO0ZZ7ryLGPUnuz2rLMZVsDaj-6sJj29syOWQ0CUFAOM750ichMieXHWp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddtgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeelveduteeghfehkeeukefhudfftefhheetfedthfevgfetleevvdduveet
    ueefheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepthihtghhohesthihtghhohdrphhiiiii
    rg
X-ME-Proxy: <xmx:bmbCZRLbEpFqMEJamPqjhdiKdDgXwEwACPf7I667FgWz-7sBoHKQpA>
    <xmx:bmbCZQI3tYJ8BlmUpJIioAdbOsgwhsQqOHq95VGeRPhilIlHZD8GdA>
    <xmx:bmbCZSzUUmlJ5KIwGI-K0-NHiAgs0zK4ZUj071VPWrArBF6lf8h_Fw>
    <xmx:b2bCZVEFdJlGbZtFyUdnb8_M12T8oU97Rf8GEXcqK8aJEq8zLlaS2g>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 12:03:42 -0500 (EST)
Date: Tue, 6 Feb 2024 10:03:41 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidfd: change do_notify_pidfd() to use
 __wake_up(poll_to_key(EPOLLIN))
Message-ID: <ZcJmbUzox6Rd3587@tycho.pizza>
References: <20240205141348.GA16539@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205141348.GA16539@redhat.com>

On Mon, Feb 05, 2024 at 03:13:48PM +0100, Oleg Nesterov wrote:
> rather than wake_up_all(). This way do_notify_pidfd() won't wakeup the
> POLLHUP-only waiters which wait for pid_task() == NULL.
> 
> TODO:
>     - as Christian pointed out, this asks for the new wake_up_all_poll()
>       helper, it can already have other users.
> 
>     - we can probably discriminate the PIDFD_THREAD and non-PIDFD_THREAD
>       waiters, but this needs more work. See
>       https://lore.kernel.org/all/20240205140848.GA15853@redhat.com/
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Reviewed-by: Tycho Andersen <tandersen@netflix.com>

