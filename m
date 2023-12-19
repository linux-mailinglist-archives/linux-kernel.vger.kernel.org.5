Return-Path: <linux-kernel+bounces-5537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E37E1818BD7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3D62877B7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8DE1D148;
	Tue, 19 Dec 2023 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMFVXhRT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E4F1D125
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D83C433C7;
	Tue, 19 Dec 2023 16:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703002064;
	bh=179zRTP4CAGhjZ3EpQVeRAlCewCRC30TMoZOeWZPh0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EMFVXhRT1DSUBIYPUFklbKygEmsOeSaRZMn4zdJekEA0C0jD69XTIrwRavK3DVD/a
	 QusbaRrXzXuz6B5rLOXuyHnVtbMkTvyIJiXjZFs6chg5pHEk/yxxxrxB2wqXMlrjMb
	 TmkfT3D8hbdpbzs1GHwUyvqLLPEcI+efOHU979fWfAS8F6sB4fVCp5lFSJlEerbrRF
	 yLixDJTo55aQIUBLy5v/2zK6unx+wZ0Y+SqhEZDuIsw+MOBKsTWGLGug5IMWYoNaFA
	 3kZemesC6lh43XlOiKIu+lJwfyuZhE7OK2ciOG6sY9r3lp9Cg2aoLlhcbSlaJ1omp9
	 9nbyf9FcpDJGQ==
Date: Tue, 19 Dec 2023 09:07:42 -0700
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH v6 0/6] nvme: add csi, ms and nuse to sysfs
Message-ID: <ZYG_zlnvfLOJHEJM@kbusch-mbp>
References: <20231218165954.29652-1-dwagner@suse.de>
 <ZYDN_G-VP2_pn3kC@kbusch-mbp.dhcp.thefacebook.com>
 <acd4f5b1-b1d7-40e0-ac80-573e2d5cfe85@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acd4f5b1-b1d7-40e0-ac80-573e2d5cfe85@nvidia.com>

On Tue, Dec 19, 2023 at 04:42:20PM +0200, Max Gurtovoy wrote:
> Hi Keith,
> 
> On 19/12/2023 0:55, Keith Busch wrote:
> > On Mon, Dec 18, 2023 at 05:59:48PM +0100, Daniel Wagner wrote:
> > > Rebased on the current nvme/nvme-6.8 branch and added the Review tags. Also
> > > addressed the printk format issue pointed out by Chaitanya.
> > 
> > Thanks, added to nvme-6.8.
> 
> I'm rebasing my fixes to the PI bug (which are not trivial) on top of
> nvme-6.8 and Daniel's series.
> I've found that this branch is missing some fixes from the master that I've
> added manually to local nvme-6.8 branch.
> When do you plan to rebase the nvme-6.8 on top of master ?
> It will be helpful, otherwise my patches will not apply cleanly on your
> branch. :)

linux-nvme pulls go through Jens' linux-block repo, so we have to be
based on the appropriate branch from there. We already have some late
fixes in 6.7 that create minor merge conflicts for our existing 6.8
branch, so we may provide a reference resolution branch with the pull
request if conflicts are non-trivial. That might be an option for your
fixes if you can make them work atop existing nvme-6.8 without the
conflicting 6.7 changes.

Sometime after the next merge window opens, Jens will rebase his 6.8
block tree to Linus', and we usually get a 2nd feature pull request
within the merge window from that new baseline. That might be an option
if you want to wait a couple more weeks.

