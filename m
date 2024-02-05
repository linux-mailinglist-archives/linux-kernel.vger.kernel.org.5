Return-Path: <linux-kernel+bounces-53292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7406C84A316
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE91281123
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAEF53E12;
	Mon,  5 Feb 2024 19:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xX9ooG6k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90534D106;
	Mon,  5 Feb 2024 19:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159779; cv=none; b=IkU1+g9j89tgf2/evcMpgvVz5Na/42/+op7Ok34AjsDCq8QobDAvvjqWvXoz7kPYK5uWf3VzrbsPajlDedwqRi/Fyvb33L30rAiKMAytjThLLVgI2UANLZCF73AerwELLxzNsUAjWKEPAjsWOujpV7nY/K+XKahIOI7xJJ5kHSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159779; c=relaxed/simple;
	bh=G6nL+TpgdXW2ESXHKmN0991j/T+6gE1AmmqfjsDN1V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXtqNj+J1cyN+SHnhXop5lyOUkw7hqLEmvQdC0mB4FzK8mAHDJk6B8XSsOtPXpy88yfnugUJS89bwms119JdGqM3pEqKZ9qRXx1P4VAw7ZVi5KVAQNefCjjsl3FY8b/1U1HRIe6trL9PIFyXXC4v6QbFO3lGeq1HH7NG9aPUs28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xX9ooG6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2EDC43390;
	Mon,  5 Feb 2024 19:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159779;
	bh=G6nL+TpgdXW2ESXHKmN0991j/T+6gE1AmmqfjsDN1V4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xX9ooG6k59BVHRB16Y8diFIgAqXBPqkfRy/pd5y0oolnixXCvyduzY0LQ0uEcjakx
	 CU5KVHp6+X41K+RtaHLMbqiRVLZXYAm13hD1HAVeREfsvVBa40Zc06Nl8KM7d1kKvf
	 hmeIoCLlEWv9HhXf3gbKjym1ibffZg1mdbKJb2BI=
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

