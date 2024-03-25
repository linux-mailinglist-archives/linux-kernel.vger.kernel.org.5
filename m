Return-Path: <linux-kernel+bounces-116388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A18889646
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78681C30059
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A957131E54;
	Mon, 25 Mar 2024 05:31:31 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB2F13A876;
	Mon, 25 Mar 2024 01:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711331690; cv=none; b=RvsZZ8E7mAyk7FKX1S1x0t7h7Zoy6vt5UciTJJctc/WESmayMRUd9Zr/RjTqMOShYlGB2Z0Ip/E64gwQrGTY8y29vvtSPJeA4TsjpX9vNrfJDwA3Ch0XnyOfXkqvB2aoIRfIdcQsNE46spIQMJnZjnCnGOaCkAfIwSgNgckniLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711331690; c=relaxed/simple;
	bh=XiiSClFiZHKRTyOnVAxVECc0GJmJXRzHs1zn5XKzvWU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HGoGdtJBGLoCBNxYGz/QgCz+DFAWKv0oWDD/GKp1wdulnQ+vTnmbu0VBtCqDTl/zyXGbdtfcP72LpgqZiaiSvocPSmRjIWu4m/bLzKaJGBWyqZv7NxnNxtbsdKuHzNkISKp5MVhJU9YJHCnzjLFUTnpaoD6rg6tZjNn5JD5yUFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.24])
	by gateway (Coremail) with SMTP id _____8Cxmehe2QBm4YEdAA--.49942S3;
	Mon, 25 Mar 2024 09:54:38 +0800 (CST)
Received: from [10.20.42.24] (unknown [10.20.42.24])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXs1c2QBmRWZmAA--.599S3;
	Mon, 25 Mar 2024 09:54:36 +0800 (CST)
Subject: Re: [PATCH V3] irqchip/loongson-pch-pic: Update interrupt
 registration policy
To: Thomas Gleixner <tglx@linutronix.de>, chenhuacai@kernel.org,
 jiaxun.yang@flygoat.com
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 Baoqi Zhang <zhangbaoqi@loongson.cn>, Biao Dong <dongbiao@loongson.cn>
References: <20240319124629.23925-1-zhangtianyang@loongson.cn>
 <878r2di3ak.ffs@tglx> <648e7f23-a2e0-ce8f-7c52-3bcda262de86@loongson.cn>
 <8734sghfya.ffs@tglx>
From: Tianyang Zhang <zhangtianyang@loongson.cn>
Message-ID: <7418ece8-111a-cb29-0320-e8bc08e2d7f8@loongson.cn>
Date: Mon, 25 Mar 2024 09:54:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8734sghfya.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:AQAAf8BxXs1c2QBmRWZmAA--.599S3
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7GrWDZF4xAw1rGr13Cw1kXrc_yoW8JF1Up3
	ykKa17Grn7GryfKw10qrs7tFWSvr93A3WrJ3s5Gw1DC3y5WFyFqF42qF4Y9as5XrZYy3Wj
	qa1Y9ry5u34DZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UU
	UUU==

Hi, Thomas

在 2024/3/24 上午4:05, Thomas Gleixner 写道:
> Tianyang!
>
> On Fri, Mar 22 2024 at 18:14, Tianyang Zhang wrote:
>
> Please do not top-post. See the 'Top-posting' chapter in:
> https://people.kernel.org/tglx/notes-about-netiquette
Sorry, I will carefully read the document
>> Regarding "WHY", my understanding is that a convincing reason is needed
>> to explain the necessity of this patch.
> Yes.
>
>> If so, can the last paragraph "This will be more conducive to fully
>> utilizing existing vectors to support more devices."
>>
>> be considered a simple explanation?
> Kinda, but ideally you describe it in a way that there is context for
> the reader. Like this:
>
>    The fixed mapping between the LS7A interrupt source and the HT
>    interrupt vector prevents the utilization of the full interrupt vector
>    space which limits the number of devices in a system
>
>    Replace the fixed mapping with a dynamic mapping which allocates a
>    vector when an interrupt source is set up. This avoids that unused
>    sources prevent vectors from being used for other devices.
>
> See?
Thank you for your demonstration. I will make the modifications 
according to the requirements
>
> Thanks,
>
>          tglx


Thanks again

             Tianyang


