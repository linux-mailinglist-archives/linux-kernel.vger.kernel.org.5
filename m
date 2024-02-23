Return-Path: <linux-kernel+bounces-78283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B400861159
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12875B22B55
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABE978667;
	Fri, 23 Feb 2024 12:17:09 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360AC5C90C;
	Fri, 23 Feb 2024 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708690629; cv=none; b=haFEuefbmTpOXt8PAKVPc8QPQk1CqOxsUQQ0zvRCuf1XY+lucvRH0S9XfXtxlIAO/nastBFzPwEFUfItlQk68zOaSKFT4bmVeJgOW+962ckwLrLJKXDyQT5K0EID866kbAl/z64ciBQq2Co/n9ZivLt1dxyShS8w5eynuQwiAas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708690629; c=relaxed/simple;
	bh=qDrweQQqf8nzNthDbW29boU/th8Tx7nKWJxKyp/ks0w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gfxIxTNfU69dKBvuG1MWJXrFVnl6rKlIqwVWqS/eQ9eDTVVjtY17R+DColcg0MwyFUSDsw4mUHBdwQ4MZItNI87DlNqXpngw4U248SaqJEg0ZID2sXqRx5iW/mZYMR2AoGv0ImR8n3AoDRAsYXZAxShlone84yOe8X+zDxbxTX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Th86H5SCgz6K64V;
	Fri, 23 Feb 2024 20:12:55 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B5251140B54;
	Fri, 23 Feb 2024 20:17:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 23 Feb
 2024 12:17:03 +0000
Date: Fri, 23 Feb 2024 12:17:01 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Shuai Xue <xueshuai@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
	Ira Weiny <ira.weiny@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
	"james.morse@arm.com" <james.morse@arm.com>, <rafael@kernel.org>,
	<wangkefeng.wang@huawei.com>, <tanxiaofei@huawei.com>,
	<mawupeng1@huawei.com>, <linmiaohe@huawei.com>, <naoya.horiguchi@nec.com>,
	<gregkh@linuxfoundation.org>, <will@kernel.org>, <jarkko@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
	<linux-edac@vger.kernel.org>, <x86@kernel.org>, <justin.he@arm.com>,
	<ardb@kernel.org>, <ying.huang@intel.com>, <ashish.kalra@amd.com>,
	<baolin.wang@linux.alibaba.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<dave.hansen@linux.intel.com>, <lenb@kernel.org>, <hpa@zytor.com>,
	<robert.moore@intel.com>, <lvying6@huawei.com>, <xiexiuqi@huawei.com>,
	<zhuo.song@linux.alibaba.com>
Subject: Re: [PATCH v11 1/3] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
Message-ID: <20240223121701.00004bcf@Huawei.com>
In-Reply-To: <20240223120813.00005d1f@Huawei.com>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
	<20240204080144.7977-2-xueshuai@linux.alibaba.com>
	<20240219092528.GTZdMeiDWIDz613VeT@fat_crate.local>
	<bdf15819-46e0-498f-97e1-a0183f257086@linux.alibaba.com>
	<65d82c9352e78_24f3f294d5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<20240223120813.00005d1f@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 23 Feb 2024 12:08:13 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Thu, 22 Feb 2024 21:26:43 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Shuai Xue wrote:  
> > > 
> > > 
> > > On 2024/2/19 17:25, Borislav Petkov wrote:    
> > > > On Sun, Feb 04, 2024 at 04:01:42PM +0800, Shuai Xue wrote:    
> > > >> Synchronous error was detected as a result of user-space process accessing
> > > >> a 2-bit uncorrected error. The CPU will take a synchronous error exception
> > > >> such as Synchronous External Abort (SEA) on Arm64. The kernel will queue a
> > > >> memory_failure() work which poisons the related page, unmaps the page, and
> > > >> then sends a SIGBUS to the process, so that a system wide panic can be
> > > >> avoided.
> > > >>
> > > >> However, no memory_failure() work will be queued when abnormal synchronous
> > > >> errors occur. These errors can include situations such as invalid PA,
> > > >> unexpected severity, no memory failure config support, invalid GUID
> > > >> section, etc. In such case, the user-space process will trigger SEA again.
> > > >> This loop can potentially exceed the platform firmware threshold or even
> > > >> trigger a kernel hard lockup, leading to a system reboot.
> > > >>
> > > >> Fix it by performing a force kill if no memory_failure() work is queued
> > > >> for synchronous errors.
> > > >>
> > > >> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> > > >> ---
> > > >>  drivers/acpi/apei/ghes.c | 9 +++++++++
> > > >>  1 file changed, 9 insertions(+)
> > > >>
> > > >> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > > >> index 7b7c605166e0..0892550732d4 100644
> > > >> --- a/drivers/acpi/apei/ghes.c
> > > >> +++ b/drivers/acpi/apei/ghes.c
> > > >> @@ -806,6 +806,15 @@ static bool ghes_do_proc(struct ghes *ghes,
> > > >>  		}
> > > >>  	}
> > > >>  
> > > >> +	/*
> > > >> +	 * If no memory failure work is queued for abnormal synchronous
> > > >> +	 * errors, do a force kill.
> > > >> +	 */
> > > >> +	if (sync && !queued) {
> > > >> +		pr_err("Sending SIGBUS to current task due to memory error not recovered");
> > > >> +		force_sig(SIGBUS);
> > > >> +	}    
> > > > 
> > > > Except that there are a bunch of CXL GUIDs being handled there too and
> > > > this will sigbus those processes now automatically.    
> > > 
> > > Before the CXL GUIDs added, @Tony confirmed that the HEST notifications are always
> > > asynchronous on x86 platform, so only Synchronous External Abort (SEA) on ARM is
> > > delivered as a synchronous notification.
> > > 
> > > Will the CXL component trigger synchronous events for which we need to terminate the
> > > current process by sending sigbus to process?    
> > 
> > None of the CXL component errors should be handled as synchronous
> > events. They are either asynchronous protocol errors, or effectively
> > equivalent to CPER_SEC_PLATFORM_MEM notifications.  
> 
> Not a good example, CPER_SEC_PLATFORM_MEM is sometimes signaled via SEA.
> 

Premature send.:(

One example I can point at is how we do signaling of memory
errors detected by the host into a VM on arm64.
https://elixir.bootlin.com/qemu/latest/source/hw/acpi/ghes.c#L391
CPER_SEC_PLATFORM_MEM via ARM Synchronous External Abort (SEA).

Right now we've only used async in QEMU for proposed CXL error
CPER records signalling but your reference to them being similar
to CPER_SEC_PLATFORM_MEM is valid so 'maybe' they will be
synchronous in some physical systems as it's one viable way to
provide rich information for synchronous reception of poison.
For the VM case my assumption today is we don't care about providing the
VM with rich data, so CPER_SEC_PLATFORM_MEM is fine as a path for
errors whether from CXL CPER records or not.

Jonathan


