Return-Path: <linux-kernel+bounces-112176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E94887692
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 03:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D7351C22BC7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 02:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDCE137E;
	Sat, 23 Mar 2024 02:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SDHpXhFd"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC206EC2
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 02:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711159684; cv=none; b=CzydNXMRmO/5Jzo+95AFOqKvSYzPi+ulWldDl5zLr3EROIMruNFwlXjHnewXvis749B4Kk2ixodCKhi5s9ZSET4HcG2uqB/37DYQzmfLIekaqmg0m8b1RjGcRNiFxv29yyGXPiPgX81ZGWTn5yuWOr7z9ioducumZxRS2ahsYYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711159684; c=relaxed/simple;
	bh=G0qqejbTt8x+fQsE2uIDzXF2fMgwgfYI1BMVmDEbtVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1pK5Q4LAyAhB8d1CWofbh2Jw7OsQ8TZl9WlCE0KWvl173io7/IiujDxScFhWU2g2SDbtHnIsSSd/m1O12lCG+9XsC1fR6AT2Wq0s4qex1RnnZb1nlAJqAAT++QIHpsgHnqQizUohTTOT+xV7I1wQ1w4FiAMAKsiEcvRnQz2+sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SDHpXhFd; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 22 Mar 2024 19:07:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711159681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5VkD5z9YkAdX6FArt2jg1nT/B62sh2p7lPRadskyhS4=;
	b=SDHpXhFdepH9Nj+WO/hIIjmvTRVCgXX6AKi+TQQXTYMd1JS/R4MWvwg2QeCz5Aza55n83d
	GkB2zofd2b4riHxCi3zhFaTsWoBg0QiEQG46JIHRc+WKtDgpogxfMXOXnsnveH9HCUaWhT
	pXFNjI9dkhah5sJIwmnK7NeD46SWwrs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sebastian Ene <sebastianene@google.com>
Cc: catalin.marinas@arm.com, james.morse@arm.com, jean-philippe@linaro.org,
	maz@kernel.org, qperret@google.com, qwandor@google.com,
	suzuki.poulose@arm.com, tabba@google.com, will@kernel.org,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH 2/2] KVM: arm64: Allow only the specified FF-A calls to
 be forwarded to TZ
Message-ID: <Zf45eDs8Bd1UQ94Z@linux.dev>
References: <20240322124303.309423-1-sebastianene@google.com>
 <20240322124303.309423-2-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322124303.309423-2-sebastianene@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 22, 2024 at 12:43:03PM +0000, Sebastian Ene wrote:
> The previous logic used a deny list to filter the FF-A calls. Because of
> this, some of the calls escaped the check and they were forwarded by
> default to Trustzone. (eg. FFA_MSG_SEND_DIRECT_REQ was denied but the 64
> bit version of the call was not).
> Modify the logic to use an allowlist and allow only the calls specified in
> the filter function to be proxied to TZ from the hypervisor.

I had discussed this with Will back when the feature was upstreamed and
he said there's a lot of off-label calls that necessitate a denylist
implementation. Has anything changed to give us confidence that we can
be restrictive, at least on the FF-A range?

-- 
Thanks,
Oliver

