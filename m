Return-Path: <linux-kernel+bounces-132002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A9F898E78
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79F21F27CC0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9F01327ED;
	Thu,  4 Apr 2024 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w7WrLvK8"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5916133425
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712257239; cv=none; b=q+EoJLCc0RiGYqvXaYQTCPBp2nODgVmFIrDsB05p3tOYi4V1RjIfBqBXt4PEymlgm5f8RznlHsfftPzh/ndlGPubIyu3X25ww4zSFQtjQAjKEbo77D4Xalp2Vx+3kt2RXWTy45gRmK2+gHqsSB4K8B6xkFQ0x8FwanqeMtvmJEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712257239; c=relaxed/simple;
	bh=sbbwP4m8hODhTvUlJxQ9gw6z8fPxCf3pdA3GY9BOP58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPrg8UgPtSr1u7UwdAR4mJDDPSS3oE+0EJp/xV2l+l5RJqEGvKJRwkFOcmdCYPgjWlL0j1SKAc5i9zOavoEOFVCeJbKur6G7dovT7IisheJHss3oV4XPjHUGNmvi2UfL7Ua2m9XcI9mpqznBS7uL5rE2AWNr+bfRiW7p23r8auA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w7WrLvK8; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <110c4768-2294-436e-a96a-7063bae85ee7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712257218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sbbwP4m8hODhTvUlJxQ9gw6z8fPxCf3pdA3GY9BOP58=;
	b=w7WrLvK8Y1ywCKqh3erOTr6gfYJoIk760WqMipeqVSAQ1CyewsmG8DR5lDQbwTBS1plgfR
	+XkvQdIbyOEFEruYKN2ex9LrBq+n2iQ51we3hAZ6I2uSvRxyHE6EYpjVVj4xRfXWVcHftQ
	FD0PpekVP4AhkWiKv6vFlFgwpRwt4Gc=
Date: Thu, 4 Apr 2024 12:00:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in trie_delete_elem
Content-Language: en-GB
To: Aleksandr Nogikh <nogikh@google.com>
Cc: Alexander Potapenko <glider@google.com>,
 syzbot <syzbot+603bcd9b0bf1d94dbb9b@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com,
 song@kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000f9ce6d061494e694@google.com>
 <2ee098ec-a46f-44fa-8719-049331c4c206@linux.dev>
 <CANp29Y4WcXr7vd=cvdtxRWaPxOKzr97f9L+BXtm07AGGiW2j2A@mail.gmail.com>
 <02d29315-13ee-45c1-984e-13c98e88247b@linux.dev>
 <CANp29Y7WXm58E=Dv5WFivKuSz-OSCjMQLhBVdPA=ZpNmwcMitg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CANp29Y7WXm58E=Dv5WFivKuSz-OSCjMQLhBVdPA=ZpNmwcMitg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/3/24 1:47 AM, Aleksandr Nogikh wrote:
> On Wed, Apr 3, 2024 at 5:59 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 4/1/24 11:36 PM, Aleksandr Nogikh wrote:
>>> Hi,
>>>
>>> On Mon, Apr 1, 2024 at 8:55 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>> On 3/26/24 12:00 PM, syzbot wrote:
>>>>> Hello,
>>>>>
>>>>> syzbot found the following issue on:
>>>>>
>>>>> =====================================================
>>>>> BUG: KMSAN: uninit-value in trie_delete_elem+0xc0/0xbe0 kernel/bpf/lpm_trie.c:448
>>>> Unrelated to the bug itself, with KMSAN is enabled, qemu cannot boot my vm
>>>> any more. Anything special I need to do in order to boot a KMSAN kernel?
>>>>
>>> Does the kernel print any specific errors to the serial console while
>>> booting? Or nothing at all?
>> In my case, nothing at all.
>>
> If you're using qemu, please try adding "-machine pc-q35-7.1" to its
> arguments. Otherwise it's known to have problems with very large
> kernel images.

I still do not help. My qemu does not support pc-q35-7.1. The most
q35 machine is pc-q35-5.2 and it does not work.


