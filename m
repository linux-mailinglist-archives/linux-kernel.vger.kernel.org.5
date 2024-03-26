Return-Path: <linux-kernel+bounces-119346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C53488C759
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1F6320191
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D2F13C8F9;
	Tue, 26 Mar 2024 15:35:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B705513C8E3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467337; cv=none; b=caFcjmjIxpKhZ00v+9T25tGS+c4/vGSu0z3Aq8ISdg3RDv9kR358yN2okEBr7B85Wugr2gajb6fliDRVVLkWF4bvR7GFpJA/FIo8xVl3HZqpDJVGu0GHWDHi2BuFp6qQFxme8iU0ZhLyYFPmHPg03hyY8KPSvNZRMiLNiG9egyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467337; c=relaxed/simple;
	bh=Kyhb5q3lU4UhpGJ7tYd+4i5cDP17k8NZvE0FhPQYUCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRNysy72SAsF6RfVTHbVPEAaWMHtcg1oD3PUSnlnt7l9ZTQf00jHA+XsDYxP0IYPg08yQ14xD+um3+fYX7VNDV7hwUC5sKaIv9y5jQ6/2o1g3ztNACvVyOD0aNr54oTn5YWPUT41KrJnt50o5/xafNw9+ofCLrxCOqF8Z9vmxUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86D252F4;
	Tue, 26 Mar 2024 08:36:08 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFC993F694;
	Tue, 26 Mar 2024 08:35:33 -0700 (PDT)
Date: Tue, 26 Mar 2024 15:35:31 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Marc Bonnici <marc.bonnici@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Olivier Deprez <Olivier.Deprez@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bertrand Marquis <Bertrand.Marquis@arm.com>
Subject: Re: [PATCH v2] firmware: arm_ffa: support running as a guest in a vm
Message-ID: <ZgLrQ7FtDy3INX8F@bogus>
References: <20240325081335.2326979-1-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325081335.2326979-1-jens.wiklander@linaro.org>

On Mon, Mar 25, 2024 at 09:13:35AM +0100, Jens Wiklander wrote:
> Add support for running the driver in a guest to a hypervisor. The main
> difference is introducing notification pending interrupt and that
> FFA_NOTIFICATION_BITMAP_CREATE doesn't need to be called.
> 
> The guest may need to use a notification pending interrupt instead of or
> in addition to the schedule receiver interrupt.

The above statement makes me worry a bit that we are still not on the same
page about NPI vs SRI. NPI need not exist in addition to SRI. And in v1
you did mention you have SRI in the guest as well. Then why do we need
NPI in addition to that. As part of SRI, the callback  ffa_self_notif_handle
gets registered and will be called as part of SRI handling. What you
do in  notif_pend_irq_handler(), exactly what ffa_self_notif_handle()
already does.

I am still struggling to understand the usecase here. If you just have
NPI and no SRI when running the driver in the VM, then it aligns with
my understanding of possible use-case(not the one you mentioned in v1:
where FF-A driver in VM will have SRI as OPTEE is the secondary scheduler)

If we are supporting NPI or SRI, I think we can see if we can further
simplify this change, but I want to get to an agreement with usage model
before we dig into implementation details in this patch.

--
Regards,
Sudeep

