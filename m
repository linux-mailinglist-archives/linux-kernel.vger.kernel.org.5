Return-Path: <linux-kernel+bounces-123365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A7B890728
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DACF91F29706
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2C180BF0;
	Thu, 28 Mar 2024 17:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUiQfBep"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EE07EF07;
	Thu, 28 Mar 2024 17:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711646711; cv=none; b=onUkPxevWyWcAaUCOBf2oRv7WvqKbI7vp4WP+RkCpjIJVk5bMShvP1wwLYMW/Uofc3Ga2OqbWNxU666owLIIyIezWJsASd+h8s/3QuKs475mJ9GJ73yHtZHuIo95XEQlrCia2O4v2436/+K5AkHgfP6ucRW3HHR6Rh0r2spiw1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711646711; c=relaxed/simple;
	bh=4a9MWViGRcqAECnsnUOxO078l7HkHOclyczdE+L8b8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOQuU5g+68M8nBulHfFEIfmKuVeCGBRMBbF2S6SsviFsWWCi3MUjz/3LV6TDjfJGhC499gG7rfxviSDQHyuoRi/U1+RxMJRB2g9GCEv9kV+UsghHHlDj2OqIziWKNsDw8kqk7x9BXwuJsaQ3Y1xEjqOKISH5ciBcOjj8jS2bDoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUiQfBep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2763CC433C7;
	Thu, 28 Mar 2024 17:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711646710;
	bh=4a9MWViGRcqAECnsnUOxO078l7HkHOclyczdE+L8b8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dUiQfBepPA1AMjGJxnXohBg6QiEDNBLJomxDyDgNcW8B75CzH+ezeW+gLtvY7+sU5
	 WC+RBJi5svnnsSTLvvxT2tjIkYskvRxRshDvWoFdgupCMwkckm+8uvBQzEhjDbhEDQ
	 C2MovaXiTeODaQ0OX4QcbzcddvGpeUuEZHVOxlwF07scSjRLBHlNcpY/86iy6f2Rb2
	 OIPXLQBTobxv3TL2ViatQmUxGmwKTREhHjtQG8RIhNkxPyKxtFrOKzKKJRSDXzUBi6
	 0jIq3vnZC9uHb2DQxA3n0PmM4+f7/ASim9otgNOC+j2uDHRHcgZzPcKKPb+cHD0yaJ
	 CMUiC3Wf0tU/A==
Date: Thu, 28 Mar 2024 17:25:06 +0000
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, mschmidt@redhat.com,
	aleksandr.loktionov@intel.com, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH iwl-next v2 7/7] i40e: Add and use helper to reconfigure
 TC for given VSI
Message-ID: <20240328172506.GG651713@kernel.org>
References: <20240327075733.8967-1-ivecera@redhat.com>
 <20240327075733.8967-8-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327075733.8967-8-ivecera@redhat.com>

On Wed, Mar 27, 2024 at 08:57:33AM +0100, Ivan Vecera wrote:
> Add helper i40e_vsi_reconfig_tc(vsi) that configures TC
> for given VSI using previously stored TC bitmap.
> 
> Effectively replaces open-coded patterns:
> 
> enabled_tc = vsi->tc_config.enabled_tc;
> vsi->tc_config.enabled_tc = 0;
> i40e_vsi_config_tc(vsi, enabled_tc);
> 
> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


