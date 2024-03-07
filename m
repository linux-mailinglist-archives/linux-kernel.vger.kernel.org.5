Return-Path: <linux-kernel+bounces-95811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE83875311
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A370C1F220F5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDE412F395;
	Thu,  7 Mar 2024 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lN6U5wys"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3B712EBF1
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709825012; cv=none; b=EMuHHXBot5CKzPsEBNpqua6osPtDrtz4U1vu6Tg0uZ9vZs0eCMLq0UdzcnrSieTq2vA5Ih+QtvHwD8P4AjRkPgwH6WvxBPr4DG+xPHGr+EPFHlYUC0VrJELST8dyr8wvt9jiLgzCHyhWXgfTnHQ9mZWOPF/9POMfLy69fdiDDnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709825012; c=relaxed/simple;
	bh=QLwDJBwJUyurwdA1KQeq9Y4vMNeTVG8BJ1Hj5GtG0FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARc0T72GWwGI3r2M+J5uEh9b2Y/1nsAsHc3glqVSiF1oJzD09CJ0P89lDvOXGU28FhKVttQBidOx9Znm9oecl5HJJ1DV8toLZnEIhNoLa6qyeRsdsX/hqbESObui8qhFzJXxhyrmkBTWZXGPRFLSgpZIABt09kjJm77and6j6OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lN6U5wys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41477C433F1;
	Thu,  7 Mar 2024 15:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709825011;
	bh=QLwDJBwJUyurwdA1KQeq9Y4vMNeTVG8BJ1Hj5GtG0FY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lN6U5wysUBIsea39sveda6cKOE8vaYQeS428B3+79IalRiz1prKW5EJAc14cDSk08
	 23zae8ymWNhLYfRHmFoqAJsCtCXPETajKuMpzn60oZSNFtG4hSMIay6jzpMHp6s5GK
	 mQUu2B5pGqfAIuXTRxYONY7klnRKZ7txdFQ38M/MIwHcmc0NE6dYbs1Gf2lERPZ1FZ
	 wxyq1kEdDDBMxLf/599BYrBnNOwT1gu0XvZX+Dy7dO+TSXpWZ6Lzm23kkbxm54pKIV
	 jBiDzGZRMy7mBtcnhQfrRf1O76E2rzDiDaFwhqCimQrA2jTIdyiPFX5gLKeBDnx0+5
	 p39v1nd8w44fA==
Date: Thu, 7 Mar 2024 08:23:29 -0700
From: Keith Busch <kbusch@kernel.org>
To: Len Brown <lenb@kernel.org>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
	maxg@mellanox.com, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 1/1] nvme: Use pr_dbg, not pr_info, when setting shutdown
 timeout
Message-ID: <Zenb8eDX9Hq6YbQQ@kbusch-mbp>
References: <49a7c0b667abe23d95d67cf0cf7ea7e193d9f2a1.1709773065.git.len.brown@intel.com>
 <dc6c4d98-e56a-448d-b372-38ce0cd927e9@nvidia.com>
 <CAJvTdK=Fbo0in7diYv_4Zk_-zrOPP4skDgpTMOYw-UM8=3R29Q@mail.gmail.com>
 <ZenacXkUAh4I1gkK@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZenacXkUAh4I1gkK@kbusch-mbp>

On Thu, Mar 07, 2024 at 08:17:05AM -0700, Keith Busch wrote:
> But personally, I don't find this print very useful anymore, so I don't
> care if it gets removed.

Or maybe we can make the print less scary: how about changing "shutdown
timeout" to "D3 entry latency"?

