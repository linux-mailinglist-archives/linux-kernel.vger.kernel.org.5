Return-Path: <linux-kernel+bounces-22607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D8A82A057
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BACD1C22587
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B7B4D587;
	Wed, 10 Jan 2024 18:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6QA385J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244754CDEB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 18:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCB3C433F1;
	Wed, 10 Jan 2024 18:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704912031;
	bh=1Bisy52+4v+u+GwuKg5Tzrfw8JADYsFRUtOE99jsZPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L6QA385JFf7m8iRGMu5ALTiAL/XVPYKPMviprK2QJZHYbktlYrV+nwLKQ/Cs0Hc7A
	 rBDwO2tSiUPsVmFysnIoNeW6CfAvy/1ZcqgvJD4oVJwGrP/4i9YB1VbLXRofhJPnmW
	 Sc/i2T65Cmmo4zidwHPfbpJQfuF3JQwn5q2v8JAoR/EqWAQoF+grcNsmQbIx/Fenz8
	 nOHBVBRLx++duafZnUBwortRsjkArIqJ9VbfCpO9/FNLmdyBOQZdNgLaDGMXeuODiZ
	 dsjCPHMdEARdX4uUWqi2PNKtPSe4aK+4Rzgpp5seXeZ2ytpovcxeIDpK+Mg9KXM8AY
	 0TUGgv/2L8Geg==
Date: Wed, 10 Jan 2024 11:40:28 -0700
From: Keith Busch <kbusch@kernel.org>
To: William Butler <wab@google.com>
Cc: Pavel Emelyanov <xemul@openvz.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: Inform controller of doorbell config before
 unquiescing IO queues
Message-ID: <ZZ7knJGSVx8hWvaW@kbusch-mbp>
References: <20240110182855.1833512-1-wab@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110182855.1833512-1-wab@google.com>

On Wed, Jan 10, 2024 at 06:28:55PM +0000, William Butler wrote:
> During resets, if queues are unquiesced first, then the host can submit
> IOs to the controller using shadow doorbell logic but the controller
> won't be aware. This can lead to necessary MMIO doorbells from being
> not issued, causing requests to be delayed and timed-out.

Good catch. I guess we wouldn't normally expect any requests to be in
queue at this point, but plenty of reasons it could happen.

Applied to nvme-6.8 with a slightly updated title to match the local
conventions.

