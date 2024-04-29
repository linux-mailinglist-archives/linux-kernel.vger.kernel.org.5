Return-Path: <linux-kernel+bounces-161961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F29158B53CB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821E62822C0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F5820B2E;
	Mon, 29 Apr 2024 09:08:06 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139921805E;
	Mon, 29 Apr 2024 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381686; cv=none; b=Toxu1oUWCGeXp9vhVjt4ueL0E0d2JLVUjkgq82HvayQWo14KRqVBymokp1gCuP7XhkVx79ia1tEa9pyaV4zUQZkPFGHEYL3YCLnMCFrLbbe8JV0QFMQ4j2ts1MSBnO/yV2MO5t1l0GD2yTZ4i6T70ik0vMVO6JNxBkPIk6B410Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381686; c=relaxed/simple;
	bh=guNjjWLmvSp8lpG7nRF+0ukVE0ALG4fM2lUW1nukGDE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QiHibQJdz+HV9iKGE94XPzd/HNdtk9FvAJt5J/zA9Ch5uaW//ANoM/XWhk+Racg2ap6u/d5Yduis3yXK/IJmC7dCP2gHzp9t3fTw1z0UAQ5S4PcdyoMLKSASCTV7TcJvNsasroeeQJ7/BAGpN/jVODBbtCN+LYExBUY7SQ94qjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.239])
	by gateway (Coremail) with SMTP id _____8Cxg+pvYy9mWdsEAA--.4517S3;
	Mon, 29 Apr 2024 17:07:59 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxXN5rYy9mE+4JAA--.24418S3;
	Mon, 29 Apr 2024 17:07:57 +0800 (CST)
Subject: Re: [v3] LoongArch: KVM: Add PMU support
To: Markus Elfring <Markus.Elfring@web.de>, loongarch@lists.linux.dev,
 kernel-janitors@vger.kernel.org, maobibo@loongson.cn
Cc: LKML <linux-kernel@vger.kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Tianrui Zhao <zhaotianrui@loongson.cn>,
 Wang Xuerui <kernel@xen0n.name>
References: <20240424091813.1471440-1-gaosong@loongson.cn>
 <e68e09e0-75f3-43b8-b947-22cc0d1a0dae@web.de>
 <b8818597-2770-f2a3-03bd-1653cd26fc78@loongson.cn>
 <b50cf967-b5ab-49e9-a270-a4ff4ddc4559@web.de>
From: gaosong <gaosong@loongson.cn>
Message-ID: <0a562fa1-8305-9ad5-cc6f-94b92bc63c7c@loongson.cn>
Date: Mon, 29 Apr 2024 17:07:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b50cf967-b5ab-49e9-a270-a4ff4ddc4559@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:AQAAf8DxXN5rYy9mE+4JAA--.24418S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
	ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E
	87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
	AS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
	07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
	1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
	JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
	1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
	YxBIdaVFxhVjvjDU0xZFpf9x07jYSoJUUUUU=

在 2024/4/29 下午4:20, Markus Elfring 写道:
>>> * How do you think about to avoid the repetition of version identifiers here?
>> I'm new to this, is the following example correct?
> Different enumeration styles were published.
>
>
>> ---
>>
>> v4:
> Would you like to specify version identifiers with “V” consistently?
>
Yes.  I'll.
>> Patch v1: https://lore.kernel.org/all/20240410095812.2943706-1-gaosong@loongson.cn/
> You may specify such links also in each description section directly.
OK,  thank you.

Regards.
Song Gao
> Regards,
> Markus


