Return-Path: <linux-kernel+bounces-67776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 306C9857084
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96351F23E6F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28911420DB;
	Thu, 15 Feb 2024 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aBCxM7a4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A0A13DBA4
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 22:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708036037; cv=none; b=mlg9pJJCiMloJc/Xd0661nvNq5kBkSnn2R62MM6lqbxzFywzlrJsMaK4x7gF9QViKV8TlergNqbvFYjkh3/nNoj2gYKqBk9hFctKH48BToFuYq2aLLWPPGTkb7zVtd3gm5FhAn44s3UYfR4a8RF5Yk+pIPLtrsPruMoy+tLF+ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708036037; c=relaxed/simple;
	bh=7Ca+9j+KewaYiUtVmgiA47pdLe1IIt5wtCIV0TdXfpE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=a3KaN8qFPUoTFhIs3br2u4XAMJbbCWAJQmxNnNyIGRyLBJoUtZatYAqgV3CgBWjXBVdUwAfev9o/THYUH69jJxGtH0hZYwkCzbC+kmZAP8IWnS09Pq5FdwQLa9tR0uyplUVdCWFAJKMsxmMYR9LZSPE6sbs55LYpyEO8VdDyV5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aBCxM7a4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459FAC433C7;
	Thu, 15 Feb 2024 22:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708036036;
	bh=7Ca+9j+KewaYiUtVmgiA47pdLe1IIt5wtCIV0TdXfpE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aBCxM7a4rtVxaEOUcFFsYAO/p/D3zFeUe/yHdt6JRYshxv8Znw4FLUfruHwp+de9W
	 1LFymtNt6oWa9a3bW2h2t+qWswJAiONLseikq0b21dBdbFkv7QrmyIAb62Q7rFeRp5
	 XkWddzSPWNQJ8+KIngv0yvMw2JbPBnhRJVb4ZcS0=
Date: Thu, 15 Feb 2024 14:27:15 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
 dvyukov@google.com, vincenzo.frascino@arm.com, kasan-dev@googlegroups.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kasan: Increase the number of bits to shift when
 recording extra timestamps
Message-Id: <20240215142715.9c9e2c5295d90cc9c7cac4dc@linux-foundation.org>
In-Reply-To: <AM6PR03MB58481629F2F28CE007412139994D2@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB58481629F2F28CE007412139994D2@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 18:39:55 +0000 Juntong Deng <juntong.deng@outlook.com> wrote:

> Fix the mistake before,

This is rather imprecise ;)

I shall add to the changelog:

Fixes: 5d4c6ac94694 ("kasan: record and report more information")

> I thought printk only display 99999 seconds
> at max, but actually printk can display larger number of seconds.
> 
> So increase the number of bits to shift when recording the extra
> timestamp (44 bits), without affecting the precision, shift it right by
> 9 bits, discarding all bits that do not affect the microsecond part
> (nanoseconds will not be shown).
> 
> Currently the maximum time that can be displayed is 9007199.254740s,
> because
> 
> 11111111111111111111111111111111111111111111 (44 bits) << 9
> = 11111111111111111111111111111111111111111111000000000
> = 9007199.254740

Another important thing to always changelog is the effect of the
bug/shortcoming upon our users.  So that

a) others can decide whether the issue is serious enough to justify
   backporting the fix into earlier Long Term Stable kernels and 

b) people who maintain other kernel trees (of whom there are many)
   are better able to determine whether this patch is likely to address
   a report which they have received from their customers.

Because 99999 seconds is a very long time, I am assuming that the
effect of this upon our users is basically zero, so I shall not be
adding

Cc: <stable@vger.kernel.org>

to this patch's changelog.



