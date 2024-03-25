Return-Path: <linux-kernel+bounces-117493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B95CF88ABF7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 709A72C4A83
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2951149C5D;
	Mon, 25 Mar 2024 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sh1wH5Sj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142B312D747;
	Mon, 25 Mar 2024 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385044; cv=none; b=n5eqUGgW8rKoGOvgMcxnvV/CInMWdMjKyqlTUT+dCxZGnWfqeTnMBzlgVpV6Pgse+Cu2VuNL9gM9EndtzzLW9SxRQZlz7rHwdmXRj0yNzPfSCSKTOAlGA7t/+cFHPTRE3pBsTjlWhjUEm35SZjcrQXH/DmMWVUG47nVMPCB+gAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385044; c=relaxed/simple;
	bh=84lb1y+TpjyavnkWNmwchbU884Msl6lsLUlg6T6K2bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAz/3HgKB/MLXJwEQMu4x5WRB5kzMeFYWMWXawYw5d3Gs3hEsP/FnYmZxderb4n7zSf4O2aYVXESclnYHicBNWTiOlliCrZwqHqj1YMX1BGdGirLOHLIrlz+ALt3flDgHpz+gmoVZ6Qc8U5uLLetNqJvu9wjiiZ3CIBDD+2ojD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sh1wH5Sj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEA0C433C7;
	Mon, 25 Mar 2024 16:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711385043;
	bh=84lb1y+TpjyavnkWNmwchbU884Msl6lsLUlg6T6K2bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sh1wH5Sj3Lqqu5aNqrEAtLB2OUcyRZ67//17Djc+hwmqvqKd8UyaqpBP25ZGdE9zW
	 r1a+IUdVJfByjvFc7kTzQaJIS39mYunvmw842g+D5kj7vlVCBv42uJaoAm+Dsr0Ou5
	 iJpcD8ICTfFn9MZFrRK85ta0LpLmTo3z4RCTsB35vQlvbuNHd53tybRLWd3HhoHtaF
	 ZlVr5Z7lI/JDWM9AFgMp/zTjI0zVBSy49uAHIxJpS+SeJkEfjDUizK4ViiAsoIDp0G
	 2rmo1UEVy8ibTSgPuU13Kg97JgagmhMELwdvpey+yUzeYfSe0kDdQACII+gcCE/O6F
	 9nUNDizpDDSbA==
Date: Mon, 25 Mar 2024 11:44:01 -0500
From: Rob Herring <robh@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Saravana Kannan <saravanak@google.com>,
	Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>,
	Sonal Santan <sonal.santan@amd.com>,
	Stefano Stabellini <stefano.stabellini@xilinx.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v6 1/2] driver core: Introduce device_link_wait_removal()
Message-ID: <20240325164401.GA276583-robh@kernel.org>
References: <20240325152140.198219-1-herve.codina@bootlin.com>
 <20240325152140.198219-2-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325152140.198219-2-herve.codina@bootlin.com>

On Mon, Mar 25, 2024 at 04:21:25PM +0100, Herve Codina wrote:
> The commit 80dd33cf72d1 ("drivers: base: Fix device link removal")
> introduces a workqueue to release the consumer and supplier devices used
> in the devlink.
> In the job queued, devices are release and in turn, when all the
> references to these devices are dropped, the release function of the
> device itself is called.
> 
> Nothing is present to provide some synchronisation with this workqueue
> in order to ensure that all ongoing releasing operations are done and
> so, some other operations can be started safely.
> 
> For instance, in the following sequence:
>   1) of_platform_depopulate()
>   2) of_overlay_remove()
> 
> During the step 1, devices are released and related devlinks are removed
> (jobs pushed in the workqueue).
> During the step 2, OF nodes are destroyed but, without any
> synchronisation with devlink removal jobs, of_overlay_remove() can raise
> warnings related to missing of_node_put():
>   ERROR: memory leak, expected refcount 1 instead of 2
> 
> Indeed, the missing of_node_put() call is going to be done, too late,
> from the workqueue job execution.
> 
> Introduce device_link_wait_removal() to offer a way to synchronize
> operations waiting for the end of devlink removals (i.e. end of
> workqueue jobs).
> Also, as a flushing operation is done on the workqueue, the workqueue
> used is moved from a system-wide workqueue to a local one.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> Reviewed-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/core.c    | 26 +++++++++++++++++++++++---
>  include/linux/device.h |  1 +
>  2 files changed, 24 insertions(+), 3 deletions(-)

Greg, can you ack and I'll take this series.

Rob

