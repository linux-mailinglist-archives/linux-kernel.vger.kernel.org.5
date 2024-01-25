Return-Path: <linux-kernel+bounces-38248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A3883BD10
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877DE1C23C64
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBE31BC3F;
	Thu, 25 Jan 2024 09:19:25 +0000 (UTC)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A5F1BC32
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706174365; cv=none; b=aIcfr2eIlhLH2fP2Q4tINrDimsMlN1OF6G+H0QaX4qf/F0awUxToo+wPUMh1+BEAoac5n8ZWC5aZHN+jvSaNGU8SJjExz1WsjahaHDmhrtcuMfELop1Ya+xnKRZ7by7BaxNTjxioJZnqCtyQ4TwyIwU1arSWjw6UK6Y8+BQuYAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706174365; c=relaxed/simple;
	bh=ajceh1Vt9XpWQUJnO01TtgADI5oINn2cCkqX/1zC4Gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NAFxsB0eCuntIN4waXCTx221bCKKWisqQ0U5wNrSmS+LELqEGP8RPJWSC20ae/En9X/2Q+ziD82W4l2kF7zfmTZ+v7Z1s7zY+cMRvhkxt72QiEb+U3rhdo/t9hFiqzmeRZbC4mqkS7gdq9iwtI0hsSV15/dmkrVdYB3MizKEcYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W.JuoKJ_1706174358;
Received: from 30.178.67.122(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W.JuoKJ_1706174358)
          by smtp.aliyun-inc.com;
          Thu, 25 Jan 2024 17:19:19 +0800
Message-ID: <76a6cf81-fdf6-4583-aa4d-1e6a899bbb58@linux.alibaba.com>
Date: Thu, 25 Jan 2024 17:19:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] watchdog/softlockup: report the most time-consuming
 hardirq
To: Doug Anderson <dianders@chromium.org>
Cc: akpm@linux-foundation.org, pmladek@suse.com, tglx@linutronix.de,
 maz@kernel.org, liusong@linux.alibaba.com, linux-kernel@vger.kernel.org,
 yaoma@linux.alibaba.com
References: <20240123121223.22318-1-yaoma@linux.alibaba.com>
 <20240123121223.22318-3-yaoma@linux.alibaba.com>
 <CAD=FV=X_uLqi1W7JuSjo=WXF5JEvtM=wxbSeFQQ2KhVcW9=Fcw@mail.gmail.com>
Content-Language: en-US
From: Bitao Hu <yaoma@linux.alibaba.com>
In-Reply-To: <CAD=FV=X_uLqi1W7JuSjo=WXF5JEvtM=wxbSeFQQ2KhVcW9=Fcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/1/25 08:19, Doug Anderson wrote:
> 
> I guess maybe (?) the case it wouldn't catch so well would be if you
> had a loop that looked like:
> 
> * CPU from "storming" device takes ~10 ms and finishes.
> * After the "storming" device finishes, we somehow manage to service a
> whole pile of normal interrupts from non-storming devices.
> * After the non-storming interrupts finished, then we went back to
> servicing the slow storming interrupt.
> 
> I haven't dug into the bowels of the Linux IRQ handling well enough to
> know if that would be possible. However, even if it was possible it
> doesn't feel likely to happen. If those "normal" interrupts aren't
> storming then it seems unlikely we'd see more than one of each of them
> between the "storming" interrupts. Thus it feels like the "storming"
> interrupt would still have the highest (or tied for the highest) count
> on the locked up CPU. Maybe you could print the top 4 or 5 (instead of
> the top 3) and you'd be pretty certain to catch even this case?
> 
Hi, I now understand your suggestion. Using interrupt time as a
criterion of interrupt storm is suitable for scenarios where we don't
know whether an interrupt storm has happened. However, in the context of
this softlockup, we have in fact already determined that an interrupt
storm might have occurred through the "hardirq time", so there's no need
for a redundant determination. Thus, I agree that using IRQ counts
seems like good enough to find "storming" interrupts.

> In any case, I'll wait before doing a more thorough review for now and
> hope the above sounds right to you.
> 
> -Doug

