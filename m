Return-Path: <linux-kernel+bounces-44885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C1384288A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E4FD1F26614
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84B68612D;
	Tue, 30 Jan 2024 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9EHfRRg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD7E85C67
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630351; cv=none; b=sn+ySi5HqWJTk2h6DyYA1VHVc6VZEz4a+qT4A59NAajVeK9iupHNh5/zwrQYWeKo8Ky96TrSTS7rBYaakkiKcMCY05VapeXYnjMKNeufkmPg8qtcX3hh0u2vTgpaX7z3IRyzerEUVURUrZevSKdGCUp4l4cL80zU2XQhbWNOgPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630351; c=relaxed/simple;
	bh=ayeCCM9eX9UuzR6QhI1Yi/QBnlgDh998JcXlC3hLB44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmMUoEc0sVcue6DOPn2l1bmG+LVCoTcgBCkW6g6FN5onn1I2b1cnNbHneFzygzvLTZq7AAwV8SvcZX0UkPgjplTsewlwkjeMWapq2KaAiAi3ND5yh6eQeqZSN8D81OILrcV+ZrSMNGHIs0gZqekIxOoml+E07IcuY3r1LM7EucQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9EHfRRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF70C433C7;
	Tue, 30 Jan 2024 15:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706630350;
	bh=ayeCCM9eX9UuzR6QhI1Yi/QBnlgDh998JcXlC3hLB44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S9EHfRRgKUwzZqRUsOXlRJ2Zr5I8nKUacNjp87CUob2Lq3vLHh8FTJo2jA2ndu8qD
	 LpYyGt9mvgL+H9SMRSdIwmm6ymznsbjjUSQ4FI/aKqbmRREjhTwgj6NiKJKgfcGRpY
	 4DJEnFpqN6waJiXJKW3mHVlHDmXZHDrDU0q4QzTSdr3HnkJHcTZAjfssdz8sszt0nt
	 qi17/4qrK2FHI8UO9rvLMC+6YCESkoyPJlo1+PieAXIGCiPzqqlxjcURe2PFFH3HZr
	 eeKUjvQoayjTy5SFmXuTX2X35sxdAQEc0SpwvOC1kn1bcxhngo/kNd1A3sf43Lcjqf
	 dDGtAqcR+kG+g==
Date: Tue, 30 Jan 2024 21:29:07 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.intel.com, Basavaraj.Hiregoudar@amd.com,
	Sunil-kumar.Dommati@amd.com, vinod.koul@intel.com,
	venkataprasad.potturu@amd.com,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 04/13] soundwire: amd: implement function to extract
 slave information
Message-ID: <Zbkcy3KLLkJ1mw7x@matsya>
References: <20240129055147.1493853-1-Vijendar.Mukunda@amd.com>
 <20240129055147.1493853-5-Vijendar.Mukunda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129055147.1493853-5-Vijendar.Mukunda@amd.com>

On 29-01-24, 11:21, Vijendar Mukunda wrote:
> Implement function to extract slaves information connected on the bus.
> This information is required during machine select logic.
> This function will be called from machine select logic code.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

