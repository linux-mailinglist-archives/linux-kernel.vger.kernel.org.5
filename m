Return-Path: <linux-kernel+bounces-53541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF7484A516
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEA4CB237EB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A52172EA6;
	Mon,  5 Feb 2024 19:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Za7DVdlb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0762E14D456;
	Mon,  5 Feb 2024 19:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159832; cv=none; b=WGgD5B1l4V/RSFy/YuebSWOyoHHl6qLME8RIml4TkwM8ILCrFgOg0nfYCRkOv3grdR2Nto5hYn9X+7bgTWAqVqlEGIgUUmmVfcO7Kb/4inAIdYCsXxlJFeAPeUfZ9pMQ6b2UhV8/TZkYP/DDxxNsSBJFKt/1osu9RzfHBhIdA5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159832; c=relaxed/simple;
	bh=enzvkJrZvs3n5pWxdWktechxKDk4+Wgewr4aMoQPZwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMM0jeu2/stm6nwqBXiflt3cGcX4Pp9efROwHiz4PzwXduYxGobJdMRwu/EuwcrMeaiAy4e4PHGBcvnBRvfAykLmxw4rJQdHujTmhLDN6bukA6xxQWyyXfA0LVFns9Sj2YHQpufvDEVUX4X56FZzeqvM5a4pWSKZeDngZItsCuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Za7DVdlb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F614C433C7;
	Mon,  5 Feb 2024 19:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159831;
	bh=enzvkJrZvs3n5pWxdWktechxKDk4+Wgewr4aMoQPZwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Za7DVdlbH6EBmG7c0dtkmfUp5YOBYkQUMm9RbxyToobd41E8nL19GVwnt7kxf22cw
	 e69GalEOpccZpixinBY2+B/HLpjngTem5v1+AGXCCCF6EMuhb2IqoY5CdhTZj3sPRu
	 yhFBzF3j1s2WyCck1/wJr45tvpJlfar4HTkXbxAQ=
Date: Mon, 5 Feb 2024 04:49:55 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] ntb: struct bus_type cleanup
Message-ID: <2024020550-protract-deviator-0b35@gregkh>
References: <20240204-bus_cleanup-ntb-v1-0-155184f60d5f@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-ntb-v1-0-155184f60d5f@marliere.net>

On Sun, Feb 04, 2024 at 01:21:59PM -0300, Ricardo B. Marliere wrote:
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
>       ntb: ntb_transport: make ntb_transport_bus const
>       ntb: core: make ntb_bus const

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

