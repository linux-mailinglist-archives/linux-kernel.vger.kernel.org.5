Return-Path: <linux-kernel+bounces-39526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8700583D257
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EF4C1F27769
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1615469D;
	Fri, 26 Jan 2024 02:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="tuc+1XPr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F420F7494;
	Fri, 26 Jan 2024 02:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706234673; cv=none; b=F9oV8HOYRWBb9b8S4AYtjCkZPwoVaQnNAXtuvoKRufm0w0EPj/sQQkBSFN6SbOHaOr/8NIDXzWa8GMHx38iDYhwT+M/f2uBUCbGxwM+FCQaWUlOBVihMDVEtPVfnV0FfpVhQvwIwEmHO9OFUbWfq9ongPAZA192F2h2XcC0lrUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706234673; c=relaxed/simple;
	bh=HWEos3+udILzj8RZ/TTxlduuwOKMV4VQFbTq8RZGoPM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TUNzMVTkMhXco5CY88G3U+j+BjwIx8fvemSPMTMifKuDTBZLDYNJU1XYzWCPXq1u20XuY6lo/JLx8UWTQ6iISIPn1m2JwF6AS6X8bifH5q/f4MRjsdXrVVj5BLDbYAe4P9n1+KvQTDQuz0z7DtqOCKKpFy94fXI6DT7rEyhGwEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=tuc+1XPr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74479C433C7;
	Fri, 26 Jan 2024 02:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1706234672;
	bh=HWEos3+udILzj8RZ/TTxlduuwOKMV4VQFbTq8RZGoPM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tuc+1XPr+hUVWa4GOyLQhEugYXMMsybYvWuE0/xs82eeqs83luvv7hWozsTjDEJU2
	 xqH+oihlu/t9Hy0Adp3wCLYFeU2IG8f5LdvEXo7yJ7AqNEu5svDOvx1sFx40QZHZup
	 Q5dVW0OiqBacQI7MjfRyUJZIaPhBJ+rifm367ymU=
Date: Thu, 25 Jan 2024 18:04:24 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: willy@infradead.org, will@kernel.org, catalin.marinas@arm.com,
 palmer@dabbelt.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
 agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King
 <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 1/1] arch/arm/mm: fix major fault accounting when
 retrying under per-VMA lock
Message-Id: <20240125180424.121455beae4d56799a0bac28@linux-foundation.org>
In-Reply-To: <20240123064305.2829244-1-surenb@google.com>
References: <20240123064305.2829244-1-surenb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 22:43:05 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> The change [1] missed ARM architecture when fixing major fault accounting
> for page fault retry under per-VMA lock. Add missing code to fix ARM
> architecture fault accounting.
> 
> [1] 46e714c729c8 ("arch/mm/fault: fix major fault accounting when retrying under per-VMA lock")
> 
> Fixes: 12214eba1992 ("mm: handle read faults under the VMA lock")

What are the userspace-visible runtime effects of this change?

Is a cc:stable backport desirable?

> Reported-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

