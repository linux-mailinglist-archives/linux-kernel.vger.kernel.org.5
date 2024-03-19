Return-Path: <linux-kernel+bounces-107507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8639787FD74
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24FB9B21691
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039EC7F7C9;
	Tue, 19 Mar 2024 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbHqefuw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE037F469;
	Tue, 19 Mar 2024 12:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710850829; cv=none; b=SJg46Jq2QP1sJ2QfiTBhnXOoz+9v79bJnprKApU5qRhPNRbRDdKvw0s5G459JwhbJXGeYBUXkjXOKmM3q3vbEDXLoHH+77jKCkO99VihpiHi4AE4yl1/ZWaLrvUSPAD75+nOdSTe0DxvfCkG7ngOiz63TKOAJU8fLeMfsmN7oCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710850829; c=relaxed/simple;
	bh=tNjc7nnylbSais8DsBZzrd94/93ipPvqn/Y1zZVH5cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeCIRmvRxJ+lMV/bhShrDULYigrKKVeOWUL15Hj7uE1hKK6b069oJNP3oMYVMWs4UKLz44C236euh930KF2HJXHN7+7ugK58yiK4QISzMYOlZYHe6G5yoU1WnP2frp0OoTEBSJHOP2c3TFgv39/usIzcTfCF6ZmNGsntGd7M+lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbHqefuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83730C433F1;
	Tue, 19 Mar 2024 12:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710850828;
	bh=tNjc7nnylbSais8DsBZzrd94/93ipPvqn/Y1zZVH5cY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SbHqefuwZCTg0JhEXhmcav1tqE1RvW1qxgfFL3NcJMxJPjvFqXymUJMuM5zHZPQyH
	 RpqEg6luMeCCical3TSfiYCfH13sfAD8yFcNsk51GavJpxfWumLcUBMKrf6sq6Eldf
	 /9bX5L3dLu0QFgZ2565+JYS1Xjeo1f7GHysCEYqFj32ovCjs0jMxBVXrvJDPJVLvB8
	 kP+xLED7mQkRw9KWRzyRfiu50/5WMhqSLooGP2y9osfNbxjUg/zA6/4X6uaKfQ+6cB
	 skse6WaHo5ZIvL8Q5I3wNfbuaOpBOLOiV2SJuvn69xr90FmtJ15sohFbmZQPc/D9SP
	 L+GFTTTCp1SwA==
Date: Tue, 19 Mar 2024 12:20:24 +0000
From: Simon Horman <horms@kernel.org>
To: Erwan Velu <e.velu@criteo.com>
Cc: Erwan Velu <erwanaliasr1@gmail.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 iwl-net] i40e: Prevent setting MTU if greater than MFS
Message-ID: <20240319122024.GJ185808@kernel.org>
References: <20240313090719.33627-2-e.velu@criteo.com>
 <20240318174503.GE1623@kernel.org>
 <d33b98de-dfc0-445e-bdd7-0ae76d050ed4@criteo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d33b98de-dfc0-445e-bdd7-0ae76d050ed4@criteo.com>

On Tue, Mar 19, 2024 at 12:38:03PM +0100, Erwan Velu wrote:
> 
> Le 18/03/2024 à 18:45, Simon Horman a écrit :
> > [...]
> > Hi Erwan, all,
> > 
> > As a fix, I think this patch warrants a fixes tag.
> > Perhaps this one is appropriate?
> > 
> > Fixes: 41c445ff0f48 ("i40e: main driver core")
> 
> Simon
> 
> Isn't that a bit too generic ?

Yes, maybe it is.
What we would be after is the first commit where the
user can hit the problem the patch addresses.

> [..]
> 
> > I am fine with this patch, so please take what follows as a suggestion
> > for improvement, possibly as a follow-up. Not as a hard requirement from
> > my side.
> > 
> > The part of this function between the two hunks of this patch is:
> > 
> >                  netdev_err(netdev, "Error changing mtu to %d, Max is %d\n",
> >                             new_mtu, frame_size - I40E_PACKET_HDR_PAD);
> > 
> > My reading is that with this patch two different limits are
> > checked wrt maximum MTU size:
> > 
> > 1. A VSI level limit, which relates to RX buffer size
> > 2. A PHY level limit that relates to the MFS
> > 
> > That seems fine to me. But the log message for 1 (above) does
> > not seem particularly informative wrt which limit has been exceeded.
> 
> I got some comments around this.
> 
> I wanted to keep my patch being focused on the mfs issue, but I can offer a
> patch to get a similar output for this. What WRT stands for ?
> 
> 
> I wanted also to make another patch for this :
> 
> dev_warn(&pdev->dev, "MFS for port %x has been set below the default:
> %x\n",pf->hw.port, val);
> 
> The MFS reported as hex without a "0x" prefix is very misleading, I can
> offer a patch for this too.

FWIIW, I think handling these questions in follow-up patches is fine.


