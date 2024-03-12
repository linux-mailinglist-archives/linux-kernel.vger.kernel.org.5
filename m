Return-Path: <linux-kernel+bounces-100453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 589068797C1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB171C2138F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2C67CF09;
	Tue, 12 Mar 2024 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNcucUym"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8714A1E534;
	Tue, 12 Mar 2024 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257869; cv=none; b=u379j4GGoFHWb/FNQJGjeLUepgHYpI3PlgraglhcWAjFsbNFukMZMyrb8YL6gOX8GngDJU6dUUzumx8qPKWvfBqBVZyo0u0/9QX2uNNVieg+5wPmvaQtfG4Ija1sJhdrYm2fehVcxd0v9oaXQKnKrd3Npmjoo8l3xsvnhHeraLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257869; c=relaxed/simple;
	bh=a1HUuTjqXPjdMAODl61yMmgB6v/nDK8Z43bW0h5mYQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUI9ls4g3LJDPv8v6EiJ0Iseu/W4AUv27bxz3Zfj2FvD+6rDnuG1cmT4W0vZ5ounZSM771NT+qQS6ZZArlD6rwXhjcDGUdCh6sZHLE0x+nS/ZUnN54vOmUIzRwwzEp6j0ml4WsCGctWvB9nKD2qJgYgMOfHcomVesK/bwyE+xl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNcucUym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A15C433C7;
	Tue, 12 Mar 2024 15:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710257869;
	bh=a1HUuTjqXPjdMAODl61yMmgB6v/nDK8Z43bW0h5mYQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kNcucUymh43PmouWxMJDNZU9OYI1fqD413lILPRCs/jiUxGX7/2IABS7O7aGHJQ3b
	 0txvh53c7QGo/I7YNQvsyI2tMVUNFGRclMJFUUhVWLtuB4Jr9l2nAsbxogq14q/rRH
	 l8PHWNIgHrnuhYwJsMhG28B5fp6aKhi613a+9Woeqt7z1hyn1J7dVaEOIhZdxQPWdT
	 drrWTinBC5ctHwL1e3of0TqORKafkuUNzYhhKQocsoKxdvYwMYEuRR5heOZEH9Eild
	 vfBJZ04IbpRJpDUc/DnTE9AWmMp/8ixHSqa/I0hl51Njz0g76Ic3oNtR53qmwJOdlG
	 K4iwM39T5mTgw==
Date: Tue, 12 Mar 2024 16:37:42 +0100
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
Subject: Re: [PATCH v8 1/7] ata: libata-sata: Factor out NCQ Priority
 configuration helpers
Message-ID: <ZfB2xrTOuNrrl2Q8@ryzen>
References: <20240307214418.3812290-1-ipylypiv@google.com>
 <20240307214418.3812290-2-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307214418.3812290-2-ipylypiv@google.com>

On Thu, Mar 07, 2024 at 01:44:12PM -0800, Igor Pylypiv wrote:
> Export libata NCQ Priority configuration helpers to be reused
> for libsas managed SATA devices.
> 
> Switched locking from spin_lock_irq() to spin_lock_irqsave().
> In the future someone might call these helper functions when interrupts
> are disabled. spin_unlock_irq() could lead to a premature re-enabling
> of interrupts, whereas spin_unlock_irqrestore() restores the interrupt
> state to its condition prior to the spin_lock_irqsave() call.
> 
> Acked-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Jason Yan <yanaijie@huawei.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>

