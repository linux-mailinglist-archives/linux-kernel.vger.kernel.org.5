Return-Path: <linux-kernel+bounces-130667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09211897B71
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9157D1F24062
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB73156980;
	Wed,  3 Apr 2024 22:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2iN3KZI1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56A7156973
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 22:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712182200; cv=none; b=Gn1cGELqAsvjVcbvpyO5KqxM9Mp6R1Bod0/tP5KtktFnKTqfrc29dqJR9JZKeuVErjGr8OUCkGtVg/MEpfz9a0ebUb7xuoNbWPDc+NZQrKPIl07OWpFpOU3ATOHEgEg5hnG5hfhfQRDX/vFHYJ64fmcr4kX1tpcI+XGZw6R1rOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712182200; c=relaxed/simple;
	bh=n349FnivoNht5scNSIA8rs9+fyGB9wKkkmj417/isp8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rq/cbTYT5BGfrrRYH7NKNwMhuJypl2v03IIHT3F0iMcGG+KD5fuh4VgX3IK0dHaiVrvVvcDf7o9nJLQkH1TKVRvyd/P3ky4Q55P0yll6I+Z1WD7uoGIB+z45oNa1X1MPJOcUHL81xNsXYUiCvI5QsKPygyPKvjtoG1AMlk1QVmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2iN3KZI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E987C433C7;
	Wed,  3 Apr 2024 22:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712182200;
	bh=n349FnivoNht5scNSIA8rs9+fyGB9wKkkmj417/isp8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2iN3KZI1/aMHLlr07gsZUVlgcw//QaexZXRk6HCjTdXfr+YsvcSlsut+xhlq0G7Wt
	 fTtNOFc2xY+LcvZBMvsyFZ/dv5TK0oTZYwzy1CBg3W+IrBkrg4N3eSfulNXkU4fm0X
	 NrEthCxNte/NR7Yh8Qi7oidV8j+bOTmmQUv3+QC0=
Date: Wed, 3 Apr 2024 15:09:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas
 Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>, Borislav
 Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
 <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Fei Li
 <fei1.li@intel.com>, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2 0/3] x86/mm/pat: fix VM_PAT handling in COW mappings
Message-Id: <20240403150958.713734a1dfbf6cd99d8e7b02@linux-foundation.org>
In-Reply-To: <20240403212131.929421-1-david@redhat.com>
References: <20240403212131.929421-1-david@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Apr 2024 23:21:28 +0200 David Hildenbrand <david@redhat.com> wrote:

> Rebased on latest mm-unstable. As we have a conflict now with a cleanup
> from Chrostoph, temporarily revert that one, so we can apply the fix,
> and reapply the adjusted cleanup on top. I squashed the fixups
> sitting in Andrew's tree for that patch.
> 
> The fix should likely go in first via the hotfix route, that's why I'm
> moving it to the front.

Well that was easy, thanks ;)  Perhaps hch can double-check [3/3] here.

