Return-Path: <linux-kernel+bounces-2237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05550815A0B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B91285CF9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 15:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBC030346;
	Sat, 16 Dec 2023 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0dROIJj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F8830645;
	Sat, 16 Dec 2023 15:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F6DC433C7;
	Sat, 16 Dec 2023 15:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702741909;
	bh=wd8SoMHo9vcCJBA3pnqCM0GFhG9SQ0ZhY2DAQmgP/Y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d0dROIJjnwaWzSAw7cPz5DLrL75krNmKWWLr8s5w7inHmFTuJBzUTAFf6Y+SRvB5X
	 7GpZ1AMo9ncruwQRMbKaOW1yqjPq5BAvZO+PIEmGqlXHaehJ8mjtlokOgzkNIVki3l
	 dnQkZGLseq1aBUhELiVwgiey0jk78cv+kUnmdCN+JqaMAOJSID2zMoyLRecb4MJUH0
	 a0/2jmKSj4Z2wNJalA00ks4SZfMmevOcIWcCH7Wy9YqtnaKJ4Qv4yM5mtZkFjrjx5c
	 JoWWpEj7Q4EAG2aA1fh+rLpmrYS7Hs3mKaMXovkIZlld3ZMeDzF+VSnFH0UlM5FLsA
	 UKDF1YJt4rG9A==
Date: Sat, 16 Dec 2023 15:51:45 +0000
From: Simon Horman <horms@kernel.org>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Edward Cree <ecree.xilinx@gmail.com>,
	Martin Habets <habetsm.xilinx@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sfc: fix a double-free bug in efx_probe_filters
Message-ID: <20231216155145.GN6288@kernel.org>
References: <20231214152247.3482788-1-alexious@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214152247.3482788-1-alexious@zju.edu.cn>

On Thu, Dec 14, 2023 at 11:22:46PM +0800, Zhipeng Lu wrote:
> In efx_probe_filters, the channel->rps_flow_id is freed in a
> efx_for_each_channel marco  when success equals to 0.
> However, after the following call chain:
> 
> efx_probe_filters
>   |-> ef100_net_open
>         |-> ef100_net_stop
>               |-> efx_remove_filters

I think the call chain may be a bit more like:

ef100_net_open
  |-> efx_probe_filters
  |-> ef100_net_stop
        |-> efx_remove_filters

> 
> The channel->rps_flow_id is freed again in the efx_for_each_channel of
> efx_remove_filters, triggering a double-free bug.
> 
> Fixes: a9dc3d5612ce ("sfc_ef100: RX filter table management and related gubbins")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>

The above nit not withstanding, I agree with your reasoning.
And that the problem was introduced in the cited commit.

Reviewed-by: Simon Horman <horms@kernel.org>

...

