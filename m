Return-Path: <linux-kernel+bounces-76492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E071985F7DB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16DDD1C228F3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17B66088D;
	Thu, 22 Feb 2024 12:16:09 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EBD5FB91;
	Thu, 22 Feb 2024 12:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708604169; cv=none; b=ZpcSmYhdyfZah99LfQsh7pLuhNQL0Dc5K4fFdFCha+PXYu4hd3vdjKFoYC4iWuzQ6bHnVLh5/RhMZmPgoszcZi16Cw9dcz1hhGaLAq6vM52wR3mMpBmOglwGopFJXSNJC09SijQmbqMlwogdbDxYR57E5Ui5qWTpVyPFs048wbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708604169; c=relaxed/simple;
	bh=EzBOrHhIZy8QxnhzaZPVIu+UmwRn1mRi9keUxv87bxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H4FgCx3qa5bjiQz+lCEBY5yHGlCcjceNrZU5c5H89WHHwZz4eJGkYlqw/FX9sJHNA1IWnOcoa0vBswa45ENi5dJFzibidG98CySFDd1s6pYiSq16kPbhP7/1/JJqM1HgXMvdi+EqldCMNlUFN/P40W0sHtkkTqfsriDW+Pl3okU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893ECC433F1;
	Thu, 22 Feb 2024 12:16:07 +0000 (UTC)
Message-ID: <01046eb8-a351-4599-96dc-847896fc0785@xs4all.nl>
Date: Thu, 22 Feb 2024 13:16:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media/cec/core: fix task hung in cec_claim_log_addrs
Content-Language: en-US, nl
To: Hillf Danton <hdanton@sina.com>
Cc: Edward Adam Davis <eadavis@qq.com>,
 syzbot+116b65a23bc791ae49a6@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 mchehab@kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000006d96200611de3986@google.com>
 <tencent_941B48254CBA00BB4933069E391B6E4B5408@qq.com>
 <20240222104320.236-1-hdanton@sina.com>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20240222104320.236-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/02/2024 11:43, Hillf Danton wrote:
> On Wed, 21 Feb 2024 15:38:47 +0100 Hans Verkuil <hverkuil-cisco@xs4all.nl>
>> On 21/02/2024 15:20, Edward Adam Davis wrote:
>>> After unlocking adap->lock in cec_claim_log_addrs(), cec_claim_log_addrs() may
>>> re-enter, causing this issue to occur.
>>
>> But if it is called again, then it should hit this at the start of the function:
>>
>>         if (WARN_ON(adap->is_configuring || adap->is_configured))
>>                 return;
>>
>> I'm still not sure what causes the KASAN hung task since I cannot seem to reproduce
>> it, and because it is hard for me to find enough time to dig into this.
> 
> Likely because of the window for initializing completion more than once [1].
> 
> [1] https://lore.kernel.org/lkml/00000000000054a54e0611f1bc01@google.com/

I have been able to reproduce this by adding msleeps in several places.

When I have some more time I will start digging into this.

Regards,

	Hans

