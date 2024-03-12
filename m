Return-Path: <linux-kernel+bounces-100450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3A18797B9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65B31F23CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E8A7CF01;
	Tue, 12 Mar 2024 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8hUP6JI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583977C0B2;
	Tue, 12 Mar 2024 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257828; cv=none; b=KTuI5JWNyS5kHJOkKrUg+2avYUiNLjz2LxNad8YG3RO5m9aWdzqPprtEbZhkBKt/8kKKT6PlI3FieN/pTMYVvrqmrI6QviZH+NcWkuYBgTt2zHiERW1Txq8rYJdObrV9AJSeqgmb9QY91h9RaYlZWszcE4umAaZ54I5LrtELxCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257828; c=relaxed/simple;
	bh=W30M/6SE7BKh9U1huPbKGcpVKwBjwlhhTiOxGjXQktQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbykxdt6ry5KSFPz+XbcDIT9tBsii83xn487KUcYN3SZKs1f2CZ5QxCoPdAISVOvowZg8aaLZTtskiB0ndhCOOeezqL3K2Spy1av8mD9ELOKc5hDYP5pm3fguQKwvPUVkTEkEAZdsjEyUl6kEVCDDQvXxt5TNwk+f5noLwUsqXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8hUP6JI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2021C433C7;
	Tue, 12 Mar 2024 15:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710257827;
	bh=W30M/6SE7BKh9U1huPbKGcpVKwBjwlhhTiOxGjXQktQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d8hUP6JIjXohPvBv6NPFZi0JrrhFfeA1Mt75eFhrHGf3un72QrgosFPDbu31HeoS4
	 N0Vv5mWQnqEEUp182QYq1mPGf47b8/4I4i4l7pN808iPlvXOe7twHESd3j6rSkvEbz
	 BJKptL9zDn2vAC8P4rluHRyfZEwycTJmS0dt1CaveubPiIIebW+N5NpcACCamP/GBo
	 bVS2EX7maUSEQf6GFtcZPANfCtZ/E80Va8LitP35CkE9X14tz7eLKuV8dW1i8zBvZ3
	 bmcreJSfHSX+tKcqiGaY71n1LNHSrwlBpcexH+yVbXfLYgWGIuvVRC4GufOwbzByVi
	 /q4fqX2xoHfwg==
Date: Tue, 12 Mar 2024 16:37:01 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Igor Pylypiv <ipylypiv@google.com>,
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
Subject: Re: [PATCH v8 1/7] ata: libata-sata: Factor out NCQ Priority
 configuration helpers
Message-ID: <ZfB2nTnzDqIgb65V@ryzen>
References: <20240307214418.3812290-1-ipylypiv@google.com>
 <20240307214418.3812290-2-ipylypiv@google.com>
 <ZeriaUWlhBqp4Q77@ryzen>
 <35801735-1e6a-43ef-8687-06ff04d53619@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35801735-1e6a-43ef-8687-06ff04d53619@kernel.org>

On Tue, Mar 12, 2024 at 03:17:43PM +0900, Damien Le Moal wrote:
> On 2024/03/08 19:03, Niklas Cassel wrote:
> > 
> > Anyway, like you said, as you are now creating helper functions:
> > ata_ncq_prio_supported(), ata_ncq_prio_enabled(), ata_ncq_prio_enable()
> > these function might no longer only be called from sysfs code,
> > so it is probably a bad idea to let these functions use spin_lock_irq().
> > 
> > However, can't ata_ncq_prio_supported() and ata_ncq_prio_enabled()
> > still use a simple spin_lock(), why would they need to disable irqs?
> > 
> > Damien, you are the author of ata_ncq_prio_supported_show(), thoughts?
> 
> See above. The spin lock irq-disabling variant is needed because the port lock
> is taken from command completion context.

Yes of course, I don't know what I was thinking...

