Return-Path: <linux-kernel+bounces-126758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D66D893C59
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D931F224C7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B5C446AC;
	Mon,  1 Apr 2024 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXfpB+RM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A0841A8F;
	Mon,  1 Apr 2024 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711983005; cv=none; b=tL7RcWp2Qi5/IDH5QTyGr/v7LGl21W1Ajqjl0To5+xQ5RAzQXuDtxHcN3oRBRmaR7gpm/O74Th0fUDxfb+j8n1bJ86TktslMVXdKLRL/YkigLjeA70sCqRPVGkPFeSL+4aT1OWeYJ4Cpp+gCpNLDMhkD0agjqAvRZv+jHdPJ9F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711983005; c=relaxed/simple;
	bh=g1p0JxSTbPiaXdqzfHvytWBMEFzWaRM2oDNw0BLXbDM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=beXWKQ6hYDNItyeDK1Oleujs/yyaTPkX1Cx2EfUMWNBEO0zTktJoHOuZvrIVyuUcl96Ybe1KaqI0aCYn2Z6Bn6bm/mCfeUVRmIIWozZJ/6x+WNPenZUIE5Yj3Wa4iV73K3cjf5sigVp6+ad8qSrEFdY0PSpOG9ym2ikoNm0JmhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXfpB+RM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F511C433F1;
	Mon,  1 Apr 2024 14:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711983004;
	bh=g1p0JxSTbPiaXdqzfHvytWBMEFzWaRM2oDNw0BLXbDM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YXfpB+RM11goqpxKtttYlK6UvF9aR8UcwfJ4cL5CtJWzh7EV9VkLbYkeXKv58ziQx
	 H+MhTNW9PM2SEKhLM09Karx5kuEXeY00ZvvARbkyE+mlNJQx8dDymrm21yHBGFX9Up
	 GK1bfM8GqdBdcFsaWeSZqHWEOP9mJUdSuiCQgiNBoQG6NILTSZMFLj5DTALdriUAGP
	 sQsp3wtgC9kEQKoQuLi2U93MsH6AxDtLigxnWZLMIfIRv98bvveO02cOL3SXassvcX
	 1JOFyGATYyHSifK9907WxBQZVyRRXl6VV4GuaOXcen3H6CcT7M4AtNnBWlklaSlrel
	 GjbaFKno2ZtJw==
Date: Mon, 1 Apr 2024 07:50:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jason Gunthorpe <jgg@nvidia.com>, Christoph
 Hellwig <hch@infradead.org>, Saeed Mahameed <saeed@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Jiri Pirko <jiri@nvidia.com>, Leonid Bloch
 <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Aron Silverton <aron.silverton@oracle.com>,
 linux-kernel@vger.kernel.org, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Junxian Huang <huangjunxian6@hisilicon.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240401075003.70f5cb4b@kernel.org>
In-Reply-To: <20240401123003.GC73174@unreal>
References: <20240214175735.GG1088888@nvidia.com>
	<20240304160237.GA2909161@nvidia.com>
	<9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org>
	<2024032248-ardently-ribcage-a495@gregkh>
	<510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
	<Zf2n02q0GevGdS-Z@C02YVCJELVCG>
	<20240322135826.1c4655e2@kernel.org>
	<e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
	<20240322154027.5555780a@kernel.org>
	<1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
	<20240401123003.GC73174@unreal>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Apr 2024 15:30:03 +0300 Leon Romanovsky wrote:
> > The proposal is an attempt at a common interface and common tooling to a
> > degree but independent of any specific subsystem of which many are
> > supported by the device.
> > 
> > Your responses continue to align with the notion that because the device
> > can spit out ethernet frames, all diagnostics, debugging, configuration,
> > etc. MUST go through networking APIs.
> > 
> > You seem unwilling to acknowledge that devices can work for various use
> > cases without a netdev driver, and thus aspects of managing that device
> > should be done outside of a netdev driver.  
> 
> HNS driver is a good example of such device. It has nothing to do with
> netdev and needs common and reliable way to configure FW.

Sorry, I have a completely different reading of that thread.
Thanks for bringing it up, tho.

As I said multiple times I agree that configuring custom parameters
in RDMA is a necessity. Junxian's approach of putting such code in
the RDMA driver / subsystem is more than reasonable. Even better,
it looks like the API is fairly narrowly defined.

