Return-Path: <linux-kernel+bounces-75291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C776485E5E9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AB9A285C79
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A2A1272B6;
	Wed, 21 Feb 2024 18:25:07 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA4185280
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539907; cv=none; b=eSuxfIOoJ0ddz10MmBQ4vc3XQhhpKDCGF1KG2MmANVj9zRVRv/S7B9/8wpA7PJMDgNzjgyU1bziEsQkrFM/LEZqLU0tLNz9JXBV2gavCkKH0uwJWxR6IRpmWIYZeY/28x83pUQxekZfCUb0oG+U4bGk6GhxgeqQnMoic1s+aqQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539907; c=relaxed/simple;
	bh=cLn8dL69+Lvu/fIfZczLNpufcusO+7qo0OtM9ehE7Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uFXVEExg5hOTjOjVEBUSKhnSksQDtR7AUl41npOgZtdOS2cSfkHwj1HiCwYm15k6LJ8FL8ILzjjzQYPtjzVKAC0XAHd3RhTn4RBBreYqrPLSducupIj2jDXcf8tqapcaYwSP92iZtwjowXBCzfBkKymYs9xv5uS/YrcNOP65YLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AA4C433C7;
	Wed, 21 Feb 2024 18:25:03 +0000 (UTC)
Date: Wed, 21 Feb 2024 13:26:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, peterz@infradead.org,
 torvalds@linux-foundation.org, paulmck@kernel.org,
 akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
 mgorman@suse.de, jpoimboe@kernel.org, mark.rutland@arm.com,
 jgross@suse.com, andrew.cooper3@citrix.com, bristot@kernel.org,
 mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
 glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
 mattst88@gmail.com, krypton@ulrich-teichert.org, David.Laight@ACULAB.COM,
 richard@nod.at, mjguzik@gmail.com, jon.grimm@amd.com, bharata@amd.com,
 raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 02/30] thread_info: selector for TIF_NEED_RESCHED[_LAZY]
Message-ID: <20240221132651.5d1b0a24@gandalf.local.home>
In-Reply-To: <20240213055554.1802415-3-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
	<20240213055554.1802415-3-ankur.a.arora@oracle.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 21:55:26 -0800
Ankur Arora <ankur.a.arora@oracle.com> wrote:

> +/*
> + * tif_resched(r) maps to TIF_NEED_RESCHED[_LAZY] with CONFIG_PREEMPT_AUTO.
> + *
> + * With !CONFIG_PREEMPT_AUTO, both tif_resched(NR_now) and tif_resched(NR_lazy)
> + * reduce to the same value (TIF_NEED_RESCHED) leaving any scheduling behaviour
> + * unchanged.
> + */
> +static inline int tif_resched(resched_t rs)
> +{
> +	return TIF_NEED_RESCHED + rs * TIF_NEED_RESCHED_LAZY_OFFSET;
> +}
> +
> +static inline int _tif_resched(resched_t rs)
> +{
> +	return 1 << tif_resched(rs);
> +}
> +

This may have been mentioned in another thread (don't remember) but please
make the above __always_inline, as that also matches tif_need_resched() as
it is today.

-- Steve

