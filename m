Return-Path: <linux-kernel+bounces-109624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060FD881B89
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 04:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3CC9B21D55
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D24B66F;
	Thu, 21 Mar 2024 03:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyeHGcVW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2739455;
	Thu, 21 Mar 2024 03:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710991758; cv=none; b=fbZL4G4SBP0GQbkFihXcp9nkc8+rZt2NIn5tQNtnyFdin0WunSciK7pqvKFzLe7zC72osGflsdAc+SQnWxVOIyf7Tgm4GCIJb8RieQyU5GIxVVN4SyEjfqBCo7qBvMP49Xo77gZZsl4/7A51aRN8boqf1QngPnCkuiG8zlf3VRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710991758; c=relaxed/simple;
	bh=AndrSsRlqw/W3pe2hOtcA+x3b9aKANapvXbBK9oocR0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXOY3lxNBmCdR77XfV1shtr6SDQxI/URKUHgHzEfe8ctpbJrKnS0ZYdPgKLfkMgtUSRO50BX7a3Cd3EowGSDlAmAh922AX3AXajMqn4xnHSX3gpp3N+9CFdp0Z5nNoL57aEFrF4O0RuVjfxMevDu676Yu7i4tksLpWjm2Jku88A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyeHGcVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A8CC433F1;
	Thu, 21 Mar 2024 03:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710991758;
	bh=AndrSsRlqw/W3pe2hOtcA+x3b9aKANapvXbBK9oocR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OyeHGcVWPFs5jA4jqo37nPwn0hPr4JaN3Tk9M97jdrF1Ew6O1kaC8D7ZDTAE5Z403
	 GDPKM4sMWJUrachr1ZouLRAwbI1VUoef22cCmIzAJNN2bDXSg3VJI2lSqN6f8b3GdY
	 iuvnuhitVAge5QJNdD46qatqfWY+7FQeyb+JiFT6fBfqatpoB+k2MKrmbGNP7PeN3y
	 QnEea0YPBxvhRQUUy4Yqf2XCOFbXwo0NV/NGGf6uZ4JBDlgpmaunLjgXLCaF0bF1ba
	 azYkWxrcD9eL9ImsxJT7eHcQwHE4Bvk1STDgkTmilGmDnFULbc4mZaMXW2pPP2Dn4z
	 76vwdGIAeT86w==
Date: Wed, 20 Mar 2024 20:29:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] ice: Fix freeing uninitialized pointers
Message-ID: <20240320202916.2f2bda73@kernel.org>
In-Reply-To: <facf5615-d7ac-4167-b23c-6bab7c123138@moroto.mountain>
References: <77145930-e3df-4e77-a22d-04851cf3a426@moroto.mountain>
	<20240319124317.3c3f16cd@kernel.org>
	<facf5615-d7ac-4167-b23c-6bab7c123138@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Mar 2024 08:01:49 +0300 Dan Carpenter wrote:
> > This is just trading one kind of bug for another, and the __free()
> > magic is at a cost of readability.
> > 
> > I think we should ban the use of __free() in all of networking,
> > until / unless it cleanly handles the NULL init case.  
> 
> Free handles the NULL init case, it doesn't handle the uninitialized
> case.  I had previously argued that checkpatch should complain about
> every __free() pointer if the declaration doesn't have an assignment.
> 
> The = NULL assignment is unnecessary if the pointer is assigned to
> something else before the first return, so this might cause "unused
> assignment" warnings?  I don't know if there are any tools which
> complain about that in that situation.  I think probably we should just
> make that an exception and do the checkpatch thing because it's such a
> simple rule to implement.

What I was trying to say is that the __free() thing is supposed to
prevent bugs, and it's not. Even if it was easy to write the matcher
rule, if __free() needs a rule to double check its use - it's failing 
at making it easier to write correct code.

In any case. This is a patch for Intel wired, I'll let Intel folks
decide.

