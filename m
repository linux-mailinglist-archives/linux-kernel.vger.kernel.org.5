Return-Path: <linux-kernel+bounces-53646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E27E84A611
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BA2BB20F95
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8742186CDA;
	Mon,  5 Feb 2024 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zhoO5yM4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E91B16DC9D;
	Mon,  5 Feb 2024 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159844; cv=none; b=g095u8nYgg3jMXS7mbRzBBW7xsX5Foh2SrW9xn8qXyuz8fJJfEbriCl7+5lrsGVavXITRvdUBwHlMFI/kjDAeggH6rSTm9s63U66xhkfRUQ7lwVFIyLoJKr50vcct+aMIGD+crV7wW8nAq7dx2xnEHE7da8PL2Bw2xiq/1epr5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159844; c=relaxed/simple;
	bh=JHJpfUqaJyRZ4AI78rBIr1ZJeKJ3VKOnvFJCzFqVgZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZYgKEuIAz/nyp6bcRfuoe6ocoxbFT78QZCztAmg+iRQQI8SCpL1rrmQc+94GzQIGh3xdR+JRx5+ouVp9Hbx8oM8VBwoO8G6fSU5mfAsWTjllDr1SiZV0YR7acldvPFGwA06lbbrYOvKuv2mEjJZgO4nF+99B8hiXYx/+Zfb+cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zhoO5yM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E0BC41679;
	Mon,  5 Feb 2024 19:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159844;
	bh=JHJpfUqaJyRZ4AI78rBIr1ZJeKJ3VKOnvFJCzFqVgZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zhoO5yM4124w2Zl5AxBaNtWSYFSQD4UcD5Jnyqt31Gu8c07+/fBjvikl8hHhJswSq
	 SH3CSKhg0zETu6WIXbf50Ia+zB/Fplvvl24zIP6WX7bBj9vVO0EJbTn502AsIGCkpW
	 wP/D2oGRprVHHSQXYohTmuld9mFumVAeqm9qZFA4=
Date: Mon, 5 Feb 2024 04:50:47 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: William Breathitt Gray <william.gray@linaro.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: make counter_bus_type const
Message-ID: <2024020541-reveler-urgency-30a0@gregkh>
References: <20240204-bus_cleanup-counter-v1-1-cef9dd719bdc@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-counter-v1-1-cef9dd719bdc@marliere.net>

On Sun, Feb 04, 2024 at 01:02:30PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the counter_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

