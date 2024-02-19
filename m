Return-Path: <linux-kernel+bounces-71044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116BE859FD4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F72281C3E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FF92556C;
	Mon, 19 Feb 2024 09:38:50 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629CA25556
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708335530; cv=none; b=uUHgy7CgQW6wRMjyC975WIDA9oU3GPKm5oMnNDkQ/4LRppzvlv/cO4/Lm4JRDzHk372CzlRFmecJWWOO1YQyI+HSFnjWXxWj7YJg7INNyZ70VcKTffNL44jFQGgH1vBWZ9N4TrE2iRGUVKMSyskUC37Bzqf3NexQbARRvauln/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708335530; c=relaxed/simple;
	bh=beV3HkcCobjEE+8GR3pJ/U2oTxy49Di4rABAON7noqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lj1LdBukcZpCcJBCF8kQhByfFKhrvizPJGa99acgaoYnMpHRolI5IJq1Swb60iLCLCj9T2zjmvmrvA6Tbbdgf9Zpb86rgfSCarz1JHaz+AC7V15FPyliw/NtOJeqgzTUJkJ5n/0PRa6KCNxbbPyeFuWN4Igy+b7wmLQey15c07k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Tdcr055lpzXhDH;
	Mon, 19 Feb 2024 17:36:48 +0800 (CST)
Received: from dggpeml500004.china.huawei.com (unknown [7.185.36.140])
	by mail.maildlp.com (Postfix) with ESMTPS id 13CFF18007A;
	Mon, 19 Feb 2024 17:38:40 +0800 (CST)
Received: from [10.174.186.25] (10.174.186.25) by
 dggpeml500004.china.huawei.com (7.185.36.140) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 17:38:39 +0800
Message-ID: <a3a41828-e65d-bc7f-ca75-7d3e9477042c@huawei.com>
Date: Mon, 19 Feb 2024 17:38:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] KVM: arm64: Add capability for unconditional WFx
 passthrough
Content-Language: en-US
To: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>
CC: James Morse <james.morse@arm.com>, Suzuki K Poulose
	<suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, <linux-arm-kernel@lists.infradead.org>,
	<kvmarm@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Colton Lewis
	<coltonlewis@google.com>, <wanghaibin.wang@huawei.com>
References: <20240129213918.3124494-1-coltonlewis@google.com>
 <Zbgx8hZgWCmtzMjH@linux.dev>
From: "sundongxu (A)" <sundongxu3@huawei.com>
In-Reply-To: <Zbgx8hZgWCmtzMjH@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500004.china.huawei.com (7.185.36.140)

Hi Marc, Oliver,

On 2024/1/30 7:17, Oliver Upton wrote:
> Hi Colton,
> 
> On Mon, Jan 29, 2024 at 09:39:17PM +0000, Colton Lewis wrote:
>> Add KVM_CAP_ARM_WFX_PASSTHROUGH capability to always allow WFE/WFI
>> instructions to run without trapping. Current behavior is to only
>> allow this if the vcpu is the only task running. This commit keeps the
>> old behavior when the capability is not set.
>>
>> This allows userspace to set deterministic behavior and increase
>> efficiency for platforms with direct interrupt injection support.
> 
> Marc and I actually had an offlist conversation (shame on us!) about
> this very topic since there are users asking for the _opposite_ of this
> patch (unconditionally trap) [*].
> 
> I had originally wanted something like this, but Marc made the very good
> point that (1) the behavior of WFx traps is in no way user-visible and
> (2) it is entirely an IMP DEF behavior. The architecture only requires
> the traps be effective if the instruction does not complete in finite
> time.
> 
> We need to think of an interface that doesn't depend on
> implementation-specific behavior, such as a control based on runqueue
> depth.

If I understand correctly, this run queue belongs to the scheduler, right?
And I will be appreciated if you can share any more detail information
about this.

> 
> [*] https://lore.kernel.org/kvmarm/a481ef04-ddd2-dfc1-41b1-d2ec45c6a3b5@huawei.com/
> 

Thanks,
Dongxu

