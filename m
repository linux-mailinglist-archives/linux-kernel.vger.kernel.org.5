Return-Path: <linux-kernel+bounces-96798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3329876195
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49E71C21C64
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E7B54773;
	Fri,  8 Mar 2024 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6d3Px3E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4260C2CCB3;
	Fri,  8 Mar 2024 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709892609; cv=none; b=thXhaoLrmWe1u7XsD6/j9gYTlW0rSh2XIeuefnh8SAFImfg0L6fAtfKXra6x4uE1jzVu+Ll2I4HnDOEfv1lEu1ucGlfd8wJp77TeYzsCCsR0V4YY/EasjlbI5eb26b0cg0if/IsM101k9iq8xpAvmJZy4/KDBOtqQ/m3M55kqTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709892609; c=relaxed/simple;
	bh=OCKwCfTIRJwvOriF5VsusXHyfUYH3b+fWYKa4JsFYAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggVclNqTfCDThG2fv16OmHcGsTNBGMuNi9EGEjjHZ0wASEHypwN3Jge7//XZp+iQVHknKAsyPdhOQc27s45qkkrbZ4hD/obeSvTJ3ilnPkw9q6YD+FIF29TRpn+kPaaABGub7KQ0QsCPOLAlSZiJ8YRRgCnAxwT1l38TBBwx8LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6d3Px3E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79362C433C7;
	Fri,  8 Mar 2024 10:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709892608;
	bh=OCKwCfTIRJwvOriF5VsusXHyfUYH3b+fWYKa4JsFYAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l6d3Px3EAnOOA2ro7NhZnhLQCRtJb2fQsbwJsPGEKOtwmkiZwVbTZCw4Xpqz5TEWh
	 YWrGmT4Oh6J4rOLv/IGYIn4Blz6PX6gL63Ro3ZUg0N173dy3GDMKdEpcw9vIcIMhGU
	 8ZRuVP49FKwyzhir8jUoiPOfFZWWaTa85uAn3k1B/2S1pUCO7n4tquRZZxKn/xBvqp
	 6KcRdCabk18cpCoLraG3w8Q8CedBAqIq/V2GbUqRZ5JXJZeUQus2vltPLS0qNIjf0M
	 H7EsmUM13sAyebp55EQLkcqgke7wHG3X0oFiAVDJsKwXQTsJs5dkYZ5w/aeZcG7rl2
	 hddJITLCiJWMg==
Date: Fri, 8 Mar 2024 11:10:02 +0100
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
Subject: Re: [PATCH v8 6/7] scsi: aic94xx: Add libsas SATA sysfs attributes
 group
Message-ID: <Zerj-rojTEQ3rThv@ryzen>
References: <20240307214418.3812290-1-ipylypiv@google.com>
 <20240307214418.3812290-7-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307214418.3812290-7-ipylypiv@google.com>

On Thu, Mar 07, 2024 at 01:44:17PM -0800, Igor Pylypiv wrote:
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

