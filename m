Return-Path: <linux-kernel+bounces-69636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E486B858CA3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A07EA282FEB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7621B7F2;
	Sat, 17 Feb 2024 01:13:48 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4AF19470;
	Sat, 17 Feb 2024 01:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708132428; cv=none; b=KXm0DFATg1FPUtgF9axcSzOPQhH7hBakXvZgTl8kZkNwCqIMiiCOQOw3zFgi0HeJn0zta/eoViDdE+lGrx6y1fsES1hSEIlag5BQmCZ2DCa+r33AlKvkOEw6wzmMvxgZldQDlHzm00GCDN9Kgcb8eN5kB8cYip4lu4VkDoO/4ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708132428; c=relaxed/simple;
	bh=r85n2cbkodPY5aoOYKTOFPbefMnX/kFSpeJFH5L5r+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHNwY21flFXBS+QL7df9mVdwV19mLXABDJKIVR1dTovoucUbDMUL33aU8VTUqPKiUdu1stwUh8ChY8gZxHI0kV8Xe/3h5d2c4JGgse2b/BiDdPoILC/syrXNtzCOHoVUG0vUbRcWRAfOYXMFxOE9kX8HsnO/g2r5C6XgvRH4x34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rb9Gu-00EeOG-AN; Sat, 17 Feb 2024 09:13:41 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 17 Feb 2024 09:13:54 +0800
Date: Sat, 17 Feb 2024 09:13:54 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Weili Qian <qianweili@huawei.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	liulongfang@huawei.com
Subject: Re: [PATCH v2 0/3] crypto: hisilicon/qm - add stop function and
 obtain queue status
Message-ID: <ZdAIUhs4J2U/FW/i@gondor.apana.org.au>
References: <20240207095101.37280-1-qianweili@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207095101.37280-1-qianweili@huawei.com>

On Wed, Feb 07, 2024 at 05:50:58PM +0800, Weili Qian wrote:
> Patch #1 supports stopping function by sending mailbox to device,
> device directly flush out function data.
> Patch #2 supports users to obtain the queue stopping result by
> querying the debug file.
> Patch #3 changes function type.
> 
> Changed in v2:
>  - Remove redundant check in patch#2.
>  - The loop exit condition is modified to
> prevent no log output when timeout.
> 
> Weili Qian (3):
>   crypto: hisilicon/qm - add stop function by hardware
>   crypto: hisilicon/qm - obtain stop queue status
>   crypto: hisilicon/qm - change function type to void
> 
>  Documentation/ABI/testing/debugfs-hisi-hpre |  15 ++
>  Documentation/ABI/testing/debugfs-hisi-sec  |  15 ++
>  Documentation/ABI/testing/debugfs-hisi-zip  |  15 ++
>  drivers/crypto/hisilicon/debugfs.c          |   5 +
>  drivers/crypto/hisilicon/qm.c               | 184 +++++++++++++-------
>  include/linux/hisi_acc_qm.h                 |  10 +-
>  6 files changed, 183 insertions(+), 61 deletions(-)
> 
> -- 
> 2.33.0

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

