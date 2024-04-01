Return-Path: <linux-kernel+bounces-126654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5048C893AF7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B055B281B66
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B392AF15;
	Mon,  1 Apr 2024 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruUwIGob"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98349374F7;
	Mon,  1 Apr 2024 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711974607; cv=none; b=tAdhZpbJ90c7jE/w1GSwqVCMH8So9HXESpvoz5x60kuTF666JwquxSteHdTa0HPiIRAfiUU68aQE9ACbLiWNZ0c0k8m/8hgsDzcznTrk42zzMYf58Cg8fqNpp6jjYC+sExTtyw6EC+HUb8uwlalQnalwFX9Hkqcxpv6uZ1Rc44Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711974607; c=relaxed/simple;
	bh=n1scydYqnXYoe3F/lagJJwCsVVpnrTsNZEwHwCsuGIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jA6AGBg0NA+qVlYBXfLJsguNsUazEhXe2Q+pBDlbV85fjHA9afuBmBNqBQ6pbmartJwR7GNiTo1e9Ci5Jgs6m4J2G3b6wB3nlqDNKvYfp7kU23t6cPf7DzJf+FvJXhB87zbGY1mZYbD+WUTDvPdk4hzgnCv9WhtNsEy+yXnY/rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ruUwIGob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75FB0C433F1;
	Mon,  1 Apr 2024 12:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711974607;
	bh=n1scydYqnXYoe3F/lagJJwCsVVpnrTsNZEwHwCsuGIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ruUwIGobQWsZa1yYreKyMYiD6lJREDF2AKMJ0w33cyfSxtjfoHcEVmYrK9j4BKCc9
	 mQquZabE1kSplZMSmTRjzglVHHEGPwSjuLDN0qhRwG7GVho/U1tKGwlr8En6bERZQO
	 MDPsjD5Iy7YEZpRPLLHsNLdDtP28Zn9sVHsreLeIEl8ky+HhxC5XY6aTSWOKO4BnCo
	 DwQFQbbZfVNPjZQ0RPxtX4wjiXUbYa8qQdDZhXBXTYya4xbFzpbjCquAsw8H4ddS6s
	 aDsDI6HsJqtxYAhOfS2pnNPR1Uh0S7ILNXWOYbZACO6GNyENsZ6Rv9I/WbRHECM288
	 kpn3oA4vWfUbQ==
Date: Mon, 1 Apr 2024 15:30:03 +0300
From: Leon Romanovsky <leon@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	linux-kernel@vger.kernel.org,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240401123003.GC73174@unreal>
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>

On Tue, Mar 26, 2024 at 08:57:29AM -0600, David Ahern wrote:
> On 3/22/24 4:40 PM, Jakub Kicinski wrote:
> > On Fri, 22 Mar 2024 15:18:09 -0600 David Ahern wrote:
> >> can you respond to Jason's email with the proposal for the new fwctl
> >> subsystem and identify places you do not agree? That would provide more
> >> concrete discussion points. Thanks,
> > 
> > Respond in what way, David? Comment on technical aspects of whether 
> > a common class device with a discovery mechanism and a sprinkling of
> > semantically meaningless fields can be implemented? Some trivial object
> > hierarchy?
> > 
> > On whether someone can actually enforce any of the 4 "don't"s, and
> > whether this interface is basically encouraging and giving a leg up
> > to those willing to be dishonest?
> > 
> > Or should we go for another loop of me talking about openness and
> > building common abstractions, and vendors saying how their way of
> > doing basic configuration is so very special, and this is just for
> > debug and security and because others.
> > 
> > There's absolutely no willingness to try and build a common interface
> > here.
> 
> The proposal is an attempt at a common interface and common tooling to a
> degree but independent of any specific subsystem of which many are
> supported by the device.
> 
> Your responses continue to align with the notion that because the device
> can spit out ethernet frames, all diagnostics, debugging, configuration,
> etc. MUST go through networking APIs.
> 
> You seem unwilling to acknowledge that devices can work for various use
> cases without a netdev driver, and thus aspects of managing that device
> should be done outside of a netdev driver.

HNS driver is a good example of such device. It has nothing to do with
netdev and needs common and reliable way to configure FW.

https://lore.kernel.org/all/20240308105443.1130283-1-huangjunxian6@hisilicon.com/
https://lore.kernel.org/all/20240322163201.GF66976@ziepe.ca/

Thanks

