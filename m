Return-Path: <linux-kernel+bounces-85561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2592886B7C2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574F61C22AAA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DABC71ED3;
	Wed, 28 Feb 2024 18:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cLw0kHgZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F00E79B79;
	Wed, 28 Feb 2024 18:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709146461; cv=none; b=THHDO+1ush0JD7QuaE99CDW7LCEMUvo/ZfuO4kBVlYizdheZVzTiE1hFyCA3jhnxbNXVVRbcykesZZGZeQM2wSfm9fQAR+Ot957SpVvxnod+ty6CkrbqMRyWWJgBg93q3Hy32YKH6TvRaf6m09gpjft/giUlFLmETIsH1tarrko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709146461; c=relaxed/simple;
	bh=UUQNFDIoLGj8E8dC+r/j0MRZe+6zHvZowh5kECkoeHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsUF2wblztxqzlEmIyn9pmbbOrMxUINnqtvbg4aJCXbKZmBl5vTlChRGHnQRatdaeDQco2Ve82cn9Y4J9KNN5eQS6itKupWXY6MKDz9irBeREC93HfushxR3PWXg+11QwmoDI3eQPXCvgLdhQK1EWe9LMRs8B8boiJ67/GAopek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cLw0kHgZ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709146460; x=1740682460;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UUQNFDIoLGj8E8dC+r/j0MRZe+6zHvZowh5kECkoeHE=;
  b=cLw0kHgZVt4Zf/Jb9OboIRX44RHxTDiwyN9XblB6ffJT6PoXbDaVVUF6
   0LG98xkhyHJ7TXTjo0Pq+lSi906AV7PUMC3PVzs0XZx2ymFhTNc+2DUDj
   7mYjfay94dfj0qDSynam6f9kP0ro42e2lnDM7KCB3m5QWMvmA2uaz3hLA
   YGMfHaGO5T65CKQE+ctj5tDYXQm9S2f/K7H89Ngo5/xEDkYxaQAKTjeS4
   0TFz8QK/+DRvfJklVgg9/EpLkyOGNw0AzaZntmpr1KA42mtKpXKy1Khcf
   OetPGcemwIq+M1fPT79Y1LfJ1wGqh4QhfYJQFHCoXu7giS19d6WUOIEIg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="26035563"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="26035563"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 10:54:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="7584476"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 10:54:17 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 0815F11F855;
	Wed, 28 Feb 2024 20:54:14 +0200 (EET)
Date: Wed, 28 Feb 2024 18:54:14 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: tomas.winkler@intel.com, mchehab@kernel.org, wentong.wu@intel.com,
	hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: v6.8.0-rc6: mei_ace_probe / mei_vsc_probe: do not call blocking
 ops when !TASK_RUNNING
Message-ID: <Zd-BVmoFOiCxA632@kekkonen.localdomain>
References: <Zd9wUv1zSJ59WS8i@shine.dominikbrodowski.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd9wUv1zSJ59WS8i@shine.dominikbrodowski.net>

Hi Dominik,

On Wed, Feb 28, 2024 at 06:41:38PM +0100, Dominik Brodowski wrote:
> Hi,
> 
> thanks for your work getting the Intel IPU6 camera system - such as found
> within my Dell Inc. XPS 9315 - to work with an upstream kernel. Much
> appreciated!
> 
> On Linux 6.8.0-rc6+ (as of this morning, HEAD is at cf1182944c7c), though,
> I get the following warning during boot with everything built into the
> kernel:
> 
> ------------[ cut here ]------------
> do not call blocking ops when !TASK_RUNNING; state=2 set at [<000000003688dc79>] prepare_to_wait_event+0x54/0x1a0
> WARNING: CPU: 5 PID: 122 at kernel/sched/core.c:10099 __might_sleep+0x59/0x60
> Modules linked in:
> CPU: 5 PID: 122 Comm: kworker/u24:3 Tainted: G                T  6.8.0-rc6+ #2
> Hardware name: Dell Inc. XPS 9315/00KRKP, BIOS 1.1.3 05/11/2022
> Workqueue: events_unbound deferred_probe_work_func
> RIP: 0010:__might_sleep+0x59/0x60

The issue should be fixed by this patch:
<URL:https://git.linuxtv.org/sailus/media_tree.git/commit/?h=ipu6&id=e2dc122949ce2efd05910c0c78617534c3258158>.

I've posted to the LKML, too, so hopefully we have it merged soon.

-- 
Regards,

Sakari Ailus

