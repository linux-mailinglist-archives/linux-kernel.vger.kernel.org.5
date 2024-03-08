Return-Path: <linux-kernel+bounces-96794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A05A87618B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C6D28334C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8853D53E34;
	Fri,  8 Mar 2024 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/VWkXj+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF663535DA;
	Fri,  8 Mar 2024 10:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709892583; cv=none; b=GffwH8k90gnt4VDYVENXOu+EMQgHPRb2qwBjZGuBVDnVRRl4GCsXq0V5w5gfkwi2rF4YvKa0jYmzU3Pgs7G9INZP0jZhYHO9hgWcZuLTa+aInDQY6uXo8LDHHi/l2bVLtYzFIGM9kkxXSLqcgmg+pfa8Inc7m4RUQWv3MGnFXkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709892583; c=relaxed/simple;
	bh=+G8orH8im1fJ7rNQbGZr86/Bi7x7EOtVKN/WfGSAwUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODKRBWYkwsVPIYpIuEDFdbYdQ2YJIuCc+UaQHoleHCRaX7VKZX3KUbbHb+0El2miCD/GLKzq5wTewfywWz7a1mq5aEuuY83ak8nqHLlkaLNB53pWIH7zV9ysMjH/2AG26xnTj4YN/5Edh6aOI7NSV4m1UwD3yH9nD45p08oNkLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/VWkXj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D64C43394;
	Fri,  8 Mar 2024 10:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709892583;
	bh=+G8orH8im1fJ7rNQbGZr86/Bi7x7EOtVKN/WfGSAwUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n/VWkXj+igndGIpNlIdjJ1TwUnm+GV3D+6xboeaHUaDB8HCj13W9/JX9RKwshYRst
	 t02pM+xwRLGhVKYRUEGoWe6+S3e30jMu8LcXn2+d1iC1hq2CAHgrUvKxhVwaHDjJUV
	 5nu+paQJozztApZEqs2MrUi4xJhJ996gLP6gh+U/qzn8tp2+Lo6ZVhCj8ltvUGxQj7
	 MGeVWtiTVJvlcr3RSv7n/538rMPkENtu5kXPWDBi9zG3961kQck2zmGO5mBGy6tO3q
	 cwznp8zVcVGxNfHSgIIq72Id9SkNKTB2COn7F4gu7EhdcSU5XbpgraSKMC4xKhXeaP
	 St5Y/Kja1NKhQ==
Date: Fri, 8 Mar 2024 11:09:36 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Jason Yan <yanaijie@huawei.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	Hannes Reinecke <hare@suse.de>,
	Xiang Chen <chenxiang66@hisilicon.com>,
	Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
	Bart Van Assche <bvanassche@acm.org>,
	TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/7] scsi: mvsas: Add libsas SATA sysfs attributes
 group
Message-ID: <Zerj4NRFLpp3zPCj@ryzen>
References: <20240307214418.3812290-1-ipylypiv@google.com>
 <20240307214418.3812290-5-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307214418.3812290-5-ipylypiv@google.com>

On Thu, Mar 07, 2024 at 01:44:15PM -0800, Igor Pylypiv wrote:
> The added sysfs attributes group enables the configuration of NCQ Priority
> feature for HBAs that rely on libsas to manage SATA devices.
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Jason Yan <yanaijie@huawei.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>

