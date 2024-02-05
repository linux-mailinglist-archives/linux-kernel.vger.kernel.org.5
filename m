Return-Path: <linux-kernel+bounces-53786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D4D84A6A4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A287AB28240
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5D31A8B0C;
	Mon,  5 Feb 2024 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IrR1GCGi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C86F17E4A6;
	Mon,  5 Feb 2024 19:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159859; cv=none; b=c130EIe8HtNd8xjWHCh8W9Bt2lBgI9G+IEw4G2AughZ7I4jlVKijgsCFubKscSe2/ApXgwCoxEcEPDUZyMHJugA0FaOlo/S2IY2WSvmqBBHKKYEihpAD8f2P2HtubEHe9AYdpzhz+hBEIINUO3ULa8L8SZR6JyyUI9uqJdPnvR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159859; c=relaxed/simple;
	bh=GWC/R9KnvqMqsuGJbyvLUE5rq9tD0443OWb0hB5RjH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktNBOHkVwBQKg0xBxM5FygSR4Dp/cP9Own6AXV+c+kkTxv7VJe6zfyG2nRdYNWTU61k0UZd1mOZf6RNQuwAa7Z/eNYcHpXxEY+jFuQOUmLon4ek4rwFcImHUNqmDCuZmwI4bVM5rwD4yOEQy0GlwyAJ8iKLzfU0Q7WGD0Em7jbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IrR1GCGi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B4EC4166C;
	Mon,  5 Feb 2024 19:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159859;
	bh=GWC/R9KnvqMqsuGJbyvLUE5rq9tD0443OWb0hB5RjH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IrR1GCGiwB3VHXLh8IdqQ+YK+uzFscY6O+5W7MoIo0fmsSGQ2GLeDeJyILQyDyvXR
	 WR4FqB7xeKDJh0U7K7Q6xkydRRYAzpskWCwobKnk9+jNEBC50GHdItqOVQiNrXXlef
	 sNQZDzmcYllmZEzGkt39T0QPBsMrNavnMaOKIA3w=
Date: Mon, 5 Feb 2024 04:51:56 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mips: struct bus_type cleanup
Message-ID: <2024020550-mountable-grandkid-a4a9@gregkh>
References: <20240204-bus_cleanup-mips-v1-0-05af5e9a7ead@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-mips-v1-0-05af5e9a7ead@marliere.net>

On Sun, Feb 04, 2024 at 12:06:56PM -0300, Ricardo B. Marliere wrote:
> This series is part of an effort to cleanup the users of the driver
> core, as can be seen in many recent patches authored by Greg across the
> tree (e.g. [1]). Specifically, this series is part of the task of
> splitting one of his TODOs [2].
> 
> ---
> [1]: https://lore.kernel.org/lkml/?q=f%3Agregkh%40linuxfoundation.org+s%3A%22make%22+and+s%3A%22const%22
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=bus_cleanup&id=26105f537f0c60eacfeb430abd2e05d7ddcdd8aa
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> 
> ---
> Ricardo B. Marliere (2):
>       mips: sgi-ip22: make gio_bus_type const
>       mips: txx9: make txx9_sramc_subsys const

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

