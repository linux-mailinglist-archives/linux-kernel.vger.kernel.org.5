Return-Path: <linux-kernel+bounces-49566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8E7846BE4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E97932914A1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457DE78695;
	Fri,  2 Feb 2024 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HYUcO5Mp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0A277F3A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865775; cv=none; b=amxqFc+K9NMsB1nznm66XjhkUUq4h1A7r2+rsGzka450yH8HjhCFA145dpPEk/hel7/9/NVWHx3bxqXgr1LjQrYjlgVYzln0LBhaSe0l8qOB1V1+J7ARHcnRZ3KnoF2PlxzTu/nhcNq9e2g2hIm4c7cCIBwh4iEgXkswoiSrxdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865775; c=relaxed/simple;
	bh=TdWS27s4EMNXFrh+FGof0R8zvZMI3ZS+Gn1BrxmQcWw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=p63MuscgZyycvTm2xSpzuJBeGzLnGKSOrxHXhnF4Ig5PSOrBXrPpI+oYwxuD9p+xmA5Ws7CJRR/97tqykvUDIZdY8IuY7tjwqb++QnqlDvaaM4xZiDTY+XCJmyrEJWxGpgZUZRIHkzNPEr9I6VLUbQGxSA39VgPsZp8/39HZNYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HYUcO5Mp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E617BC433C7;
	Fri,  2 Feb 2024 09:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1706865775;
	bh=TdWS27s4EMNXFrh+FGof0R8zvZMI3ZS+Gn1BrxmQcWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HYUcO5MpMzN6wi5pD+JUCPWDtxPsRImIKOIoK99ULMG0OiEBghKnlWUB82bTpGfVJ
	 Ql/+23VSVy0jOuAbM4o6v+q/9iPetGbCaDt1xF4MXjqNP1Kq8ndaGEnsrHdJDoK2mx
	 /nLuyjHKyYDoD+XLFnBFUc0YyG9LlkeuCpZhv3rA=
Date: Fri, 2 Feb 2024 01:22:51 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Zhiguo Jiang <justinjiang@vivo.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
Subject: Re: [PATCH v2] mm:vmscan: shrink skip folio mapped by an exiting
 task
Message-Id: <20240202012251.1aa5afbfdf2f8b3a862bced3@linux-foundation.org>
In-Reply-To: <20240131131244.1144-1-justinjiang@vivo.com>
References: <20240131131244.1144-1-justinjiang@vivo.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 21:12:44 +0800 Zhiguo Jiang <justinjiang@vivo.com> wrote:

> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -840,6 +840,13 @@ static bool folio_referenced_one(struct folio *folio,
>  	int referenced = 0;
>  	unsigned long start = address, ptes = 0;
>  
> +	/* Skip this folio if it's mapped by an exiting task */
> +	if (unlikely(!atomic_read(&vma->vm_mm->mm_users)) ||
> +		unlikely(test_bit(MMF_OOM_SKIP, &vma->vm_mm->flags))) {
> +		pra->referenced = -1;
> +		return false;
> +	}

The code comment explains what the code does.  This is, as usual,
pretty obvious from reading the code!

A better comment is one which explains *why* the code is doing what it
does.

