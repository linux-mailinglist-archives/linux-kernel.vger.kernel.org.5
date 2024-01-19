Return-Path: <linux-kernel+bounces-31272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19512832B9E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5DB6288C8C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9220554276;
	Fri, 19 Jan 2024 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcUDEGoO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47A753E24;
	Fri, 19 Jan 2024 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705675771; cv=none; b=oFGsPLzW0UfZs5kvXHYKwXBgfi10TOPACmpF04B53LaHqlF5YIKg52ZGw/GwVFMPG4ODNZeSlrykJ+DmVsheWRyXQD9nQTnpr/Ydc9uKxxpB5/Jyvu06B45ahxndb9N+UOJJL9XyXrvM6M7Ta5PkX2kM3/dw5zM2/byexdS63q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705675771; c=relaxed/simple;
	bh=hCsjv91Yj4g0mu9TcH2Xv3lssnwsCBwDQBHzNUt9fjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjO5kBsdCiVJo8WZ0YDWdMM8+S7NIH8DyDXSAJsB6XPq2aAKhutOQ6zbY6XgnMuC1NPyy3WZscIC4xpG9TqUIxYgSHwLlyTojbXYDJfA7HKy5dmAVJdHeZ6+Tm8rnvPMCbb5i8sxdjkNxP11bd5DYYgVZ7kcyA29DchJT1Q9roY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcUDEGoO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC55C433F1;
	Fri, 19 Jan 2024 14:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705675771;
	bh=hCsjv91Yj4g0mu9TcH2Xv3lssnwsCBwDQBHzNUt9fjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CcUDEGoOFlcLo+0ZJN8vUz0TsUYBvRn2MSjEw9MRuxGor91adf5VbKu9ojYSgtNO4
	 kId5csymMPuYgpMxvigwacpP1EHfXn+XdukEQs+mkq0FIXTlFiOO1vs70PVVgY6sBP
	 GGmRWFZXPvqkdoMGzh2Zq02GXHL+G8ZRV6Zyv39U9YPCxOzr+WKZJTKOcvrkds3kOm
	 kwIMCj6z2iAaOIoYCCyryl9oS6K8Xbk/UCmSauqVHq1SHavRCY17ETnyjN6xVAB1nB
	 HPESE3H8wd6ihIoJrc7/u+BqXZSA5mue2NeWPiEE087Z13Oa1ZwvXoRYSi8mLwnekj
	 +5iwZ2vt9T5Sw==
Date: Fri, 19 Jan 2024 14:49:26 +0000
From: Simon Horman <horms@kernel.org>
To: Suresh Kumar <suresh2514@gmail.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i40e: print correct hw max rss count in kernel ring
 buffer
Message-ID: <20240119144926.GA89683@kernel.org>
References: <20240119131652.8050-1-suresh2514@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119131652.8050-1-suresh2514@gmail.com>

On Fri, Jan 19, 2024 at 06:46:52PM +0530, Suresh Kumar wrote:
> The value printed for  "HW max RSS count" is wrong in kernel dmesg for i40e
> NICs:
> 
>   ... i40e 0000:63:00.0: User requested queue count/HW max RSS count: 48/64
> 
> whereas  ethtool reports the correct value from "vsi->num_queue_pairs"
> 
> Channel parameters for eno33:
> Pre-set maximums:
> RX:     n/a
> TX:     n/a
> Other:      1
> Combined:   96
> Current hardware settings:
> RX:     n/a
> TX:     n/a
> Other:      1
> Combined:   96  <-------
> 
> and is misleading.
> 
> This value is printed from 'pf->rss_size_max' which seems hardcoded.
> 
> Below commit also removed this 64 limit:
> 
> Commit e56afa599609d3afe8b0ce24b553ab95e9782502
> Author: Amritha Nambiar <amritha.nambiar@intel.com>
> Date:   Wed Nov 8 16:38:43 2017 -0800
> 
>     i40e: Remove limit of 64 max queues per channel

Hi Suresh,

I think it would be more normal to cite this commit something like this:

The limit of 64 was removed by
commit e56afa599609 ("i40e: Remove limit of 64 max queues per channel")

Also, it's not clear to me if this should be considered a fix or not.
If not, which I lean towards, then it should probably be targeted
at iwl-next.

	Subject: [PATCH iwl-next] ...

If it is a fix, then it should have a Fixes tag and probably
be targeted at iwl.

	Subject: [PATCH iwl] ...

..

