Return-Path: <linux-kernel+bounces-162383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F00AF8B5A53
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD6FE285A1D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D015774424;
	Mon, 29 Apr 2024 13:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOvgJnff"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F116651B6;
	Mon, 29 Apr 2024 13:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398131; cv=none; b=KduauTMErGgXy1lkHtY+MvesUNVJalonbpVQ60oC3XzDS7okeN1tpOH+NuYUq0TObpD1DbdYg8ol61SpcCO7psUO+DR0OxBXkVFSczbAQmk9jLXK1K7zoc3wO8ZohDoqFbV/zb/yqpwYm08v/RyOOyZzOEdXWytVyXvJEJfZNdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398131; c=relaxed/simple;
	bh=zxcI4PxUFpWLulg+udpZ9IhWhzZ7eE3x+oRR48hITQc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IiASY6sFwP00tiqbiJ3F/Q8yqzlU6Ts8kpb4lB9zdpTp9A536LYpWPGHNla+eVAqvcqI5vbCm8DXR0ZO5dahD4DBb7aQ1IuKRtJjFe3F329bOMxeWcYOfk0dFS5V6IeuBpkq10On14OGkEctduO4kzeKnCBLV/28dCnUL57uQjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOvgJnff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3926AC113CD;
	Mon, 29 Apr 2024 13:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714398130;
	bh=zxcI4PxUFpWLulg+udpZ9IhWhzZ7eE3x+oRR48hITQc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BOvgJnffQRdc2eLLsTzkjwUsRuizxKjUGmODzgf2wxZdLBeH9W//DPFLoh+xg7/Cu
	 EQ7gm5wh6U/CL3+UsqDkeLp9AxZA36haIBWy+bhVnMRDWnr7030vnxbq9nAzbm5tqv
	 SqbZF6v9WIHSSbmIQ0Q4fL1aQickFVlw2/JT5gyzjJv3nuHkc1Ce/GzRTetn+7Ytjp
	 uGB3o55UR/+4uMQTh1A5EH9GcmGgwW0VtvaeQ7ZWalBJwzjTNp/vzuqWNVDXjAPBXM
	 2rjzig29Cl/2PLP8UfN0R5Nv/Pat5+7hC+xtIIzyWtJNWKC+5zi9rEtyDKhYwFdNbT
	 EwN2skM936VVA==
Date: Mon, 29 Apr 2024 06:42:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <shiming.cheng@mediatek.com>
Cc: <willemdebruijn.kernel@gmail.com>, <edumazet@google.com>,
 <davem@davemloft.net>, <pabeni@redhat.com>, <matthias.bgg@gmail.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Lena Wang
 <lena.wang@mediatek.com>
Subject: Re: [PATCH net] net: prevent pulling SKB_GSO_FRAGLIST skb
Message-ID: <20240429064209.5ce59350@kernel.org>
In-Reply-To: <20240428142913.18666-1-shiming.cheng@mediatek.com>
References: <20240428142913.18666-1-shiming.cheng@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Apr 2024 22:29:13 +0800 shiming.cheng@mediatek.com wrote:
> From: Shiming Cheng <shiming.cheng@mediatek.com>
> 
> BPF or TC callers may pull in a length longer than skb_headlen()
> for a SKB_GSO_FRAGLIST skb. The data in fraglist will be pulled
> into the linear space. However it destroys the skb's structure
> and may result in an invalid segmentation or kernel exception.
> 
> So we should add protection to stop the operation and return
> error to remind callers.

One of the fixes you posted breaks the

  tools/testing/selftests/net/udpgro_fwd.sh

selftest. Please investigate, and either adjust the test or the fix.

