Return-Path: <linux-kernel+bounces-96547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A23875DE8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31838B2226E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 06:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E0736129;
	Fri,  8 Mar 2024 06:12:09 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29FC2E821
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 06:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709878329; cv=none; b=aZ3zq5ioKrdwGgtUqyDrbUq4rqGD0Xc1Hd0wTWICkTugvWCuC/PA4dOn5ewK1/k+nqqZo/WSLp7qOI+Paj4qkqmYQTzNpOD47hDZerec90yD7nD6KktrjppwPtrC1tSf+jq7j1qY4V1izr1K3dy9EO9PHXn1W/wiRgHVX7ruJEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709878329; c=relaxed/simple;
	bh=k44BMiSeroU1V/o+VX/N436qBMDRBdEAkXKdBxhugrU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzzmwEN/xk23eSdmc78+eaHjKujVLJY5+WNwCc0Vx0uR/0YA2GkQI37ywqcSlO71Ptu6ThuK2ZXQR4Ex4sxOOcZXQFn7+eh/AtY0OwsOi+qLgHu7+4Ri0TAKiGinSkqAjUEgA/EWmnNMaphST8VRStlJS/y2rSe/vPJ00is64W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TrbNm4FxdzXhln;
	Fri,  8 Mar 2024 14:09:44 +0800 (CST)
Received: from kwepemd100007.china.huawei.com (unknown [7.221.188.221])
	by mail.maildlp.com (Postfix) with ESMTPS id C6E9E1400FD;
	Fri,  8 Mar 2024 14:12:02 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (7.221.188.204) by
 kwepemd100007.china.huawei.com (7.221.188.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 8 Mar 2024 14:12:02 +0800
Received: from M910t (10.110.54.157) by kwepemd100011.china.huawei.com
 (7.221.188.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Fri, 8 Mar
 2024 14:12:01 +0800
Date: Fri, 8 Mar 2024 14:10:54 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Borislav Petkov <bp@alien8.de>
CC: Changbin Du <changbin.du@huawei.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Alexander Potapenko <glider@google.com>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<kasan-dev@googlegroups.com>
Subject: Re: [PATCH] x86: kmsan: fix boot failure due to instrumentation
Message-ID: <20240308061054.54zxik32u4w2bynd@M910t>
References: <20240308044401.1120395-1-changbin.du@huawei.com>
 <20240308054532.GAZeql_HPGb5lAU-jx@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240308054532.GAZeql_HPGb5lAU-jx@fat_crate.local>
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd100011.china.huawei.com (7.221.188.204)

On Fri, Mar 08, 2024 at 06:45:32AM +0100, Borislav Petkov wrote:
> On Fri, Mar 08, 2024 at 12:44:01PM +0800, Changbin Du wrote:
> > Instrumenting sev.c and mem_encrypt_identity.c with KMSAN will result in
> > kernel being unable to boot. Some of the code are invoked too early in
> > boot stage that before kmsan is ready.
> 
> How do you trigger this?
>
I run the kernel in qemu. One of the calltrace is:
(gdb) bt
#0  find_cc_blob (bp=0x14700 <exception_stacks+30464>) at arch/x86/kernel/sev.c:2067
#1  0x0000000003daeaab in snp_init (bp=0x14700 <exception_stacks+30464>) at arch/x86/kernel/sev.c:2098
#2  0x0000000003db3d69 in sme_enable (bp=0x14700 <exception_stacks+30464>) at arch/x86/mm/mem_encrypt_identity.c:516
#3  0x000000000100003e in startup_64 () at arch/x86/kernel/head_64.S:99
#4  0x0000000000000000 in ?? ()

find_cc_blob() has instrumentation enabled and panic when accessing shadow
memory.

> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

-- 
Cheers,
Changbin Du

