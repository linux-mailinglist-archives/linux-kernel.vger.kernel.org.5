Return-Path: <linux-kernel+bounces-148755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC9E8A8704
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E594AB26221
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD421474AE;
	Wed, 17 Apr 2024 15:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="drjTnJfB"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D34146A98;
	Wed, 17 Apr 2024 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366426; cv=none; b=tBid08NDqpdZv0Cffd3Eo7ikwyRNC4otjl3gTgl9mRIe/scIbiJvkmf3AOxzZFWAKVdpinsgSNbTqTRnhA0/GUgirU4I/v5CHRhoyTiYXermzlYbvXbXuI3AAbHR0rT0iZMU4gBUlyPGNaypy5/TLk56qQHTsvtHpCp13Ctn4FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366426; c=relaxed/simple;
	bh=yApPYuulzE17i6dmwrXZM/IajwO1lP0UGISZ6thL88s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hx8fcaFg42d7a+3iV+eNIjKgy7NO2QlTwuyDN3WcZ8FnSrsch2oH5/PK+8RmWG4HtP+6Gye6ckkD4WekBiEH1nZi/ApQQbswOqPnkhxGLrUoUaVJRoAKleJrITPfmslpcQ4sXo9QRDVG6mIldhZKeeDhqrJQfG2hrtnkSFlbBlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=drjTnJfB; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cF+8R035uNTlFeFw8pdAD8eweWCrr746jpBDTBrOITI=;
  b=drjTnJfB6VZlnR3tWr7VSVrKyUCBJxJjqykiaDui2j20B3sUoUijYEwc
   3qfpluVzgV4G0dIOQwavDfPDRmcgB5n4uGir4KjhlAS84UFSN3A9Elni6
   u2ycOjDJAcvNrvmWYdtNBLQjImXaPukLGw3YHvHdsq2+S+iTuEd4SnP0R
   g=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,209,1708383600"; 
   d="scan'208";a="85068655"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 17:06:54 +0200
Date: Wed, 17 Apr 2024 17:06:53 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Wenchao Hao <haowenchao22@gmail.com>
cc: Markus Elfring <Markus.Elfring@web.de>, 
    Wenchao Hao <haowenchao2@huawei.com>, linux-scsi@vger.kernel.org, 
    kernel-janitors@vger.kernel.org, 
    "James E. J. Bottomley" <jejb@linux.ibm.com>, 
    "Martin K. Petersen" <martin.petersen@oracle.com>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] SCSI: Fix issues between removing device and
 error handle
In-Reply-To: <b55da065-dbbb-4d8e-8baf-50807b507cc4@gmail.com>
Message-ID: <173b55ca-cde-ab3-be92-d9c8b4b6b5c@inria.fr>
References: <20240307144311.73735-1-haowenchao2@huawei.com> <99598b98-8550-4dca-beea-4c2d61d46f78@web.de> <b55da065-dbbb-4d8e-8baf-50807b507cc4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1787994114-1713366413=:3710"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1787994114-1713366413=:3710
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 17 Apr 2024, Wenchao Hao wrote:

> On 4/15/24 11:07 PM, Markus Elfring wrote:
> > …
> >> These issues are triggered because devices in removing would be skipped
> >> when calling shost_for_each_device().
> > …
> >
> > How do you think about to add the tag “Fixes” to any of your patches?
> >
>
> Thanks for your suggestion, but I don't know how to add this tag. Could you
> please tell me how to do?
>
> I just added "fix" in my cover letter and some patch's subject.

Search in the git history for other patches that contain Fixes:

Search in process/submitting-patches.rst for Fixes:

julia

>
> > Regards,
> > Markus
> >
>
>
>
--8323329-1787994114-1713366413=:3710--

