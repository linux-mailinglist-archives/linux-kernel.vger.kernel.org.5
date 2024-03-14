Return-Path: <linux-kernel+bounces-103692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EA287C30D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259211C219A2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA5276048;
	Thu, 14 Mar 2024 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgvF2cyB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D0873509;
	Thu, 14 Mar 2024 18:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710442197; cv=none; b=dnl0WZY1BGUQufqKISVR+Aq6uYhnalu22DhdmaT1/mtrjRouDg0s0AJSprMcxWQzZDXEQHKB9NB4lgQJEvzxWI9qm9ckAm3+zHrBEBCVvbTVWqvSKhwvxQZCIU1Yq8ieFYJjdD2Ugi0BnFPr3f7xpbYI+xzmmLxX+EqiWcRSxNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710442197; c=relaxed/simple;
	bh=pb0vIzbYslsxt10rHOb4hxaHicDLWDRrEaXbbtynnbc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VTfBLu0BE6MELs6b41hFTzQDoOgir7P1UetQpjhSLkmrMnA2iEqX/lTEDH8RAi9c30z4gE8L7vSSDs9Rx1ZioJ/pYPUPF79rofISRZxgcR7HnKCDh83GXFPpcCxRwpP02e4TxcTVJksPlO8dg4qyVTtiZyVe6zHlNG3uc/kTyA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgvF2cyB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60025C433F1;
	Thu, 14 Mar 2024 18:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710442197;
	bh=pb0vIzbYslsxt10rHOb4hxaHicDLWDRrEaXbbtynnbc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FgvF2cyB2dEhOJQTo+BV/LtO+QYJphhNwiRl9EzUgEmZhyEk6Cw+cRAj8HoVpHJ3u
	 Bmg/byQz3KLSQ+8ztBi850ll+ahOLJ1795tY5/bwSVI8FDBXQGrpsWu7LKbai1nVwO
	 PC61SeYguFEfd6DMInUBougdHgVtVXQ64fOoQDxv8MO3j/BH4WdgANoYn1YuLLFWrU
	 Yu85fX5ZHmoU49tLjwI0g5pBMLraI81TktYDBu5Af6BE6kZceKJ/d7kWKX9T/5pvuv
	 qSjxq5Lj1lIUuDlNyM/51f+J9MimnnN2U/Go0ExDFeS27ewuXiTGua/+5KC/YpbGuK
	 PL7lnyJ31C6Ow==
Date: Thu, 14 Mar 2024 11:49:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: "David S. Miller" <davem@davemloft.net>, Tal Gilboa <talgi@nvidia.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jason
 Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>, Jonathan Corbet <corbet@lwn.net>, Randy
 Dunlap <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, Breno
 Leitao <leitao@debian.org>, Johannes Berg <johannes.berg@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev
Subject: Re: [RFC PATCH 0/2] net: provides dim profile fine-tuning channels
Message-ID: <20240314114955.71ada20c@kernel.org>
In-Reply-To: <1710421773-61277-1-git-send-email-hengqi@linux.alibaba.com>
References: <1710421773-61277-1-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Mar 2024 21:09:31 +0800 Heng Qi wrote:
> The NetDIM library provides excellent acceleration for many modern
> network cards. However, the default profiles of DIM limits its maximum
> capabilities for different NICs, so providing a channel through which
> the NIC can be custom configured is necessary.

Given that DIM is currently enabled and disable via ethtool
why are you putting the API is sysfs and ops in ndo?

