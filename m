Return-Path: <linux-kernel+bounces-39533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D0F83D26D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01B21F21DF3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AD379CC;
	Fri, 26 Jan 2024 02:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVvu8TaM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7BC7493;
	Fri, 26 Jan 2024 02:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706235407; cv=none; b=b8ehHDSb8r1prBijq6/KflOYk1rtxOyPYo1hSiuo8lYBfTWjijbC3fqOUt80DeI6PeyrpJKN7DFg1H8EKr5M5ITfF5ZF8sN02YLiLRpA7XK3vhQVw9jGvR2+1w+qUFvoh4U2kE2XfPbCatm9KInBPV95Ar8IWiwl8XvyLkM7rjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706235407; c=relaxed/simple;
	bh=dtACEqcIp3VkhqFiK+Xnyu4jcs5kH7UtV2G9Fkq8+rI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDsq/28MfwwXuHq78L3VnUbRZPi/S27QMNe294luCW27yhgiU4e4v7MNPVDZhkVODBTQI2N/ZV63jFMY7MANzKFNmHcSJkOJqFQNcmXgv2pl2C4w7G6cRRpAuq7gXKH7UtRCwvwXXVk9ReewkuYG52QdGViUQCphzO0wejkm9hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVvu8TaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452DAC43390;
	Fri, 26 Jan 2024 02:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706235407;
	bh=dtACEqcIp3VkhqFiK+Xnyu4jcs5kH7UtV2G9Fkq8+rI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DVvu8TaMLiCl8Lm9+WVOHtoNfCy/ngyd4MTHSJxY7pzpSuondXhso84rS3kZzVcNc
	 YnIWH5AXGhlYDbcZllmgPhGb6FwmsePPYRtrLpc1NSP3rnbKtWqA1cGjqM1nMmWFEL
	 ycx9tBvVCz9707y5RjwyQYz+ZNsopKvr0ROJZd9FGogFEijNItuNWZlUGHVJlu4Ap8
	 BJaQ0z5atqRlX5vKXm/OBS4H7dLUkTo0e3Op8fdHaKmUEv1ZbRPRUd2G4C2wyHUY8C
	 mTEb/sr1H90tOJ5gSNzyg/VnsCKtAwhUdCurew/1IruRrVYomuujm0xNLWR4rwsCZZ
	 OSqhUkkWKq8lA==
Date: Thu, 25 Jan 2024 18:16:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
 <sgoutham@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: Re: [net-next PATCH 0/3] Dynamically allocate BPIDs
Message-ID: <20240125181646.522e6d35@kernel.org>
In-Reply-To: <20240124055014.32694-1-gakula@marvell.com>
References: <20240124055014.32694-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jan 2024 11:20:11 +0530 Geetha sowjanya wrote:
> Current hw support 512 backpressure(BP) Ids. These BPIDs are
> statically reserved among 4 interface types based on number
> of channels supported. Latest HW support configuring
> multiple BPIDs per channel. To support this feature, the
> patch set creates BPIDs free pool from the BPIDs reserved for
> LBK channel as, LBK uses single BPIDs across multiple channels
> and on request it dynamically allocates N number of bpids
> from the free pool. This patch also reworks the LBK device id
> checks.

I looked at this for 20 min, I don't understand how this fits together.
Please improve the commit messages to also explain the functionality
and how user interacts with the features.

