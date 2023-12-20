Return-Path: <linux-kernel+bounces-7366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C3981A696
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17E5CB24BFF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E1A481BC;
	Wed, 20 Dec 2023 17:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="sP5UEEYa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0138481A0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 17:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED69C433C7;
	Wed, 20 Dec 2023 17:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703094824;
	bh=e8oEkJKfdldneCNIZ5sBcHKLKmVjreR/mRRznuu6iSA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sP5UEEYaq/A5kWYdBz/UGiN0vKghTrvtaQt26anQNDthrOeXYfwb6cPp3jMERMZWG
	 e0YEIUaYd3nHH2g91iiZlF5m0bvd5cmPG0nVkhvIPQM9mpGYlz0UWMjxcfm3EU+fwz
	 qWTtxYA9cbdJc9vmbCjLNfShj5EzZYJFrdKeD/zo=
Date: Wed, 20 Dec 2023 09:53:43 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "jiajun.xie" <jiajun.xie.sh@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm: fix unmap_mapping_range high bits shift bug
Message-Id: <20231220095343.326584f605e8ce995ac151d0@linux-foundation.org>
In-Reply-To: <20231220052839.26970-1-jiajun.xie.sh@gmail.com>
References: <20231220052839.26970-1-jiajun.xie.sh@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Dec 2023 13:28:39 +0800 "jiajun.xie" <jiajun.xie.sh@gmail.com> wrote:

> From: Jiajun Xie <jiajun.xie.sh@gmail.com>
> 
> The bug happens when highest bit of holebegin is 1, suppose
> holebign is 0x8000000111111000, after shift, hba would be
> 0xfff8000000111111, then vma_interval_tree_foreach would look
> it up fail or leads to the wrong result.
> 
> error call seq e.g.:
> - mmap(..., offset=0x8000000111111000)
>   |- syscall(mmap, ... unsigned long, off):
>      |- ksys_mmap_pgoff( ... , off >> PAGE_SHIFT);
> 
>   here pgoff is correctly shifted to 0x8000000111111,
>   but pass 0x8000000111111000 as holebegin to unmap
>   would then cause terrible result, as shown below:
> 
> - unmap_mapping_range(..., loff_t const holebegin)
>   |- pgoff_t hba = holebegin >> PAGE_SHIFT;
>           /* hba = 0xfff8000000111111 unexpectedly */
> 
> turn holebegin to be unsigned first would fix the bug.
> 

Thanks.  Are you able to describe the runtime effects of this
(obviously bad, but it's good to spell it out) and under what
circumstances it occurs?

