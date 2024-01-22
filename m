Return-Path: <linux-kernel+bounces-34216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A0C8375B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD07A1C26256
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE500482EF;
	Mon, 22 Jan 2024 21:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a2ck8Ek1"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5F5482DA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 21:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705960758; cv=none; b=A9J+LK5Rt1180iLbLi2cjEnO0Ux5d2wFesV9PWnUb3dKeEj6TO1uU3jgytrXWDcIeOAF59AvxQjFQjRSK/MrHk2a/SaYR+i56lTEbUjSqAFDDQMu43haaM3Wsgs3PjNiM15GTyj+4DLocjDdmNsM0qHyYgvIx4P2t3OtNPulfEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705960758; c=relaxed/simple;
	bh=ECFKPL3PnElBsExFBI86TFUGond9GFIE0/soQcR69uQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bUZNlHOktMYJzbdCGBM+Vd5KHsYZNuBKjlvwz8rOJJ9PcBb0bNMEbUKErEeEo/6LDrjeQXlkzhVty6jcaJz+LQNtznV/4lIa30Yfr7SF8tUgzJxgIDoTVhf4WZIXFPlmA4qG47uRUzTFFkqRAdDft5/xNiHz+2qL/GSzZE2L9Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a2ck8Ek1; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705960756; x=1737496756;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ECFKPL3PnElBsExFBI86TFUGond9GFIE0/soQcR69uQ=;
  b=a2ck8Ek1KPwO+aRHok8w5+xum+5t5iPzyUl+qLclnXzm1KYuCMM6Gy5k
   hjW9tx0Yvl7yyExNcEXVbUH8Jj5TX/FvzXktIv9q1jsiECxDYNZlm0TI5
   pSeIANX9ZMeq4TJw3bZ5HvGcZdd48C8zxxxkoxBWDVCcXNnZT+GB7HHgP
   9iyVbUhveaI9XFC2kTUF0H5Ln34JzQ2GokXIFqPcqvKZWeQl4LNCKZj//
   /PYizuS+9aJoDRFIMOCxo1LqIXY+vMN25+2sj+KUTUqUAgN4Su4HuMhqX
   8JWwu1xJgfqtHJtCXLsxhRaLtSGwF6c2kRn6jzbPFg6W0te+qkpGBo+7C
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="400994288"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="400994288"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 13:59:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="27500674"
Received: from ishandes-mobl1.amr.corp.intel.com (HELO [10.209.49.194]) ([10.209.49.194])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 13:59:15 -0800
Message-ID: <b4f5ac150685456cf45a342e3bb1f28cdd557a53.camel@linux.intel.com>
Subject: Re: [PATCH] sched/fair: Skip newidle_balance() when an idle CPU is
 woken up to process an IPI
From: Tim Chen <tim.c.chen@linux.intel.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>, linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com,  gautham.shenoy@amd.com
Date: Mon, 22 Jan 2024 13:59:14 -0800
In-Reply-To: <20240119084548.2788-1-kprateek.nayak@amd.com>
References: <20240119084548.2788-1-kprateek.nayak@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-01-19 at 14:15 +0530, K Prateek Nayak wrote:
>=20
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b803030c3a03..1fedc7e29c98 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8499,6 +8499,16 @@ done: __maybe_unused;
>  	if (!rf)
>  		return NULL;
> =20
> +	/*
> +	 * An idle CPU in TIF_POLLING mode might end up here after processing
> +	 * an IPI when the sender sets the TIF_NEED_RESCHED bit and avoids
> +	 * sending an actual IPI. In such cases, where an idle CPU was woken
> +	 * up only to process an interrupt, without necessarily queuing a task
> +	 * on it, skip newidle_balance() to facilitate faster idle re-entry.
> +	 */
> +	if (prev =3D=3D rq->idle)
> +		return NULL;
> +

Should we check the call function queue directly to detect that there is
an IPI waiting to be processed? something like

	if (!llist_empty(&per_cpu(call_single_queue, rq->cpu)))
		return NULL;

Could there be cases where we want to do idle balance in this code path?
Say a cpu is idle and a scheduling tick came in, we may try
to look for something to run on the idle cpu.  Seems like after
your change above, that would be skipped.=20

Tim


>  	new_tasks =3D newidle_balance(rq, rf);
> =20
>  	/*


