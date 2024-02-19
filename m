Return-Path: <linux-kernel+bounces-71642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678F585A83C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 082EBB24C85
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC643D56C;
	Mon, 19 Feb 2024 16:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oraUqvh/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694473B79D;
	Mon, 19 Feb 2024 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358907; cv=none; b=qk8yHIxtG5IaF19z0ONN6Q6wAIcc6hxdssI0OLNElnoRocXT1oLX5y142XTkpqxjZMwods7K47CNhjNMmrzdrwbOufM+wj1PdFA6VQcduCQf2/OTql7M5PabCxzsJDlGbeZMgUuFbpfmh9FqlN9lCkFZYiB7usLxpEpEVCffqLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358907; c=relaxed/simple;
	bh=w5zyWB0zCqUq5ura4kPaJjtdUevtDVevxgEmY/Ns0J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+VxS0u9fh4dM6+CMdACsotEL/6nTLvau4MNRLFDLAjXbeaS0PVe8zmPWX5esau8yiD/UgRu3zrLxzBBb9amq9Uo25sokrWfBIanTk2S/2J1y1xzrQ78MkxQtE+JLkLBRI/dDYYO02x7Fbj9U/D43qbmAUPo7ShCTG2O/6tofPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oraUqvh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5046C433B1;
	Mon, 19 Feb 2024 16:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708358906;
	bh=w5zyWB0zCqUq5ura4kPaJjtdUevtDVevxgEmY/Ns0J4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oraUqvh//OrA+nxEoztgmnAS+4ohUmYxlaCY1rqD8oC8cBSOYiKU8RHTdk7Fz8zUH
	 p2MCufGHuJ75baRx8RxloHqcobppPB9VCxs8V5DVo82t4iQL8k+MDizJp2cCicC6aL
	 dIyEb0cpNBSpucJ9iJLcOqFwn/dX/ani86me9QQItwuEG6URVcyNqwqV3IvkSqY7G8
	 llLd5YAwtkqb8EZ72SUn/Fgc5TrUx1vClozODBhUkFPqkMFwxBe/EBAAZ/55Yz5L6P
	 /1+VRVVUkVap4fXEhq+21Qy82FclEEF+9w23gP1EsrQpdZ28sZyqalNxj/H7FOOHDU
	 fK6W0vzJBMCgA==
Date: Mon, 19 Feb 2024 16:08:22 +0000
From: Simon Horman <horms@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mac80211: clean up assignments to pointer cache.
Message-ID: <20240219160822.GF40273@kernel.org>
References: <20240215232151.2075483-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215232151.2075483-1-colin.i.king@gmail.com>

On Thu, Feb 15, 2024 at 11:21:51PM +0000, Colin Ian King wrote:
> From: Colin Ian King <colin.i.king@intel.com>
> 
> The assignment to pointer cache in function mesh_fast_tx_gc can
> be made at the declaration time rather than a later assignment.
> There are also 3 functions where pointer cache is being initialized
> at declaration time and later re-assigned again with the same
> value, these are redundant and can be removed.
> 
> Cleans up code and three clang scan build warnings:
> warning: Value stored to 'cache' during its initialization is never
> read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@intel.com>

FWIIW, these changes look fine to me although I might have split the
mesh_fast_tx_gc() and mesh_fast_tx_flush_sta() changes into different
patches as they seem to address separate issues.

That notwithstanding,

Reviewed-by: Simon Horman <horms@kernel.org>

