Return-Path: <linux-kernel+bounces-75347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC58185E6FB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22E6E1C24661
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B5585C42;
	Wed, 21 Feb 2024 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0EFue7k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ABE53E0D;
	Wed, 21 Feb 2024 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708542742; cv=none; b=ks4+Feql7ac70frirMcJVGUHS7szDLBTbeHD/bHceomoisydTNMrHirMLAetQxTdjE9M95qX0dXYEkAnE5PoXnxPZBGKAaEGjUwGJgR3JGx3UpavBMDXiNpx3vo9acOhvkhFAariU5nHXnDWc53meBCeLXO+qShSkVALix5+zfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708542742; c=relaxed/simple;
	bh=HbFX41l2n6H1gMRIKPuLIsTT8B4OgQtH1R+ivawPBWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iKNQFxCMchv2AYXcpSMVZdZdWoJkKyrXtzn/CaGA+0eBXHC2Mw6X1jUtXoVFPcBSIl1Vgt1abzXo0Ymr9efoQVXiL7h9XPIWrEIopj4yq0VhxP6L8F5Z1PZa36iiLo6iV3eRb98KOuz2/DhH8lEuiCNjcxiGvQb4oZrr8pLTqLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0EFue7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2036AC433F1;
	Wed, 21 Feb 2024 19:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708542741;
	bh=HbFX41l2n6H1gMRIKPuLIsTT8B4OgQtH1R+ivawPBWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S0EFue7kFEUdqIvWdAj5WZ8oaEIpQXve75p0Zp39wv9G/XhchXr/uQZr3WY99YfJI
	 DU9iUpuhYff+nYgZr+aTdbwWvLCJi/8dwuZQgf8fisNaceBFs7LFDgSRgX7grUSzJ8
	 PfW6dfYBsXDKhejCEZQ1BNmRhYti8ZGdwhpd1ClQJiwkODxRElKapuYyALdMt9eJuu
	 WrAQsZQ6XqKOnF0ZiA0VQWqstIp0WUvg0Yq1/Or3+jLVkIszTkhhRyvN8ZerPKb1Kr
	 gFA18LXZSoclHF9qXjC6nnr81I8+ZHkaYbNq5jt/5gSW20NYZ6kxMg6v0LNkRbxsOd
	 zKo4SZxW68pTQ==
Date: Wed, 21 Feb 2024 11:12:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Sridhar Samudrala
 <sridhar.samudrala@intel.com>, Alexei Starovoitov <ast@kernel.org>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH net-next 1/2] netdev-genl: Add ifname for queue and NAPI
 APIs
Message-ID: <20240221111220.4e6b6170@kernel.org>
In-Reply-To: <1708531057-67392-2-git-send-email-jdamato@fastly.com>
References: <1708531057-67392-1-git-send-email-jdamato@fastly.com>
	<1708531057-67392-2-git-send-email-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 07:57:29 -0800 Joe Damato wrote:
>  	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_ID) ||
>  	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_TYPE) ||
> -	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFINDEX))
> +	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFINDEX) ||
> +	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFNAME))

This means user always has to provide both ifindex and ifname,
right?

