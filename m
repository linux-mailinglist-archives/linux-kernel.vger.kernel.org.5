Return-Path: <linux-kernel+bounces-3067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DE48166DF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 984781C20981
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4779A79C1;
	Mon, 18 Dec 2023 06:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hJFscnMJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAAB101D9;
	Mon, 18 Dec 2023 06:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DC5C433C7;
	Mon, 18 Dec 2023 06:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702882435;
	bh=VNz5SxVR3JFdRousanTI1EoLW8p9ziakyuKcU0mnkO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hJFscnMJtLb9LdeI/+jAZWsRpGP3S8VQ+fTilSt/YMbslTwa0XacvAD8hTCG755gc
	 rfFUp3MdnS2CXxwp6h6T/d2xGnluoDtbsXlgJE3rYaGAEe+YOpLX44c2NkI/MqiSgh
	 Hj4ELbTjrFD6LwZIpeVEFbUkk9S6E60XfzGBU1pE=
Date: Mon, 18 Dec 2023 07:53:53 +0100
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
Subject: Re: [PATCH v10 1/4] ACPI: APEI: set memory failure flags as
 MF_ACTION_REQUIRED on synchronous events
Message-ID: <2023121847-resistant-fleshy-0c4b@gregkh>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20231218064521.37324-2-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218064521.37324-2-xueshuai@linux.alibaba.com>

On Mon, Dec 18, 2023 at 02:45:18PM +0800, Shuai Xue wrote:
> There are two major types of uncorrected recoverable (UCR) errors :
> 
> - Synchronous error: The error is detected and raised at the point of the
>   consumption in the execution flow, e.g. when a CPU tries to access
>   a poisoned cache line. The CPU will take a synchronous error exception
>   such as Synchronous External Abort (SEA) on Arm64 and Machine Check
>   Exception (MCE) on X86. OS requires to take action (for example, offline
>   failure page/kill failure thread) to recover this uncorrectable error.
> 
> - Asynchronous error: The error is detected out of processor execution
>   context, e.g. when an error is detected by a background scrubber. Some data
>   in the memory are corrupted. But the data have not been consumed. OS is
>   optional to take action to recover this uncorrectable error.
> 
> When APEI firmware first is enabled, a platform may describe one error
> source for the handling of synchronous errors (e.g. MCE or SEA notification
> ), or for handling asynchronous errors (e.g. SCI or External Interrupt
> notification). In other words, we can distinguish synchronous errors by
> APEI notification. For synchronous errors, kernel will kill the current
> process which accessing the poisoned page by sending SIGBUS with
> BUS_MCEERR_AR. In addition, for asynchronous errors, kernel will notify the
> process who owns the poisoned page by sending SIGBUS with BUS_MCEERR_AO in
> early kill mode. However, the GHES driver always sets mf_flags to 0 so that
> all synchronous errors are handled as asynchronous errors in memory failure.
> 
> To this end, set memory failure flags as MF_ACTION_REQUIRED on synchronous
> events.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Tested-by: Ma Wupeng <mawupeng1@huawei.com>
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> ---
>  drivers/acpi/apei/ghes.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

