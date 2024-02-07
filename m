Return-Path: <linux-kernel+bounces-56290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CBE84C858
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD42286DB4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1441124B39;
	Wed,  7 Feb 2024 10:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QOQE5xZS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31773241E6
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 10:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707300758; cv=none; b=QUa8GRSYwQa9R02HvGuw+2QkovHLsUv48alhTiheawGwhyTqH7Poo9E95TYOQFYt9Sx2uuEYxbPXW8tSs2haw53EtbN5lcXDZEu8exoRtR54q30zSPGk2nwidzv9R2UlDDGDewcSxpO7kYAv82ioKB+xrc/cUleIKfWloNcyH1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707300758; c=relaxed/simple;
	bh=Y+v0eyT0XQ1tyCEGwMTDA+YBw9zpRqps4fcTDdHbrDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKOxCSlJINvvTgIMVA+kXkayE9TFzafwXa8VlaTANSRgwy7T1QRCyMmt3Zk6p35X5YZeRVE0a4b8llqVXaYq/llYAEfMEf1wdtSTGXq6IgIvUAT1tFYwsQE4QUTCloCXRnPq/+GnBp7LnwuKM6Tfo4el5nWKPPmCwxtyHaH/0Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QOQE5xZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E8EC433F1;
	Wed,  7 Feb 2024 10:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707300757;
	bh=Y+v0eyT0XQ1tyCEGwMTDA+YBw9zpRqps4fcTDdHbrDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QOQE5xZSv+QafwjC7N8enEavLhsLi9dYo0oHuK7G4kZ8OU3+L5s8YhjxdT85ksWRo
	 /cWWFrpPDVctta9mYY5YhQJFdj9KVXYNmObMgIFvwvFCR5Rzq2zBk5f8DkVUnK4IBS
	 v3acnP6dxtWGcf43nYK0cNGslpRf705mjfBg5Ow0=
Date: Wed, 7 Feb 2024 10:12:34 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: make wq_subsys const
Message-ID: <2024020752-tannery-frozen-04ea@gregkh>
References: <20240206-bus_cleanup-workqueue-v1-1-72b10d282d58@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206-bus_cleanup-workqueue-v1-1-72b10d282d58@marliere.net>

On Tue, Feb 06, 2024 at 03:05:06PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the wq_subsys variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
> The maintainer asked [1] for this patch to be received through the
> driver-core tree.
> [1]: https://lore.kernel.org/all/ZcEeOueCbrltxr_b@slm.duckdns.org/

There is no cross-tree dependency at all, but hey, I'll take it, no
worries...

thanks,

greg k-h

