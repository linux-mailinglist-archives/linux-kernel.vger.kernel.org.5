Return-Path: <linux-kernel+bounces-96045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7701787567F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17CB61F215A1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C7F135A70;
	Thu,  7 Mar 2024 18:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4IgkS67"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442FE12FB12;
	Thu,  7 Mar 2024 18:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709837921; cv=none; b=jOmjcYSe6ff0K9tqJXSynWY8Cq+bdBaoX8OTujW1yoDoYcrrw4fADeMIOsWQxvAK6U6rVobfLzq3rIhRtpDEdtJhOPo0vGHcTq2QmHZx1d9/bMvUDOmHtiVaVcJ0OekCIC8y9LXCzrfdT1JwqS5M+C09UbtXDPnbVjfDvxkCpZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709837921; c=relaxed/simple;
	bh=XrTXKV4fLLNZYeQ7K7P7tCKsNgQbgRtB2hmD8awyd7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbK8xj0Lb1w/ekv8yPRF7Jrc4A1MoDBaTehgQRf6I9iwquc+d9XLztCD/LlYJqa9oJSjkED2PWylJn7Fv1CzutyKt7lTgEI7Wmj1iLnFloDOJcBt/1cLRR951QkXZU6jrnZCgEQrK9FImOhYkm0ElMdjKkhFUV6gSrHVWuHVV7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4IgkS67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7792C433F1;
	Thu,  7 Mar 2024 18:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709837920;
	bh=XrTXKV4fLLNZYeQ7K7P7tCKsNgQbgRtB2hmD8awyd7s=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=T4IgkS67qBXEryQUh1eyup04KKujuTcp1GpBVVC8GTfw7LhnS5cRcPmPxqiYX341X
	 5QFzU5lVrQ12kfVjLceTo3j8L6pU1zxiiPM8ac8By9WBUnXdHr2MpO/YPOgfmLW3Cg
	 ySkH7HplOBQpDXuSLQIgHouMTqeZ75dIiRrQ/U8AyBMQwSgq+0+ZNWNCq1UOpTSv4z
	 pgh8FfKFzUQkrpM0mR58q4YLajIQA/XLGBeHqyV5n+zpgKQp/1o5jRYHPnc/GFvo/I
	 cdvMvgqqMb8mPX1Q0pHfQ/RaDywZ3kQN3a4Q5iLAWl7XgBdj/u0ajJkvksWhg/rFT/
	 X0KQ1Dfs8MAlQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5C49ACE0716; Thu,  7 Mar 2024 10:58:40 -0800 (PST)
Date: Thu, 7 Mar 2024 10:58:40 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Network Development <netdev@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
	kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
Message-ID: <1165c893-b812-4f88-a1d6-fff85592657e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <55900c6a-f181-4c5c-8de2-bca640c4af3e@paulmck-laptop>
 <10FC3F5F-AA33-4F81-9EB6-87EB2D41F3EE@joelfernandes.org>
 <99b2ccae-07f6-4350-9c55-25ec7ae065c0@paulmck-laptop>
 <CAEXW_YQ+40a1-hk5ZP+QJ54xniSutosC7MjMscJJy8fen-gU9Q@mail.gmail.com>
 <f1e77cd2-18b2-4ab1-8ce3-da2c6babbd53@paulmck-laptop>
 <CAEXW_YRDiTXJ_GwK5soSVno73yN9FUA5GjLYAOcCTtqQvPGcFA@mail.gmail.com>
 <fcaf6cad-9959-4b6d-a6e4-05ae1b2fabdc@joelfernandes.org>
 <Zenx_Q0UiwMbSAdP@FVFF77S0Q05N>
 <20240307135215.7ba88d83@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307135215.7ba88d83@gandalf.local.home>

On Thu, Mar 07, 2024 at 01:52:15PM -0500, Steven Rostedt wrote:
> On Thu, 7 Mar 2024 16:57:33 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > * Use rcu_tasks_trace to synchronize updates?
> 
> Yes. I think I wanted both. The above to make sure it covers all cases
> where something could be preempted, and a case for those covered when RCU
> isn't watching (which always has preemption disabled).
> 
> My mistake was I thought synchronize_rcu_tasks_rude() did both. But I just
> found out recently that it is not a superset of synchronize_rcu_tasks().
> 
> But it really needs it in every location that synchronize_rcu_tasks_rude()
> is called.

Should any RCU Tasks Rude grace-period request also wait for an RCU Tasks
grace period?

I would feel better about proposing this, especially for
call_rcu_tasks_rude(), if RCU Tasks Rude was not supposed to be going
away after all the noinstr tags are in place.

							Thanx, Paul

