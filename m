Return-Path: <linux-kernel+bounces-53326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB1D84A35F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188BB1F25DEF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AE563110;
	Mon,  5 Feb 2024 19:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0IFu7iQq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF8C612D1;
	Mon,  5 Feb 2024 19:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159793; cv=none; b=OgoQc/043ufZDr+fx0AyTahuvJKk0SJMhIWAjt9pO/7aQDTtbT9QSyt34DPVYJmH0RnNCrUIjJaSa8ezFGKK8C/GOKe3rrIDqzNNJN9LaVTWDaeB6WEWTiPxpz2dq9cFn+zxZd5zVVCfRkJgnLP0cOe6pepdO5rDCzhQBPvsHUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159793; c=relaxed/simple;
	bh=NPy4Qjb0aNJaUt1anX4DLKcJO8MAHo9hxB1lf/SnJVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0kueLigvhvVvLyhGT8uQI3e9bLCWD97e1jghd0oBo1ZKJMeTzMbSSh0tRaFKZBQZwneUTnTtuNbQ5lp6RO/jS5NopMqA1RXhYDzWa5cRgPZMIcRpZVQyXzQgMRCy8s5oFPXN+AAQj/E134XjJuTG6DLD9oRvdfo08sQSCrWA14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0IFu7iQq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A074C43390;
	Mon,  5 Feb 2024 19:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159793;
	bh=NPy4Qjb0aNJaUt1anX4DLKcJO8MAHo9hxB1lf/SnJVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0IFu7iQqTx6bOTOd9vriIMwWn31HI/bPOkRqA2a4tGAG8ZJiPvlqlSUl6BO+dg474
	 19J0CsV8O3ClscHUREWfK1OXMtqF45AC4IRjf4N24PtEwWeyHEMeogv3xevuQPmCkA
	 SSpPInlyWBV2jxqtCMQPZJQnUzoEJY0pM/MPduZM=
Date: Mon, 5 Feb 2024 04:47:01 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rpmsg: core: make rpmsg_bus const
Message-ID: <2024020555-disrupt-remark-5e34@gregkh>
References: <20240204-bus_cleanup-rpmsg-v1-1-1703508c23b7@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-rpmsg-v1-1-1703508c23b7@marliere.net>

On Sun, Feb 04, 2024 at 05:32:05PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the rpmsg_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

