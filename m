Return-Path: <linux-kernel+bounces-53370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB99384A3A6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AB951C22E80
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1523C823AD;
	Mon,  5 Feb 2024 19:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x0lTfEf1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E75880BE6
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159805; cv=none; b=rlISnK2t9fRvMvQaXpT+VuAIDcCv6dPQn2WMC/JWkhxRh3/JQzva3Ms1IstiyDziugwJ0lHXTDxXp+bwPh4m3A4NWJ63ke/8M/h6P32YtWGqUuWoIE7zJVy2ZdyxIBhG/O/E/ny8gc22pN+aqAjI7hGUnbkHnE8SmKEXsycEx+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159805; c=relaxed/simple;
	bh=pzZpbeAfRWRXcDaTKAmrNezLJqRxqLfisQvtNhqamEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fm9AnAUAr13tNaTvHR+T1tgxiMQPOiQsprlAy8SPXCaRaQlFhx9FJ5fTjvnAXpqQeVPkuzlaHLuxYPx7Q+/EdzUdsG/URNWEmDVGtiwWQ/pBClR5BkbBouopGGzhoaMfv28w4yFPOUu0HVlJxlCc3gCgpoI4k1DnSU77KcDPquQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x0lTfEf1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16F6C43390;
	Mon,  5 Feb 2024 19:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159804;
	bh=pzZpbeAfRWRXcDaTKAmrNezLJqRxqLfisQvtNhqamEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x0lTfEf124QO85OU4Bfc9+FmBepmukA8Wr7p6zTbPcSBR8Ru4sZMjjTUTyopEqQ+B
	 u8OOejLeJSfjo2PMys2ul712dtb8SfXkLQ7kq6ZxKiucAAUp4hBVad+A2MlFv82BCL
	 XD6i4fcMv7Rk5CoFsBgblENNWvW/3W4zFdizjFb8=
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

