Return-Path: <linux-kernel+bounces-133188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C9789A016
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D56EC1F21807
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A960416F292;
	Fri,  5 Apr 2024 14:47:58 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A323A8BEF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712328478; cv=none; b=K5ysig7Qp3jFhqZoU0tvj8Pu7yHncZkcENpRB3mhyunwr55rP2siNUyPyM13R4kws+SAFcSStZfX08cmkGny4GLpfmatWLJYwhJXe8BaQXadW3Gr12PBb5e5R/BBiNbChk62tQiL0nMho1bIIfydXorQWuNE0qR0Dv7B+TAveU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712328478; c=relaxed/simple;
	bh=51uyCF4lmzV3fozaPhMCo53TfAuaSOsEt2npaG2RIso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlTemxjc9EwSuEwiEFaeavpQYG693k91KKJLVlTuynA0PymLGpDvK+UXHQrzhA5tvRQxzrYqrF9bWIyRpL0scCGirlIRVZkW4+PLjDO1U5OnVmim+xKgBV83fp6aDNRvOQxbZ8D8nhh9Ap2dtQVUZAlMVV4i9n1E8N43duJFbmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 788C668D07; Fri,  5 Apr 2024 16:47:52 +0200 (CEST)
Date: Fri, 5 Apr 2024 16:47:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, James Smart <james.smart@broadcom.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH v4 3/5] nvmet: return DHCHAP status codes from
 nvmet_setup_auth()
Message-ID: <20240405144752.GA6352@lst.de>
References: <20240405062055.GC3107@lst.de> <3qh6d2fensgck2rodnbhreirfwkf7lloqwvk6gyfafu4fvgxss@jxb4b4kzu224>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3qh6d2fensgck2rodnbhreirfwkf7lloqwvk6gyfafu4fvgxss@jxb4b4kzu224>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Apr 05, 2024 at 12:02:51PM +0200, Daniel Wagner wrote:
> > >  	if (!host) {
> > >  		pr_debug("host %s not found\n", ctrl->hostnqn);
> > > -		ret = -EPERM;
> > > +		ret = NVME_AUTH_DHCHAP_FAILURE_FAILED;
> > >  		goto out_unlock;
> > 
> > This is now returning returning random on the wire fields that aren't
> > even the NVMe status codes from a function otherwise returning Linux
> > errno values.  I can't see how this works or is maintainable long term.
> 
> This is the target side and we generate the on wire return code here.

True.

> Are you sure I should map this to errno codes and the back to NVME
> status codes? Sure, this is possible but don't really think it makes
> sense.

No, but we should not overload the return value.  Pass in the req
or sq, or add a new paramter for the auth fail reason.

