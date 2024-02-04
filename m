Return-Path: <linux-kernel+bounces-51701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC623848E5E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E5C1F221AF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4C0225D5;
	Sun,  4 Feb 2024 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W7OtkGlk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA7A225CB
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 14:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707056560; cv=none; b=B/MFox0apie85+kf4Z/jvmBslFEj8y+0XzfAcgUY5dhoGxGFhW0Yq+l0mYbzSEiqRjnBb//xYHcEFQoU4g3HelbCY2aWxr6mGLsFyyj00P8NjGaSyN7wC1ekyj5A1D5wg/mtkg9xL+yoPQKRMtM0m+sIjT37KEi1Pq4KvymXMUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707056560; c=relaxed/simple;
	bh=1CpwfGJb8JQnMtiapNj4quei4505VAdpOAcA5R9QxAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gpo11S0NpzX3Yp/6lN+x7nuzvxdCaJTBUa3v/QqcRkEJcYfbBdrfCQ4OcsuEcUmH9emjuPdEmQPbx3bcRdS1E1odC0pqsD2/0n5ZHDsf/7Up99XiabZgHPa6M8J8vwb+g8ptGFi+XXPmGiecUNn3KPbU149T0M7ZFFnaPDvl4Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W7OtkGlk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DFAC433C7;
	Sun,  4 Feb 2024 14:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707056559;
	bh=1CpwfGJb8JQnMtiapNj4quei4505VAdpOAcA5R9QxAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W7OtkGlkhyDGQZ1arVxEoHWGQ1XckOIm7TR7lzo+r9xazcFWngyTVQ5FNU0d8TRze
	 dNe1Gd5YjXxIciyMuUdcecn0NXYUKL6ccBoAH1JRWOOvlU6wfFFiWozufVyfq/ONzM
	 cv3UfgaIQ/iyBWemIVdovUuLjd7WI5TWY4X5QErM=
Date: Sun, 4 Feb 2024 06:22:37 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: make wq_subsys const
Message-ID: <2024020428-brink-sprig-d811@gregkh>
References: <20240204-bus_cleanup-workqueue-v1-1-311748f9101a@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-workqueue-v1-1-311748f9101a@marliere.net>

On Sun, Feb 04, 2024 at 10:47:05AM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the wq_subsys variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  kernel/workqueue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

