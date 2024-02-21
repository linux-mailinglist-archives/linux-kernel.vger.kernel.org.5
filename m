Return-Path: <linux-kernel+bounces-73893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B823F85CD37
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7257C281043
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543EE1FDD;
	Wed, 21 Feb 2024 01:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/5NAwCm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9850D17D5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708477474; cv=none; b=YelhoLrAQehORNaDuPZ1X9TP1JwAVkEYGT84jYTZhn0e89otN6dwknK5PEL3uGFI7Ev43+mX9p50cn83TGQ/Zdi8Lw/Pu1qhYMSEZExO09T87ZbW0P4dNlfuP5AMRv7AHhV1KsBJP5TGQdSUx80wRjfPHqW2FENa95aDut7Po2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708477474; c=relaxed/simple;
	bh=lY1BvwYdkdPQgChfmKA+k2lduIGy+T+Lsl5kVFPtli8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQJDltkuQND9fAscgSe1Orn44+LMIgSqgWwrmo1JuOObfmbebL4bzzONE84Stj5NlO246+XXOErx9GDU49QZERaxeeXf3JgOIyFIisbtLO2EQxEJ31l3rmrgRmj3ftyopGIDYnkTybPgPJCcovv+RAYrrFfg8SfdVKCzKDVEHvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/5NAwCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F45C433F1;
	Wed, 21 Feb 2024 01:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708477474;
	bh=lY1BvwYdkdPQgChfmKA+k2lduIGy+T+Lsl5kVFPtli8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T/5NAwCmZfaacxe9uGeGXDlgNRfGgHaGKYDpOIkYlAdhMz9Hd4baHZ2NIGTLWpD8S
	 0xSPWBi9xNK2xExQ+aVoGv22dO7ael31gcQZCVQX5i6eIdVdnZADIqRe34sJNQVi5b
	 PJdobMLdBlX/7ta6+L8URQdNBU+FSMkl0VfXxtrneA56bVWc+o2O23RlmjFUxn1kQK
	 KGGVUYU42pyAIjHg4TAJFaFXdLnNQ/SYsAx6Kp6AEymrO8Udx171yNkSxh0PQoIohx
	 FR2ZLXXR8NE4E/ryO8H6mPwdiVnZ1/vPYE9t2Qt50OO9PhsXsg1osjMP/l5P3xE9Ta
	 BfsiV7v3gwZMg==
Message-ID: <73c8c2b1-b5c1-4cdc-b8c3-f64d7dfdb125@kernel.org>
Date: Wed, 21 Feb 2024 09:04:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH 2/3 v2] f2fs: use BLKS_PER_SEG, BLKS_PER_SEC,
 and SEGS_PER_SEC
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20240207005105.3744811-1-jaegeuk@kernel.org>
 <20240207005105.3744811-2-jaegeuk@kernel.org> <ZcpfF9UJz8bNW6ge@google.com>
 <bded9fde-9541-465d-86f8-292249226cc9@kernel.org>
 <ZdUMgrzpVHob6KvQ@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZdUMgrzpVHob6KvQ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/21 4:33, Jaegeuk Kim wrote:
>> @@ -4723,7 +4723,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>>   			.reason = CP_DISCARD,
>>   			.trim_start = 0,
>>   			.trim_end = MAIN_SEGS(sbi) - 1,
>> -			.trim_minlen = sbi->blocks_per_seg,
>> +			.trim_minlen = BLKS_PER_SEG(sbi),
> 
> We don't have this.

Oh, it's due to my branch is not clean... I should rebase this diff to
last dev-test, sorry.

Thanks,

> 
>>   		};
>>   		f2fs_write_checkpoint(sbi, &cpc);
>>   	}
>> -- 
>> 2.40.1

