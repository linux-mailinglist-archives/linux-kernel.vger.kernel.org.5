Return-Path: <linux-kernel+bounces-119189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E06788C545
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10C42B22756
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD10513C3E1;
	Tue, 26 Mar 2024 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOLND2jc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFCD13C3CD;
	Tue, 26 Mar 2024 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711463782; cv=none; b=oR/+4a9WsglgydRjBe/XaCrcMnjBfJH5vasBsoVvUEvYHKlitxIlqcKdqq5jjBWnMdXEMV8XEmrGR6M36nD3FHkH0Tu0AL0vfRC5u/EFMxtpOUjdM/4niSy9O4AS7OdvgZ6a3KmrWL4Sxw+ud80bOcqJiO1TjZyCNSbXZ8gTEQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711463782; c=relaxed/simple;
	bh=T5+Ilvr1b291b954quPpgBb3WMNDJu0NuiX26qSRQHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHp6Z8PLJsv6gFqPNgX56rhYBgZPQ6UEFIGRpmIiKMZkmNnmstPLDfTjVe0jdf4Tufs0bYaKe+XREXO4TkjzRrD8b+gNJNVAnVsw+vj3u+9vIA1A0jLbeZjvQZA8LtpecjX1XAnfLdnPoT2sWgxlo2KLLVj/5+c3MkrfySGoSbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOLND2jc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79317C433F1;
	Tue, 26 Mar 2024 14:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711463781;
	bh=T5+Ilvr1b291b954quPpgBb3WMNDJu0NuiX26qSRQHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HOLND2jcqr9pzlZ0/W6u68xW9sxo5LaL+MKtPF7dPa0aiJMCqkhT98LeRf0bujSJM
	 Aa4TBjibbEVL3Hv0ClMRocZaoqSY1KnXqSGMtGZNwipJeC+dR8i1BxCeuRWdkaO2xq
	 QWn6ElobDNbOk5GfozD4c+Jbhr3JX2FVbEZCHzc3dDXxxtOqPY0x0AxUPoR9JUY5qZ
	 n0vU4KN7M7ATBm3/UzyCjDoZc4K15QFWoJMRmGJWaC8m+P1u2Gwb5r7AZPWd6HK7So
	 +sAeH/GwaJqoKLpWHJpYhNM4SuLIbDKFbTHC5Ubbvnax06TQgknCruQB8sPLh/hPzM
	 An5+oSrus34kw==
Date: Tue, 26 Mar 2024 14:36:16 +0000
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
Subject: Re: [PATCH 3/3] igc: Remove redundant runtime resume for ethtool ops
Message-ID: <20240326143616.GA403975@kernel.org>
References: <20240325222951.1460656-1-helgaas@kernel.org>
 <20240325222951.1460656-4-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325222951.1460656-4-helgaas@kernel.org>

On Mon, Mar 25, 2024 at 05:29:51PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> 8c5ad0dae93c ("igc: Add ethtool support") added ethtool_ops.begin() and
> .complete(), which used pm_runtime_get_sync() to resume suspended devices
> before any ethtool_ops callback and allow suspend after it completed.
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


