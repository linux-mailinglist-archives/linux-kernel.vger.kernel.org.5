Return-Path: <linux-kernel+bounces-45675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC988433DF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD3D91C27F9D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF13611E;
	Wed, 31 Jan 2024 02:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="KmrtVPFu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qEo06QOB"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41545667
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 02:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706668076; cv=none; b=SWFTjB0crgMtqYuzBeQA6fDJwJADIaPuhIZSF4ZEDstaRVVE2nCsaKZHLKrSC4McIZOOP03O07ATJ95YRb93x8Qy5zUG0Y57cfUlL0N2/8vCBCdD/9X2TT0KwYxmbdwTeWqouapWRSEN0LKoKYlzQH5YOV2DefCDUk18EhUVNwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706668076; c=relaxed/simple;
	bh=rqfGQ33rW27oNnjc+6yHT9BLkWlpUqBhPyW9ihVyVxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsiTS75UY7SJ4mrqh4ID7EHDWfhwvbHNcQUfyT3NISDgSNzjgc6WAeVHE828bQYAZc6lZpEX4kKy2N5DzW4zw5cmVhF3RRYzj7gNUI3A5KMKrxJ7K5h4Km97touc5oIadFWOarN3GN/gjDY7m2kubUgLf0gTUjYVIOcQ8hYdXoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=KmrtVPFu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qEo06QOB; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B791F1140081;
	Tue, 30 Jan 2024 21:27:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 30 Jan 2024 21:27:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706668073; x=1706754473; bh=81kLSaihQo
	tDKU9jTT77jkJOpqh/hq1cds+S6k0OFNQ=; b=KmrtVPFuwVEqAqfu3rXHveGwlY
	ZacOwX1OcM6Lw3aVjasasUEWkg5TNmTtUyKFDza4OFWEpNnDvhcJhrrziYoJUwas
	nsSP1sbnWnTURAScWutMo31wZag92CqDEzK7uv1OTOoLdpti+3IaCXX4kPite2iZ
	ViURvNYcrdx39TExAooxnpL+tIHtjvhFKLVsXYb/6ooJOswwW03XNzFb3dg2n7ne
	gWyH0UZ2elzc7Cpj5CExe/C1lKXxgqxd5WzDrwxK3bxqFYHeKEM4BnoCiyd3IM6W
	uJcCBsakxAiOcsZRhvbvolHaup0IDQ3JuYDWP3873pRpdzJfQTSkS4KpmUcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706668073; x=1706754473; bh=81kLSaihQotDKU9jTT77jkJOpqh/
	hq1cds+S6k0OFNQ=; b=qEo06QOBd6c1YsTJXtVNPYdwNj+d8avFV8Bgmx5OTgfM
	v6gF/Gb2F32HdkXfLUmRK/qGbMdJyLfKxx/v/Sr5UUchD9lOfY5t5+7hDL1z+FiG
	UkxZI+PMSTeX8Q0z3IAWgzd7DGheFNwss4Yfmm6Jrne3z8ue5KeRjP+Cl/K641HH
	MYwJf83rrjpkt76qbtSLGtYqx+GFEKXRvpCX0Qf3V/UehSXXvaV1atykSqGoHNG/
	SpP+Xd03x8+eCBbF00rqB3VO0xLEtHNJmwdS6ziZdInKYjkoTeRlLOX994ZqCU9A
	Kj3w5tYj1EYHliiIgR3rzK7+lVV3+kMfzJOKs24ueA==
X-ME-Sender: <xms:KbC5ZRJD_DG-xzXOPM6sNJn-6N439XCDj3HQMWQrAppr--fr0svU_A>
    <xme:KbC5ZdLWOKXJrAQHd1-W8LUO5QLaz0EbbdIlZuWs-qqaEEruG6cTEJK5KxyNGh87A
    oJrRvvluMuy8g3_hck>
X-ME-Received: <xmr:KbC5ZZt7LIdAcVsfXOzHGDdryFNuadVcYrwnhSF9uq9LFJFjhvZYZNE2Rmc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtkedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:KbC5ZSZPxSY7Gh-dv7RtfZ5NMuwtGv-EujFK27zS67sUQyYZ4AnxGg>
    <xmx:KbC5ZYabau5VdYa8HMZGzVwOQXvHTUt04bi_I6xNsGesZ0mn2GS-hw>
    <xmx:KbC5ZWA4jV9mp5VDp7elsxHU4TX39vLfS4mD5L26RepIfQBqIkR1kA>
    <xmx:KbC5ZfUH3M10VChsiS2Ep-SmHV7nTP5I8c_PfxDmoZr7_Z7Xqdv0QA>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jan 2024 21:27:52 -0500 (EST)
Date: Tue, 30 Jan 2024 19:27:50 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pidfd: implement PIDFD_THREAD flag for pidfd_open()
Message-ID: <ZbmwJiIS4ei64u6R@tycho.pizza>
References: <20240130112638.GA29773@redhat.com>
 <20240130113409.GA29849@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130113409.GA29849@redhat.com>

On Tue, Jan 30, 2024 at 12:34:09PM +0100, Oleg Nesterov wrote:
> Damn. Self-NACK.
> 
> I forgot (we all ;) about mt-exec, and there are 2 problems.
> 
> 1. The "if (!thread_group_leader(tsk))" block in de_thread() needs
>    do_notify_pidfd() too, the execing non-leader thread looses its
>    old pid, pidfd_poll(PIDFD_THREAD, pid-of-execing-sub-thread)
>    should succeed. Must be fixed, I think.

I think the `test_non_tgl_exec` from my tests exercises the scenario
you're describing, and it works.

> 2. pidfd_poll(PIDFD_THREAD, pid-of-group-leader) should not succeed
>    when its sub-thread execs, the execing thread inherits the leader's
>    pid. Perhaps pidfd_task_exited() can check sig->group_exec_task,

I didn't have an explicit test for this, but I hacked one up, and
pidfd_poll(PIDFD_THREAD, pid-of-group-leader) doesn't return after
exec.

I think it's ok? But I must be missing something.

Tycho

