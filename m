Return-Path: <linux-kernel+bounces-87303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B8486D276
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C4D1C20DCE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEBD134426;
	Thu, 29 Feb 2024 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gZvtYW5R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD51160629
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 18:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709232014; cv=none; b=fEfJZqxNiCYrRsh3rv1E2WABWLbLTqxO4Dy1mMZXe8J6cidSs639kasIvFht7Dfrh6SJb6SB2f2fZJ/B94tpYmKVyoA4RTZq6UBOOJsYdHxUZHMqhwDa2LEaceevF0gM67mPaFsHRQ7XE8dQQgH6m+2m80OIiZsTBpyNn2j8Fxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709232014; c=relaxed/simple;
	bh=G39x9X/r8wD8EZNMCjKX99fVjL/JmQl3/uLDdbycsUw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=M6MU1VtFdaxkLy27QLDrp5fB4/d1ysZIcQKxdI7auLJeHhLi1ZMwmKDwXKWtvc0d09KSIhb9LGviPfSUaoszalXSB2X2a9gJFrz0kpSQKa1DafRfE19A/II4hDhZJQPjqqoURgWM5TiRQ76neyJCEnuo4yobC17HIn3HHdOAA8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gZvtYW5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B82C433F1;
	Thu, 29 Feb 2024 18:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1709232014;
	bh=G39x9X/r8wD8EZNMCjKX99fVjL/JmQl3/uLDdbycsUw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gZvtYW5RjwYGvMOcS1OD4p/NBFNkCvv+69I/19wQJojZcno1nDd8S9x6ufT9/b74c
	 hrtO5sy9ttg1Enx/clLC3kgJM+v4EpMSxjvvkSPcfJxrZTOqz8FNt52Fus1uBgV5hG
	 wdx/0gzpkwkSj4llp4f4J9CYk6lUE4gu9noxwvvA=
Date: Thu, 29 Feb 2024 10:40:13 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Hao Ge <gehao@kylinos.cn>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, gehao618@163.com
Subject: Re: [PATCH v2] mm/vmstat: Add order's information for extfrag_index
 and unusable_index
Message-Id: <20240229104013.5ed8c1ca9c2dbd0bd5fb571f@linux-foundation.org>
In-Reply-To: <20240229141443.99408-1-gehao@kylinos.cn>
References: <20240229141443.99408-1-gehao@kylinos.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Feb 2024 22:14:43 +0800 Hao Ge <gehao@kylinos.cn> wrote:

> Current cat /sys/kernel/debug/extfrag/extfrag_index and
> /sys/kernel/debug/extfrag/unusable_index is not friendly to userspace.
> 
> We should add order's information so that users can clearly understand
> the situation of each order at a glance like pagetypeinfo.
> 
> before:
> cat /sys/kernel/debug/extfrag/extfrag_index:
> Node 0, zone    DMA32  ...... ...... ...... ......
> Node 0, zone   Normal  ...... ...... ...... ......
> 
> cat /sys/kernel/debug/extfrag/unusable_index:
> Node 0, zone    DMA32 ..... ..... ..... .....
> Node 0, zone   Normal ..... ..... ..... .....
> 
> after:
> cat /sys/kernel/debug/extfrag/extfrag_index:
> Extfrag index at order:       0      1      2      3
> Node 0, zone        DMA  ...... ...... ...... ......
> Node 0, zone     Normal  ...... ...... ...... ......
> 
> cat /sys/kernel/debug/extfrag/unusable_index:
> Unusable index at order:     0     1     2     3
> Node 0, zone         DMA ..... ..... ..... .....
> Node 0, zone      Normal ..... ..... ..... .....
> 

This may break existing parsers of this file.

And that would be allowed if these files were under debugfs.  But
they're under sysfs/debug, where the rules are less clear.

Still, it's unclear to me that the benefit is worth this risk.  What do
others think?

