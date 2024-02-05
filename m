Return-Path: <linux-kernel+bounces-53362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA3B84A39C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A632856D4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB687FBCB;
	Mon,  5 Feb 2024 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ugpLTutO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBAC7F473
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159803; cv=none; b=LC9tgqhSx7IgkXerjk+MewKg4w6WbgyLa47gZEUjh0n7H7cj23mFQ+g2ioZ4G2s8lNqJ1pQndV3+rLGVAPXokRE6vYqyrqWJrAn4XBpsvRyk6JEvU3K1eZH6PREeVJD1F1hhPWdkNCoDvRK8eksU7fFDZ2Lm6uMLyHAa6FxXcQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159803; c=relaxed/simple;
	bh=pzZpbeAfRWRXcDaTKAmrNezLJqRxqLfisQvtNhqamEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dePCiBowfnIiiPVTj7iTFdGzIwt+iPxKhEe2p4NnldRz0ukW+O8B4meijf6yEu0wWLHCCF9A2Y0uo17m1O37ho0d9FFhjxq0v9J5kwtW16rXwovpyUHuthHntEcw5JLPJpbxpAFnLms7M8fkwauEmGJ8n8IucPkk1wPkxhQAXEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ugpLTutO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3B2C43394;
	Mon,  5 Feb 2024 19:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159803;
	bh=pzZpbeAfRWRXcDaTKAmrNezLJqRxqLfisQvtNhqamEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ugpLTutOtGyPWkEGV1MievlAziIQAkxEGCwdGPbXkLW7UFzPZROzZNl03YKrPCGyb
	 taOuvQ99lpYVT7jCHgp5t3RZ2O5rTua6iL4WxKNJguFN8W7hFAGbyfEq0zkZV9jo+9
	 bRlFz4IziM3DXFv56pWk5c+h4y0hNgvHng7LoHg4=
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

