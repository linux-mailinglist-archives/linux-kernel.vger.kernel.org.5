Return-Path: <linux-kernel+bounces-10755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7378281DB4F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 16:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03321281898
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 15:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F535748A;
	Sun, 24 Dec 2023 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUVI7Mfz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0FBC8D2;
	Sun, 24 Dec 2023 15:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B78C433C8;
	Sun, 24 Dec 2023 15:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703433102;
	bh=a8AVVMA9i8/vIRkHwBif/ih1iJwLQCXmGBNA6/LCdO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dUVI7Mfz84DXVBs41CT4Trzet+epNbKLETOcL/fBrzxi7aOSIlalfRJbkfqvP+qwu
	 8QTyN21Ignp0QH0w/zyiZ9G1T2udtO/2Xgx00nTHN/dyVUdwjaibalj11WtL5q7b2a
	 +csyz8RZzr6qfK/xRRs+lC3rnRcIsT0fD3SyorF31VUXrLk8wJJ8P5xugCms1TOeIt
	 x7teiy/vpJf3QO1uBYs2HagMrAtCXWFU/QeDeIhmqkR+GF4X4G3lBcW3TvEi/yEypT
	 nGA8e8lQRsaMDzUfklZ+OLsv84k7F1xHr15QIFg7e6flOCkXfYTO6bM21VycgThXXJ
	 vL49EvioitnSA==
Date: Sun, 24 Dec 2023 15:51:38 +0000
From: Simon Horman <horms@kernel.org>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Edward Cree <ecree.xilinx@gmail.com>,
	Martin Habets <habetsm.xilinx@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] [v2] sfc: fix a double-free bug in efx_probe_filters
Message-ID: <20231224155138.GA228041@kernel.org>
References: <20231222154952.3531636-1-alexious@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222154952.3531636-1-alexious@zju.edu.cn>

On Fri, Dec 22, 2023 at 11:49:52PM +0800, Zhipeng Lu wrote:
> In efx_probe_filters, the channel->rps_flow_id is freed in a
> efx_for_each_channel marco  when success equals to 0.
> However, after the following call chain:
> 
> ef100_net_open
>   |-> efx_probe_filters
>   |-> ef100_net_stop
>         |-> efx_remove_filters
> 
> The channel->rps_flow_id is freed again in the efx_for_each_channel of
> efx_remove_filters, triggering a double-free bug.
> ---

Everything below the line above (---) will be omitted from the commit
message when the patch is applied.

> Changelog:
> 
> v2: Correct the call-chain description in commit message and change
> patch subject.
> 
> Fixes: a9dc3d5612ce ("sfc_ef100: RX filter table management and related gubbins")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

Hi Zhipeng Lu,

I think that your Signed-off-by should go last when you post a patch.

And the Changelog should go below the (first set of) scissors (---).

> ---
>  drivers/net/ethernet/sfc/rx_common.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

With the above in mind, I think you want something like:

In efx_probe_filters, the channel->rps_flow_id is freed in a
efx_for_each_channel marco  when success equals to 0.
However, after the following call chain:

ef100_net_open
  |-> efx_probe_filters
  |-> ef100_net_stop
        |-> efx_remove_filters

The channel->rps_flow_id is freed again in the efx_for_each_channel of
efx_remove_filters, triggering a double-free bug.

Fixes: a9dc3d5612ce ("sfc_ef100: RX filter table management and related gubbins")
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
---
Changelog:

v2: Correct the call-chain description in commit message and change
patch subject.
---
 drivers/net/ethernet/sfc/rx_common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
pw-bot: changes-requested

