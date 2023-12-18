Return-Path: <linux-kernel+bounces-3070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E53D38166ED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61BA1C222CF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EAA79F9;
	Mon, 18 Dec 2023 06:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iyTclJ8/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB62101C9;
	Mon, 18 Dec 2023 06:54:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D47C433C7;
	Mon, 18 Dec 2023 06:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702882462;
	bh=WqSdOGaMwSBPoEtUznslg5s7PXAyzsMtO2SlEkxyWGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iyTclJ8/wMW+zu7NPf5HxB+KPpilY4WTl38/pGkHfTLt355xwMgIZfyU7dIReIUB9
	 dCraaErrmnktGo/N4KrHf0CS0DGxi1/eP5nKRH7eu1y0DlGqJ5zZxRNe0WyMz10aw4
	 v4zHkvihss/8toJXCHaAJxfTfER2aI8wyDGUJs78=
Date: Mon, 18 Dec 2023 07:54:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: bp@alien8.de, rafael@kernel.org, wangkefeng.wang@huawei.com,
	tanxiaofei@huawei.com, mawupeng1@huawei.com, tony.luck@intel.com,
	linmiaohe@huawei.com, naoya.horiguchi@nec.com, james.morse@arm.com,
	will@kernel.org, jarkko@kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, linux-edac@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org, stable@vger.kernel.org,
	x86@kernel.org, justin.he@arm.com, ardb@kernel.org,
	ying.huang@intel.com, ashish.kalra@amd.com,
	baolin.wang@linux.alibaba.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
	robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
	zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v10 4/4] ACPI: APEI: handle synchronous exceptions in
 task work
Message-ID: <2023121813-monthly-matriarch-2df4@gregkh>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20231218064521.37324-5-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218064521.37324-5-xueshuai@linux.alibaba.com>

On Mon, Dec 18, 2023 at 02:45:21PM +0800, Shuai Xue wrote:
> Hardware errors could be signaled by asynchronous interrupt, e.g. when an
> error is detected by a background scrubber, or signaled by synchronous
> exception, e.g. when a CPU tries to access a poisoned cache line. Both
> synchronous and asynchronous error are queued as a memory_failure() work
> and handled by a dedicated kthread in workqueue.
> 
> However, the memory failure recovery sends SIBUS with wrong BUS_MCEERR_AO
> si_code for synchronous errors in early kill mode, even MF_ACTION_REQUIRED
> is set. The main problem is that the memory failure work is handled in
> kthread context but not the user-space process which is accessing the
> corrupt memory location, so it will send SIGBUS with BUS_MCEERR_AO si_code
> to the user-space process instead of BUS_MCEERR_AR in kill_proc().
> 
> To this end, queue memory_failure() as a task_work so that the current
> context in memory_failure() is exactly belongs to the process consuming
> poison data and it will send SIBBUS with proper si_code.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Tested-by: Ma Wupeng <mawupeng1@huawei.com>
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  drivers/acpi/apei/ghes.c | 77 +++++++++++++++++++++++-----------------
>  include/acpi/ghes.h      |  3 --
>  mm/memory-failure.c      | 13 -------
>  3 files changed, 44 insertions(+), 49 deletions(-)
> 


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

