Return-Path: <linux-kernel+bounces-28307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DB682FCC8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B1D31C280BA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35715F87F;
	Tue, 16 Jan 2024 21:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XSdGJ7Y4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056DE328C9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 21:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705440724; cv=none; b=E9u0ZRqtB7r2rN7tMbUAHNAm8AgSjwkHzz9sz4u2MoaH6r3MD+m1YjS0PHwSwqhXO9VBmyyKgj3zUDtyNdwXuv1U8GAc4scHoes6lE/v9XJeyyEKz+tiZYfocIqYw/F/7Guz7Du41PXZ47N6t6ModBzl+mXd5KHW6zd9/xpnLmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705440724; c=relaxed/simple;
	bh=Km38UH1gQEJmb+o0r2Lh1oKVg5SrOpeW9EYhafnGdxk=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding; b=rqiVzSLm06r9PL0DWSUFEhksU+UsCfzvHvpK9G24nS17lWRBCA3UhMC5YQvF0u8xpDneZYi72Gy48GJbEYce12XLX2C2ZoxUBgu2RnIq3wguJHKONbS6bvTQB5qD/GPeIp8HaLbkYxnvBbgwr5pVyJoAFJcL1YQ1thJOBGFZVlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XSdGJ7Y4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F57C433C7;
	Tue, 16 Jan 2024 21:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1705440723;
	bh=Km38UH1gQEJmb+o0r2Lh1oKVg5SrOpeW9EYhafnGdxk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XSdGJ7Y4JCeYaWbrVEqw+Zg0L4uXOcmX6i8UjcuDseFSWJyMhckQyGQ0d8ZlIgfzq
	 1juNyI0buP50zwaEBagiKtsmQsoqFEFrLI3jytRX7qSs94dLEL2dQSbuME8qo9pvz8
	 iu7kJklDa/fxoDthC2UkMNGcDtPc8qaQlfiaBrOg=
Date: Tue, 16 Jan 2024 13:31:59 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yang Shi <shy828301@gmail.com>
Cc: "Zach O'Keefe" <zokeefe@google.com>, Yin Fengwei
 <fengwei.yin@intel.com>, oliver.sang@intel.com, riel@surriel.com,
 willy@infradead.org, cl@linux.com, ying.huang@intel.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm: mmap: map MAP_STACK to VM_NOHUGEPAGE
Message-Id: <20240116133159.f92cbfebd792d85a498c23fa@linux-foundation.org>
In-Reply-To: <CAHbLzkq12j+KSLegxbepzjAkOz1SE-7w5OuKwxarp_Lh+d0MOQ@mail.gmail.com>
References: <20231221065943.2803551-1-shy828301@gmail.com>
	<20231221065943.2803551-2-shy828301@gmail.com>
	<7433e325-9af7-4b8c-888e-07a0debf8e46@intel.com>
	<CAAa6QmQjE=7qYBWSsMF=J2dir+1q9-zmAEkj7Jqg52cC7hy-xQ@mail.gmail.com>
	<CAHbLzkq12j+KSLegxbepzjAkOz1SE-7w5OuKwxarp_Lh+d0MOQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jan 2024 12:57:41 -0800 Yang Shi <shy828301@gmail.com> wrote:

> > Should this be marked for stable? Given how easily it is for pthreads
> > to allocate hugepages w/o this change, it can easily cause memory
> > bloat on larger systems and/or users with high thread counts. I don't
> > think that will be welcomed, and seems odd that just 6.7 should suffer
> > this.
> 
> Thanks for the suggestion, fine to me.
>

Thanks, added, along with

Fixes: efa7df3e3bb5 ("mm: align larger anonymous mappings on THP boundaries")


