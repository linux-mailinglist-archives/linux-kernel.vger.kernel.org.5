Return-Path: <linux-kernel+bounces-53605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 545B684A5DB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54E61F2843E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FB3183AF8;
	Mon,  5 Feb 2024 19:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wEb4NtGQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9B615CB65;
	Mon,  5 Feb 2024 19:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159839; cv=none; b=b9x8tP6ya2fHce8P5qxEjN+dwTVSOqA6hcdZ+sW6bPegONyTfIMd1tQIxrWJ4/kbBEuffVCX+LL2AKQbrp+9T2QItgWwZCI9bkMfl0IkNC5B8OrAIFmDSp4D6RtSE6DyzJTOf9OefjTClTxkDuvaz2JMPtqTSt7XAYGiOVSUEyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159839; c=relaxed/simple;
	bh=JS0rLE0gDCoPrvmO8t1oRrM76E6Y2uXxbFDJB1HChLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jViIM5+9ZUhXhr2YaMlOmX33V5sIHVCOT5ErtxqBJ04GURJ+yqaXJmGsfJz1uBSxfhbYfpbUbxH4UzMjw8Jki2iz7FnplWk7D6k8YNzi8SY3Et5rbs0p0GrSNY4TyLE4eSKfC6R/wNGrwRmf8bcql2JzWFrm8fw/j1uqe2K5h9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wEb4NtGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C3EC43609;
	Mon,  5 Feb 2024 19:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159839;
	bh=JS0rLE0gDCoPrvmO8t1oRrM76E6Y2uXxbFDJB1HChLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wEb4NtGQnfTx4QVjK/zRTrr65E2uDRnpxzOM8ywru89UXQsk469aEZvWqs7gUHCiX
	 hlQ/ulqIH1LHVWgJe+hmuZRd3Gfzi8gVpv9XTe14n2oD/SSBBEh6wnFEF0z+aN5nc+
	 giBsWjDdxjepllpSduNCw4d9jbXhyrx0LIYEmWJY=
Date: Mon, 5 Feb 2024 04:50:30 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Julius Werner <jwerner@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: coreboot: make coreboot_bus_type const
Message-ID: <2024020511-confound-chirping-38f7@gregkh>
References: <20240204-bus_cleanup-firmware-v1-1-d1bff946606d@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-firmware-v1-1-d1bff946606d@marliere.net>

On Sun, Feb 04, 2024 at 01:10:18PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the coreboot_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

