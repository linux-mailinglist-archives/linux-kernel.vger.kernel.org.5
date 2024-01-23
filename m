Return-Path: <linux-kernel+bounces-34816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A158387DA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF5BB2848E5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D576C51C49;
	Tue, 23 Jan 2024 07:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qW5Zq2D6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4FA2CA2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705994164; cv=none; b=tInU1l9h6ZS7pwUaf+8aJG+TCcGJtFHK0K0XMVYvHL/73ZzwP9ylSger2verCQQCbH/TXTSyW2b5nPCoclFCcaDkW4eLXoOPaB1iUnR2OTkGJLUZwDxHtPKgpHNPH+6FxwpmAhXVdBtUDzUByLpnLUCcdINgZsJ566N2DgCdmjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705994164; c=relaxed/simple;
	bh=Qv0r9JskAd/omjXZcyv5p/SPThUBQVmcjBfikLL8YWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5rdWHPRHjCo0EXcDzd82U692Ec1IGRguh9Capf3UajYt5/KXKJ85s/Xqqq243L6XhUUwMMaX63mKcxrYNoFM1WuRGoEuTC+zT6OVrm51mc5yir7FM5VWT3DbnxuSL3m5RBRXeEgbOPuHJJ/csBCGFIorCBJbK1VnmE+zYXIAv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qW5Zq2D6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EDBC433C7;
	Tue, 23 Jan 2024 07:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705994163;
	bh=Qv0r9JskAd/omjXZcyv5p/SPThUBQVmcjBfikLL8YWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qW5Zq2D67axmNfAag6UD+cc0EyAAhQ4cWTjSdG312yVyVfCKlA1nuX0vQXij14p3z
	 BsDDjAci3ZSPOShc6jOVA9Ojf1MC7JmipGhixnkx5ZC5v788r03pPwBLom3xJxtzl4
	 QCbgzcdtFT+t6tohVfNaTnrDIFtT9t28sPi9rNfY5zXtBYS7T0Ls64uIGucFV2rlOq
	 Nzs/BD/IpNMhN5HwihoPgUIm2FE1rD4vOl/+UW1RycGnhgZPTqawjimTWQ4AckS+Fh
	 1cwp7MRc6tK0iikQiJEBouIIZeW82ENtDOeyWCk/VCqLug7kv/7fXG5IfOyQBdBuND
	 TmSPc4n+TItIQ==
Date: Tue, 23 Jan 2024 12:45:59 +0530
From: Vinod Koul <vkoul@kernel.org>
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.intel.com, Basavaraj.Hiregoudar@amd.com,
	Sunil-kumar.Dommati@amd.com, vinod.koul@intel.com,
	venkataprasad.potturu@amd.com,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 03/13] drivers: soundwire: amd: refactor amd soundwire
 manager device node creation
Message-ID: <Za9nrtvDtCT_SLzY@matsya>
References: <20240110094416.853610-1-Vijendar.Mukunda@amd.com>
 <20240110094416.853610-4-Vijendar.Mukunda@amd.com>
 <Za4f1rwAXAiJU-j5@matsya>
 <d8f5ee8b-466e-4069-b06b-41cdc7fa9e40@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8f5ee8b-466e-4069-b06b-41cdc7fa9e40@amd.com>

On 22-01-24, 17:18, Mukunda,Vijendar wrote:
> On 22/01/24 13:27, Vinod Koul wrote:
> > On 10-01-24, 15:14, Vijendar Mukunda wrote:

> >
> >> + * @count: link count
> >> + * @num_slaves: total number of devices exposed across all enabled links
> > should this be not per link?
> No, this will be total count of peripheral devices across all the links.
> This variable will be used in  snd_soc_acpi_sdw_link_slaves_found()
> API.

yeah noticed later

> >
> >> + * @link_mask: bit-wise mask listing SoundWire links reported by the
> >> + * Controller
> >> + * @ids: array of slave_id, representing Slaves exposed across all enabled
> >> + * links
> > this does not tell us which device to expect in which link..?
> sdw_extended_slave_id structure contains information about link id as well.

ok

-- 
~Vinod

