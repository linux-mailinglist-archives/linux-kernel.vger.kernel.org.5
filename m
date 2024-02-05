Return-Path: <linux-kernel+bounces-53423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2252184A404
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60571F260F4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCF31332BC;
	Mon,  5 Feb 2024 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K8/NxDH0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF3112F39C
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159815; cv=none; b=PLHYed+vhamTnx5duwpfZ3jZDT2P2ylPN6z7UEFtezDqJFpTjGhusmbAr8H3wSI1Mc6zyadG1baK6EgGduEPmfSjwkM/JbjbYDGdqV7j5jIKCKsEt36XLV0taUH91Vqw8CfkC3vB4L7qXoFF2k8S+Ju3/ys8AaBJ0qunYcNakkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159815; c=relaxed/simple;
	bh=y7w8Nhpz0xbXO20mK1nlsBvyVlLtjn1RFbbLTjOYJ3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQWvXjfzsIthfk4YkoQMJ34mB9Uw9BmydM7RT4e4eReO8QeWZGeR82kU6crgK1jwqm1xyBkR8Nyf4wkn+24ZoEvbXiDOqg4xDo32ZN1AZW9liL23KXcoVJFlL1mc/VbygFbnUtlOms8PLh1W1uJ+SwuWjhJ2MSCkj1ZgbcXi+ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K8/NxDH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48762C43399;
	Mon,  5 Feb 2024 19:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159814;
	bh=y7w8Nhpz0xbXO20mK1nlsBvyVlLtjn1RFbbLTjOYJ3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K8/NxDH0/YoCfJDUNVAH9Y65ezErof9i3BVL3yCPStG32Qvcn+p2VDMJgmN/RDn1A
	 aJrq7L4z5+T62lnG3MATR/JlwCBsD9ZQe/wRl3kEWRLG1uaiNUyX48DJXknz3peAGt
	 C9DR/AKbptKXiyb7KlvT8ZZYpqjVeUI6mW7Xic1E=
Date: Mon, 5 Feb 2024 04:48:36 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: mcp-core: make mcp_bus_type const
Message-ID: <2024020531-hatchery-scalding-f83c@gregkh>
References: <20240204-bus_cleanup-mfd-v1-1-07335ebc034f@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-mfd-v1-1-07335ebc034f@marliere.net>

On Sun, Feb 04, 2024 at 05:10:32PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the mcp_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

