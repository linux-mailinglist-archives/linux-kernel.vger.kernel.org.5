Return-Path: <linux-kernel+bounces-44890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B7D842895
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C25DB28906C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A4512836B;
	Tue, 30 Jan 2024 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4J0i8c7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6496128371
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630452; cv=none; b=ZZtL/XHXTI+t/5CYZZq/1NBfw41E33iQ+3xg7jjf2OQA5kiLT8xX4WZvtbW1KkHQQGcVAM4xTm4/h8yFspvn+bs7pSbcR2HoUsCy2rxRKA4avkD/NTvRSEWx2jYsdLz/Mqkf0efbkUZoXWArCmb0QqvyzGXSW7CrHvB2coEEuEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630452; c=relaxed/simple;
	bh=0KL/Y0SnobL/6n/MUpYveoYcHEtx4NlHTFVtjPAIIRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esBg16V1JR/owmr/mtwYhiuqiQ1MASaoVMUo7xy9U2Y0ZBsyScNdnQTQ7ZHbfPKd7o/c6IIJ2u8Ukl0h9jJ4f6lfZIdlknMFBeZKFSlLvarsphoobRUuVaWQUJSwdoK8WsJu9YdlPvaIv+na3dx1OkxPGvwJ+UFSV7yMTJBHS9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4J0i8c7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FC3C433F1;
	Tue, 30 Jan 2024 16:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706630452;
	bh=0KL/Y0SnobL/6n/MUpYveoYcHEtx4NlHTFVtjPAIIRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E4J0i8c79Ox8p/S7gFAvjkgr8SkNJ0KTSs/GHu0RmE+VRkNU62vrfwElr50l4ppl9
	 trNKevIb7cmeB1zkvbQ1pykYQFPUquB+Ls9IhZOYhbwUp11/JwGL8+LYcJcQ+Ez3gc
	 DZkF9STkQ8NZ3cKZBao73QXUjg58A0FPGzUTFUEtZRmx9Kr1MRMgP2wN9yzDoNY9t2
	 fWjt2mPXFHaSx+D07LobsoQpKD3Kq523SkCrMeqrbBtTOL5Nig9d7cWIyNitjwjBhE
	 AOLijyK7sFUfhwRs0907uOAF8oMcqcH6aBPDBlasfzQFZun00M0HKNclez6aeKRBxP
	 8zw64+0rpYUcw==
Date: Tue, 30 Jan 2024 21:30:48 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.intel.com, Basavaraj.Hiregoudar@amd.com,
	Sunil-kumar.Dommati@amd.com, vinod.koul@intel.com,
	venkataprasad.potturu@amd.com,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 06/13] soundwire: amd: refactor register mask structure
Message-ID: <ZbkdMKp-vGdJfZ_b@matsya>
References: <20240129055147.1493853-1-Vijendar.Mukunda@amd.com>
 <20240129055147.1493853-7-Vijendar.Mukunda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129055147.1493853-7-Vijendar.Mukunda@amd.com>

On 29-01-24, 11:21, Vijendar Mukunda wrote:
> Register mask array structure is no longer needed as except interrupt
> control masks, rest of the register masks are not used in code.
> Use array for interrupt masks instead of structure.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

