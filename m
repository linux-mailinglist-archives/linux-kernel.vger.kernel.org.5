Return-Path: <linux-kernel+bounces-121433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E89288E7D7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04ED01F35750
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078A412FB29;
	Wed, 27 Mar 2024 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkCPQTx8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A0D147C80;
	Wed, 27 Mar 2024 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549576; cv=none; b=p//Nr49P7YGIpCYiu7l/2BXsDmmXyeGNoxbTa4aUDHEY3ZVLCNKzfO6EdzUXQ0lJm8+RHZ1jUx1VSy/h4dv6FmbUAiftZsfqnZPZRz8ToNLygNCi27Sz9X/sSYxlKctDdSex5dBLpobI6F6xDl0AKgmrbHsDGgsmf+SrtP54pKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549576; c=relaxed/simple;
	bh=tYPHhNepAAUe/RQ25n0j0I86CGTDkYfEPdE4S8lqpas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uG46wo3EUNA/YP/0MPPKplkNSOMkUoRkRtsWpuwmLFY0uJXlQHLHT0Taofcy+cNdsTCoG6FNhZpZgrBY8Se0JjH/ru+F3aJNkPcWBcrYXZdQEbXdb1qzUHKRgWO4bEJIBYCtHvygcTW2DDGbvvg/16LUNY/cXuhWk7gfm7XwtmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkCPQTx8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256A5C433F1;
	Wed, 27 Mar 2024 14:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711549575;
	bh=tYPHhNepAAUe/RQ25n0j0I86CGTDkYfEPdE4S8lqpas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rkCPQTx86xKBwvhO7HDufGb5TKgJnEhkgurHdpJP2aGkREXb4bWU9HlVf2dDPQ8ht
	 QQCXpMrDWKt40fjB3JZfbkKhRJwxTKqpsF1AONm11z/vKvlMlZwwYZOg63P6rE/VHZ
	 P7ziXQhb+6A6CJ+L39PXLqydtd/ebYP0Z+OnOR3YtdQ9u4zA/FO34PrntOuZKTvvAC
	 dMp6xdNb3OOWu+bqrD7RpqmmuLPC5DTrqZpJ3Ze2Ej5hXYqDSUIdxwSPzeOWwB7Mw1
	 W8SRMhKw2dPENkg4EERVYrp/mQxgIu1+1Ii0Vkd6yBCduwZEiGwCGSnGJMWAHBecLn
	 oLr9UgQ5W9E9w==
Date: Wed, 27 Mar 2024 14:26:10 +0000
From: Simon Horman <horms@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, sgoutham@marvell.com, gakula@marvell.com,
	jerinj@marvell.com, lcherian@marvell.com, sbhatta@marvell.com,
	naveenm@marvell.com, edumazet@google.com, pabeni@redhat.com
Subject: Re: [net PATCH] Octeontx2-af: fix pause frame configuration in GMP
 mode
Message-ID: <20240327142610.GI403975@kernel.org>
References: <20240326052720.4441-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326052720.4441-1-hkelam@marvell.com>

On Tue, Mar 26, 2024 at 10:57:20AM +0530, Hariprasad Kelam wrote:
> The Octeontx2 MAC block (CGX) has separate data paths (SMU and GMP) for
> different speeds, allowing for efficient data transfer.
> 
> The previous patch which added pause frame configuration has a bug due
> to which pause frame feature is not working in GMP mode.
> 
> This patch fixes the issue by configurating appropriate registers.
> 
> Fixes: f7e086e754fe ("octeontx2-af: Pause frame configuration at cgx")
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>

nit: For consistency with git history,
     octeontx2-af should be all lowercase in the subject

Reviewed-by: Simon Horman <horms@kernel.org>

