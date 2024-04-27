Return-Path: <linux-kernel+bounces-161075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A948C8B46C2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 16:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C143FB23797
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 14:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530155684;
	Sat, 27 Apr 2024 14:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cv6mmH0F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E1C5660;
	Sat, 27 Apr 2024 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714229810; cv=none; b=r4ufM4R23cKD3b1h6MBXqM3C5Bx2FV5J+ZD0rFm+jFosZkYvkTv5vP2K7/ZHdeCTdQVIK1GgfrIgFlsmVlwqFDPXNcZxXIPiv6NyFKqeV31dd22EV7EFn49W3ogDX6H0OHXArVADLXnqv1l/q64yvOYmBjTQJKgRMUf4pNmM/k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714229810; c=relaxed/simple;
	bh=f75jXn+JImVzW04XSBfpbAqM9Xc3DVOREU6CXnC59uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eey0OAQlzfGvAO75m1tr+KQ/mnkPYaiXZv52k9CioWBRZPnowqN339n19gIu/4cH1kOoirYekGOsfDdhKVWuojuFA9dQuzHbTqqUVUOjpdiHDPJoMtakc0XR7uUeeT6S6P5g2cvuq7XIfmpjWkoAJH6myAciktPN9L0ShBbTcS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cv6mmH0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF92C2BD10;
	Sat, 27 Apr 2024 14:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714229810;
	bh=f75jXn+JImVzW04XSBfpbAqM9Xc3DVOREU6CXnC59uY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cv6mmH0FaySGo8/F3+Qfou1j8kxBPCoudQ1Xqj6l1pidEVhFDbr/Zgl8NBaJbUlCh
	 uBMbKw3l/dtFsX9tgChPvU/l2vy1pnr0WbY1HY2uGaZ082qWYeKbUDQg5lkZdUcugq
	 0uCPJGoe3JbRAVm4KNBb5UjdkdCq7L/9mrxTJqK3n4gzjIAqqAa1V8AelfmkwJFsQS
	 Q5bk4nw8RaTiz3vUK7cPD85qs2/OmYUAMVSGNJAHrqqLnHGdZferHqu3sjCkZDhStd
	 TvvQ4vpuDJAo7MhIDgkO+3xzQVkIwDnVD+yWIoGTKL8Qq2wm03SLfIeXwvMkJ75mMx
	 ispyGRaEb03/Q==
Date: Sat, 27 Apr 2024 15:56:45 +0100
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 5/7] i40e: Consolidate checks whether given
 VSI is main
Message-ID: <20240427145645.GQ516117@kernel.org>
References: <20240427072615.226151-1-ivecera@redhat.com>
 <20240427072615.226151-6-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427072615.226151-6-ivecera@redhat.com>

On Sat, Apr 27, 2024 at 09:26:06AM +0200, Ivan Vecera wrote:
> In the driver code there are 3 types of checks whether given
> VSI is main or not:
> 1. vsi->type ==/!= I40E_VSI_MAIN
> 2. vsi ==/!= pf->vsi[pf->lan_vsi]
> 3. vsi->seid ==/!= pf->vsi[pf->lan_vsi]->seid
> 
> All of them are equivalent and can be consolidated. Convert cases
> 2 and 3 to case 1.
> 
> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
> Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


