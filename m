Return-Path: <linux-kernel+bounces-3068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A89C8166E3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D40281E21
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3787496;
	Mon, 18 Dec 2023 06:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IzjAMFF0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3787C8C6;
	Mon, 18 Dec 2023 06:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE19C433C7;
	Mon, 18 Dec 2023 06:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702882445;
	bh=8Kl+lj+tSnogG6JvAU6RoT4pxakzbvX1ijwD+7zp3I8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IzjAMFF0vQGHpA1qzgdXpaupuutj/CMlFSu+srLaE4/MSS90lmByqlQxFcnKQ2YZI
	 UTZ9b/kgzi+IyyUadHjzR6BhguXzBlJ0Abcasx/BmfRYLxd5M+ZSkgxFAqN13uQ2zD
	 uJ+xuIOKS3IGeVwgR1yS1ZaVtzFMDWdMdHgai6UQ=
Date: Mon, 18 Dec 2023 07:54:03 +0100
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
Subject: Re: [PATCH v10 2/4] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
Message-ID: <2023121855-crimson-hamper-57ef@gregkh>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20231218064521.37324-3-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218064521.37324-3-xueshuai@linux.alibaba.com>

On Mon, Dec 18, 2023 at 02:45:19PM +0800, Shuai Xue wrote:
> Synchronous error was detected as a result of user-space process accessing
> a 2-bit uncorrected error. The CPU will take a synchronous error exception
> such as Synchronous External Abort (SEA) on Arm64. The kernel will queue a
> memory_failure() work which poisons the related page, unmaps the page, and
> then sends a SIGBUS to the process, so that a system wide panic can be
> avoided.
> 
> However, no memory_failure() work will be queued when abnormal synchronous
> errors occur. These errors can include situations such as invalid PA,
> unexpected severity, no memory failure config support, invalid GUID
> section, etc. In such case, the user-space process will trigger SEA again.
> This loop can potentially exceed the platform firmware threshold or even
> trigger a kernel hard lockup, leading to a system reboot.
> 
> Fix it by performing a force kill if no memory_failure() work is queued for synchronous errors.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  drivers/acpi/apei/ghes.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

