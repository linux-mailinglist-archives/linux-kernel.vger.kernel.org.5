Return-Path: <linux-kernel+bounces-32425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E426E835BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85A9E1F223E0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE56125CB;
	Mon, 22 Jan 2024 07:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kThrX8DK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB27FBE1;
	Mon, 22 Jan 2024 07:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705908757; cv=none; b=t07TolQHKhFvZZY+GDhc3PX4W1GGmr/IPCGjCl7Y/O/JZfKcGh5CEJVQhd2qBQA4a4MuliivVz+GcmXlbQ6oTek5rXbaNMr8OpbH0zslYtyTRH7fTu7TuZrxOAOXVBZWb1acY2te9ls54Ey0bZwUe2jVWusqqNijNELW7shIFkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705908757; c=relaxed/simple;
	bh=w3x6fjQRj1G239oK4GnIyAbnMwFvI9UCv7x3oK55Llk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCZ7vSf+L0xvIoHsIdOUkhTKM/ZJYht8YOzYMGRVHMcU2Jw8gd2B3QHKopy2uDIaQDynxoAg87FcuowlB+BGInjjBXGEKJRhdzB3KgJ+nwZ66o5IBuP3qjl1W1WSGFd/zxWse1MZCmpQeRDbK3ADpA0z5uCB5jtpenANbvR08Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kThrX8DK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE58C43390;
	Mon, 22 Jan 2024 07:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705908756;
	bh=w3x6fjQRj1G239oK4GnIyAbnMwFvI9UCv7x3oK55Llk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kThrX8DKkqS/wgk/ydg8e9O+Ht9U9dFKbiK8Wz5sBUH/T6Mg8bQzwwD07efNxXaq7
	 /+MzyqpQT89gC5+AKc7k5Sdz4ZyJ9CcACJCWFdg36WHwKwLRkOyZqZGu0hShqb1IH+
	 oA4emJvBTNrhC1wJvyaX/nSsibnHprJ6dUmCN7vx0hRy7UGyGzjOHWrjq+iZ8pZbmG
	 5lEkXS6DBgFiI9wC1cC4S/YaHeI6sfGC6ZpgtBue37FMVdtkhOyhIJ4SOg50iGpoS2
	 FIfFHFYnJvE3smS3jq06+Jh1vU0C8euG/+x7hDneaj0hYxVeyQHtHcRfNOBifu85EL
	 IGWpPJfUqfYzA==
Date: Mon, 22 Jan 2024 13:02:32 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.intel.com, Basavaraj.Hiregoudar@amd.com,
	Sunil-kumar.Dommati@amd.com, vinod.koul@intel.com,
	venkataprasad.potturu@amd.com,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Syed Saba Kareem <Syed.SabaKareem@amd.com>,
	Arnd Bergmann <arnd@arndb.de>, Marian Postevca <posteuca@mutex.one>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>
Subject: Re: [PATCH V2 01/13] ASoC/soundwire: implement generic api for
 scanning amd soundwire controller
Message-ID: <Za4aEL1NaGS8UeGr@matsya>
References: <20240110094416.853610-1-Vijendar.Mukunda@amd.com>
 <20240110094416.853610-2-Vijendar.Mukunda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110094416.853610-2-Vijendar.Mukunda@amd.com>

On 10-01-24, 15:14, Vijendar Mukunda wrote:
> Implement generic function for scanning SoundWire controller.
> Same function will be used for legacy and sof stack for AMD platforms.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

