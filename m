Return-Path: <linux-kernel+bounces-53298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC6384A327
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43383B25694
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0942957303;
	Mon,  5 Feb 2024 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CK6gDeWz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C8A4B5B1;
	Mon,  5 Feb 2024 19:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159783; cv=none; b=Qo0VO0zWKWYrc+Xm8Ep1wnXh6QMFGiC739XIwZ86g0LggerO4ejxqdcKHkFc/6VPStyKs6ay+RubKmOhCi62IdFPEOv+3YNZUYDdgJkSYi8QY37hOmLlnACiIt9ujXFXhkrDQE+DKnHkEk9d4caOcEDKUWHJ0FlAJnYO23NT5BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159783; c=relaxed/simple;
	bh=znOHAaa3DwDxM9WxEYLeSLhTNRtK/ileI0+EFf25BJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aM6k+oKtv3Y60PeN/WM0FwPbKK+v0oiv+Im5ex6ysD500LEBwN8t7BXUeyQe0ONOY+IkEdS1ZUU9LQo13n5z0HtU96maEX7mMupN3vDpYe6L2j5irqfbJqMSrBgsxGdOPWGoGTjkwUXiOhs61UfGcGmDqSo8hrD+I4YINBzxt48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CK6gDeWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4EAC433C7;
	Mon,  5 Feb 2024 19:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159782;
	bh=znOHAaa3DwDxM9WxEYLeSLhTNRtK/ileI0+EFf25BJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CK6gDeWzryYBIhmvc3sZdBDLF8IHTQ7MRUDiWNIphDXcET3zwxhgLhzsVrZgnlqmL
	 r6XF/i16wo5e3R2TXfadszu0HWFuFFkpz/67eMR+s2yOj5+3i/Y/MrtrAhS/zgS+WC
	 NfmYPJPAJLefxJr7HiafmXt3fcT2nKO0xwX/3SzY=
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

