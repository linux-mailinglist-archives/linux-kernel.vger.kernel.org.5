Return-Path: <linux-kernel+bounces-129086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4E3896492
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C2F282E83
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727B417BC2;
	Wed,  3 Apr 2024 06:33:16 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D4917555;
	Wed,  3 Apr 2024 06:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712125996; cv=none; b=GmzOk0cUu13aKSs4K792YdahVfcv1jWKp7wBaiXlULa27QADi84lwQV25TdSec483RjRUY+EJBEwYAm1kvp8Z+o72GBCjp1+oMLR1ARBPpxLF2joQiBbXS54/oHBS3Xo44vqQaKcLG2Nb5yfnSLK1iFWOQTKqEfWHscZu7gKF4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712125996; c=relaxed/simple;
	bh=Oegz8fvYBzWUGK86dPOUrHnnarkFjfGNwr9ygzyfZSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O2fF7jVa0wEy+txfq5fJD+q6T8LAFtK+6IgkLmIsyCPlRtVuiAmDq8CiCddUvAV9fYYfOEwDCFSGVzanWg84FugEPKC1E9U11Fdo8ag6818BIvCaiNjZgfzVkujzSeWSreFhNeZs+olg9mlyzWYupK2AHdxasFJFnR99AkBsH0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4V8Zcr38CZz1QCCD;
	Wed,  3 Apr 2024 14:30:36 +0800 (CST)
Received: from kwepemi500024.china.huawei.com (unknown [7.221.188.100])
	by mail.maildlp.com (Postfix) with ESMTPS id 5EC081402C7;
	Wed,  3 Apr 2024 14:33:10 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 14:33:09 +0800
Message-ID: <95f416eb-a0ea-acba-6427-2a38d431ba8d@huawei.com>
Date: Wed, 3 Apr 2024 14:32:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [tip: x86/boot] x86/boot: Ignore NMIs during very early boot
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
CC: <linux-tip-commits@vger.kernel.org>, Jun'ichi Nomura
	<junichi.nomura@nec.com>, Derek Barbosa <debarbos@redhat.com>, Ingo Molnar
	<mingo@kernel.org>, Kees Cook <keescook@chromium.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@kernel.org>,
	Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Peter
 Zijlstra <peterz@infradead.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, "liwei (GF)" <liwei391@huawei.com>
References: <170133478498.398.5261666675868615202.tip-bot2@tip-bot2>
 <20231130103339.GCZWhlA196uRklTMNF@fat_crate.local>
From: Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <20231130103339.GCZWhlA196uRklTMNF@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500024.china.huawei.com (7.221.188.100)

Hi Borislav Petkov,


My main job is to develop driver software based on arm64 features. 
Sometimes I also

help to analyze and solve problems found by other departments on x86 
servers, and

contribute repair patches to the community.


I sent you the almost same patch before

(https://lore.kernel.org/all/20230110102745.2514694-1-zengheng4@huawei.com/), 


but you kept struggling with my grammar rather than the code logic itself,

and even questioned my motives for sending the patch.

(https://lore.kernel.org/all/Y7174pEWZ8IzCdQ9@zn.tnic/)


Until just now, I saw your completely different responses to the same 
patch.

I'm not pointing this out to change anything, but in the hope that other 
people or

my colleagues would avoid encountering similar things.


Regards,

Zeng Heng


