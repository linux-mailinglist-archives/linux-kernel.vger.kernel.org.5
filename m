Return-Path: <linux-kernel+bounces-14860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5124882234A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA42D1F22EF8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B4E168B6;
	Tue,  2 Jan 2024 21:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqKkdFFA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1368F168A8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 21:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18851C433C8;
	Tue,  2 Jan 2024 21:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704231363;
	bh=/Tu1p48wBPy7AOClCXdtk7/dL0MSgw0z7yEN8J+Cku0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QqKkdFFALloiFaEAuhXV1aBwSAZsCcKD7QJUO8cbq0kv13cqlGbluuoElFJDM6t0S
	 xvh5cONP3FdeienmLwnS2r1T4DCCSpA7gOTYT5WcGqVsgCpHeIkz0lxlq0CZUVXlrX
	 v5/hIyUgWs3zP7KPFYZX41lFl3kR3exFEgLHWtNV4FD+9ZOK5h4wQ7HKJINRMd6w2n
	 N14JqlWKI4EAOAlTyK47w4AP1Wn6T6l1YGIrM0QFSPQVqkFSxoHVFCuLerTga/Nj6z
	 IRd/Dj9N25AB0a4/iKHwTjJPgE4aILgZmYM0vMyYUmyVZivZFnAk2p3LFEjMAtZ3e+
	 0yugzAe/9HOlg==
Date: Tue, 2 Jan 2024 14:36:01 -0700
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 00/17] enable nvmet-fc for blktests
Message-ID: <ZZSBwNifBWtD5fFr@kbusch-mbp.dhcp.thefacebook.com>
References: <20231218153105.12717-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153105.12717-1-dwagner@suse.de>

On Mon, Dec 18, 2023 at 04:30:48PM +0100, Daniel Wagner wrote:
> Another update on getting nvmet-fc ready for blktests. The main change here is
> that I tried make sense of the ref count taking in nvmet-fc. When running
> blktests with the auto connect udev rule activated the additional connect
> attempt etc made nvmet-fc explode and choke everywhere. After a lot of poking
> and pondering I decided to change the rules who the ref counts are taken for the
> ctrl, association, target port and host port. This made a big difference and I
> am able to get blktests pass the tests.
> 
> Also KASAN was reporting a lot of UAFs. There are still some problems left as I
> can still observe hangers when running blktests in a loop for a while. But it
> doesn't explode immediately so I consider this a win.
> 
> Apropos KASAN, it still reports the problem from [1], so anyone who want to run
> this series needs to revert ee6fdc5055e9 ("nvme-fc: fix race between error
> recovery and creating association").
> 
> The first four patches are independent of the rest and could go in sooner.

Applied patches 2-5 to nvme-6.8.

