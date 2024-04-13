Return-Path: <linux-kernel+bounces-143694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7768A3C57
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 12:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3A71F21C55
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 10:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1762F3D977;
	Sat, 13 Apr 2024 10:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZfhvQYmY"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9983E474;
	Sat, 13 Apr 2024 10:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713005638; cv=none; b=Bu8ZuyTDb9C/rvGXo+SftwBO6zXZRSt2ftSybtdy0tSxFwrUdioMNUXdjfEVu96G8oIjPfq4ukdZb22RmIMszvgGFtbelc+2/K8chU3hMOZoc/371z2gnUMZ4m3fxd30rstlkxbliqnpKM6O9ZUVzBw5PSASnV1Z+btWUJnuQgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713005638; c=relaxed/simple;
	bh=J/I69OHPYRW3oenSHCI4V2tqpjIkZ2xEoS0CcFpA8jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGpDNameZyNJ0AIXX4XKtEu7DoUQtZ4Kmpv52CMtFzDKgtP3F5fS2ccT14Fbskexk4sMNW1hxq8U8U2qAZAcZ1rMkWOOhIiZ2uoQC43XviPxqWn1XXdixGOvJH5NGsGq0s4TPloUZ30fE6ZYooy68V6pDU9DFj+xbM+XhhFtzf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZfhvQYmY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EtZCvz9OOwHhF+AnRS3IqhTk9IyXCEDTR32VzQ0riNg=; b=ZfhvQYmY2cyVPFtNeMwj7Ssg7y
	QZYW3DWdLN4jyoKEJb1AfrjkPp65YCjtz8ziDa6lnb+0LIwSFwI96PF5aRDn1HTIbBsaNIa6slIsA
	AkbKD8TA4qE0VpXDW/zo5cYZAy0kUitgOOJReJqsOzxWkoaWS5Cx1AaPLNdYFb0s1T81cGtQ+//DR
	NxgwByjXNiLNWw1FEiXJSbn34diSGNtX36MefxbosGuJsUZbMHicSNxYpf538VEE5awY82WYoy51f
	MDw7w4jVyNZGb86RNk/JbAN/cmIQhvQbMLyMp7GBrkwVIh8SKvUqVe55U4d9r8npyfwqxzrz/+gRl
	2dj5qvSQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvb0t-0000000BFWj-16F7;
	Sat, 13 Apr 2024 10:53:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E750930057A; Sat, 13 Apr 2024 12:53:38 +0200 (CEST)
Date: Sat, 13 Apr 2024 12:53:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, primiano@google.com,
	aahringo@redhat.com, dcook@linux.microsoft.com,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC PATCH 0/4] perf: Correlating user process data to samples
Message-ID: <20240413105338.GD40213@noisy.programming.kicks-ass.net>
References: <20240412001732.475-1-beaub@linux.microsoft.com>
 <20240412071245.GD30852@noisy.programming.kicks-ass.net>
 <20240412163724.GB467-beaub@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412163724.GB467-beaub@linux.microsoft.com>

On Fri, Apr 12, 2024 at 09:37:24AM -0700, Beau Belgrave wrote:

> > Anyway, since we typically run stuff from NMI context, accessing user
> > data is 'interesting'. As such I would really like to make this work
> > depend on the call-graph rework that pushes all the user access bits
> > into return-to-user.
> 
> Cool, I assume that's the SFRAME work? Are there pointers to work I
> could look at and think about what a rebase looks like? Or do you have
> someone in mind I should work with for this?

I've been offline for a little while and still need to catch up with
things myself.

Josh was working on that when I dropped off IIRC, I'm not entirely sure
where things are at currently (and there is no way I can ever hope to
process the backlog).

Anybody know where we are with that?

