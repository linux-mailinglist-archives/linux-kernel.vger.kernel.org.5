Return-Path: <linux-kernel+bounces-53372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C9F84A3A7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F2C1F230D2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5D5823C4;
	Mon,  5 Feb 2024 19:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tNE9ukff"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA34811E5
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159805; cv=none; b=teJWw/5097I5ebXeLpVN0kySJHJ6ePxpLn68BdAQ3Z5WhiYsoXOfR51DSCsteTPFGdw/4+7wpe/JwPXK0DSApt4G37oRrhcP9XBdhjck/5w4bMW2XMIBLy1dX2bA9mPl1ZrWTdS8MH34cxy66+gkfEe2PQogOEFf3hfgF/Exx+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159805; c=relaxed/simple;
	bh=pzZpbeAfRWRXcDaTKAmrNezLJqRxqLfisQvtNhqamEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fm9AnAUAr13tNaTvHR+T1tgxiMQPOiQsprlAy8SPXCaRaQlFhx9FJ5fTjvnAXpqQeVPkuzlaHLuxYPx7Q+/EdzUdsG/URNWEmDVGtiwWQ/pBClR5BkbBouopGGzhoaMfv28w4yFPOUu0HVlJxlCc3gCgpoI4k1DnSU77KcDPquQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tNE9ukff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D51C43399;
	Mon,  5 Feb 2024 19:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159805;
	bh=pzZpbeAfRWRXcDaTKAmrNezLJqRxqLfisQvtNhqamEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tNE9ukffTOlYg+l2HMtz43PyDpfQqXWN6UvQAV+FnRBEPd8+OKMgElpQoB+/lAZFZ
	 1P1cJSQrZ9HWM8QDCuryFGkoY/azrju9kLRrBVqEympDdj/0huGmENFYOmuTO5tKWm
	 tivm0vnFulu5d8C0b4v6EqHc3jX7VAiW+F7IfMT0=
Date: Mon, 5 Feb 2024 04:48:10 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: core: make nvmem_bus_type const
Message-ID: <2024020505-monstrous-shorten-81bb@gregkh>
References: <20240204-bus_cleanup-nvmem-v1-1-21775783d1d2@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-nvmem-v1-1-21775783d1d2@marliere.net>

On Sun, Feb 04, 2024 at 05:22:51PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the nvmem_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

