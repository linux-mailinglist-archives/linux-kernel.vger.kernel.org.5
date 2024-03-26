Return-Path: <linux-kernel+bounces-119187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC4D88C53F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E77DB20C37
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B013913C3DA;
	Tue, 26 Mar 2024 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljOk2w0Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F240713BC3B;
	Tue, 26 Mar 2024 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711463750; cv=none; b=dQmxNnaNAicA0kpoQDcTTnVlKPl+78r+nfoFz43spgfhnrwr6/9XxGLQG/YECgh7rTSPalZqpzIanqfbGBPY1gc8xKfUueQ00gNlWVclR1YodRcI9qTOd/8OYRHRtZhZ7HP2O2iBP6MQfSJHNRjO2RSotx0zxGKZUf6OB7yh9Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711463750; c=relaxed/simple;
	bh=Ni4Cb8d+9/UtZWDS1MJ8TsKOaKB5beJmlBXXrWRHe/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/EwqO4bVoy570OXruyjwfceJU/Hcx3reSec+LguVAcuusTTPOIrbtxW5sQtANHa6UjtGl9bBdvFpxpXOtms4sZeXN3LcF6ya9sJ5QvhqNuBt0mP7PlaSXIb43K5aEBAjfP8GCNDPcn9zh0EXcCEP2BBK/wYMepKHfamCSz1+1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljOk2w0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67517C433F1;
	Tue, 26 Mar 2024 14:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711463749;
	bh=Ni4Cb8d+9/UtZWDS1MJ8TsKOaKB5beJmlBXXrWRHe/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ljOk2w0Zq6ZBjwoNgc5qsqetXQWZmTaojsWyb4v2XxO43hoAfYg8lGvzDZDaieq/F
	 Dw6U/mn3/Cr60E3fGpxQ96TdizogFMEn4pserO15OvwzLFRz+U6mHZFLTVv2qOcEJg
	 lbpFSXHuUX3JdnzuFEXUt5TJhX+4SfVBhgcHosNerAhkIGwtMINQqM5dNASgF4guHv
	 +diZgWE7Ecr4m5YEgNirWGkme+EArfZw9tEg25ZDGVzPxqpDfmXb8rNgTQ4tCZzo+9
	 mwv0xDYZyGHfagGaScGs9ry9dDrnxjcD5bYe6AICWUKg1LNCPyGOlYD7do/3vHYhi7
	 fzJMSBkVa99nw==
Date: Tue, 26 Mar 2024 14:35:44 +0000
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
Subject: Re: [PATCH 1/3] e1000e: Remove redundant runtime resume for
 ethtool_ops
Message-ID: <20240326143544.GY403975@kernel.org>
References: <20240325222951.1460656-1-helgaas@kernel.org>
 <20240325222951.1460656-2-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325222951.1460656-2-helgaas@kernel.org>

On Mon, Mar 25, 2024 at 05:29:49PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> e60b22c5b7e5 ("e1000e: fix accessing to suspended device") added
> ethtool_ops.begin() and .complete(), which used pm_runtime_get_sync() to
> resume suspended devices before any ethtool_ops callback and allow suspend
> after it completed.
> 
> 3ef672ab1862 ("e1000e: ethtool unnecessarily takes device out of RPM
> suspend") removed ethtool_ops.begin() and .complete() and instead did
> pm_runtime_get_sync() only in the individual ethtool_ops callbacks that
> access device registers.
> 
> Subsequently, f32a21376573 ("ethtool: runtime-resume netdev parent before
> ethtool ioctl ops") added pm_runtime_get_sync() in the dev_ethtool() path,
> so the device is resumed before *any* ethtool_ops callback, as it was
> before 3ef672ab1862.
> 
> Remove most runtime resumes from ethtool_ops, which are now redundant
> because the resume has already been done by dev_ethtool().  This is
> essentially a revert of 3ef672ab1862 ("e1000e: ethtool unnecessarily takes
> device out of RPM suspend").
> 
> There are a couple subtleties:
> 
>   - Prior to 3ef672ab1862, the device was resumed only for the duration of
>     a single ethtool callback.  3ef672ab1862 changed e1000_set_phys_id() so
>     the device was resumed for ETHTOOL_ID_ACTIVE and remained resumed until
>     a subsequent callback for ETHTOOL_ID_INACTIVE.  Preserve that part of
>     3ef672ab1862 so the device will not be runtime suspended while in the
>     ETHTOOL_ID_ACTIVE state.
> 
>   - 3ef672ab1862 added "if (!pm_runtime_suspended())" in before reading the
>     STATUS register in e1000_get_settings().  This was racy and is now
>     unnecessary because dev_ethtool() has resumed the device already, so
>     revert that.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


