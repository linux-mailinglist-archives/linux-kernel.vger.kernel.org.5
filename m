Return-Path: <linux-kernel+bounces-53525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A765F84A4EF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8A61F27252
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845AE16E387;
	Mon,  5 Feb 2024 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="guEbsnWv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30BD135414
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159830; cv=none; b=Axc5/xi0oRApvIPWKtpUGW1fdmvg4wkyfzjACzRkwfBRpxuaYZsZZySlm1nNnZC0F7gTMWYAjuO0tex94O45b82YCMrslw9O5fUjjm5cB1v11VToFepkCWafuuk6kPFq+1U+FJfEY8l6g5ve5If+ATgvmHeTBZmhoDiWPyiZlkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159830; c=relaxed/simple;
	bh=CmfGjtjNGwPPR52pDEpS6eNjFtN2FcZ9H09650pl6P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5o6P8NMO1PVFCwq+6eeXz9chBZx+QXPL2JnyHSfFTmc5o1iS1SHXh0d3hl7ySbmLRs2pzN3RubswHdXFMEIx6DYi8FLvFxHPVP+5jEMMz7V72+1J9XS2IIJYGhlnLADrtHbWupPlIPVK362c487IvYn1KtYyJ6UpR7MgVvZqOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=guEbsnWv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE86C43399;
	Mon,  5 Feb 2024 19:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159829;
	bh=CmfGjtjNGwPPR52pDEpS6eNjFtN2FcZ9H09650pl6P0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=guEbsnWv+U8wXVghkHbYeTPx2md9mRMdBcgP3d3lh2OB7eTJQAcj72pGdD1IrtP4o
	 2VBXkrmYAE9lBKkwbNLtr1osqkJPVsaVH2LVhJUpmDt8/4kxLu+g9FaCmKVVH1CTQ+
	 41FWpbZFoiLZXfeyvbdUIXTiVGcVhsSuMdrWYV4M=
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

