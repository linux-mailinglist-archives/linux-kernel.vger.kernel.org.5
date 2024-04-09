Return-Path: <linux-kernel+bounces-136210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B1F89D13C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92569285F11
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFFA54BFD;
	Tue,  9 Apr 2024 03:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IybSXFxI"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0E754BEF
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712634012; cv=none; b=CaI2/UeyuQn5cJMEYohbcoF/MFMcHE0B+hkrsRwoNASePa4/uAfEHPNfvB2U0V4F6yk707gbuzDPo6pJOZcv80+W2OPNY3Y1C6TsdrJ6K3Ll14hzGlzwQHUisLDdtW6PPiloyg7HV93EII5FeRnsJmNoECO7PiZuzTKq6IKvN24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712634012; c=relaxed/simple;
	bh=fFF78VPngM7y/us+qOuPjusOESrskdwFUvjmvDF+A5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2dkd0MqMM7DL+cRqX7ZXFZzowH+SMtVMw6AeyaxrZ7t0CF/DduQFu428eP623D6LtQPngRXkIBUptfQZPmdoJpC7EykezpqVKpbI25gauOg3JDCMONP4SNuX8G57HO4I5IrqqKpzcMFDa+teEuYCG4cQn6kh8vftmtZSU4Kdtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IybSXFxI; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 8 Apr 2024 23:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712634008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pJRkboi1XfUhwyGSGsoCmSy3Kg0vHEU0PUHEGOzc2K4=;
	b=IybSXFxIG7G4z7NZL+lJGPg3IP8nE6mX+nildWlX3cc2xvghUUnsiz25bQ9ZJHtE/jiBQJ
	oOjHPj4AbaXKZ77GaqwLNwsodiSXm9Jvw9uh5krnkCXS2gJyMAjONervwTyIj//5sAqmTC
	54/zO9xkgRXwbddjtU2UOjvsrrFfF9A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: colyli@suse.de, msakai@redhat.com, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, akpm@linux-foundation.org, 
	bfoster@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	jserv@ccns.ncku.edu.tw, linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dm-devel@lists.linux.dev, linux-bcachefs@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 00/17] treewide: Refactor heap related implementation
Message-ID: <i2qewo34mvw7bizhefwz5s3fc4nlc4zk7eijglkieuci5iradm@zgcks3u5omhw>
References: <20240406164727.577914-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406164727.577914-1-visitorckw@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Apr 07, 2024 at 12:47:10AM +0800, Kuan-Wei Chiu wrote:
> This patch series focuses on several adjustments related to heap
> implementation. Firstly, a type-safe interface has been added to the
> min_heap, along with the introduction of several new functions to
> enhance its functionality. Additionally, the heap implementation for
> bcache and bcachefs has been replaced with the generic min_heap
> implementation from include/linux. Furthermore, several typos have been
> corrected.
> 
> Previous discussion with Kent Overstreet:
> https://lkml.kernel.org/ioyfizrzq7w7mjrqcadtzsfgpuntowtjdw5pgn4qhvsdp4mqqg@nrlek5vmisbu
> 
> Regards,
> Kuan-Wei

pointing test automation at it now:
https://evilpiepirate.org/~testdashboard/ci?branch=refactor-heap-v3

Coli, could I get some acks from you?

