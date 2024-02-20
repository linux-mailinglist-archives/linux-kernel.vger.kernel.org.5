Return-Path: <linux-kernel+bounces-73065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D9085BD02
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82E632867BD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96EB6A343;
	Tue, 20 Feb 2024 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/ezfS8Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397C469DE4;
	Tue, 20 Feb 2024 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708435128; cv=none; b=HA0DYSLoj2NgJrSl6vGbzYgqvO4tEUkPLj0jTOdAmzzR845kOWv0lQ51xKrMLm1EDRjJA+rj3BIqlpREaSbdyO7nOmNMCwb2fSk1LuD8dvYQBAHwNTxQNn0vBxUZOr7fvzbLLfkJzVktFwnzuKLJE0ShTBSsZys+WB/3Ki16Aoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708435128; c=relaxed/simple;
	bh=RZZk0PE0TiY7k+x5DBdvarX9mRIKYJiIQkRfbPjIlbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwUPqdcpcThz72IB7QEzb+HiXlsI6Dh5gCC+jwL6OMNQakYQgCirfBTVoi1WC10bR+vQguzeYtLYkenmmCaiJhT8WB3m+lE8D3uTJC80qjphegp+Zh2xqbCcUUSdQYtw9DPxnYB4suz/Ih6TtoNlg3eKFxQQDuhvwdt3znKWvkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/ezfS8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F78C433F1;
	Tue, 20 Feb 2024 13:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708435127;
	bh=RZZk0PE0TiY7k+x5DBdvarX9mRIKYJiIQkRfbPjIlbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V/ezfS8QpHqQymbTzuh8+/2ORCPdvgXTC8pBg0PQL7ijM5+4ScTS3/lVUXCZhAitq
	 JIs3Hz5pToRl9TbqMy8zv0uG/dzFhxwwBKEP5zGBge6D3rVrXGokcR/7hAfZYY3Hq0
	 HbwkJ/alhGyXsvNNwtvYl6yoM+0yVX6rgcKh8K08utKyEBspi/ibqgib2HwtjDYhmy
	 mAW1ZMWEgIefdfGc/ZuBPhWqtIkAwnkvqhGpOG6vbIWJCxFOPoz6B4T6clvOQoKDn8
	 k2Xeq4WixppjT91HaUTwfKkZNJMimrc5gvZ0IHrn6zsKeYfNIJID1qIScVdx2h2FOO
	 7e2h4bmLGr4PQ==
Date: Tue, 20 Feb 2024 13:18:44 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/dummy: Move stats allocation to core
Message-ID: <20240220131844.GJ40273@kernel.org>
References: <20240219134328.1066787-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219134328.1066787-1-leitao@debian.org>

On Mon, Feb 19, 2024 at 05:43:28AM -0800, Breno Leitao wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core instead
> of this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> Move dummy driver to leverage the core allocation.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


