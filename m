Return-Path: <linux-kernel+bounces-53421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1A784A3FE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4EAF283CC5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203F0132493;
	Mon,  5 Feb 2024 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K8/NxDH0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7819512EBD7
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159814; cv=none; b=pFJOcxqkkon7KYkdGxVEQIJLh3wm9e7ggEr0SYD9Z8RpYbdi62rcKQ7z933DTkfokLnqzYXeLMB69FwDGPmTO9cV3xsq4naE0Ah8QRlsAo5Cy6tAGWHDeCNni14AaquRAGZ8KOiPouclD9PWoHfZ+9eMOGMfThQub9LSeCrecHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159814; c=relaxed/simple;
	bh=y7w8Nhpz0xbXO20mK1nlsBvyVlLtjn1RFbbLTjOYJ3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IB/xXEEw3SBpCRtiXlTj4bgpPNiACyXfM9vE7KXcdw2sNUfwXq1ggW4teB3SA7HKT60RXx9iQgCw2pxwMeFsrpANu7SlXU42ZnBQ2BQbeJtc1h8DWKkHmpLycI5XA4rIUeK71eFe9DeAiED2kfRDYRLoogHEcKfSrxnncy0iA4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K8/NxDH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F229BC43330;
	Mon,  5 Feb 2024 19:03:33 +0000 (UTC)
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

