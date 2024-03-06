Return-Path: <linux-kernel+bounces-94504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD368740BF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7CC2866ED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED66E140E29;
	Wed,  6 Mar 2024 19:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7Zs7EkJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F04D13E7E7;
	Wed,  6 Mar 2024 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709754505; cv=none; b=VeUxEQRh//uPwkHn8nNLYFsBGqNjAhfaP+Ig6HfZpHSwSVL3Jb4ca+C6y+qprmScc0Q+EBn3/GV9AkfdVkYf+Jkh6OfFwIX20I+hGiflqwBUAPm4O3O3ezCed76DQr0OyA3yQgqioZdYAWeVoBNIuNX8DMZg0s19XGvEtw5Wt5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709754505; c=relaxed/simple;
	bh=4ROU/p+RnoKxYsR/Fiit5nIVZTuetST5QP62nYaBqXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/1OkDQJvtDvuIWbONcY96vO2/MYmjN1ynHG8xyhjrUyFr2HbcW9U/fyzcyKrvn3hUm6VHz+yrJjj44sWnzmnpPmXik0W4CzCTDYxXjs7ZyUExoNtCqEEoS3+MN3sEtXVYLauDKV//mBOc8SIpfG/RffMST5GZ0OCfaUXaivlbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7Zs7EkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D0FC433F1;
	Wed,  6 Mar 2024 19:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709754504;
	bh=4ROU/p+RnoKxYsR/Fiit5nIVZTuetST5QP62nYaBqXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H7Zs7EkJ03wgArZOVfU4XHpkYAsCAYHBIhU1HvQM1iGf2SCgwkOS+n5by+99rH8HG
	 YYf7Jzw5RE12n3X01wS1GtrStueZ8bvC09OZbHMIjfZmqad4pjA8ImZ1c00b1ruRZs
	 o2kp89ntd7j2o3vJXi3FHdBxNDCIS91e7qWfZL7EDFpC2oiNmXhsCa/EkFp7J3JRfb
	 EuUXOGvdfjHmwV7eYZ+5jc5Byi4efRZd31RgJcXVRU+jSMisQ2+oEkv0X519rD0GWZ
	 SU5kk8vbRxLXXMn0CTcfwLU/W8peCnL555j0KwvYEQYvq7BPB98bAySOQM0WETMXi8
	 gTFsPO842KPkg==
Date: Wed, 6 Mar 2024 19:48:20 +0000
From: Simon Horman <horms@kernel.org>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sgoutham@marvell.com,
	gakula@marvell.com, hkelam@marvell.com, sbhatta@marvell.com
Subject: Re: [net-next PATCH] octeontx2-pf: Add TC flower offload support for
 TCP flags
Message-ID: <20240306194820.GC281974@kernel.org>
References: <20240305181606.244208-1-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305181606.244208-1-saikrishnag@marvell.com>

On Tue, Mar 05, 2024 at 11:46:06PM +0530, Sai Krishna wrote:
> This patch adds TC offload support for matching TCP flags
> from TCP header.
> 
> Example usage:
> tc qdisc add dev eth0 ingress
> 
> TC rule to drop the TCP SYN packets:
> tc filter add dev eth0 ingress protocol ip flower ip_proto tcp tcp_flags
> 0x02/0x3f skip_sw action drop
> 
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


