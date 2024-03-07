Return-Path: <linux-kernel+bounces-95287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A08C874BC8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A55B1C210F4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4226E12BEB9;
	Thu,  7 Mar 2024 09:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1hyPxsV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ABC85274;
	Thu,  7 Mar 2024 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805579; cv=none; b=sms+M3aZMdHF0MCyqE0zdlQBja+tPdtWRinbMthwynWdzkZ8t0H5MtO6lmw+1MwaoUObkMyuZj5IwloqTvtklEyk6M7cX6qly7o55Fbfri760dDMbimO97hsG9NAzOX6VG+ZcPWgElpjq3R9FUoqTRCKeLhL9y+HQekSNr1ohL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805579; c=relaxed/simple;
	bh=QESLITRRZmWL1xYI6WaTXqc22mhlRf1RjJuqoqwfe90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkAOOXE7F+GyN2be/k0CKTZfvgVnExEN501nrtxWLSJ6DxA3YJnrxKZvyVfXBS6bErp+YZxWgz3CiTK4Ia1pNxaIHqcMLVN9GCq0PzHn1AXvIbqXkwR45btyniYz1PwgcOHGqQtThNn15uWl2hiLjucYvHIj4uj4yBDwjzxwyX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1hyPxsV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED31AC433C7;
	Thu,  7 Mar 2024 09:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709805579;
	bh=QESLITRRZmWL1xYI6WaTXqc22mhlRf1RjJuqoqwfe90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U1hyPxsVr2Sn0zfyl9cDSdqpUzmUlXLVvZztStJaP/sMfvpYLv/60kT+JMuHZ8DkL
	 ICtrXpBwhqzzr2NMq1xmTK804mYqaqGZda2j9Ia7UK5R6gFsKrlv/br+eu8BTaMy8Z
	 CJjko3P9pFT7SpQcWhsx1eegdmG07k4ZAywUCHnFjJQsoCFfkOgRoAOW/HrtZ7KHlE
	 kcZBRFSbwZGhJnyQvd7gymdvqNOV8c2z85OEDb9FJFE8X9nJoakMev7parYUUWPh/B
	 w8LtFuSkVbzbhKpJcqvUFu8FJcFWxK2Bb+3GOtLMgUxMbtbcCduXCrvlbI11/i5zO5
	 zaTBbBH9t/aYg==
Date: Thu, 7 Mar 2024 10:59:32 +0100
From: Niklas Cassel <cassel@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Igor Pylypiv <ipylypiv@google.com>, Damien Le Moal <dlemoal@kernel.org>,
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
Subject: Re: [PATCH v7 5/7] scsi: hisi_sas: Add libsas SATA sysfs attributes
 group
Message-ID: <ZemQBLMcJP617WDC@ryzen>
References: <20240306012226.3398927-1-ipylypiv@google.com>
 <20240306012226.3398927-6-ipylypiv@google.com>
 <ZehLpV06mpHxjecc@ryzen>
 <ZejYb4ykeF7Qx5a5@google.com>
 <c3ebaa55-d05b-4f11-83a8-2a0fb85044cf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3ebaa55-d05b-4f11-83a8-2a0fb85044cf@oracle.com>

On Thu, Mar 07, 2024 at 08:55:51AM +0000, John Garry wrote:
> On 06/03/2024 20:56, Igor Pylypiv wrote:
> > > > ---
> > > >   drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 6 ++++++
> > > >   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 6 ++++++
> > > Is there a reason why you didn't patch:
> > > drivers/scsi/hisi_sas/hisi_sas_v1_hw.c ?
> > > 
> > I originally patched hisi_sas_v1_hw.c as well. John Garry pointed out
> > that v1 HW doesn't support SATA so I dropped the change.
> 
> If you are going to do another spin, then maybe update the commit message
> with this.

+1


John, now I'm curious, do you know why hisi_sas_v1_hw.c is implemented
as a libsas driver (instead of a regular SCSI driver), if it doesn't
support SATA?

Was perhaps v2_hw and v3_hw implemented as a libsas driver first
(since they support SATA), and v1_hw support was added later,
so that it could reuse much of the parts of the existing driver?


Kind regards,
Niklas

