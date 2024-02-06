Return-Path: <linux-kernel+bounces-55424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C14E184BC88
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62836B21B36
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8358A134BC;
	Tue,  6 Feb 2024 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3Skh+K/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7268134A5;
	Tue,  6 Feb 2024 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707241932; cv=none; b=ciAfccjYe/jzp/8B2VQJrVirv1+egMOztuJTaCMkKKSmebrMzr7goHE4Fyioc7ghgSeSyUZaxv7jW6NzHPod8VTcevUrbZvgW0joSHJLEk5iEzWP/j0E+9Fzl09rM8/jA6JhnR4IqF9LIC0Yp0XgbD96nV51VfnrIAtxL6jKtB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707241932; c=relaxed/simple;
	bh=sbkWhpso4EZTK/maCFJTjKFRmHHtepEZjYY0FS4eWcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdwvkIA8OksWVJkKvEFy7uEVpvcgQX9caquNECFiXjaYN53UIkcHV409bsX9qbHUHgCz2wtrt7r+k/JMY6zmcEu2IWTJ6CKFfFfpcGrfPNK01HUMfgpiD9Hylr9yEsiFrlGMBKVCIqc3Kti4/pOwLrp8/TH+cfYgwgGVtMQMRx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3Skh+K/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D442AC433F1;
	Tue,  6 Feb 2024 17:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707241932;
	bh=sbkWhpso4EZTK/maCFJTjKFRmHHtepEZjYY0FS4eWcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W3Skh+K/0BjVo3UuRa0tzv8HyAIHxOZp+7iMmwUZsKsnRBnSQ2Pd9QdYglYUcdA+Q
	 mcuyd9KfuzcYumM0pn4ZxFH3NJSYQ4GQkIyc+KBoItd7QpOmTpd4NILfddpLszLvWk
	 7MImDsZUBygaGIQjsp2xECMjK5VasXYq7zotFmBd6P58/fjg+d7EY6onCGvWwjIBIx
	 umyA6N8zCu8HJN6ySjk+/oSvGXcNo0I56+tTjlTXDj3FpdJDbs9CumhF4Z04ni7qcC
	 CER+AChQ3dBuCwzxlGtLtmvdDjqrbWZZIS4fUW+OLbQAgNDe/Rd9dwfTrFa/Mao+Zi
	 zEtHomv9vW3zA==
Date: Tue, 6 Feb 2024 09:52:10 -0800
From: Keith Busch <kbusch@kernel.org>
To: Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	alan.adamson@oracle.com, kch@nvidia.com, hch@lst.de,
	"sachinp@linux.vnet.com" <sachinp@linux.vnet.com>,
	"mputtash@linux.vnet.com" <mputtash@linux.vnet.com>,
	"abdhalee@linux.vnet.ibm.com" <abdhalee@linux.vnet.ibm.com>
Subject: Re: [revert commit 9f079dda1433] [mainline] [6.8.0-rc3] [NVME] OOPS
 kernel crash while booting
Message-ID: <ZcJxyjfBniERIWiq@kbusch-mbp.mynextlight.net>
References: <a54c8860-18c7-474d-95e2-a0153a2da885@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a54c8860-18c7-474d-95e2-a0153a2da885@linux.vnet.ibm.com>

On Tue, Feb 06, 2024 at 10:05:20PM +0530, Tasmiya Nalatwad wrote:
> Greetings,
> 
> [revert commit 9f079dda1433] [mainline] [6.8.0-rc3] [NVME] OOPS kernel crash
> while booting to kernel
> 
> Reverting below commit fixes the problem
> 
> commit 9f079dda14339ee87d864306a9dc8c6b4e4da40b
>     nvme: allow passthru cmd error logging

Thanks for the report. Let's take a shot at fixing it before considering
a revert. I copied you on the patch proposal.

