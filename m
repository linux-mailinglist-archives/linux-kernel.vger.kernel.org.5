Return-Path: <linux-kernel+bounces-37588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2B083B232
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BF02B24698
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9428133986;
	Wed, 24 Jan 2024 19:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ysFy5u7T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="THHs3+e6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB9F77F36
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 19:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123901; cv=none; b=ioa1LWxtIEg8F7Menz7BFsukvLm0Bgg49JG0X5X66W2uyy+rTwvK9MdpKSKcc0rnMA2J3GbKCa6WmOl0gCazClilyB2KHEH5PNTg9Wx6TqLo6x0eC+hDM55NQXZfMrvkBg0G3+Nz8rWFUzjHOer1C57aNyjIA6CjWlLgv09Nbrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123901; c=relaxed/simple;
	bh=4a+nv2mWAOtSGN4sAs4/ycgnsea+1L00DLE/DdoTuuI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cW6SczhpgLi9VaDXSKVb9/vCDJxDAtKx6P0sRCBbGaZgsFiCY49r8isgln1f2t/6fxjCJbfEB0VpSBqAIdY6GdEFnU5vkOpxUgusX2CeroXpxtSF4IRpNXPen7kKs5Znu2vgxVUY7sKwmngYbq2635Ulm1nP7Hr2z32PyuGhnXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ysFy5u7T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=THHs3+e6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706123898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=17TaQXd/pfSOXylZ6VwFblUVWrjVURLj7FVz9h++l84=;
	b=ysFy5u7TPqR4adMpSUISWuuHPu/3l79WTC/c8mdH46jMGd9QiGqKNHelHV5lfn0sJ8E+Tb
	vRzdMyrRGM1iuMm8IyV/BkzW5moPCm29C8CchYJAsmlOXYkAm7+6UkxpeKvZKIAGLSkSeP
	z4y2D0YyeQrHya9cV7k9zrYUe76zCk5gJFLmRPVRlYdXqugJqgrIQTiW51PtNZ7EC8rLQ6
	eat8ojKS2E0ZeDOLXfccUtFuTFnG43N8dvZENvp/xd00RbS5zxZJhuyEdr9QwRGuihG4AE
	wsHEwt4Txma26/To8DowzaF+GRIrc8G7EceqHu6O8ipuaOCkmafW6tuLKtfnNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706123898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=17TaQXd/pfSOXylZ6VwFblUVWrjVURLj7FVz9h++l84=;
	b=THHs3+e6PatxgLvKWvrBrUH1e8OzCIqql0oZ7+zMVdNcalObuEtp7vHnKVUmOpm/1CijPD
	eqWj6tedauH0H3Dg==
To: Yu Liao <liaoyu15@huawei.com>, linux-kernel@vger.kernel.org
Cc: liwei391@huawei.com, wangxiongfeng2@huawei.com, frederic@kernel.org,
 mingo@kernel.org
Subject: Re: [PATCH] tick/broadcast-hrtimer: Prevent the timer device on
 broadcast duty CPU from being disabled
In-Reply-To: <20231218025844.55675-1-liaoyu15@huawei.com>
References: <20231218025844.55675-1-liaoyu15@huawei.com>
Date: Wed, 24 Jan 2024 20:18:16 +0100
Message-ID: <87y1cek0av.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Dec 18 2023 at 10:58, Yu Liao wrote:
>  static int bc_set_next(ktime_t expires, struct clock_event_device *bc)
>  {
> +	ktime_t next_event = this_cpu_ptr(&tick_cpu_device)->evtdev->next_event;
> +
>  	/*
> -	 * This is called either from enter/exit idle code or from the
> -	 * broadcast handler. In all cases tick_broadcast_lock is held.
> -	 *
> +	 * This can be called from CPU offline operation to move broadcast
> +	 * assignment. If tick_broadcast_force_mask is set, the CPU local
> +	 * timer device may be disabled. And hrtimer_reprogram() will not
> +	 * called if the timer is not the first expiring timer. Reprogram
> +	 * the cpu local timer device to ensure we can take over the
> +	 * broadcast duty.
> +	 */
> +	if (tick_check_broadcast_expired() && expires >= next_event)
> +		tick_program_event(next_event, 1);

I'm not really enthused about another conditional here and that
condition is more than obscure.

The problem is that the local clockevent might be shut down, right?

So checking for that state is the right thing to do and the proper place
is in hotplug_cpu__broadcast_tick_pull(), no?

Thanks,

        tglx







