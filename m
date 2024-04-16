Return-Path: <linux-kernel+bounces-147228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 931038A7147
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E025B2159A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B139131BD3;
	Tue, 16 Apr 2024 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gE0OzcRK"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B9F43AA5
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284606; cv=none; b=jAqjPmWDbLH+DpPCQq+AEA2756476iUu8pmAuozeL0LKxalNFpsr70i+ePThsVSkiMWHDl/u6we5545qsy97fAQka6zqPnMlnEJwYWihMEEFCWi4iOx+SvW8F13FELxq//a6Psu1Fi9nj8a0dy8gW16LtzEXbFTg7FEDeNgYhkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284606; c=relaxed/simple;
	bh=NqJNbQnkmhNwT2hjGCczzRCYVBXMl2cwjSjuwVmFj4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaMde9zhulN39Yp0cRaUpuiSMX2da4RFj6MYiVMNp+NfLnLeVoQoN/5jm+3k8WmFPBgvl4qIUm7LVCW+Kap7fUBbDqrEBByT+4NJXzOI5rfikyNUDJQpEx+mIa66ZNVG6ou/w4geNUWSmHFY/Rv0k7qCf9+v6ofjnfftTcVSa6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gE0OzcRK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZR5n7juj1Hh+Zmj/fiVDbxN1QXrwOEQlxO/uA8d7SzI=; b=gE0OzcRKn8l0pqnUK+Ce8VuHYL
	7VZh4vw6xOyBDxX48Ll5h2lrH5cb/3EE5can0Z6OBQs0wm6Or+MGjgfGxm9byZObjLdrGMkOGneWx
	NCN03a1SrlHAvmUfIxPhJEU/XIUg/1Suj8wIMJ1WvENb2ejltUro9opxhB1txahTV31cNiWgLxHNJ
	vwPSzmQX7T3I2cn30uY9/tmUsOhGU4fRTni6j0HJhmRImdJpLudxWNblw5wUtKVU/gKLThfi6hDgC
	n3AIaaIPLDoskosuvyhFJYvY2oPwW9+dXMH/FitD6/cnFS3lucK2Nl+lZYjyHbLLXPt+CpWWHtu3M
	HdHOjGFg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwlaa-00000000v5r-07tL;
	Tue, 16 Apr 2024 16:23:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A93AE3002E1; Tue, 16 Apr 2024 18:23:19 +0200 (CEST)
Date: Tue, 16 Apr 2024 18:23:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Igor Raits <igor@gooddata.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	slyich@gmail.com, wuyun.abel@bytedance.com, yu.c.chen@intel.com
Subject: Re: 6.8 to 6.9.0-rc3: kernel NULL pointer dereference in
 pick_next_task_fair+0x89
Message-ID: <20240416162319.GG30852@noisy.programming.kicks-ass.net>
References: <CA+9S74jmWiSWaGoMU9AZnJJd1Ck2qNBdkBZG1=J3PC8gsqqWxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+9S74jmWiSWaGoMU9AZnJJd1Ck2qNBdkBZG1=J3PC8gsqqWxg@mail.gmail.com>

On Tue, Apr 16, 2024 at 08:18:28AM +0200, Igor Raits wrote:
> Hello all,
> 
> We also see this issue quite frequently these days, however it gets
> slightly hidden behind printk issue so that full stacktrace can't be
> printed due to the deadlock.

Who is we and how do you make it go bang?

Having a semi reliable reproducer in hand would be a tremendous help.


Anywya, I've had:

schedtool -D -e bash -c "while :; make O=defconfig-build clean; make O=defconfig-build -j64; done"

running for an hour or so now, but no luck :/

