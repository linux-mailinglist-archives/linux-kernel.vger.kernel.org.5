Return-Path: <linux-kernel+bounces-64030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48667853922
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD22DB2A429
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2F9612CB;
	Tue, 13 Feb 2024 17:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O4XYoG2G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43502612C4
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846900; cv=none; b=fULXnKxGY2ZFbHNl+Tbnny6R1Cvq7oyEZBTS0sjIHbx5iMaRAYx+q2gykmicB0/Z1YiFw/8dJVumA67hdPd+0oM6qvrbfkAzBSou/4XtFmzyQMHs89DqEKcdzS+dtqkzZPpKZcc18/lGYZ57wfGGc5oFrVEBOWBaxMd6ue+A3G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846900; c=relaxed/simple;
	bh=fkt9NvcefWq6HaVXS1+B/buBOjL8fqSRphpLKPoAspM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwnytQJKgP3XwwYw8p21XhmN5jEE84OAZk7yzrDXIzVLsPeVtybjkGGZcYmH+YwWZL0jiVTN/1rj16LzwqomwKtFOnKpw7SEsrEw4jSwccwwtPqRlhXzjpmJLlNV2bo5tU9t+A9+pLMUrmW8rxJp3oeKosOdGeT4oMiNYjgtY6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O4XYoG2G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F8FC433A6;
	Tue, 13 Feb 2024 17:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707846899;
	bh=fkt9NvcefWq6HaVXS1+B/buBOjL8fqSRphpLKPoAspM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O4XYoG2G3bRZ9UGOeRWlDOxTABe8Ay6u2udCejTrfM42tFVdg1brUE+5Ga2DFaE/6
	 LfmKImpTKVW29yOZkb8+NNQRIjOsvmxD0HWkF57RgtP5klXnX93q94jEsJnlBcN8s9
	 PcFZIPUoFCh1A3ccE6BOYdOs6tPkEa0DrccJjXVA=
Date: Tue, 13 Feb 2024 18:29:55 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: bus_type: make sdw_bus_type const
Message-ID: <2024021351-observing-concerned-38cf@gregkh>
References: <20240213-bus_cleanup-soundwire-v1-1-3878b00f6f57@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213-bus_cleanup-soundwire-v1-1-3878b00f6f57@marliere.net>

On Tue, Feb 13, 2024 at 11:36:56AM -0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the sdw_bus_type variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

