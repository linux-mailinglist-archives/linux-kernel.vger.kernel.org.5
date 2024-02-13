Return-Path: <linux-kernel+bounces-64049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 532EC853967
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76A41F23287
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E885605AA;
	Tue, 13 Feb 2024 18:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYsy4lZu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C903605A3;
	Tue, 13 Feb 2024 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707847499; cv=none; b=SMvMvcwjcjH/7NuLMj4ua6m1I4gse8l14Mx5QgVpTqjdDQHMoIrsU8Nm2NylLADPPXVtL74ThYSWGhPySwIOlbQ/AySl/6m9H+S2Xc5va1q4NKf7sM3qk+dTU8C67ybV3D7JFSVf2uR7XNACPKFUQzKhhKk7HMzlFYow4kVwSCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707847499; c=relaxed/simple;
	bh=QcYIDSiCp33r8BU8FmPB//SjKuQcfdO/ovF933HfSR0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vFT0LS704obkYFhMysJF2ub1TOjiuh/RxatYagFnNBXF5VSZBEVpeA5hBXZKH5+Y0i7oSjVF6pN7aD2MK+E/MVWVvS41tW/aHO6SUiXwzFvXjkJZp572aMGJ9bZ3kPlTAXZAXiEQurH35lYLDepuB7NV+EI7IAknW8K8SuEnc7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYsy4lZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B20C433C7;
	Tue, 13 Feb 2024 18:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707847498;
	bh=QcYIDSiCp33r8BU8FmPB//SjKuQcfdO/ovF933HfSR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WYsy4lZuf3g58s8VpVgwI7cVjG5uF7Qa2eo1nxCkDfnZr4/o36pygCwWDZejklHzi
	 OeFJY9XVFDnZ0W4GVozJnViVjQ4C4CcztMhkG9KofurM4VHEoHYazoX00ogQBAbIYq
	 0JXqo4DmZQiW/SrbWAP5vb8ZpAPTFUmEE3fS5nYR7qQN8KREaN1GxOUg23CMqHlXgq
	 q5UEwjLwqdTaB/X7pn2O4W5RzcQCBxsmFE8bNGuNAJDoNlDLI5Cx+6KSpI4DO85roV
	 gQVjDZA9BHOJAjzBDuP67j9xlhQdaTNMpBGFYJxxIQVq/nwbMFVP/AuEsaA0sXdTMS
	 ig8OXTK0lRCXg==
Date: Tue, 13 Feb 2024 10:04:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Breno Leitao <leitao@debian.org>, davem@davemloft.net,
 pabeni@redhat.com, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, weiwan@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Johannes Berg
 <johannes.berg@intel.com>, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <linux@weissschuh.net>, "open list:TRACING"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3] net: dqs: add NIC stall detector based on
 BQL
Message-ID: <20240213100457.6648a8e0@kernel.org>
In-Reply-To: <CANn89iLWWDjp71R7zttfTcEvZEdmcA1qo47oXkAX5DuciYvOtQ@mail.gmail.com>
References: <20240202165315.2506384-1-leitao@debian.org>
	<CANn89iLWWDjp71R7zttfTcEvZEdmcA1qo47oXkAX5DuciYvOtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Feb 2024 14:57:49 +0100 Eric Dumazet wrote:
> Please note that adding other sysfs entries is expensive for workloads
> creating/deleting netdev and netns often.
> 
> I _think_ we should find a way for not creating
> /sys/class/net/<interface>/queues/tx-{Q}/byte_queue_limits  directory
> and files
> for non BQL enabled devices (like loopback !)

We should try, see if anyone screams. We could use IFF_NO_QUEUE, and
NETIF_F_LLTX as a proxy for "device doesn't have a real queue so BQL 
would be pointless"? Obviously better to annotate the drivers which
do have BQL support, but there's >50 of them on a quick count..

