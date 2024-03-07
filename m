Return-Path: <linux-kernel+bounces-96035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F88387565E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0BB41C21447
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFA5135A46;
	Thu,  7 Mar 2024 18:50:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BEE1E4A2;
	Thu,  7 Mar 2024 18:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709837422; cv=none; b=KVdMceSq5R5Td1nUvUJ5qc4D4Qo/CbNSsNtCnvzoHIZa8ePv/8i7j1J0ZhsJopL+bBkwzC9+sK1YWAyOjAPYHizGHBTFbJu/GZdulC0uv0VbNdC/TUkez+B34ejHQFzqB0agq/wJDRaEXCcRWLA8iE+RLW3cc1Lrq6aOCO0fZ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709837422; c=relaxed/simple;
	bh=Oui1MW119tBegORPmVHwUMz4AAtqfEqlY9x5E6G59XE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJ+hSeolhVGHq6hMPi71qNIxQLmOW2azwiTF39/zTf2m6+jdEhGLAym9ooC2e0AT4YWBe59PsylRM5K7gMG6MgzHHEiQfY2pqm+smqXWRhMQx4HSJbgWhbxZBpKliB49ETYIMQbbkbXMWK0kEtYqFnIJr2l162Cx6OnPXQ9QS04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7CBC433C7;
	Thu,  7 Mar 2024 18:50:20 +0000 (UTC)
Date: Thu, 7 Mar 2024 13:52:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, paulmck@kernel.org, Network
 Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 rcu@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
Message-ID: <20240307135215.7ba88d83@gandalf.local.home>
In-Reply-To: <Zenx_Q0UiwMbSAdP@FVFF77S0Q05N>
References: <55900c6a-f181-4c5c-8de2-bca640c4af3e@paulmck-laptop>
	<10FC3F5F-AA33-4F81-9EB6-87EB2D41F3EE@joelfernandes.org>
	<99b2ccae-07f6-4350-9c55-25ec7ae065c0@paulmck-laptop>
	<CAEXW_YQ+40a1-hk5ZP+QJ54xniSutosC7MjMscJJy8fen-gU9Q@mail.gmail.com>
	<f1e77cd2-18b2-4ab1-8ce3-da2c6babbd53@paulmck-laptop>
	<CAEXW_YRDiTXJ_GwK5soSVno73yN9FUA5GjLYAOcCTtqQvPGcFA@mail.gmail.com>
	<fcaf6cad-9959-4b6d-a6e4-05ae1b2fabdc@joelfernandes.org>
	<Zenx_Q0UiwMbSAdP@FVFF77S0Q05N>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Mar 2024 16:57:33 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> * Use rcu_tasks_trace to synchronize updates?

Yes. I think I wanted both. The above to make sure it covers all cases
where something could be preempted, and a case for those covered when RCU
isn't watching (which always has preemption disabled).

My mistake was I thought synchronize_rcu_tasks_rude() did both. But I just
found out recently that it is not a superset of synchronize_rcu_tasks().

But it really needs it in every location that synchronize_rcu_tasks_rude()
is called.

-- Steve

