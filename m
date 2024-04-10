Return-Path: <linux-kernel+bounces-138025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6149B89EB3A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B9FB282D23
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F83335DB;
	Wed, 10 Apr 2024 06:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Asj7+RZD"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688BA524A;
	Wed, 10 Apr 2024 06:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731511; cv=none; b=Fs47zeNsosy9B5CMTGiTwRasRyhKXMeQzqPIj6x1o8dU216vv364UdR7vgiEIYpMj+Pb4DEBcoyQx+nmWlA9om7QmiJDjs4NdogthsKK0Xj9mZmCgBaASrAAJcDYicMHe1H2PsIZ9tetQbsVZaGqk88X/pPDav5mQobpW+/md+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731511; c=relaxed/simple;
	bh=RNjTiw+z2UXgWb291KUYhTrh7oCU2XpYJTpoXJoJ2Ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MGDIno2L0xoeVYQ4Frrw3h5TFsS55vWuyKAEoXkzHN93samR4FTisMCrgLkCRoHzWm3ERZIO4dfvaTK/48m/i9y0fcbKQNTMPRxmCFN0SyJlCsK+5/9eia1OJ3zwJonMgPXHGqqnH5SrkYAWWRcZDNUf4IC7+XYCo/Xk283OphU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Asj7+RZD; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712731506; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ebzbpFm8mKtEwX879U96DPZbzdY2iwe+NayJYElOkPM=;
	b=Asj7+RZD2qJ3sk6kwrOGu/K8WACsgX4zQ/QnqQtLILH+U2iD9p19DDk+0mOnW/oklBThk5AI4z1MOorrcyXMNXUw7GLF6c9SN5gkXoJD0tFDaHt4nfwWIlWqU4joGLO/HjZxwvLcQJLpndBh9KPxU5llzB+d7hRcqatQjbraZF8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W4GtVHI_1712731503;
Received: from 30.178.67.212(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W4GtVHI_1712731503)
          by smtp.aliyun-inc.com;
          Wed, 10 Apr 2024 14:45:04 +0800
Message-ID: <f3c7ef07-8fad-4ef6-9095-16e4bd734477@linux.alibaba.com>
Date: Wed, 10 Apr 2024 14:45:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv12 1/4] genirq: Provide a snapshot mechanism for interrupt
 statistics
To: Thomas Gleixner <tglx@linutronix.de>, dianders@chromium.org,
 liusong@linux.alibaba.com, akpm@linux-foundation.org, pmladek@suse.com,
 kernelfans@gmail.com, deller@gmx.de, npiggin@gmail.com,
 tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
 jan.kiszka@siemens.com
Cc: linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 yaoma@linux.alibaba.com
References: <20240306125208.71803-1-yaoma@linux.alibaba.com>
 <20240306125208.71803-2-yaoma@linux.alibaba.com> <87frvu7t85.ffs@tglx>
Content-Language: en-US
From: Bitao Hu <yaoma@linux.alibaba.com>
In-Reply-To: <87frvu7t85.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024/4/9 17:58, Thomas Gleixner wrote:
> 
> This does not apply anymore.
OK, I will update this patch based on the latest kernel code.
> 
> Also can you please split this apart to convert kstat_irqs to a struct
> with just the count in it and then add the snapshot mechanics on top.
> 
OK, I will split this patch into two. The changelog for the first patch
will be as follows.

genirq: Convert kstat_irqs to a struct

The irq_desc::kstat_irqs member is a per-CPU variable of type int, and
it is only capable of counting. The snapshot mechanism for interrupt
statistics will be added soon, which requires an additional variable to
store snapshot. To facilitate expansion, convert kstat_irqs here to
a struct containing only the count.

By the way, what do you think of my reason for using printk() instead of
pr_crit()? Should I change this part of the code in v13?

Besides, are there any other issues with this set of patches? I hope we
can resolve all points of contention in v13.

Best Regards,

	Bitao Hu

