Return-Path: <linux-kernel+bounces-9110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5382181C0B7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D0D1F22F4F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB3177F29;
	Thu, 21 Dec 2023 22:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cw8Y20B2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC3E77F15
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 22:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AF6C433CB;
	Thu, 21 Dec 2023 22:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703196181;
	bh=8FGnjhDRKc63x6ERnHGCSptOkrbsqPFpkkKFJyg21vQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cw8Y20B2iIadYSq+h5u2ueHu6JqUTjdciIgVa4yrnUfWDfZjoDo89/Tsuom2/ncZy
	 H89QvIwHir1WNrmKBE1ixTnVNvptOSaNk0vZcOx0IBbS9iwG6BuZWvXt8Goj+h8vWD
	 iJLrfWKHYPJiyfrzmHMcA45OYhJ64/NT4fBEqFbk=
Date: Thu, 21 Dec 2023 14:03:00 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, Baoquan He
 <bhe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Simon
 Horman <horms@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] x86/kexec: fix incorrect end address passed to
 kernel_ident_mapping_init()
Message-Id: <20231221140300.4fcfd4945eeb3b6c145a969c@linux-foundation.org>
In-Reply-To: <20231221101702.20956-1-ytcoode@gmail.com>
References: <20231221101702.20956-1-ytcoode@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 18:17:02 +0800 Yuntao Wang <ytcoode@gmail.com> wrote:

> kernel_ident_mapping_init() takes an exclusive memory range [pstart, pend)
> where pend is not included in the range, while res represents an inclusive
> memory range [start, end] where end is considered part of the range.
> 
> Therefore, passing res->end directly to kernel_ident_mapping_init() is
> incorrect, the correct end address should be `res->end + 1`.
> 
> ...
>
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -44,7 +44,7 @@ static int mem_region_callback(struct resource *res, void *arg)
>  	struct init_pgtable_data *data = arg;
>  
>  	return kernel_ident_mapping_init(data->info, data->level4p,
> -					 res->start, res->end);
> +					 res->start, res->end + 1);
>  }

Thanks.  When fixing a bug, please always full describe the
userspace-visible effects of that bug.

In this case I'm assuming "none", due to kernel_ident_mapping_init()'s
upward rounding of the address?

