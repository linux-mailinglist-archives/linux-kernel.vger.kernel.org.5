Return-Path: <linux-kernel+bounces-108072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238B3880596
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0FB3284097
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB833A8F0;
	Tue, 19 Mar 2024 19:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPj5lcGs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505D339FFD;
	Tue, 19 Mar 2024 19:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710877399; cv=none; b=Byrp+JPi30yXsDVD/OFamzTbnskCDmdqgUM455ttmIm9/1haX8Lg7xjPG9sGbL6fu8fx60HYtCc2+OqyrXJir+APDvnUoyaZoU9gvPKUYUY5SV7s16kC+QS5kkG+PFILFy+tMPe859h0CvIBaoGky+8Xdr5xmlqBRqKDG3ebM90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710877399; c=relaxed/simple;
	bh=4c0gTY5ILrK0uD6EsujNoi/J2gWpLE0huRdLKPHIfwg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K8TLd7IZmow2i5uDTMa4yf/MzkKBAIvpOzQ0zDAOkuGL1Cgb+fRya4cmBFIlY57yySbY/okIZ8WShSzpY9d/Nn95W358sNEavImIZx4JezFe1EvdROvRqA93SAKSaVo4kRLjJuZIv5+L93EsxsGDWDrt8jJV3ynccOoIeL7SAtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPj5lcGs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A102DC433C7;
	Tue, 19 Mar 2024 19:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710877399;
	bh=4c0gTY5ILrK0uD6EsujNoi/J2gWpLE0huRdLKPHIfwg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hPj5lcGsZBFbWYX9sTipBmth0flulHxveKZSdSIYL9f9rnIFdPotJ6AjMBKD9E1Wx
	 Sfu6LWJqHTQmjEHpqD7W6UVFp526dSluffT6r6Lkpy/tN0s0b0eV8IT1jY2Iuy0ot7
	 FnynRVm1UV0bQlEwjm7EfDD7x0rScmrqtfrz55YX5uqHh9z4my7KKb48L0CT3ZtJuj
	 qhKbGM2CLqEXiHYNK2QyoEZaVjw82vdlfv2xfLQdrsFCy13lnNP+4BKRMzGuuO/lJx
	 D309CxTY3kt0I5KXRslduxBgSvTFNf56Iju2LDEyAkGaQO0op5UzVkkZGzhYH46qsB
	 6mtHcRQkiIalA==
Date: Tue, 19 Mar 2024 12:43:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] ice: Fix freeing uninitialized pointers
Message-ID: <20240319124317.3c3f16cd@kernel.org>
In-Reply-To: <77145930-e3df-4e77-a22d-04851cf3a426@moroto.mountain>
References: <77145930-e3df-4e77-a22d-04851cf3a426@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Mar 2024 12:44:40 +0300 Dan Carpenter wrote:
> -	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree);
> -	void *mac_buf __free(kfree);
> +	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) = NULL;
> +	void *mac_buf __free(kfree) = NULL;

This is just trading one kind of bug for another, and the __free()
magic is at a cost of readability.

I think we should ban the use of __free() in all of networking,
until / unless it cleanly handles the NULL init case.

