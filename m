Return-Path: <linux-kernel+bounces-161079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8C78B46CC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 16:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BB93B23DA4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 14:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC37FBA5E;
	Sat, 27 Apr 2024 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAP8MeSu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC9123DE;
	Sat, 27 Apr 2024 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714229851; cv=none; b=tR3+vsvt8j7cbeJ7y3PzYyV5qEYE0OdH40h1s+YELDh61VGxq+U9SepEqshXjO8mFlSFgFXepRrUWdr7nOUo0JN5GQGVqSqsNgW6p+ya1MzzuRwi249ijX6cOi9GCaXjDPUeIYSFHNAkAf2fbAR+hCKmm3H/R1oSoJE4ADUP0D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714229851; c=relaxed/simple;
	bh=mCv9x1EKrhloSSiqcx+RUqM7323tzFzD08bdhSgkKsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAkXLf2An4e1gvkUpdnu4TmNeU7QKpBqEHE+HTir3d9+k8NfQwHo/gsNfcn+Z46oarth2rCudxIDQMKNaxzZQqPQRvaTNhNOrr1CASpWImJmNhb9lmpPfuTUM/tPkle4vhufPkz7bVwomvzN95lfwU+BweuIzeMYuen1IZ4AktI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAP8MeSu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D15C113CE;
	Sat, 27 Apr 2024 14:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714229850;
	bh=mCv9x1EKrhloSSiqcx+RUqM7323tzFzD08bdhSgkKsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kAP8MeSuQZWSzGNFPVf9BF26QJPQG4sWzrWBffWmqIlDap/oD7povPZJXD3piZEBX
	 82zVTKTktPNuUlb3gbGx/+kS4j89DVrmKYLxOoN/eQuSqYcBZ4Ed/Csk9YZiEryEhI
	 Wu0hSqNTSnVZCB6gC4cNcR67Lo2U2kqcHVi2LlidR1DNuc6WTCqdEvUaFxdwBEDwOX
	 e8QUFOYbKEH8iFiX6dPFYqldbvcnrcGKaKuqrZ43tIfEB5zgFq4IENiEQwhpO60wZp
	 CseDW0FKtrdS5b51aDJG94c4RlH0vkPmlDCY5UXYkcDx0aMAw4Pka/mqcfp4sxpwfp
	 EZYATY28u2l7A==
Date: Sat, 27 Apr 2024 15:57:26 +0100
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 7/7] i40e: Add and use helper to reconfigure
 TC for given VSI
Message-ID: <20240427145726.GT516117@kernel.org>
References: <20240427072615.226151-1-ivecera@redhat.com>
 <20240427072615.226151-8-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427072615.226151-8-ivecera@redhat.com>

On Sat, Apr 27, 2024 at 09:26:08AM +0200, Ivan Vecera wrote:
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
> Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


