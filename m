Return-Path: <linux-kernel+bounces-111443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6AF886C72
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0671F22FAE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA284595B;
	Fri, 22 Mar 2024 12:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYOnqs3X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5585F20DDB;
	Fri, 22 Mar 2024 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711112252; cv=none; b=eo3gtzWbc+3CGWl9hwH80+zNC7Eny8XskvDLHpXXuqPlmTwXiviZXvjeN5YcZk1hQgLJUoRoHVNfBqP6UjM2gFcdPiKaQzQAI2lJzYT6Y3dHVsKY5Y/8zYb/LFpWIU4x6qLzSSSpESNT6/398EMbFte7dfjRcjcYgykosCXEM4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711112252; c=relaxed/simple;
	bh=vi6qepP3WZqihtomx/Ad9yWtRNe/QyPnUUouWN8vfoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+Xx9z95nP8yTKu7kPKX1rTzd8Qyh6dGfYZdDZL5p4ME5nvjV40BzPAxf2WoXMCR1r4xWOJU7ZdYV29OpfSciCcepSLWpRtF/7H+AWR/pucz4e2dzLtIX4DMQbApmnJnqbmpZcP/qLhKXQb+dvoStgJ6Y8C8aAq6ChXCAPJOEe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYOnqs3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3C3C433F1;
	Fri, 22 Mar 2024 12:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711112251;
	bh=vi6qepP3WZqihtomx/Ad9yWtRNe/QyPnUUouWN8vfoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mYOnqs3XbPZ567x2XcqYUCB8z7YM6n71i0LA+G1lsomcgE09dZnAsQ5/jnVOTis/+
	 RPvyII8VqC0yle9uD7ZI419zJtCNjPgh2PUXSiKJa6Ta6yS7/N3S6qkotXWZpmYiaz
	 ppB5rTjd2bgLZ0m95ihhxh1d4FPmSMv95QhZaPRoxFx9kfF/ZQNmP/sejCpxpxZTKH
	 Ma1dDeNOZD/KjfsULlkpWSYR7ICpajzsaCRnPE6iAFhSyZzf5lcP9KnPGqq1J9QFaF
	 lFRUdJHIeZy5ZsdhHsNZBIgz0JCqnnWZKZ2v1ra6cd3Grj9LXoI4gMoFBUQoNJv0Ak
	 YtYq2gOuwo3Qg==
Date: Fri, 22 Mar 2024 12:57:27 +0000
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 net] ice: Fix freeing uninitialized pointers
Message-ID: <20240322125727.GE372561@kernel.org>
References: <0efe132b-b343-4438-bb00-5a4b82722ed3@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0efe132b-b343-4438-bb00-5a4b82722ed3@moroto.mountain>

On Thu, Mar 21, 2024 at 05:42:12PM +0300, Dan Carpenter wrote:
> Automatically cleaned up pointers need to be initialized before exiting
> their scope.  In this case, they need to be initialized to NULL before
> any return statement.
> 
> Fixes: 90f821d72e11 ("ice: avoid unnecessary devm_ usage")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: I missed a couple pointers in v1.
> 
> The change to ice_update_link_info() isn't required because it's
> assigned on the very next line...  But I did that because it's harmless
> and makes __free() stuff easier to verify.  I felt like moving the
> declarations into the code would be controversial and it also ends up
> making the lines really long.
> 
> 		goto goto err_unroll_sched;
> 
> 	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) =
> 		kzalloc(sizeof(*pcaps), GFP_KERNEL);

Thanks Dan,

I agree with the approach you have taken here.

And I apologise that it's quite likely that I skipped warnings regarding
these problems when reviewing patches that introduced them - I did not
understand the issue that this patch resolves.

Reviewed-by: Simon Horman <horms@kernel.org>

