Return-Path: <linux-kernel+bounces-137763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED47A89E6CF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A1A2282C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C2128F1;
	Wed, 10 Apr 2024 00:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="th19fEtI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638D81C2D;
	Wed, 10 Apr 2024 00:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712708764; cv=none; b=UL8UHGxjHkhDw7v8EEPMJ64eGq08Vx/aKdlK33c+6Alte0i0wlem8VTCE2PVr4E+wB2g8BmtyWu3r5SokglfFmc2cvrF3hL6Y8YeKY8rXpfqiWS0fuSWgxmpswy6hivxHMBiQ3i5imThq2nCzrxBur0YBXhj1e/rgWx600I3fFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712708764; c=relaxed/simple;
	bh=mZzCVN2DJvyCXQkJ8KuHCAYHlb91LAyKGFIouebzzlU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HfyD3IIt9hHUP4PBoWfpcMRH90thvJ609aPdBSr6HUymeNtBS89C6g4JgPMMrWcke6t8uBu9JLEB3XGw5nt16SfZ6D8AkSpiL2Sl6072LzkSBn2sP4FzqVVDSlqk8OjB7HM6w8+6bIqPMt0MjVzEaEGBVp1jf0qHpsel27k6ql8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=th19fEtI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A633C433F1;
	Wed, 10 Apr 2024 00:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712708764;
	bh=mZzCVN2DJvyCXQkJ8KuHCAYHlb91LAyKGFIouebzzlU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=th19fEtIHnDgpF2lpuWIpG73KUbbQv/uCyAd0x4w8cmHtUT2VY2320pPMVeGzaV8x
	 QLQgSBf/sCSUdwBpRyTG0O1ZhRgzEnNlhiNUy+qY5/PpnN/b6bJbhF5obc9zwdnLnM
	 4EuCSAh7xkQsp5rocsvnTVYO9lzJciFZDFwwNo642zHK0m83OUjxaly0UT1vbqhxlq
	 0MziMNVvenNotRa5HPyqvryf7o6KVJpgq/d3Hrwca+9xktTlaZzWRKiWF7+9uWx+4v
	 9Ab+Rfsgs7AQ4EGE9MfIotoKuQePe9WlRHxh1uHv3rfaLlLngcX368OTITZzEE4HpN
	 L/D1j4F9/2tlQ==
Date: Tue, 9 Apr 2024 17:26:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: John Fraker <jfraker@google.com>
Cc: netdev@vger.kernel.org, Praveen Kaligineedi <pkaligineedi@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>, Shailend Chand
 <shailend@google.com>, Willem de Bruijn <willemb@google.com>, "David S.
 Miller" <davem@davemloft.net>, Junfeng Guo <junfeng.guo@intel.com>, Ziwei
 Xiao <ziweixiao@google.com>, Jeroen de Borst <jeroendb@google.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] gve: Correctly report software timestamping
 capabilities
Message-ID: <20240409172602.3284f1c6@kernel.org>
In-Reply-To: <20240408180918.2773238-1-jfraker@google.com>
References: <20240408180918.2773238-1-jfraker@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Apr 2024 11:09:01 -0700 John Fraker wrote:
> gve has supported software timestamp generation since its inception,
> but has not advertised that support via ethtool. This patch correctly
> advertises that support.
> 
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Signed-off-by: John Fraker <jfraker@google.com>

I think it should be a single line diff:

+	.get_ts_info = ethtool_op_get_ts_info,

right?

