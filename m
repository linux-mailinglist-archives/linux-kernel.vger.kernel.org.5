Return-Path: <linux-kernel+bounces-97763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CF7876F13
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 05:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F347282560
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 04:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8FF364A4;
	Sat,  9 Mar 2024 04:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqdGkETW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998F516423;
	Sat,  9 Mar 2024 04:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709957146; cv=none; b=KOynR4yFkxzQ/Sws5e9QxS7ZR93dOC2etcbw3w5ldIDuGIL4DEgnFr2p3vYFONejDWMTVMsL1Wb3ji0FxwXIz4ec5Pm7Y4F3scyJC1XeTv6mDqmXVf0Kg6hwwKmDZGAzuli5//Ve6eRtiTTJMIGr9kScDCmppCKqv62tG+XIcMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709957146; c=relaxed/simple;
	bh=/tmyKSiu5FPQ1u4wgG/x5qvkp5nypX5JxvMrTuDSWco=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qb31IMm45XrRIZxPpFr8bPwVxRqhEbQvh62fp4uXtxnb3djUdaOV7DkvJi3afhBZsxCXsBbrZr5WLiUcydYyr2lmwCmzEMeQ/chgqhJ2pSFD3OwyEKVqgR7Z3Q3ANH2IIWuHamsv05Yi2aCCOB4uGYdeldLQl2Fg9fRPlTfXFxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqdGkETW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D89EC433C7;
	Sat,  9 Mar 2024 04:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709957146;
	bh=/tmyKSiu5FPQ1u4wgG/x5qvkp5nypX5JxvMrTuDSWco=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GqdGkETW6sZzP6Y+mf+bcDa7qnzOkH1lb3Grx45Brcy//Yb2Ijvt7zrJTBqNnpDf5
	 OueGRJ5hBAfgovN6oaGrCAdyG023bZpZPRCpXgVnJSbW3D9IXF+M8DOVaDydyALFbc
	 wEJ/TDuvlzEpWeQTlomr/aCqsRK8pZXDB0zBxpIv7Ted3GI6qV+vs8xmhQhcGMC0g0
	 GOiFQN4X0RawHdAZLYmKv4c9tPOSdsEf88Ohe3gq9z9U1SVE2J4oUIUOEZo60D3qJX
	 rG0pGkj/3l1niodvwHQlTL0dJZrefv+OuRpnXrQUMevSWGbKVQBsZ+FBWO2FMZhwvp
	 WaHVbPdSEDPNw==
Date: Fri, 8 Mar 2024 20:05:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexander Duyck
 <alexanderduyck@fb.com>, Yunsheng Lin <linyunsheng@huawei.com>, David
 Christensen <drc@linux.vnet.ibm.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Paul
 Menzel <pmenzel@molgen.mpg.de>, nex.sw.ncis.osdt.itp.upstreaming@intel.com,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 0/8] net: intel: start The Great Code Dedup
 + Page Pool for iavf
Message-ID: <20240308200544.42fcb93e@kernel.org>
In-Reply-To: <20240308141833.2966600-1-aleksander.lobakin@intel.com>
References: <20240308141833.2966600-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Mar 2024 15:18:25 +0100 Alexander Lobakin wrote:
> Here's a two-shot: introduce {,Intel} Ethernet common library (libeth and
> libie) and switch iavf to Page Pool. Details are in the commit messages;
> here's a summary:

/scripts/kernel-doc reports some issues here
-- 
pw-bot: cr

