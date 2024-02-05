Return-Path: <linux-kernel+bounces-53530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFE884A4F9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F19F728A9EE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E53E16FA0D;
	Mon,  5 Feb 2024 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="olqbNrH3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80791482F3
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159830; cv=none; b=R+DoaJxZytImy/5uLU+FbD37KXNc418qJkRwvrNFbaK6kwTQbs8pphve6EyHWisdLvawHwRBAdHj8AkXcg0PrfwkYL9Bu+6/5xRGKLPG3Ij+vpMjqi42qzeIYBY5za95F4h6k0bfnp/M0ljmn+b0fWGMvH1T5e93EKOSvRaQ1Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159830; c=relaxed/simple;
	bh=CmfGjtjNGwPPR52pDEpS6eNjFtN2FcZ9H09650pl6P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5o6P8NMO1PVFCwq+6eeXz9chBZx+QXPL2JnyHSfFTmc5o1iS1SHXh0d3hl7ySbmLRs2pzN3RubswHdXFMEIx6DYi8FLvFxHPVP+5jEMMz7V72+1J9XS2IIJYGhlnLADrtHbWupPlIPVK362c487IvYn1KtYyJ6UpR7MgVvZqOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=olqbNrH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E06CC41674;
	Mon,  5 Feb 2024 19:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159830;
	bh=CmfGjtjNGwPPR52pDEpS6eNjFtN2FcZ9H09650pl6P0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=olqbNrH30Jn8smyYrChegI2Bndurl+rZbwIATfX9OrhCHM/ogIyryU2VfKWt/uSq9
	 UTVCzloGJR9ZYXU75CQHPJjFe1nBk+KtgKEuxw0DkSM65itlCyyJ4vsh1zD+2d0yDM
	 8LWPaElv1JznqZaAdKBNf6BOka0Yd8BJrEiGmy5o=
Date: Mon, 5 Feb 2024 04:49:39 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hsi: hsi_core: make hsi_bus_type const
Message-ID: <2024020532-value-coronary-03c0@gregkh>
References: <20240204-bus_cleanup-hsi-v1-1-f9318131e842@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-hsi-v1-1-f9318131e842@marliere.net>

On Sun, Feb 04, 2024 at 01:32:13PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the hsi_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

