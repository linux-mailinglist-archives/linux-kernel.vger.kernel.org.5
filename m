Return-Path: <linux-kernel+bounces-93280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF29872D68
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F7F1F24BAD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEE9134A5;
	Wed,  6 Mar 2024 03:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyvlXl7V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8051E79E4;
	Wed,  6 Mar 2024 03:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709695111; cv=none; b=lUzmRDbl3LH9U0n5815rMCdHnabe+oj28RW6haax6ganAPw+YcKQZSJI4R6ZFHmetb9gDMGafqy+za9Rw9Vyxcs5k6ZC4LAtiuwvYLigdHfRzlqCwSJItHPHEsu7AjHMoUNDsqbca/Sr3xEYk2TNF8UEKyxHqm3gSud5aBIF02I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709695111; c=relaxed/simple;
	bh=mvhk95b95i5F452rphX9EHU3jHBno47T1oeALgtxQdg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0Yd+ufNlRVFHI1m++Etsw47MgDXUJPg/dQ57xFBrPvSTXVPcUi37Ip+f9Rx/OW6JgC6JyF4ffNpPi4VLd0TNClcNBep75tuCWq+0sylMYvN5MNeiQbBDVboIpjFm6KvUYPX4F2a5LC9UGYgBi8Si+Sg7ObcdEQB9NT5Wj0h5wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyvlXl7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79AEDC433C7;
	Wed,  6 Mar 2024 03:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709695110;
	bh=mvhk95b95i5F452rphX9EHU3jHBno47T1oeALgtxQdg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iyvlXl7V8bapyhuZSoPvonj6gCY9sTdAKGZGJ2ioQyY9+vK/dpEszoUWAnd0s2s81
	 jxS97t9qkbNcogwcJNdhrtBnP0a82wcjj3yCsph6FNWN3bIRiEYfhPcGXQlPsei8q5
	 Uu7onBBx316wDONB2nRANFNwTea8UQSr0acVX51ioa4AzrYqxTsVOYw1s6oenN89Le
	 E1JmBGnI8PQSXQloBdfXR4KTjzDJiRIGFszMCWfSVBKGHVQDUggtu3Fudj0A/+U1XC
	 d6mUQyr7HYIX4RTpi/KWRb2ANWJVbFAuhKg6pgrGaqEchuIHhpTEInIzxmolnKmZyU
	 cRlbdrY28jMjw==
Date: Tue, 5 Mar 2024 19:18:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Juntong Deng <juntong.deng@outlook.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ipv4, ipv6: Fix incorrect skb->data_len
 caused by __ip_append_data
Message-ID: <20240305191829.083ba9d8@kernel.org>
In-Reply-To: <AM6PR03MB5848A1EE8F0EBA45D440F8EA99222@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB5848A1EE8F0EBA45D440F8EA99222@AM6PR03MB5848.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Mar 2024 22:42:05 +0000 Juntong Deng wrote:
> When __ip_append_data allocate the first skb in the queue, or when the
> size of the data in the skb exceed the MTU and require a new fragment
> and allocate a new skb, both cause the size of the data increased by
> this __ip_append_data to not be added to skb->data_len.
> 
> This is because in the current __ip_append_data, skb_put is used when
> putting in the data for the new skb, but skb_put only increase skb->len,
> but not skb->data_len, resulting in skb->data_len missing this part of
> the data size.
> 
> All skb processed by __ip_append_data are unable to obtain the accurate
> data size based on skb->data_len for the above reason.
> 
> Also __ip6_append_data has the same problem.
> 
> This patch fixes the bug.

data_len is the amount of data in the non-linear parts of the skb.
Please run some tests before submitting patches.
-- 
pw-bot: cr
pv-bot: s

