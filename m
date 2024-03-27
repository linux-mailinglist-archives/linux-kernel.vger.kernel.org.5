Return-Path: <linux-kernel+bounces-121458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7725B88EACB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AB81B32C37
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2FB13B5B2;
	Wed, 27 Mar 2024 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGNJNTSE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A197913B5A3;
	Wed, 27 Mar 2024 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711550718; cv=none; b=d1rkTvH2YkqMaKVQ9ov8zUR2n5U5BYMm9LEraLWTZyhZYJwDkdY1yFFcr0gV+t3kjfOz/IDiHCqdEFJ6KV4FnDqcRZU5FUvS6sV9+CLmWFgK4jyKHkRPImAB6KI8DXiaQofeDCAJxC3e8HyHvTfw3oZbk/uVZzKE10ZEJsGm6MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711550718; c=relaxed/simple;
	bh=8DwuZaB/v3gjqMP4ZlY0VgdKvdFBfDihBASZIQ2fe/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VeasDbETb+dY4UFTll9YJRJSwMhQ2EuSTlTVYlH/DnkUd7+UtDuQqwqPig29kGxiKTjWkA6XAXxMoGzT9edlcNb7NG8oxypvwH3uINHm+mi6ZCvrGHenDkR9PmFO8olTftLRq6I9j+9F8AfCAKobl6X1FFNjd7oAYx2yHzZvQb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGNJNTSE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B393CC433C7;
	Wed, 27 Mar 2024 14:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711550718;
	bh=8DwuZaB/v3gjqMP4ZlY0VgdKvdFBfDihBASZIQ2fe/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VGNJNTSEWJNtgs2Hu+M47Xgcqo+VVmjftP3nd/F+C8sRcppBMoJhDWhicoq7pfFOP
	 7S3n/Vx2oHlntat9lLQaNy5iD7AVptqUIZrfY5ejpBq7CnLaFI7lXzIBvfwpQyt1G/
	 QO+HSeuPK/ruT03yWMoUs5mAeNRAHjp+QMWinaYGEqubEXvoJBQ3L/Zya9BS2/aUhS
	 4e6aD9fltwq6wKYJFfNlF4V57xqjJ5tge3uoCKDtBeXU6zIastxUeUGPWEO1JO/qQq
	 6HnJR7p3L2+bhfn6bhHGPZDu8Z8GrvONszFZ+wCvHIjUnOPQmxWMdyzjjkne1m5VHV
	 g90OrfmDS/Htw==
Date: Wed, 27 Mar 2024 07:45:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, Kalle Valo <kvalo@kernel.org>,
 Jeff Johnson <jjohnson@kernel.org>, keescook@chromium.org, "open
 list:NETWORKING DRIVERS (WIRELESS)" <linux-wireless@vger.kernel.org>, "open
 list:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER" <ath10k@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ath10k: allocate dummy net_device dynamically
Message-ID: <20240327074516.624b7ecf@kernel.org>
In-Reply-To: <ZgQvTTnMoBn2oG1K@gmail.com>
References: <20240319104754.2535294-1-leitao@debian.org>
	<9fcdb857-da62-4832-ae11-043fe993e4ad@quicinc.com>
	<20240321072821.59f56757@kernel.org>
	<5039256c-03eb-4cda-8d11-49e4561cf1ef@quicinc.com>
	<20240321151744.246ce2d0@kernel.org>
	<Zf2ceu2O47lLbKU3@gmail.com>
	<20240322082336.49f110cc@kernel.org>
	<ZgQvTTnMoBn2oG1K@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 07:38:05 -0700 Breno Leitao wrote:
>   -void init_dummy_netdev(struct net_device *dev)
>   +void init_dummy_netdev_core(struct net_device *dev)

Can init_dummy_netdev_core() be a static function (and no export)?
alloc_netdev_dummy() is probably going to be the only user.

I'd also lean towards squashing the two commits into one.

