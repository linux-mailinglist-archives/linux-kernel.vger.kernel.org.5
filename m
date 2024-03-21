Return-Path: <linux-kernel+bounces-110749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF1A886331
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE3D1F213D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A67137765;
	Thu, 21 Mar 2024 22:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isCQZVOh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ADF132C37;
	Thu, 21 Mar 2024 22:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711059466; cv=none; b=HRq34bpG6qwHhKvw3dxUDDc4eXwxww94KrYjAtZaoX/rMDEJLnCtxjKHOneTLLmORoeOVZY33ag0uwrw2pLycMQjxlTJ8Y5LG/lAA8FAFdlmJX6PECwveGGZ47PMAb7QES0MR+La86NCE1lwhZkKSdf+0Fk4HL+ekeo2uhElGIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711059466; c=relaxed/simple;
	bh=DjmJQ+78BPWvsjUAWnoJZsxc2vrITxo9QPDsDLcM/+A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S3FOqmqD/1CuB9Vlf4KespfrMQsxiY8CHGWLB/rJYaRZL6G3CU6m3B26AbjcS+BxiK8t/oXBWLXQxHSmHDgaHb6leTL3XR6aBWcRZ6RuqwDIEbA9FiqmCJr3JLXnjyytRYAulvQjN3+rybB2LTcCcficcU5/4VCpEK3cK1WAFsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isCQZVOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B46C433F1;
	Thu, 21 Mar 2024 22:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711059465;
	bh=DjmJQ+78BPWvsjUAWnoJZsxc2vrITxo9QPDsDLcM/+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=isCQZVOhwUx8IUng+hpByG45djv/aCqomgiN+lAwM5SalgcrXR7MaOtV2Zt74d93C
	 YudbDwv62+18fgCECgChIwHqRhV87r8NcvRpIaVLKDrNERRTZ+oj1OieZkEKkLW6+Z
	 LnhbP2lo/8rA5gZxp7cWjKHhsPFU5QyZuX2V2PZLuT4dkY0tizZHaTkSEeeEIdsJDc
	 h9WwM8BWDJlqKsBIybLuL2itFunpzZDy39TqGa1uU02PG8NDRryw50SKwi50xI0q+B
	 DZVvn+42IkzVniLvO72AfemDh22BFgA0BrFa7gwUq0joXHx7xixrko8chSvKetl5tH
	 cVg+ONEfm192g==
Date: Thu, 21 Mar 2024 15:17:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Breno Leitao <leitao@debian.org>, Kalle Valo <kvalo@kernel.org>, Jeff
 Johnson <jjohnson@kernel.org>, <keescook@chromium.org>, "open
 list:NETWORKING DRIVERS (WIRELESS)" <linux-wireless@vger.kernel.org>, "open
 list:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER" <ath10k@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ath10k: allocate dummy net_device dynamically
Message-ID: <20240321151744.246ce2d0@kernel.org>
In-Reply-To: <5039256c-03eb-4cda-8d11-49e4561cf1ef@quicinc.com>
References: <20240319104754.2535294-1-leitao@debian.org>
	<9fcdb857-da62-4832-ae11-043fe993e4ad@quicinc.com>
	<20240321072821.59f56757@kernel.org>
	<5039256c-03eb-4cda-8d11-49e4561cf1ef@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Mar 2024 15:02:39 -0700 Jeff Johnson wrote:
> >> As suggested there we should just use kmalloc/kfree to match the existing logic.  
> > 
> > Please no. There is no magic here. alloc + free must match whether
> > you're using magic object alloc wrapper (alloc_netdev()) or straight
> > up kzalloc().  
> 
> Based upon the ath11k patch there must be something going on with
> alloc_netdev()/free_netdev() that doesn't occur when these aren't used.

Looks like init_dummy_netdev wipes the netdev structure clean, so I
don't think we can use it directly as the setup function, Breno :(
Maybe we should add a new helper to "alloc dummy netdev" which can
call alloc_netdev() with right arguments and do necessary init?

> So I'm just suggesting that instead we use kmalloc() and kfree(), which are
> matching functions, and which, like the existing code, are not subject to
> whatever is happening in alloc_netdev()/free_netdev().
> 
> I don't understand your objection.

Using subsystem APIs to allocate its objects is preferable to ad hoc
kmalloc().

We're working upstream, basic alloc/free of an object should work.
Took me 5 min to realize what the problem is.

