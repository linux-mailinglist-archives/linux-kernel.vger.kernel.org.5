Return-Path: <linux-kernel+bounces-96302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1168759E8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24EF1282AD2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0F013BAFA;
	Thu,  7 Mar 2024 22:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EBZBJUiO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9940A1EF13
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 22:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709849084; cv=none; b=Ex0+kmaViHQ5PMQKjxkMQnmLnOWpTgRV0/E2bIQLNZ/ZUH8s/VqYkTu9MZiT9OLZygdBdAr3+UkPEKzQp9agFKjuqqgcQtIwPF+zY8z9pmt/Eoq+8e/hgLbozz2UIR+U9R1B8X9Asi6yV7VN+rYoTvIC/uiK7j0jKMBFfwsAkz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709849084; c=relaxed/simple;
	bh=Xbx7IeZFMT61R6EmLKA7T0kitwSc6IXVHXZOBHCG0cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKtSk36okHdUayeGdi2X6QnvZRUxP2iQEmvw+g1owCVJCdE7Z9wh78kxkILGEoFP2ilfuBrV3VLAKkmI3vTjmo01Q+qZx4ycbt4CZ5mC+HwwM0VAOwzzZJKgFBrhVRGBrppdmQToM9sgyuOVELQSPZoKtTvqTzUuLV/PqEcfgFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EBZBJUiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAE6C433C7;
	Thu,  7 Mar 2024 22:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709849084;
	bh=Xbx7IeZFMT61R6EmLKA7T0kitwSc6IXVHXZOBHCG0cM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EBZBJUiO2DsgaSao58W+Ejt1lEiKt0afwvQ5dnxxr2m+RP5E5P/MgFOX4cVqQ83c4
	 Da+OZi7CdR3/D+A9q9lgwA3nqIxv9oW0w+dAXsXeL/D5elUaNNu466eBDgJuifgCet
	 BIXHOaKlUh09odPml+KVTmPu4DZCa9lvmrW6Daik=
Date: Thu, 7 Mar 2024 22:04:41 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysfs: make sysfs_emit() return ssize_t
Message-ID: <2024030713-favorably-liking-2135@gregkh>
References: <33cd8f96-4b4f-4741-ac05-ef1bd267ce6b@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33cd8f96-4b4f-4741-ac05-ef1bd267ce6b@p183>

On Mon, Feb 05, 2024 at 01:11:36PM +0300, Alexey Dobriyan wrote:
> sysfs_emit() is most often found in functions returning ssize_t
> not int:
> 
> 	static ssize_t oops_count_show(...)
> 	{
> 		return sysfs_emit(page, ...);
> 	}
> 
> This pattern results in sign-extension instruction between
> sysfs_emit() return value (int) and caller return value (which is
> ssize_t).

Is that a problem?

> But it is better to do sign-extension once inside sysfs_emit()
> then duplicate it at nearly every call site on 64-bit.

Why is that better?  Does this affect code generation?  If so, how much?
And to what affect?

And the function itself really is dealing with an int, it's up to the
caller to want to do something with that, not the sysfs_emit() call
itself.

thanks,

greg k-h

