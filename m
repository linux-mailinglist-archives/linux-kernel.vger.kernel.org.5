Return-Path: <linux-kernel+bounces-137798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BA189E7C3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 03:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0300B21B93
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A302138C;
	Wed, 10 Apr 2024 01:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbvLlPSj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2A6522E;
	Wed, 10 Apr 2024 01:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712712337; cv=none; b=sZxeRu0LFs92JDAfuVUi/cXe8ONYAP0lGUmJBkGoVE7DVC6x6rBDrTn4uPYZsWcNBzdb7Yn/0OOlhsTM3pA9MUloUNXejn1pafp8lZM8wTJ/4SM1ffGq5vnVv92JY8r2LN4o2/E7XCZWMm8pJ9fki3rZt0b21i6fgFAthtW8QI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712712337; c=relaxed/simple;
	bh=s+LuOnS4/HijsF6NC3UfnnbYdve8rq2hI2x3j2ZD8U4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LwtAVLBoqoUR4j9PxhovzFKivAV1nUNSFME8V1JpdJ9OsAN3nKuvgADMguBXy5vj8E5dg9W3+FAeehYQgBX5yYIjGdNGlpGS1Ai6c75W3XlxZ9MYpEgEeT56Oi3qpW6azjYeiOg3u6OsUyQ52pNrUkCbL20ZRoTl3YLCbUwDGs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbvLlPSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A680C433C7;
	Wed, 10 Apr 2024 01:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712712337;
	bh=s+LuOnS4/HijsF6NC3UfnnbYdve8rq2hI2x3j2ZD8U4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mbvLlPSjzyBvrum7jzCUAgdnJSD17T36+mVtJ+clnXie3CeKuCMiRxz+KsStF/AcQ
	 z5YQ+YLQXMRrGhTgnZiqQ3hGAjF4ks3oEVbQbES+/U6Rlbok/lG1T11Uw9kRz6/cof
	 h1ndlEfx+ELsxC23ZR5y+JM1qVfIJ/btq6JpMGb5KVFcdOzVNvxYiv7aTV4Ooebicf
	 /YxrGRK3A54fxndsRS+B6/4NP6koejFVwmERJsIAh5qxOhdew7sA0xjz9jesXKUetp
	 BclC6auHZKosViaWkQPdW6ZLJQOFapNYxFKMyWuo985lzDTPy3IyzDbOEM8DCW58GB
	 VJwzu4ULy8vbA==
Date: Tue, 9 Apr 2024 18:25:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lei Chen <lei.chen@smartx.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang
 <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net:tun: limit printing rate when illegal packet
 received by tun dev
Message-ID: <20240409182535.166cda7c@kernel.org>
In-Reply-To: <20240409062407.1952728-1-lei.chen@smartx.com>
References: <20240409062407.1952728-1-lei.chen@smartx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Apr 2024 02:24:05 -0400 Lei Chen wrote:
> --- <NMI exception stack> ---

You need to indent this line with a space, otherwise
git am will cut off the commit message here.
-- 
pw-bot: cr

