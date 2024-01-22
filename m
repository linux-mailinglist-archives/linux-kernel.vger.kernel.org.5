Return-Path: <linux-kernel+bounces-32865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C407836118
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800581C25CD9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2E13CF65;
	Mon, 22 Jan 2024 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuKILk40"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A183CF48;
	Mon, 22 Jan 2024 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921645; cv=none; b=sKnU60iMy39aGKzswZFiuwQEZ1GUuCcfBiPLHqEotDBo9vSvGbD8oiqh52m2XtlTuHHqHtpCQgQKBxOwta00X7oDQwrgNrIjAGosoguhRhY3yMCiXbE16CbGOdK9Rb838Ws3BvSlJUyegY3WcXdmqyzkSs2Fx0X1GQjQN6uN8as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921645; c=relaxed/simple;
	bh=5gE+Km5fi/TLlf+ZbAr7bjFoCBGdCvtbA843YDHnPdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiroNK3NezJuHeUJinKpG5DBPBiVUF7JhU0RJUpGR/PkewP3d6VGyDO5lcMg7NuH69i1hQpYYqHRdXm6F92eHWHrj/txxjYKZWZuWo26xS9KVfxHlw2bv9ov4MTVCQiDJmlqsxOo0bgl29Zs6lWjpoB4AiGY+URbUdRgU89SYQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuKILk40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B4DC433F1;
	Mon, 22 Jan 2024 11:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921644;
	bh=5gE+Km5fi/TLlf+ZbAr7bjFoCBGdCvtbA843YDHnPdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IuKILk40lppFwkQ3einuh+aBf9EHDFc+HzB4nd9+TtD9RD8cFXoLb9uH0b4wcO+l5
	 ZgLolbB4kBvfbwMSNrdrt/DX6AdvlyCth5hF6iWkiIlyoyIRSFCRRp25OxYZNLH3y+
	 hS6J8bEWWqa7aGoYc/N0uJ5A58jQBo7moXbm94fXOfi+eVUfAEAHY2Rr8blocQIcsO
	 ajf6rqjrYgNlqJcKQ4SMOOBsFcXbNNRAsSAo+eNg6ghbMwFRi9I2q34o76bh7w4Q7n
	 VTvdOtNITDJ0/WmwMVcBlOzG7leefF8TlyW8g72DnSu42/vcq2xUuXF7Zzg8g9L7g8
	 KhDKkzWdD59sA==
Date: Mon, 22 Jan 2024 11:07:19 +0000
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Mark Rustad <mark.d.rustad@intel.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] ixgbe: Fix an error handling path in
 ixgbe_read_iosf_sb_reg_x550()
Message-ID: <20240122110719.GC126470@kernel.org>
References: <d39bbffb8817499cc2ae636cdef3b9c1eba59618.1705771534.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d39bbffb8817499cc2ae636cdef3b9c1eba59618.1705771534.git.christophe.jaillet@wanadoo.fr>

On Sat, Jan 20, 2024 at 06:25:36PM +0100, Christophe JAILLET wrote:
> All error handling paths, except this one, go to 'out' where
> release_swfw_sync() is called.
> This call balances the acquire_swfw_sync() call done at the beginning of
> the function.
> 
> Branch to the error handling path in order to correctly release some
> resources in case of error.
> 
> Fixes: ae14a1d8e104 ("ixgbe: Fix IOSF SB access issues")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Simon Horman <horms@kernel.org>


