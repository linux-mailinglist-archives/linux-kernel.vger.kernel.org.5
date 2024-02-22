Return-Path: <linux-kernel+bounces-76121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AEC85F329
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9B61B24598
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C5E2BB03;
	Thu, 22 Feb 2024 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXk2btji"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E94B1B592;
	Thu, 22 Feb 2024 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708591228; cv=none; b=tZOIcJKsMc3HK8ifdSK7+6zi+igKEGgZTucm9s/487boJzWqDvrRFeRvBKE+vGUb8wXf4nE37WqFMjkuf8AjpXfFJA1xjGrIXMe+5aC29l7ICRCgRqroiY4/Qn2l91gcbi7fWd7cPwk91uVu0TRMdexn2Dco5WgIe14pzElNLTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708591228; c=relaxed/simple;
	bh=g6Qec2O5nkm+nGkj0ld68IgPI105soDh6nDU9qh5Qq8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MyNmCgF/f3pSeZYZjPkhSvMeOb6HV1SjuS6mEPSyOe+OVB/51OOtQw/hg27yETbq4BauHq84NIkvPa4SSheJ4eQFKGaqMIxJ1H9EEoZOD58/nZEMEQgSKWDuhR1EVmougNRAH5waFDp+/zPMQGb9jbtdUmL4O6YoS/EBZMSCj/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXk2btji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97209C43390;
	Thu, 22 Feb 2024 08:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708591227;
	bh=g6Qec2O5nkm+nGkj0ld68IgPI105soDh6nDU9qh5Qq8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LXk2btjitXl9gz6LKGcMt9Js3NmMWbjIOp+7ErSn/ysCVj1CNMywcnlooUy6WOvRm
	 8vYkeV08fkL5SH2ffAZjaPnRMbRVgxderelHLmA7qS62RB/nYfqK2Cp59A8VzszfNe
	 JCciAD1j4WBRrgqLHFHTPQmOLM9u4AOLrmlpwehdyUbblQZsMjs9HmZypPg3goCJbX
	 3zdxFLmFgDEXwIvTNdQem3bDrk8+dV5+IoloTN6BVOkahodj7p2/FpdCqAnx89eUQ+
	 ZJ40Lu3pSlrJi3vzjp9PQwVCzzgM8ZyUe7ZXI6qWXN9u8Ln442YmMmYA5TQNLagrbZ
	 lrrSRNIrnOUNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E54FD84BCA;
	Thu, 22 Feb 2024 08:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] ioam6: fix write to cloned skb's
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170859122751.10907.15669558158966049047.git-patchwork-notify@kernel.org>
Date: Thu, 22 Feb 2024 08:40:27 +0000
References: <20240219135255.15429-1-justin.iurman@uliege.be>
In-Reply-To: <20240219135255.15429-1-justin.iurman@uliege.be>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 19 Feb 2024 14:52:53 +0100 you wrote:
> v3:
>  - fix patches tag ("net" and version were removed unexpectedly)
> 
> v2:
>  - use skb_ensure_writable() instead of skb_cloned()+pskb_expand_head()
>  - refresh network header pointer in ip6_parse_tlv() when returning from
>    ipv6_hop_ioam()
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] Fix write to cloned skb in ipv6_hop_ioam()
    https://git.kernel.org/netdev/net/c/f198d933c2e4
  - [net,v3,2/2] selftests: ioam: refactoring to align with the fix
    https://git.kernel.org/netdev/net/c/187bbb6968af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



