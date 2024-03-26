Return-Path: <linux-kernel+bounces-118527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C42488BC2F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28301C2C96C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91DA133998;
	Tue, 26 Mar 2024 08:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LDm8XQaP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F272E21A0D;
	Tue, 26 Mar 2024 08:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711441252; cv=none; b=TgduVlkDqSyhQSUuO5lDmlQug5w96hO3aQ02gk2wNJr9gokLHhXm7L6V9JG4wiIH9SUpmTkUHrtMvCuendjGopJyyFhyu/1P7eNViawh1qPqV1vqZJdbMwDWRf65E8tAB7pv/CApegm9WjWnQpuxfpr1uCXxI/++qZFPx9Cwork=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711441252; c=relaxed/simple;
	bh=qz9xGWKw9TwZIZmkOtsqi7+FfSavXvo92wFhs8sRnkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEZM9m4sE1BCq2lLuaZ0NdqE2Uh1iWGk8j+z6fEK8qEoKxg3l2hyr/uSM1lbK5MATFj4W8EVJr/+4XNyih4RJCQ+f+Nc1VekxRM/Aa0SvjD9Gdw+fVOCLsEff+QHbKgduf7i1siaty9hFwuWrHFCd7pPWr0ZcBB4eYJhuIGbjVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LDm8XQaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82CCC433C7;
	Tue, 26 Mar 2024 08:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711441251;
	bh=qz9xGWKw9TwZIZmkOtsqi7+FfSavXvo92wFhs8sRnkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LDm8XQaPKUEiClyhmzcOTtjFSd3byVDHpoMPcmb6vbREBzl7cdpjcrT+vH/U0WQbm
	 LukRcNmEVpHJ0XrmZvUNdLs52U4/MB11/5vIYuawqiNf+jDy9KtUj+wiuFJvpfHLpd
	 Bj2BoKpm9BYgKf/PeoJcvrCq1NF+vBNnXnNmY1Ec=
Date: Tue, 26 Mar 2024 09:20:48 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rob Herring <robh@kernel.org>
Cc: Herve Codina <herve.codina@bootlin.com>,
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
Message-ID: <2024032634-suitable-jeeringly-37f2@gregkh>
References: <20240325152140.198219-1-herve.codina@bootlin.com>
 <20240325152140.198219-2-herve.codina@bootlin.com>
 <20240325164401.GA276583-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325164401.GA276583-robh@kernel.org>

On Mon, Mar 25, 2024 at 11:44:01AM -0500, Rob Herring wrote:
> On Mon, Mar 25, 2024 at 04:21:25PM +0100, Herve Codina wrote:
> > The commit 80dd33cf72d1 ("drivers: base: Fix device link removal")
> > introduces a workqueue to release the consumer and supplier devices used
> > in the devlink.
> > In the job queued, devices are release and in turn, when all the
> > references to these devices are dropped, the release function of the
> > device itself is called.
> > 
> > Nothing is present to provide some synchronisation with this workqueue
> > in order to ensure that all ongoing releasing operations are done and
> > so, some other operations can be started safely.
> > 
> > For instance, in the following sequence:
> >   1) of_platform_depopulate()
> >   2) of_overlay_remove()
> > 
> > During the step 1, devices are released and related devlinks are removed
> > (jobs pushed in the workqueue).
> > During the step 2, OF nodes are destroyed but, without any
> > synchronisation with devlink removal jobs, of_overlay_remove() can raise
> > warnings related to missing of_node_put():
> >   ERROR: memory leak, expected refcount 1 instead of 2
> > 
> > Indeed, the missing of_node_put() call is going to be done, too late,
> > from the workqueue job execution.
> > 
> > Introduce device_link_wait_removal() to offer a way to synchronize
> > operations waiting for the end of devlink removals (i.e. end of
> > workqueue jobs).
> > Also, as a flushing operation is done on the workqueue, the workqueue
> > used is moved from a system-wide workqueue to a local one.
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> > Reviewed-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/base/core.c    | 26 +++++++++++++++++++++++---
> >  include/linux/device.h |  1 +
> >  2 files changed, 24 insertions(+), 3 deletions(-)
> 
> Greg, can you ack and I'll take this series.

Looks semi-sane:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

