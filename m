Return-Path: <linux-kernel+bounces-166230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3308B97D3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14DA1C21C19
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1328755C08;
	Thu,  2 May 2024 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7eDk5ZE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562305380F;
	Thu,  2 May 2024 09:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714642401; cv=none; b=dXJOKRRIs8QiImMNHzViGDTAN/+sHyVeXbvYbjVy+cUHp9EnAxIx32blgdk/hZGops5qOVWw8h1rXsG7FwrPX7ehP4AVe/CLBdvyhCU7ByivFpu74fmy9vg5rOGzVXsJWrt+O/be1jH7ccK+6w/za4DPh31DOVf4DGffyNtLwS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714642401; c=relaxed/simple;
	bh=QlsdmKpd21bpE2nPFn1lTOkv/zm66ev9mTVi+iaa42U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKDEP7XjmLJLKmpsYtrLbLAKIrofBLfXo3wquznl0kq/ZrHYnG2tde4rLY/s9pcp85EbwaFi4wnkGIl0L8u1pO3D9Wx+UvUi+vzrMoCUefbdHi5vbSRE7j+WdA2+P7VsaiWkw1DiKNz9KCdoI5CtxB0WeSzpG7guqbO478NRw7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7eDk5ZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F52AC113CC;
	Thu,  2 May 2024 09:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714642400;
	bh=QlsdmKpd21bpE2nPFn1lTOkv/zm66ev9mTVi+iaa42U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K7eDk5ZEubI7BxmvceOMCCQa++3rEHZqXYDnHndm3urWNZfplWyWJr+p17L/DKOm3
	 gxeYK6jkryX1VijxmLGufbVDcVd1X7P+2AzmNI5SXvPQLXnEA6O7UiTwqHY7BSkthS
	 ixnfWcz/27nbYHGPtJACwT3YE137o1xvuEDNsEAOc0+vbQfj72dZ66Bv4OmWttOlxS
	 YnHqje7VX22PFfFeik2DdS7hTV5cSRf535frmEChJIeuk6rIybj444QkdFdpJdGw2A
	 s1X37Gu/KHuw4Y2u6DcN1Wuem8A+YKCBty5NGHI53fk+94jjzALjg9LlmeCoe8/e4a
	 yAHvXTueBidvw==
Date: Thu, 2 May 2024 10:33:16 +0100
From: Lee Jones <lee@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: wangkaiyuan@inspur.com, kernel-janitors@vger.kernel.org,
	Chen-Yu Tsai <wens@csie.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: axp20x: convert to use maple tree register cache
Message-ID: <20240502093316.GI5338@google.com>
References: <20240429024547.27724-1-wangkaiyuan@inspur.com>
 <a7db79ae-71a4-4d73-a7a3-7bd19f8e57ba@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7db79ae-71a4-4d73-a7a3-7bd19f8e57ba@web.de>

On Mon, 29 Apr 2024, Markus Elfring wrote:

> > The maple tree register cache is based on a much more modern data structure
> > than the rbtree cache and makes optimisation choices which are probably
> > more appropriate for modern systems than those made by the rbtree cache.
> 
> Please choose another imperative wording for an improved change description.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.9-rc5#n94

This review comment is seldom helpful.

You may as well stop using it.

-- 
Lee Jones [李琼斯]

