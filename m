Return-Path: <linux-kernel+bounces-69669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AF3858D13
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 04:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3275284BB5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 03:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCDC1BDC4;
	Sat, 17 Feb 2024 03:32:13 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150152CA7;
	Sat, 17 Feb 2024 03:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708140733; cv=none; b=I29uvbvbzyjrxFFPycRkfUgng6kyhSHj1YEUCEx9hbs+4K5h+t27ZRPadPHlHJUXblEecCTU66iZANJt7dSXyeOWU7roybDnOD/++PuGAnw7X5dwIgQAVriDhF7d0A7mqN1vV9XiNRWd+5Y6yAZDD4BhEAhdiuKvXtmGTQqbY9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708140733; c=relaxed/simple;
	bh=UtB/ej0jid9HOz3F/jDN5xNw9C2RqBXueFstNFMDHto=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cubaRxI+gg60wIAV9u+yU2TE1yiAsPWvfUoi207+A36TuaKpUawkPQ1ncPDZiZuq8WlL+wuynVTSqzJ+sOThtP7FVI7xDAVxN8XOT82SPlCdGNHP+feTN9xQOLnvXnhgJkrxkX4fixa6YNNqAoajdND2vZsyLdkIM+xxIaeeT78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.173])
	by gateway (Coremail) with SMTP id _____8Ax++i4KNBlsPENAA--.17842S3;
	Sat, 17 Feb 2024 11:32:08 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXs23KNBlPeI4AA--.10369S3;
	Sat, 17 Feb 2024 11:32:07 +0800 (CST)
Subject: Re: [PATCH v5 3/3] irqchip/loongson-eiointc: Refine irq affinity
 setting during resume
To: Thomas Gleixner <tglx@linutronix.de>, Huacai Chen
 <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sergey Shtylyov <s.shtylyov@omp.ru>, lvjianmin@loongson.cn
References: <20240130082722.2912576-1-maobibo@loongson.cn>
 <20240130082722.2912576-4-maobibo@loongson.cn> <87a5o4iti4.ffs@tglx>
From: maobibo <maobibo@loongson.cn>
Message-ID: <00dcf10a-6703-c2fc-f92e-e2cce3c12019@loongson.cn>
Date: Sat, 17 Feb 2024 11:32:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87a5o4iti4.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxXs23KNBlPeI4AA--.10369S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtF1ftF4fGFyrGr13XFWkAFc_yoWDWrc_Wr
	Z2y39rJwnFqF1Uua1vyF4qyFW3Ga95GFyUt3yv9FW29345uF4DZ3yqkryfuw1xWFnrAwsx
	Crs8tr4avasI9osvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbxkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
	vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8yrW7UU
	UUU==

Hi Thomas,

On 2024/2/13 下午5:49, Thomas Gleixner wrote:
> On Tue, Jan 30 2024 at 16:27, Bibo Mao wrote:
>> During suspend and resume, CPUs except CPU0 can be hot-unpluged and IRQs
>> will be migrated to CPU0. So it is not necessary to restore irq affinity
>> for eiointc irq controller when system resumes.
> 
> That's not the reason. The point is that eiointc_router_init() which is
> invoked in the resume path affines all interrupts to CPU0, so the
> restore operation is redundant, no?
yes, it is. eiointc_router_init() will enable the irqs and affine all 
interrupts to CPU0. And it is redundant, the aim of deleted code wants
to resume older interrupt affinity when executing "echo mem > 
/sys/power/state".
> 
>> This patch removes this piece of code about irq affinity restoring in
>> function eiointc_resume().
> 
> Again. 'This patch' is pointless because we already know that this is a
> patch, no?
Thanks for your kindly help, English is somewhat difficult for me :)

Regards
Bibo Mao


