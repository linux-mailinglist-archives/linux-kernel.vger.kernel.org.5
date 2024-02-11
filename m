Return-Path: <linux-kernel+bounces-60836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 692ED850A07
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114951F2187B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AB55B66C;
	Sun, 11 Feb 2024 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tDeNQHwQ"
Received: from out199-16.us.a.mail.aliyun.com (out199-16.us.a.mail.aliyun.com [47.90.199.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5B05C5FC
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707665817; cv=none; b=Eso/mSV2GSh42mIJuyQ3edUHz9Fa62jZtK3U2H7yU8ngbtglsXptF1idMVp9xTOhoDtWuu9RUrJ79wIdS3AQMpcOCclg8riSWqg6RmgWL0T5QUiMIPpG1MBvGi3A3gJOM3E3fCSNJla+xKzuIV/0OLorH2CbLS/DOR3lFCe4Nac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707665817; c=relaxed/simple;
	bh=iYl66ZTpBWpjyIrY1mfn+UnUan9vHHDYAlJlDszd7Bw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qkSTQAKKQhGATcdEclCVjduzanY0KVTCkNlY28yRc0c1JtknSE8qDtmFpg8O20LVP+W6Twz5ow/YSXhmHh9iR5lWDmo6DVJDuCgB1YoeVOVk/ScOr0vspyzl4YvXyXEoLFnmvbXxDImHJP8zsnuZzeb4JdGCEQC3+HhSePkhGPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tDeNQHwQ; arc=none smtp.client-ip=47.90.199.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707665798; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=S1Iv63ntPIBNm9J2Nrlm691l1saLabCtukCnwzknJRU=;
	b=tDeNQHwQnQeLR2Jrk7IhxGo2JiUXYJEwIaA2spGY6aF70corvNBX9LXN5yLcXGZgZii5GgvTpJA1yr/amfmkxGdQeKuOSwOKauEOwSIK++Uu4C47AAT5Ns7DLNPw5XF4SZ7QMZZY0oSyXQVW/gEjWgd0Od3x4dA55Da4Z3VJfpg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W0QQ5Yc_1707665782;
Received: from 192.168.0.104(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W0QQ5Yc_1707665782)
          by smtp.aliyun-inc.com;
          Sun, 11 Feb 2024 23:36:37 +0800
Message-ID: <2babef6f-8b55-478a-95c3-337b3b1325ac@linux.alibaba.com>
Date: Sun, 11 Feb 2024 23:36:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitao Hu <yaoma@linux.alibaba.com>
Subject: Re: [PATCHv6 0/2] *** Detect interrupt storm in softlockup ***
To: Petr Mladek <pmladek@suse.com>
Cc: dianders@chromium.org, akpm@linux-foundation.org, kernelfans@gmail.com,
 liusong@linux.alibaba.com, linux-kernel@vger.kernel.org,
 yaoma@linux.alibaba.com
References: <20240208125426.70511-1-yaoma@linux.alibaba.com>
 <ZcY7P7KLDt90XqYE@alley>
Content-Language: en-US
In-Reply-To: <ZcY7P7KLDt90XqYE@alley>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/2/9 22:48, Petr Mladek wrote:
> On Thu 2024-02-08 20:54:24, Bitao Hu wrote:
>> Hi, guys.
>> I have implemented a low-overhead method for detecting interrupt
>> storm in softlockup. Please review it, all comments are welcome.
> 
> I like this work.
> 
> I wonder if you might be interested also in reporting problems
> when soft IRQs are offloaded to the "ksoftirqd/X" kthreads
> for too long.
> 
> The kthreads are processes with normal priority. As a result,
> offloading soft IRQs to kthreads might cause huge difference
> on loaded systems.
> 
> I have seen several problems when a flood of softIRQs triggered
> offloading them. And it caused several second delays on networking
> interfaces.
> 
This is an interesting issue! I had considered the matter of softirq
while working on this, but since there were no actual issues at hand,
I didn't conduct an analysis. Your mention of this problem has
opened my eyes.

Best Regards,
Bitao

