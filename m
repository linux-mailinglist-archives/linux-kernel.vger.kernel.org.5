Return-Path: <linux-kernel+bounces-34594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DD28381E8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84EC22864ED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE2B51C5F;
	Tue, 23 Jan 2024 01:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkZppsaU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FB73DBBB;
	Tue, 23 Jan 2024 01:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705973847; cv=none; b=dHAlWM/WWUQ1KOHJyPGBu653ig7aihabPmKg9vt9NHjljdsBXxeTapg5GqUuqJwMA2tr5AdTFVM7Xtd+oM3jX8CA508IAn9RQNF31/kbcyJbJICMn5z78h9/9AqNER0pqSwtTHAE2YxFyDo7RHQr6MN5V5lYDcRQVt/6o+1vOyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705973847; c=relaxed/simple;
	bh=h3vnDNkAYaV+G7RInADtQwllk0xfCCVaONUbSnERixA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVaMhKeBhAi8/vn///tflvfWZsjnFPf6CafKzsQScBfaAhCpqPrYFjcVfb1IHbt9ul2A6+KtAFrY7miOLWz0S23X7c9vRHCK9svMXFLH8+zyvjarJH8dwSGwzrglO3/8QD7c+ywcJJIse28wnIos6hkwmnv4bQNCmPoQeIYIAN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkZppsaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201D1C433F1;
	Tue, 23 Jan 2024 01:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705973846;
	bh=h3vnDNkAYaV+G7RInADtQwllk0xfCCVaONUbSnERixA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UkZppsaUOiQ3f9b0KTQkhZTQ7C9u+FoevxvEzavxBelMVgjDYcXvKHIbe4wToIjB+
	 ZAZxqLBcPT6EloK+OdENnJ1wGpvcPvPzt2IjOeYwcegOA46XGW1KK+3e31DpdU9sfg
	 BEmigZVVZp/JIhih4WoQTvdQZJ9aAivBh9a+0Mmd071N/B5bd6+vq1p5akxQA0ODop
	 jb+2dx2/5Q8ONMojclMHD90Igj2w+BLnbdz//KLwLsVzj1TXAvuBgO+6wjWY215tX3
	 mwFtlUOdYoM4lWnnT7T463SEfoh4ifao+YdUxr+jOBWXTRYvlsJhOD9nIxDUhuZrYh
	 zu8l19VOvmHRQ==
Date: Mon, 22 Jan 2024 17:37:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <corbet@lwn.net>, <linux@armlinux.org.uk>,
 <sdf@google.com>, <kory.maincent@bootlin.com>,
 <maxime.chevallier@bootlin.com>, <vladimir.oltean@nxp.com>,
 <przemyslaw.kitszel@intel.com>, <ahmed.zaki@intel.com>,
 <richardcochran@gmail.com>, <shayagr@amazon.com>,
 <paul.greenwalt@intel.com>, <jiri@resnulli.us>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <mlxsw@nvidia.com>, <petrm@nvidia.com>, <idosch@nvidia.com>
Subject: Re: [RFC PATCH net-next 3/9] ethtool: Add an interface for flashing
 transceiver modules' firmware
Message-ID: <20240122173725.066420c0@kernel.org>
In-Reply-To: <20240122084530.32451-4-danieller@nvidia.com>
References: <20240122084530.32451-1-danieller@nvidia.com>
	<20240122084530.32451-4-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 10:45:24 +0200 Danielle Ratson wrote:
> +        name: status
> +        type: u8

u32, also - it'd be nice to define the enum values in the spec and link
it here by
           enum: ...

> +      -
> +        name: status-msg
> +        type: string
> +      -
> +        name: done
> +        type: u64
> +      -
> +        name: total
> +        type: u64

perhaps u64 -> uint?

