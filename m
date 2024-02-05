Return-Path: <linux-kernel+bounces-53294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3C184A31D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2B61C24433
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AE855C06;
	Mon,  5 Feb 2024 19:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0b0OeZuj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEFA53E18;
	Mon,  5 Feb 2024 19:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159780; cv=none; b=RE+cf66iv6ypki5ryUIcXn8rJC3nAG5BDCrtTaE7ZXs6O+Kaht9WGnIgsedD0G613Sc6pZFcLjJPbifFC+mIOrt71aB71dC46MKM+M72sRVMlxN9Ido4GuL/EBqJ6uqRKSKMjiFjOXfv4zujxHuD+o06dNaJ3CoAeQ5BLFPdjN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159780; c=relaxed/simple;
	bh=G6nL+TpgdXW2ESXHKmN0991j/T+6gE1AmmqfjsDN1V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4g2jWYU6+W3AEE/ojW7wPE2tjXjUvQ937YAAFVLrHm2IclOqg0F41M23BHUZ2sWEiQTJ6bncitv7n/QicOOR+LRWbEdyIN8QN3xjqbrQkesNGgSEGnDjY5wbSBJRO7YpMLGBO6FfM1VO/R4938Xx0STPe24IyOWGxwTyp7pIFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0b0OeZuj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB50CC43394;
	Mon,  5 Feb 2024 19:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159780;
	bh=G6nL+TpgdXW2ESXHKmN0991j/T+6gE1AmmqfjsDN1V4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0b0OeZujimCh+VIY8aISeUjxx9m8S+pyGSKH3wkqWHfh/DKO7xqyVk/aEApg1OdkV
	 3FGzZjrV5vVkxxZQSaMYbIJlyYIjZmSRFAjIj8kC1bDe7hDRHVKQ1lCK2e6NDG6jhJ
	 KfDuQjV7LQcPQRy8i9f9H8kffVi8co4Srja9YZkk=
Date: Mon, 5 Feb 2024 04:46:21 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: make virtio_bus const
Message-ID: <2024020512-landlord-manhunt-25b2@gregkh>
References: <20240204-bus_cleanup-virtio-v1-1-3bcb2212aaa0@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-virtio-v1-1-3bcb2212aaa0@marliere.net>

On Sun, Feb 04, 2024 at 05:52:51PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the virtio_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

