Return-Path: <linux-kernel+bounces-83682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E576869D3D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ADE8B2C1E1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30D648CFD;
	Tue, 27 Feb 2024 17:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9+Q5INA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDA22032D;
	Tue, 27 Feb 2024 17:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709053782; cv=none; b=l3UBLf7BLEIf4cpXW8R2PKOHbszOFDmVZuQFQsSGMz7MnfFiZ2loLPJIKyMyN4/FS1NOVTf9qeiOilWgR9gg6SHKBOgXa79S4HAWY2TA0OexewwFL0kdfQLj2d6+oRFqzENlS8ma7e1QkKL1xivnt8AbdkMOe+8jbOVDQuvE6Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709053782; c=relaxed/simple;
	bh=4eAE/rmlFIWtGLRSUy3wjOLJtCVhswfMdn3Xe+j3sN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7kww5F+wfbuHI9cjCGTWLVpTUqNdGwm5RcZS1v/TJB3ScMRKy5KY7tVj+v/+6+APjp08oPT1XLqtlbVL3WXUrDxSv2+DXwO0fsm8+ZRRcoMkgxhG33EQ00WBh198McqJpUwwRs57cHaStPY/44W4YnopTI0v3j5doBiTfy/ic8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9+Q5INA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3AEC43399;
	Tue, 27 Feb 2024 17:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709053781;
	bh=4eAE/rmlFIWtGLRSUy3wjOLJtCVhswfMdn3Xe+j3sN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j9+Q5INA5mpuh4Urf0cy8QAwO1cSFpyAydp2ANsepioldiChOyY7wx73EOYhv4z5+
	 3OLnTU140Q7A2fbdtbPl1aWK+XAd9dJWmSY/YVOQlA9ysk4jVC8a35nY1yzAYxSobp
	 fuHLMkCA4c4WstOZG5ZHqbGtMebTpArXnyoROH+tiSVTye6GZYia3SEB2+00YG3sA5
	 c9eqLaeiv3ly9taPmXOkRDrB4li/9dOq0BzHUAuYV4yjkqOabnYOIsMZHIV9yIL2V2
	 KAkIS7cBk9EnGpxc/1BlpO8OYAp5t7CL2zLnVaALayYPauz7CuscWsX0mFB6DLa2NB
	 BLSrMumPZhtgQ==
Date: Tue, 27 Feb 2024 17:09:37 +0000
From: Simon Horman <horms@kernel.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, vbabka@suse.cz,
	Xiongwei.Song@windriver.com
Subject: Re: [PATCH] net: remove SLAB_MEM_SPREAD flag usage
Message-ID: <20240227170937.GD277116@kernel.org>
References: <20240224134943.829751-1-chengming.zhou@linux.dev>
 <bda53361-d334-411b-8ac1-069d41025804@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bda53361-d334-411b-8ac1-069d41025804@linux.dev>

On Mon, Feb 26, 2024 at 04:55:01PM +0800, Chengming Zhou wrote:
> On 2024/2/24 21:49, chengming.zhou@linux.dev wrote:
> > From: Chengming Zhou <zhouchengming@bytedance.com>
> > 
> > The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> > its usage so we can delete it from slab. No functional change.
> 
> Update changelog to make it clearer:
> 
> The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
> removed as of v6.8-rc1, so it became a dead flag since the commit
> 16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h"). And the
> series[1] went on to mark it obsolete explicitly to avoid confusion
> for users. Here we can just remove all its users, which has no any
> functional change.
> 
> [1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/
> 
> Thanks!
> 
> > 
> > Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Thanks Chengming Zhou,

this seems reasonable to me. But I think it would be best to post
a v2 of this patch with the updated patch description (which is very
helpful, BTW).

-- 
pw-bot: changes-requested

