Return-Path: <linux-kernel+bounces-88846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BA686E77D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8121B29996
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BFA200AE;
	Fri,  1 Mar 2024 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkaA+sqq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0440B36120;
	Fri,  1 Mar 2024 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709314519; cv=none; b=kvehxK6uKTKDwi4DdZuHFtFggwplhphCjofMfuoBQ5nwnNO5LKkAsvDItG0s0vbjuAplnOFeaNZHCmdsQhMOA0CHqq76eJWCS6CqvAAi2jbtRp2edSnPKz75PK7ei4ld8GPtMkyfVwxbAUl0OPknGFaAk+u9Ia4rcoOTNNwIDos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709314519; c=relaxed/simple;
	bh=EIj/hPN+ik4qmCHTNuVgjY4pQTRSkTwciabO+oM1s/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CYuzTJ34sX42gmHxchW+1S2tu6VywUBbprr7flxEqXoNZLgwleUPaFrXSKq1dGd2YffE9pq5knit4x8Bt5zP4DNZh200PvVZvN8Nvr5oIhm+KOw2y8om+4nl4jrCxx8QpA3AsAJOUg1tcmpvK5MYu1C0cfd4woWLCE0XzhE9cfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkaA+sqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFFEC433F1;
	Fri,  1 Mar 2024 17:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709314518;
	bh=EIj/hPN+ik4qmCHTNuVgjY4pQTRSkTwciabO+oM1s/E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WkaA+sqqt5Aprf/+ou7cadfG7bxUeTKvsb5UJe29yaHjEOEn6Xl888m3O2bwtLr6m
	 kBnYkXlU4+7VoH2QtqxJ2DRwKn4HrRYX/16b57ztkG+ZAN5A7ICLi58/9rswLl8Rti
	 Qya+bELvvD8OVl4sCXqtzQPB9dso+1CAesx2eAHVWtsvAi9GaHYbTxtlvVIJpoiDA4
	 HGxm3AyZ6Y6hdoDZTywToy6Jb+RstK9GbEzAfhoKabwFkPa/JSDS1rDfY+xGrfXWMR
	 bbS/FfN63kTeEybMi4gMbgSLSzIloMpSLLJwly7c9dmfhbFWPlDNskqEs2w7TbRgra
	 bOOWtop18STRw==
Date: Fri, 1 Mar 2024 09:35:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Eric Dumazet <edumazet@google.com>, Kees Cook <keescook@chromium.org>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, <netdev@vger.kernel.org>,
 <linux-hardening@vger.kernel.org>, Simon Horman <horms@kernel.org>, "Jiri
 Pirko" <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, Coco Li
 <lixiaoyan@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netdev: Use flexible array for trailing private bytes
Message-ID: <20240301093517.428e5b5d@kernel.org>
In-Reply-To: <77d3f074-8cb6-466b-ab31-a7b0bac659d0@intel.com>
References: <20240229213018.work.556-kees@kernel.org>
	<20240229225910.79e224cf@kernel.org>
	<CANn89iKeJGvhY0K=kLhhR39NVbaizP2UBk0Vk0r_XCe2XMBZHg@mail.gmail.com>
	<9050bdec-b34a-4133-8ba5-021dfd4b1c75@intel.com>
	<CANn89iLSLPn5PyXNQcA2HO0e5jGYvHKhTh_9_EMmfbTJKZPfbg@mail.gmail.com>
	<77d3f074-8cb6-466b-ab31-a7b0bac659d0@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Mar 2024 15:30:03 +0100 Alexander Lobakin wrote:
> I like the idea of declaring priv explicitly rather than doing size +
> ptr magic. But maybe we could just add this flex array to struct
> net_device and avoid introducing a new structure.

100% I should have linked to the thread that led to Kees's work.
Adding directly to net_device would be way better but there's
a handful of drivers which embed the struct.
If we can switch them to dynamic allocation, that'd be great.
And, as you may be alluding to, it removes the need for the WARN_ON()
entirely as well.

