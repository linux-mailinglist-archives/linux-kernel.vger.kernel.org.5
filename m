Return-Path: <linux-kernel+bounces-52408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DC48497B9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6AF02863BA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15952171A9;
	Mon,  5 Feb 2024 10:25:38 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C19517541;
	Mon,  5 Feb 2024 10:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128737; cv=none; b=avfUQh/tCegEMwDGrDNXA3bxYPqB6occti/u5DxBCGGTvmQX2jXTDjzvdIMkMhaqXfNMNKSeJ7YrMtaEl016Ygd2Cf1trW46rXIFigO8ZDqjV3bJ3VgNdttARRTO5F6KD8mZlKEK4Bh6nhGbkTxgMRGBNao7RhoRTL3ZNvwGnLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128737; c=relaxed/simple;
	bh=eRrFp2JexEbtNp6FWh3iMXTIaeLisx2WjsRpctM6ZEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNjI5uJy0K45mAt5lhlXYYpLYkuRaL4AEnSPb0YF3I+caM8fGo21kmCovB/1gmWIN0rKsht1E1vl4NEWK9KLAhFSr/90kTl6tlek5FQgp2Nyulf5ZfgDd+2B2wYJqHfFaOnIdKxAtahgANX0pCYj6wnKUcyXwApBrd8yAFyNMZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B45CC433C7;
	Mon,  5 Feb 2024 10:25:34 +0000 (UTC)
Date: Mon, 5 Feb 2024 05:25:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: kernel test robot <lkp@intel.com>, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 oe-kbuild-all@lists.linux.dev, mathieu.desnoyers@efficios.com,
 kernel-team@android.com
Subject: Re: [PATCH v13 3/6] tracing: Add snapshot refcount
Message-ID: <20240205052532.37c65148@rorschach.local.home>
In-Reply-To: <ZbjQTZ4SIkG703QM@google.com>
References: <20240129142802.2145305-4-vdonnefort@google.com>
	<202401301740.qzZlpcYV-lkp@intel.com>
	<ZbjQTZ4SIkG703QM@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 10:32:45 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> > All errors (new ones prefixed by >>):
> > 
> >    kernel/trace/trace.c: In function 'tracing_set_tracer':
> >    kernel/trace/trace.c:6644:17: error: implicit declaration of function 'tracing_disarm_snapshot_locked'; did you mean 'tracing_disarm_snapshot'? [-Werror=implicit-function-declaration]
> >     6644 |                 tracing_disarm_snapshot_locked(tr);
> >          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >          |                 tracing_disarm_snapshot  
> > >> kernel/trace/trace.c:6648:23: error: implicit declaration of function 'tracing_arm_snapshot_locked'; did you mean 'tracing_arm_snapshot'? [-Werror=implicit-function-declaration]  
> >     6648 |                 ret = tracing_arm_snapshot_locked(tr);
> >          |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >          |                       tracing_arm_snapshot
> >    cc1: some warnings being treated as errors  
> 
> Right, two tracers (hwlat and osnoise) select _only_ MAX_TRACE and not
> TRACER_SNAPSHOT.
> 
> However, AFAICT, they will not call any of the swapping functions (they don't
> set use_max_tr). So I suppose arm/disarm can be ommited in that case.

Yeah, if you can test with the various configs enabled and disabled to
make sure that it still builds properly, then that should be good.

I should make sure that my own ktest config that I use to run tests
checks these variations too.

-- Steve

