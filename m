Return-Path: <linux-kernel+bounces-53416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1976D84A3F3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3D21F24327
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C37413247F;
	Mon,  5 Feb 2024 19:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S79mUNth"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0337012E1D9
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159814; cv=none; b=jFK32UqzdMojiKSDr6tA2V1yct7PheMevd5oyi6isrDUpRXHXUz+4fh2JH28hc0BSptQPrnDIiTLf14UfSd84Wb81VHthWjKK9xNb2FG7t0V7KZipZpJ+uDBs+gLPrMG6myYt0EFzpAcyNpXPymLQOuwZr5zS/krwoMujvQ4d/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159814; c=relaxed/simple;
	bh=y7w8Nhpz0xbXO20mK1nlsBvyVlLtjn1RFbbLTjOYJ3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IB/xXEEw3SBpCRtiXlTj4bgpPNiACyXfM9vE7KXcdw2sNUfwXq1ggW4teB3SA7HKT60RXx9iQgCw2pxwMeFsrpANu7SlXU42ZnBQ2BQbeJtc1h8DWKkHmpLycI5XA4rIUeK71eFe9DeAiED2kfRDYRLoogHEcKfSrxnncy0iA4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S79mUNth; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77723C43399;
	Mon,  5 Feb 2024 19:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159813;
	bh=y7w8Nhpz0xbXO20mK1nlsBvyVlLtjn1RFbbLTjOYJ3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S79mUNthBbhmytZaAFchVpCkLsHzCfwqUFoXrLy1PXztqFB2pqm7FNsmcPrQX7gai
	 xY0sY/l9F2oWb5qGMSVL2N3AEmjJk4SWwNqPJjSBEoEqk0M6WuBIEt+zhzH179gWfH
	 +IiFMsWWApqlu1oLg5wXwlPRANtucMEwF+csu4Eg=
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

