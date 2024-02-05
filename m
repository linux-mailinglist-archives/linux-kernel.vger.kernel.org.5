Return-Path: <linux-kernel+bounces-53300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B06B684A329
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63BB01F223F8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8860D57867;
	Mon,  5 Feb 2024 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VHtFCzbY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C148756B79;
	Mon,  5 Feb 2024 19:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159783; cv=none; b=GKznMS+sAjWKc4psBjsC22IBPyCaK+aSYQ2Uwh161JMrKPUuv4/BGqtGttRFRcawzWKzJeULNpVoSq95+h4FlMLz7xbEfk1uAYiQPDjxYU3uIPVYh4467Iv5HSxbyH3eK/hp5CqWKqXN2S6aJ6WTw4S18ucNZfGcEHK765VZYL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159783; c=relaxed/simple;
	bh=znOHAaa3DwDxM9WxEYLeSLhTNRtK/ileI0+EFf25BJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aM6k+oKtv3Y60PeN/WM0FwPbKK+v0oiv+Im5ex6ysD500LEBwN8t7BXUeyQe0ONOY+IkEdS1ZUU9LQo13n5z0HtU96maEX7mMupN3vDpYe6L2j5irqfbJqMSrBgsxGdOPWGoGTjkwUXiOhs61UfGcGmDqSo8hrD+I4YINBzxt48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VHtFCzbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4771FC43390;
	Mon,  5 Feb 2024 19:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159783;
	bh=znOHAaa3DwDxM9WxEYLeSLhTNRtK/ileI0+EFf25BJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VHtFCzbY4M7dTXEyaWeGjOzNBDR7HPVRGMt/jW1i6iNDRdQMjh3Y3fndJzm/6lLK7
	 2ac666jz9Q6W1cFAFjaiQJBUbbNz6B1RyXx7I8o3tA87NJ0E8j/HLewekxi+Z2f6hx
	 zwlcDQ8A8x8KO8i3W7lExPmJ/qj21eOSAtmk9f+A=
Date: Mon, 5 Feb 2024 04:46:32 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa: make vdpa_bus const
Message-ID: <2024020528-armrest-disinfect-2c84@gregkh>
References: <20240204-bus_cleanup-vdpa-v1-1-1745eccb0a5c@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-vdpa-v1-1-1745eccb0a5c@marliere.net>

On Sun, Feb 04, 2024 at 05:50:45PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the vdpa_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

