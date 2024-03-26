Return-Path: <linux-kernel+bounces-118883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A38A88C099
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6825F1C3A7B2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52314548F7;
	Tue, 26 Mar 2024 11:26:17 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E163D4DA19
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452376; cv=none; b=i+HIYmhmTmCJkkutnPHZRuTjOj4SK/WTYRQ2wO02ZzixZO4YJzF/ZN5U8HNtWxiIwibMqHlnjyytTeI6Ht+VE68kMt69nG/rL8F2qQHTmRTpeFx8HubDT8H5MSes+/DJXSwOYfBQMJ1XNFjbNpeW9JMyznIZU79Vt2I58UOKz5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452376; c=relaxed/simple;
	bh=vHT1E2FQUx2RBKSmNbkSonlOe8xqA4x1fG34fJHk3fw=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mYpbzKeLbtSsVu0+6jTT+9huHRCcW8UWY3s+04nNQfMJfB5fTU5/+73HJIP8GRCokK7189JwISSovTJSTEfGLKiw1NuEyJhdzBc5aHD3J2PwQ0SISRirJvdfvTZ/Ty2N3Jll9lPM0rd7BwuhJOBVj1tsKl///0LCvjdhOr8Nc3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Axz+vTsAJmRloeAA--.5622S3;
	Tue, 26 Mar 2024 19:26:11 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx8OTOsAJmttpoAA--.10708S3;
	Tue, 26 Mar 2024 19:26:06 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Give chance to build under !CONFIG_SMP
To: Thomas Gleixner <tglx@linutronix.de>, Huacai Chen
 <chenhuacai@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Marc Zyngier <maz@kernel.org>
References: <20240326062101.9822-1-yangtiezhu@loongson.cn>
 <87v859e2g7.ffs@tglx>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 loongson-kernel@lists.loongnix.cn
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <45a74a88-83da-95db-2cfb-3cd3a3e6d68f@loongson.cn>
Date: Tue, 26 Mar 2024 19:26:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87v859e2g7.ffs@tglx>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAf8Bx8OTOsAJmttpoAA--.10708S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrWr4fGFWxJw17GrW7tr4xuFX_yoWxWFX_WF
	12kFZrK398ZrZ2ya1UKFsIqFs8tF4Du3ZYqr1UXr1DXFyrCF4kXF43Kryfua10qF95uFnr
	Ka95X392yr1SqosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbqxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0b6pPUUUU
	U==

On 03/26/2024 06:02 PM, Thomas Gleixner wrote:
> On Tue, Mar 26 2024 at 14:21, Tiezhu Yang wrote:
>>
>> This patch is based on 6.9-rc1. Please let me know if it is better to
>> split it into two patches, the first one is for arch/loongarch and the
>> second one is for drivers/irqchip.
>
> Why are you asking? It's documented that patches should be split, no?

OK, thanks for your reply, I read the document [1],
but I am not sure whether it is a single logical change.
I will split it into two patches and send them ASAP.

[1] 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#separate-your-changes

Thanks,
Tiezhu


