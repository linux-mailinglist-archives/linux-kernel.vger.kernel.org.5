Return-Path: <linux-kernel+bounces-161430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A328B4BE6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 15:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 804F0B21362
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 13:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0F76CDA1;
	Sun, 28 Apr 2024 13:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/guf0pd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2D16BFBD;
	Sun, 28 Apr 2024 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714309643; cv=none; b=oAKW3KIlag5Kk8l3qMgCPmlAZVCq4NEY6jVZngsFyznimnKL6lDlldI69pmGofkK1CFRsZM0v5H6FMmkgzkwpDjEWLUr/99vT4VqAcmjVCIfLdguAK0jDC9CGAoT6c0E2XvMaD/CqTQlSfnsMcHU8l29l+FFMc5lKj50ZHU+pA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714309643; c=relaxed/simple;
	bh=9yyE8eKKUc/4RgJtB91ozG6CzRgB3As3mCsWRI33/p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8qqNEJ1SS5an+zUmMI8whw9LtmAMYwLH4BQhwM5K3qYH1i7B6T9SuYKFyjUNkc967b1dYv32k8lo/k6RXSqfTTlQpb2VHJrcpTYxQN2xDZFP5m1S6yuP1DDP3Nrudpbehamp3yLlvEk7UoORflN9ooZ6r/1Iax37AFcYwGENEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/guf0pd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3CCC113CC;
	Sun, 28 Apr 2024 13:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714309642;
	bh=9yyE8eKKUc/4RgJtB91ozG6CzRgB3As3mCsWRI33/p8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r/guf0pdPIsuUe0cpmgz5Sa/Tenb1I0LoY3zNdoDXGIfG6OEQiZ80sJwWn/8B2wx/
	 4vM4xurlTQWZYLbMQ6906XXRVQqPAPx2SCGLYWo5ptROnX9dASaf9+szPiymGckRj3
	 YJ9rvucBXr9Q3BiaW69uVmgT3YtzZxQC8fX1LnBqPFSjRAUVf0Uktl9gmwOkR+F57J
	 aRkpk72IcQEzyujKFfxh86eHPDU4/vwJdD7CQmBTRQypYQvDuqKDO7DGpvCHZRFRbt
	 zS2D45/U/6Yn8W9OpZkRE0AlR5LfDCHxoUyMmAoMqr04nVcLnyAx+Cb2LgtTwDV50w
	 kWwUWzzd7HqSQ==
Date: Sun, 28 Apr 2024 14:05:47 +0100
From: Simon Horman <horms@kernel.org>
To: Corinna Vinschen <vinschen@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH net v2] igb: cope with large MAX_SKB_FRAGS
Message-ID: <20240428130547.GV516117@kernel.org>
References: <20240423134731.918157-1-vinschen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423134731.918157-1-vinschen@redhat.com>

On Tue, Apr 23, 2024 at 03:47:31PM +0200, Corinna Vinschen wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> Sabrina reports that the igb driver does not cope well with large
> MAX_SKB_FRAG values: setting MAX_SKB_FRAG to 45 causes payload
> corruption on TX.
> 
> An easy reproducer is to run ssh to connect to the machine.  With
> MAX_SKB_FRAGS=17 it works, with MAX_SKB_FRAGS=45 it fails.
> 
> The root cause of the issue is that the driver does not take into
> account properly the (possibly large) shared info size when selecting
> the ring layout, and will try to fit two packets inside the same 4K
> page even when the 1st fraglist will trump over the 2nd head.
> 
> Address the issue forcing the driver to fit a single packet per page,
> leaving there enough room to store the (currently) largest possible
> skb_shared_info.
> 
> Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRAG")

nit: The trailing "S" in the subject for the fixes tag seems to have been lost.

Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRAGS")

> Reported-by: Jan Tluka <jtluka@redhat.com>
> Reported-by: Jirka Hladky <jhladky@redhat.com>
> Reported-by: Sabrina Dubroca <sd@queasysnail.net>
> Tested-by: Sabrina Dubroca <sd@queasysnail.net>
> Tested-by: Corinna Vinschen <vinschen@redhat.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

..

