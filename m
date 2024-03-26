Return-Path: <linux-kernel+bounces-119188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D76588C542
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5E71F3EC43
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1BE13C3E1;
	Tue, 26 Mar 2024 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwxxIuMl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B005913BC3B;
	Tue, 26 Mar 2024 14:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711463765; cv=none; b=qVwMguqSl5Q7GTPFX6pKv6bk4jX1tVJScpJfht+BSZF4EfcOlFkvVrtiScNbPONnQ1eogJSxcAJ9NWFoUdxugwO7oo1Jy2KqF3HZr7bdAEYfMRw34QIz5oW0y45slkPFDL45YlWgbm7oDlq+qtDun+3qA/uv1goAAOpKNQpVOp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711463765; c=relaxed/simple;
	bh=T8xVXkMmTHcXVBfih/lyulMOMgOEEKuUVkaSFMpq/h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJTiqi5XaH6mJ2Hs9jxxDUo2JJdr9NvNTo/9zXNQqm/tswsIZDWHTXEP6KMiiMzM1EffgsXq6haFWP8g+2195GM15e4Lq0wqlUtRrDAiPrp2G/4+nnlfpI4rtppoQ8Rykm2Zvdzv2t2UMxE1PpEHjAKvaIaNrZ3RRmvLDUJEauA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwxxIuMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7787CC43390;
	Tue, 26 Mar 2024 14:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711463765;
	bh=T8xVXkMmTHcXVBfih/lyulMOMgOEEKuUVkaSFMpq/h0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fwxxIuMlcmMjiYy2E2+Gui0I7rU3vuw/GTXmGcHrjCjPQBzYSCqbHrS8coW9GcPdE
	 eBunKhyWoTi3rjx28+dTHxKzljq+4SAGc28Rh7GTwos0zZwc3EIOa5gvsJ2KrHkyVL
	 jPQ6/03CrtKIengXLAN2vU6iPoa3DWmP/pAAYZchH2zxyU+GWRwRkUYLuQ/N3abShp
	 I7VGiAVD60hgYzz6HQxNWYK0J+BwMzLRCGNiXiYIdxbmPai4g8HsvlbPKy61dd6rgY
	 WX47PiVKO232bk2iELiZ4v4R8+dLtmGScst2XPf7isSd/30DpyWNMH4jQPImmP1sW5
	 FUtmXRhESu/JA==
Date: Tue, 26 Mar 2024 14:36:00 +0000
From: Simon Horman <horms@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Konstantin Khlebnikov <khlebnikov@openvz.org>,
	Zheng Yan <zheng.z.yan@intel.com>,
	Sasha Neftin <sasha.neftin@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/3] igb: Remove redundant runtime resume for ethtool_ops
Message-ID: <20240326143600.GZ403975@kernel.org>
References: <20240325222951.1460656-1-helgaas@kernel.org>
 <20240325222951.1460656-3-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325222951.1460656-3-helgaas@kernel.org>

On Mon, Mar 25, 2024 at 05:29:50PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> 749ab2cd1270 ("igb: add basic runtime PM support") added
> ethtool_ops.begin() and .complete(), which used pm_runtime_get_sync() to
> resume suspended devices before any ethtool_ops callback and allow suspend
> after it completed.
> 
> Subsequently, f32a21376573 ("ethtool: runtime-resume netdev parent before
> ethtool ioctl ops") added pm_runtime_get_sync() in the dev_ethtool() path,
> so the device is resumed before any ethtool_ops callback even if the driver
> didn't supply a .begin() callback.
> 
> Remove the .begin() and .complete() callbacks, which are now redundant
> because dev_ethtool() already resumes the device.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


