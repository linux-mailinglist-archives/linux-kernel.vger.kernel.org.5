Return-Path: <linux-kernel+bounces-142408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 194968A2B2B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C1D0B27B77
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46E8502B1;
	Fri, 12 Apr 2024 09:27:39 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49F050299
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712914059; cv=none; b=Qy71YW4lGdmJQuIJN6RPUN/RzoC8xMB57u4iaePa0a+tzrvWlSz8nieIHZ0EJ4o9pZs07HLDLEb7epv7Yz2sB7xmKC3+HiB24XcEp5GM1wtZhhPuoIjCs7OJTRuK9nSULK3sKZLJXEMlfZkH5C0YGMOWLw4p9nshP8WOXWFK4T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712914059; c=relaxed/simple;
	bh=g/FtSzbMh7UWRlixc9gUFZ3pvuBaLRdoeR0cPDnORLU=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=bzGLvz+DI9q/54+3doE5pbPP+SI/gDX1VWa9A2q6Yk2vkos9hUrHNIqBCYwbdFD7e6b7zwlR6twaljcRJZDIFvs8rl8DryXiuh2sd5132ZLF3QR6M0hGHctOC/WtdjblTNk2aNk2L3sTvC5qSm2mEGPUpcIHYacEu13ngjOu0m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxSbqG_hhmGlMmAA--.6523S3;
	Fri, 12 Apr 2024 17:27:34 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxTROD_hhmvKJ4AA--.35435S3;
	Fri, 12 Apr 2024 17:27:32 +0800 (CST)
Subject: Re: [PATCH v3 1/4] LoongArch: Move CONFIG_HAVE_SETUP_PER_CPU_AREA
 related code to smp.c
To: Huacai Chen <chenhuacai@kernel.org>
References: <20240411010510.22135-1-yangtiezhu@loongson.cn>
 <20240411010510.22135-2-yangtiezhu@loongson.cn>
 <CAAhV-H6TVEEB=xdr_ymuUnDqPDXwtM7R7yJBj03YhWpCwqjAiA@mail.gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 Marc Zyngier <maz@kernel.org>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <dcf6e475-8219-6b1e-a99b-2cdf1e86289c@loongson.cn>
Date: Fri, 12 Apr 2024 17:27:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H6TVEEB=xdr_ymuUnDqPDXwtM7R7yJBj03YhWpCwqjAiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxTROD_hhmvKJ4AA--.35435S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKF1kGrWxKryfKF4kKw1xZwc_yoW3KFbE9F
	s5Wr1DCw18Xw4v9an7X34FvrZxJFyvgws8t3s2vry2yFy5t34rJr4kAFn3uw1FqF4rGr90
	kayvqF9xCry09osvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbqxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Dl1DUUUU
	U==



On 04/12/2024 12:12 PM, Huacai Chen wrote:
> On Thu, Apr 11, 2024 at 9:05 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> Currently, if CONFIG_NUMA is not set but CONFIG_SMP is set, the arch
>> specified setup_per_cpu_areas() in arch/loongarch/kernel/numa.c will
>> not be built and the generic setup_per_cpu_areas() in mm/percpu.c is
>> actually used, this is not reasonable and does not work as intended.
> Why is the generic version not reasonable? We need a custom version
> just because it can put the percpu variable in the best node. If NUMA
> disabled, software can only see one node, how to optimize?

The initial aim is to use the arch specific setup_per_cpu_areas()
in any case under CONFIG_SMP, this patch can be dropped if it is
meaningless for the case of !CONFIG_NUMA and CONFIG_SMP.

Thanks,
Tiezhu


