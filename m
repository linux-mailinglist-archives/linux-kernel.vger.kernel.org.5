Return-Path: <linux-kernel+bounces-64218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13937853C12
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38C9286350
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB11060BB4;
	Tue, 13 Feb 2024 20:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gaknWtD7"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED1760B85
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 20:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707855148; cv=none; b=UVwamzV6iP/d5okUp/+UwnhB8ZepvKyemfMpyNaWwBK1PHuCFRRSNelIiV2t2N5E60ymPtsnZZ+VMp8usbBcqrNn3uhlNH4Wl4hHCugXo6Eeuwf01anmEBlAlBSRX9SC+7M9r2GP0QVPdF2X3EkMxh0QERt3cFRD6hvKo1slA54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707855148; c=relaxed/simple;
	bh=WzClOifpUCSoYB1Gr9NXXGUfJ+JOmYmKWTDQuwaxiRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGx00iQVp0kO4OaIy4+JuK6DVtmK0fQWxZ6QsWfAlO+/l7gqMEKhZjFcrrQ6BgMR4djLiipzlmWWB3v44lZJVvtAuqRXZIeYw1Ju5r2kK5sfAuHmsqHEMjHjKC4/JGPLli2WIE4fyTPf9xXAn5k6znMW1Agj5EKEpSbERID8k6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gaknWtD7; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 13 Feb 2024 12:12:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707855143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ynvcun4Y8ZFlfFtT4gj87TNcq60Lzv8L5cy3V0DM2g=;
	b=gaknWtD7n6/VN29uhilsWT819EYmFiEjAGhQwHAGgX+2Z4hnXnh/JZQKCHj4890NhvfADc
	3SgZMXDJSeCH5W85ySuI8VTgUGytg0q5wQV0W5G1RtEm092yItcmgCZfv4vollSNKJ7vbw
	bkWKua0XYQmHDvlfRJEjs24ZYMHzQHw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: kvmarm@lists.linux.dev
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/23] KVM: arm64: Improvements to LPI injection
Message-ID: <ZcvNIQmLMHcGnC7m@linux.dev>
References: <20240213093250.3960069-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213093250.3960069-1-oliver.upton@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 13, 2024 at 09:32:37AM +0000, Oliver Upton wrote:

[...]

> Clearly the RCU synchronization is a bounding issue in this case. I
> think other scenarios where the cache is overcommitted (16 vCPUs, 16
> devices, 17 events / device) are able to hide effects somewhat, as other
> threads can make forward progress while others are stuck waiting on RCU.
> 
> A few ideas on next steps:
> 
>  1) Rework the lpi_list_lock as an rwlock. This would obviate the need
>     for RCU protection in the LPI cache as well as memory allocations on
>     the injection path. This is actually what I had in the internal
>     version of the series, although it was very incomplete.
> 
>     I'd expect this to nullify the improvement on the
>     slightly-overcommitted case and 'fix' the pathological case.
> 
>  2) call_rcu() and move on. This feels somewhat abusive of the API, as
>     the guest can flood the host with RCU callbacks, but I wasn't able
>     to make my machine fall over in any mean configuration of the test.
> 
>     I haven't studied the degree to which such a malicious VM could
>     adversely affect neighboring workloads.
> 
>  3) Redo the whole ITS representation with xarrays and allow RCU readers
>     outside of the ITS lock. I haven't fully thought this out, and if we
>     pursue this option then we will need a secondary data structure to
>     track where ITSes have been placed in guest memory to avoid taking
>     the SRCU lock. We can then stick RCU synchronization in ITS command
>     processing, which feels right to me, and dump the translation cache
>     altogether.
> 
>     I'd expect slightly worse average case performance in favor of more
>     consistent performance.

Marc and I had an off-list conversation about this and agreed on option
4!

It is somewhat similar in spirit to (3), in that KVM will maintain an
xarray translation cache per ITS, indexed by (device_id, event_id). This
will be a perfect cache that can fit the entire range addressed by the
ITS. The memory overheads of the xarray are not anticipated to be
consequential, as the ITS memory footprint already scales linearly with
the number of entries in the ITS.

Separately the DB -> ITS translation will be resolved by walking the
ITSes present in the VM.

The existing invalidation calls will be scoped to an ITS besides the
case where the guest disables LPIs on a redistributor.

-- 
Thanks,
Oliver

