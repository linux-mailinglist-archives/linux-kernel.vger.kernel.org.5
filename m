Return-Path: <linux-kernel+bounces-133762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE83E89A849
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 03:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B31BF1C21320
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 01:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F60B10A1A;
	Sat,  6 Apr 2024 01:55:31 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ACD3C00
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 01:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712368530; cv=none; b=NbDlSsNaKbxtReDHq4kXO91Vm9gMpz2f4DPx/tJAABl/Hv5S4MlyV3K+smQJ5Uerm/cPZpGauZDmZJ/UjZGEnj/W2xFqIhEackYSDt57NlfxvVtBjzvfXdZCwOoO11trJhpToiUA1su3nlMPUdorU78/cCfQNItlQepr21DnK7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712368530; c=relaxed/simple;
	bh=3lED+Tk8WNreBamuxb1qNlWZIC4Gb0rZ43/heOVZI8Y=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pT9TPMcYH9vqriCtEctP7P5YufutgrHGOCanS8JhVOk1XNTBf49zpLNX20jxOVFo0WViEYHRmwCNXS9XFJgV6xVP+tCrVi3tsFF73jJnlFvypCauPTFsH9+zMUb2iAO4ZkxLjWE8M8wUisRNhQV6uzNh7FCTinMBoeNMMsOTgfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VBJJp0xbgztRgJ;
	Sat,  6 Apr 2024 09:52:42 +0800 (CST)
Received: from kwepemd500014.china.huawei.com (unknown [7.221.188.63])
	by mail.maildlp.com (Postfix) with ESMTPS id DCB561402CE;
	Sat,  6 Apr 2024 09:55:19 +0800 (CST)
Received: from [10.67.146.137] (10.67.146.137) by
 kwepemd500014.china.huawei.com (7.221.188.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 6 Apr 2024 09:55:19 +0800
Subject: Re: [RESPIN PATCH] irqchip/gic-v3-its:Fix GICv4.1 needless VSYNC
 after unmap VPE
To: Marc Zyngier <maz@kernel.org>
CC: <tglx@linutronix.de>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <guoyang2@huawei.com>,
	<wangwudi@hisilicon.com>
References: <20240403083556.3862236-1-tangnianyao@huawei.com>
 <86cyr6u58r.wl-maz@kernel.org>
From: Tangnianyao <tangnianyao@huawei.com>
Message-ID: <f0c0f2c4-ec95-e719-057f-5bafc53414f4@huawei.com>
Date: Sat, 6 Apr 2024 09:55:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <86cyr6u58r.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd500014.china.huawei.com (7.221.188.63)



On 4/3/2024 18:09, Marc Zyngier wrote:
> Thanks for respinning this.
>
> A few remarks:
>
> The subject line could be improved. Something like:
>
> "irqchip/gic-v4: Don't issue a VSYNC after VMAPP with V=0"
>
> On Wed, 03 Apr 2024 09:35:56 +0100,
> t00849498 <tangnianyao@huawei.com> wrote:
>> From: Nianyao Tang <tangnianyao@huawei.com>
>>
>> Quote from GIC spec 5.3.19, a VMAPP with {V, Alloc}=={0, x}
>> is self-synchronizing, This means the ITS command queue does not
>> show the command as consumed until all of its effects are completed.
> Since this is a direct quote, make it clear that it is so.
>
>> We don't need VSYNC to guarantee unmap finish. And VSYNC after unmap VPE
>> will reach an invalid vpe table entry, which may trigger exception
>> like SError or RAS. Let's fix it.
> This should be much stronger. It's not that we don't need VSYNC. It is
> that VSYNC is actively wrong. I suggest that you rewrite the commit
> message along these lines:
>
> <msg>
> As per the GICv4.1 spec (Arm IHI 0069H, 5.3.19):
>
> "A VMAPP with {V, Alloc}=={0, x} is self-synchronizing. This means the
>  ITS command queue does not show the command as consumed until all of
>  its effects are completed."
>
> Furthermore, VSYNC is allowed to deliver an SError when referencing a
> non existent VPE.
>
> By these definitions, a VMAPP followed by a VSYNC is a bug, as the
> later references a VPE that has been unmapped by the former.
>
> Fix it by eliding the VSYNC in this scenario.
> </msg>

Thanks for the above comments, I will resend later.
>
>> Signed-off-by: Nianyao Tang <tangnianyao@huawei.com>
> Please also add:
>
> Fixes: 64edfaa9a234 ("irqchip/gic-v4.1: Implement the v4.1 flavour of VMAPP")
>
> With the above fixed:
>
> Reviewed-by: Marc Zyngier <maz@kernel.org>
>
> Thanks,
>
> 	M.
>


