Return-Path: <linux-kernel+bounces-17477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75C2824DF7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 06:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 522D4B23AE4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 05:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365995398;
	Fri,  5 Jan 2024 05:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUdMMVXM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720BE5384
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 05:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BADC433C7;
	Fri,  5 Jan 2024 05:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704431131;
	bh=bDiPV3uyCW5UPugzq4bCJlkKgkGFl8NKchlqBqf/QT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rUdMMVXMCmG1nuAMLxS0yIP7vE4rqe2372HxRHZ6kQSbiAMbrsN4S3wEGiej6i9dq
	 x9srvxJ+dbKU1MKWATpZRRnC9VNxgnfVBcmlFMT/fkA/KXY6jj+FnHVmYcIaURj9bH
	 I1Un5KMB0n8/almphcEIM474YEW6ucE5m4tmBa0tZ4U+kHmVHVH/s+iBMlzib1Sgu7
	 6ZM8mNFtqmQ+12U+rzHWpJbM0XRAm/mAsHdPBGjC5QRxUhhm/9LwQjkLMXRUBJcbs2
	 GDvMR9ZURZtxjq2oPfVJMJOIsbQvGnb6XPQuj+/pZyLK3+b16eFHTKwYr8915KqzN8
	 +CVFMJEpto6+A==
Date: Thu, 4 Jan 2024 22:05:29 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 06/16] nvme-fc: Do not wait in vain when unloading
 module
Message-ID: <ZZeOGTv0B1i8hkSB@kbusch-mbp>
References: <20231218153105.12717-1-dwagner@suse.de>
 <20231218153105.12717-7-dwagner@suse.de>
 <20231219043514.GG30580@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219043514.GG30580@lst.de>

On Tue, Dec 19, 2023 at 05:35:14AM +0100, Christoph Hellwig wrote:
> On Mon, Dec 18, 2023 at 04:30:54PM +0100, Daniel Wagner wrote:
> > The module unload code will wait for a controller to be delete even when
> > there is no controller and we wait for completion forever to happen.
> > Thus only wait for the completion when there is a controller which
> > needs to be removed.
> 
> This whole code looks fishy to me, and I suspect this patch only papers
> over it.  Why do we this wait to start with?  If we've found that out and
> documented it, the code really should be using a wait_event variant that
> checks for the actual condition (no more controllers), because without
> that you might still have a race otherwise.

The synchronization here does feel off, but Daniel's change looks
correct to the current implementation and is a minimal diff to fix it.
Do you want to see this re-worked with a better wait condition or can we
proceed with this?

