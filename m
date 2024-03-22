Return-Path: <linux-kernel+bounces-110821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C46886456
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7633E2837E2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75CB633;
	Fri, 22 Mar 2024 00:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7V8xRvV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38789376
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 00:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711067345; cv=none; b=e9fx1WDJVBQSkDiCQcXrbh9jCO2sd88kmPqLqFSQYEyHmQf21JEoY5+EXhWHsLF421DBgkI8JFZuZGrHmi9MzsVq5lAiAmt2KTTHbyxpM07MGEerAk/OWK3AV5Z25vCvY6tQPVFr8H6OvYxWhfzflAzoq93AYdmUpoyBR5Uc4A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711067345; c=relaxed/simple;
	bh=8QFd8esOMW5rZVdTF+FCShS/VOhr21smwFjuIbVf8dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qju+CwBhVR/oZwFte+7bbYPorbH/4/vSdjlQJ1XnmBI8rkFXEsKmyURcyww0SCLkguebIvDqAFKdbExehFeRX0u7JYOJCzDiZA+hyxdYqsS1wb04YmIH/ARwvenOt/Ghcw/biQPHlpz7WnnunEQQFRpeLV687+GND9OwyLicLQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7V8xRvV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE22C433C7;
	Fri, 22 Mar 2024 00:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711067345;
	bh=8QFd8esOMW5rZVdTF+FCShS/VOhr21smwFjuIbVf8dE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g7V8xRvVsvOYIV9nsn7wk/8oQODqnW3bKT4vXuj7EeiHsZ+kj++MuCorDx48ieYUf
	 G7Y1xnz/pzb4pKo+fR0BafpSxjbyaaLlyNdci9vjsKIk14BFYR/PubUXqJb7615yJR
	 47rSc0li+j1pqD456aVwZl7cgQ7RRUetTkqwJXB2b2zOYEr2jC1oEumP71BempwFMr
	 OVeeSHUxL5ABaKsD96mJWYbgfrY5q62x6ib3cK7AE+1MPV0gLb0g603UGhincMPicS
	 0Co3OaYkLDzXL/L138KGDrDKACJhYrZrVdHegpwZTneqPJ3pvPn545jjEG9hYN4pU8
	 jhCzcgD50JxYQ==
Date: Thu, 21 Mar 2024 17:29:03 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Hillf Danton <hdanton@sina.com>
Cc: linux-kernel@vger.kernel.org,
	Light Hsieh =?utf-8?B?KOisneaYjueHiCk=?= <Light.Hsieh@mediatek.com>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs: avoid the deadlock case when stopping discard
 thread
Message-ID: <ZfzQz5hwECOEGYVL@google.com>
References: <20240320001442.497813-1-jaegeuk@kernel.org>
 <20240321224233.2541-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240321224233.2541-1-hdanton@sina.com>

On 03/22, Hillf Danton wrote:
> On Tue, 19 Mar 2024 17:14:42 -0700 Jaegeuk Kim <jaegeuk@kernel.org>
> > f2fs_ioc_shutdown(F2FS_GOING_DOWN_NOSYNC)  issue_discard_thread
> >  - mnt_want_write_file()
> >    - sb_start_write(SB_FREEZE_WRITE)
> 	 __sb_start_write()
> 	   percpu_down_read()
> >                                              - sb_start_intwrite(SB_FREEZE_FS);
> 						   __sb_start_write()
> 						     percpu_down_read()
> 
> Given lock acquirers for read on both sides, wtf deadlock are you fixing?

Damn. I couldn't think _write uses _read sem.

> 
> >  - f2fs_stop_checkpoint(sbi, false,            : waiting
> >     STOP_CP_REASON_SHUTDOWN);
> >  - f2fs_stop_discard_thread(sbi);
> >    - kthread_stop()
> >      : waiting
> > 
> >  - mnt_drop_write_file(filp);
> 
> More important, feel free to add in spin.

I posted this patch before Light reported.

And, in the report, I didn't get this:

f2fs_ioc_shutdown() --> freeze_bdev() --> freeze_super() --> sb_wait_write(sb, SB_FREEZE_FS) --> ... ->percpu_down_write().

because f2fs_ioc_shutdown() calls f2fs_stop_discard_thread() after thaw_bdev()
like this order.

 -> freeze_bdev()
 -> thaw_bdev()
 -> f2fs_stop_discard_thread()

Am I missing something?

> 
> 	Reported-by: "Light Hsieh (謝明燈)" <Light.Hsieh@mediatek.com>

