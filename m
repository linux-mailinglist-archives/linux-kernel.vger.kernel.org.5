Return-Path: <linux-kernel+bounces-71838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8399085AB55
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4069F283918
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E31E482EA;
	Mon, 19 Feb 2024 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWRG4KI+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C001D53C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 18:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368250; cv=none; b=QpchMb2EIsb6GYOs+WKOXez9DpUuWhpJ+tO+E/MtaO4QHzcqRvKy4i49By+D/VuHdEF4qhNrkUIUEcnZ0K2+tBIS60EW/mzZnCzgr1CpbHQYgbJg5e0UzbDnH5zK1HAW+b7LWPMZjJqYDWIPnaLfPUAOa4Xu61K7lHXGeKxeF1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368250; c=relaxed/simple;
	bh=A+skSn5EGS8bpzAxHlYWC66tyc9qRmaHyrFHFKuAz6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwn/WhkfMDbjtLQ4i3tMWiR3lG4MV246kYzxNuN/fPqtimrNd50y+/C+Uona3lfMU3V3xoZHIGL1Guoi2/RmdEAgE64M01+G45tYWnjTZDh2rSad/nmtp/9HW5FWPQBxzpO0olbTjOdMF/z3PngrFxFxh/3BcG+c07nhHAN6y0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWRG4KI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B27C433F1;
	Mon, 19 Feb 2024 18:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708368250;
	bh=A+skSn5EGS8bpzAxHlYWC66tyc9qRmaHyrFHFKuAz6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hWRG4KI+8bAKVYukLPfmN2JxynpqPCs19YmhE/Sf4lcIMfU5uL85zLUa9LJy7HBSq
	 mKpB8QmLAX+OtA9xBgXtBhZT61FT59UdF7TF9Ql7t826DSuNMw4MQLw3jk3MB+tg/C
	 DC+0fdDdgstI8BXMAgNk3MvR6kKU4Lt2Av6c8PynIGdQXHI3+akxHAzSb+vlpzUetB
	 3qi3+eDr3v5i+V91rn/Om5OmD8X5xJxoGbe62I0yMi+nqom1Nfmip5RgU5p0ANbkAh
	 fIwH0TwUFX/08Fqq5SJbWPOWUuGhOxTvcQB/k7hIoTXdO0hEjg0gMl57MIzjpzB8pp
	 iI0vl5Cm+Wd9Q==
Date: Mon, 19 Feb 2024 11:44:08 -0700
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/6] nvme-fabrics: introduce connect_sync option
Message-ID: <ZdOheNNssYuhBT9w@kbusch-mbp.mynextlight.net>
References: <20240219131531.15134-1-dwagner@suse.de>
 <20240219131531.15134-2-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219131531.15134-2-dwagner@suse.de>

On Mon, Feb 19, 2024 at 02:15:26PM +0100, Daniel Wagner wrote:
> The TCP and RDMA transport are doing a synchronous connect, meaning the
> syscal returns with the final result, that is. it either failed or
> succeeded.
> 
> This isn't the case for FC. This transport just setups and triggers
> the connect and returns without waiting on the result. Introduce a flag
> to allow user space to control the behavior, wait or don't wait.

The series looks good to me. My only feedback is this patch doesn't
change anything without patch 6, so I think these two go together.

