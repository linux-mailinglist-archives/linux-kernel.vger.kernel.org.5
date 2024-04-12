Return-Path: <linux-kernel+bounces-142943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C03CD8A325A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D8A4B225E1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EE2148824;
	Fri, 12 Apr 2024 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAAGYBOz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322F6148302
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935465; cv=none; b=fJ6U94lBssWOLnEnWLubSX2FIgc7ZH7lNiOoNnTIflhCQJGiUeiGtxUPORxNPM6i0v8awrfGYxWPRWIWbO63lvF5PifVssmf8A1wpEQo/f19ZWIdcfHrmcLEBonCkuIwUwnkC/7SKcXZQS8Fs1erjWFzsBlxYVct58r0CQ7zGAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935465; c=relaxed/simple;
	bh=NWBY8Xi/7G/iirnu6Mw/60mc/htaj8sawp6gS840vPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjjKT0DcAzdgq2ae2hIprnSbzwsMZdaI/q7Jc/rdraeS03bDVJEmr+y8HmvomU7b6NfWGWvuNQt46qqqwa/jlCal2Vmzs/WNJkA8eTJILujq3ouaDS55fg8PnDhISnXo4pi9Dv0gHWsuaUJDc8tXsL/skNRtjKU2Tfg0xrgAmkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAAGYBOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F00FC113CC;
	Fri, 12 Apr 2024 15:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712935464;
	bh=NWBY8Xi/7G/iirnu6Mw/60mc/htaj8sawp6gS840vPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YAAGYBOzdEXGRplTCs5I+PgkflKoKKlmPBnvU9lVSUfUE31pbyih/p7afOnx6J3GH
	 QPnR3F8HUQfYkFkm4qhuOeik7iKmMgvmbv+7nw+f/QqRw7y8drkpnDJ69BzWcVCMX8
	 UraR/WHIhXHNlw78hjYWuAjKY+mgyoi92PdTgTPFzy00NvstKA35hssc8a1ATL2HCI
	 KgyTSHfJDXXWxsRqwzv0FmfarI+RcZMAe1sMh489j/3798frVVnzfVHJABrj++kMN3
	 7a+DMWx0/nktukVA6zPrMnKlW6wwXLNScH3OVjBr1+VnjktAad9kbxLuwsQ5Ta8J0B
	 hlHaa0DTyW2Ug==
Date: Fri, 12 Apr 2024 09:24:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/6]  nvme-fabrics: short-circuit connect retries
Message-ID: <ZhlSJcTwGVrlk8OP@kbusch-mbp.dhcp.thefacebook.com>
References: <20240409093510.12321-1-dwagner@suse.de>
 <ZhiBzXBvjTeDuHbS@kbusch-mbp.dhcp.thefacebook.com>
 <vbptto5zefkdadnpyhcjelfrsgadb2stjh3sole6n6mdd4h7dq@lrdxk5p5qh6w>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vbptto5zefkdadnpyhcjelfrsgadb2stjh3sole6n6mdd4h7dq@lrdxk5p5qh6w>

On Fri, Apr 12, 2024 at 09:24:04AM +0200, Daniel Wagner wrote:
> On Thu, Apr 11, 2024 at 06:35:25PM -0600, Keith Busch wrote:
> > On Tue, Apr 09, 2024 at 11:35:04AM +0200, Daniel Wagner wrote:
> > > The first patch returns only kernel error codes now and avoids overwriting error
> > > codes later. Thje newly introduced helper for deciding if a reconnect should be
> > > attempted is the only place where we have the logic (and documentation).
> > > 
> > > On the target side I've separate the nvme status from the dhchap status handling
> > > which made it a bit clearer. I was tempted to refactor the code in
> > > nvmet_execute_auth_send to avoid hitting the 80 chars limit but didn't came up
> > > with something nice yet. So let's keep this change at a minimum before any
> > > refactoring attempts.
> > > 
> > > I've tested with blktests and also an real hardware for nvme-fc.
> > 
> > Thanks, series applied to nvme-6.9.
> 
> Thanks! I have an updated version here which addresses some of Sagi's
> feedback, e.g. using only one helper function. Sorry I didn't send out
> it earlier, I got a bit side tracked in testing because of the 'funky'
> results with RDMA.
> 
> Do you want me to send a complete fresh series or patches on top of this
> series? I'm fine either way.

Oh sorry, I didn't notice the discussion carried on after the "review"
tag. Please send me the update, I'll force push.

