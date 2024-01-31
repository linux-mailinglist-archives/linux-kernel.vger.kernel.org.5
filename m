Return-Path: <linux-kernel+bounces-46426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BEA843F76
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A00EB21E46
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84A279DA3;
	Wed, 31 Jan 2024 12:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SdLGd2q7"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30ED55C14
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706704461; cv=none; b=pklpAylT+haNATiyP9hQ16Ot3r5NAKbPq8uf3+x+nK4VsLJjWbWDzZy/fmXSTnL7mjDbDS1kKyG4ueNwDNHcwDf4IUF3CiNdSAKcJ9shQQHwgJzIWOg14m1lh3xaobeOnKASrj3pE9SrDQr4SYkFR/NEG6NGEeLv3LOtFd+0dms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706704461; c=relaxed/simple;
	bh=yl7X/G/4MBAjUx+RX6EbliJqBCrIxX6dil7pQuxJagM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mBtmxLhkptYZKyHOYDwbFCAun7mAHcXbPpGqTdLhuEfuovb1GHljBNCFecz/zkSetwUUMQcqtIqUOTkZd8GQ11LUhKIpXowrEVVqV3RP5+gUMUMaOqaUTV5V8e3FbGOP0A9ZRGzs/3PRuY4LT2T6HC3E4nBcEI11BypOSTe1tuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SdLGd2q7; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2907a17fa34so3966419a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 04:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706704459; x=1707309259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=So/uvJkDp4G4Nx+mQeNe/SDxpCPSp5I1+BiBqw9eNlo=;
        b=SdLGd2q7QFNxnas+lPGRPRl7dVpOnGftOyy+v6ommLLlVmtFDYPz/ySPhsf3topY9a
         2Fb8XFoWGfNZeCKOAQyADERpRuxDshaRCXnijvYO+5arvIMrT7EmaLLOGC7/f8Dzm2yq
         yC1a2/z++AOif2h6cWpVK16L0O332LKk70Nu00TvfS263K4AK7HhqUdPfxqeeB9r8GeT
         Wf3tTV0GGz3w35TJ8nnf/JiBp0ogBP7Alj/ARvTZqV31YrEQ9IniDlw+BPlQOsXbzkvR
         d4J6ryo1WJIh98fybLidMogm2TnNvv/pPMDzud5qX+JXMRcI3VXZ6u0Nb4SEK5/7+x4I
         wbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706704459; x=1707309259;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=So/uvJkDp4G4Nx+mQeNe/SDxpCPSp5I1+BiBqw9eNlo=;
        b=aWFLtJNAfX0e2F0/PiraeS2fnNYy+eapvrGM0EoZa6gnDEBb8NhL9Yhekn0kNbzn4U
         f4xcLZ/JRU27ORG0mjRM9pDWAQZDme6n/E9z5vH5H7fRPX3aa9wBnM3oQ65ONMJosT4P
         D5WpYVKB5b3yjRaeXxGVGH06QY50xEPTaoc93NzovOTp22bjs3SIEgI01Sh1yV/ftEBu
         KCTWVIlgV542WOALfI0E8aiZVp7sm2KysvTCgkjuDu5omyo9bWMMg9/8WifG5OuBO/NV
         piB3p8LXVTQamZKCFCGmDOAOfi17i581eMyraQeNrffpO5Lz+JsdpHHiqcq7elme+jBC
         /MjQ==
X-Gm-Message-State: AOJu0Yxw+T/bycoh6EMUduKC3t1S1uF7mISeCKhA76RXRYsUp1w3xysf
	p80DiHiDGryyaA0dt1PHknqXPWR3BHsHLGrgQ4DaxgPs+IO54/J/RtvmCXTlOLA=
X-Google-Smtp-Source: AGHT+IGsxfYEcpEBVgRjFA2wMEDD0Y1dmHe7mllxjn2xAjfd1wjBy8Ndmdo1creP5/Mlj3mLlqdE6Q==
X-Received: by 2002:a17:90a:6807:b0:290:347a:f270 with SMTP id p7-20020a17090a680700b00290347af270mr1388562pjj.42.1706704459049;
        Wed, 31 Jan 2024 04:34:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW7Q3iKi08RHom/1AC+kItSc8fI1JdcmQvqWrtaH1OTiYGaOoC7rWAbcsSI881DXrWVden1BBB4OK0Kc2T63TSUM5sR2YDBf/RFptMm1kXmGI1751SwZGY1HTU02uRl0rssqqL6vabgKbXPlO0BhVnoOsx1XRBnze+csYwlWgQz0mawXTI6Ut5skYLesOYwWzdaTV0g8iuTknXT82h1X47qrdne7t0vZQhGjY/aQi2gK1ea94aW7o/k/w==
Received: from [10.84.155.124] ([203.208.167.153])
        by smtp.gmail.com with ESMTPSA id pt16-20020a17090b3d1000b00293851b198csm1379458pjb.56.2024.01.31.04.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 04:34:18 -0800 (PST)
Message-ID: <a253ee7d-8351-4cd1-bebe-fca1370b4093@bytedance.com>
Date: Wed, 31 Jan 2024 20:34:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [linus:master] [sched/eevdf] 2227a957e1:
 BUG:kernel_NULL_pointer_dereference,address
Content-Language: en-US
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, aubrey.li@linux.intel.com,
 yu.c.chen@intel.com, Tiwei Bie <tiwei.btw@antgroup.com>
References: <202401301012.2ed95df0-oliver.sang@intel.com>
 <23cbb613-c8a2-4f07-b83b-fa3104bef642@bytedance.com>
 <ZbkDIlIR7qzPt7Vk@xsang-OptiPlex-9020>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <ZbkDIlIR7qzPt7Vk@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/24 10:09 PM, Oliver Sang Wrote:
> hi, Abel,
> 
> On Tue, Jan 30, 2024 at 06:13:32PM +0800, Abel Wu wrote:
>> On 1/30/24 3:24 PM, kernel test robot Wrote:
>>>
>>> we found this issue happens in very random way (23 out of 999 runs).
>>> but keeps clean on parent.
>>
>> Thanks for reporting, I will try to reproduce the issue. Does the 'parent'
>> mean the same code branch without this commit?
> 
> 
> it just means the parent in git log.
> 
> xsang@inn:/c/repo/linux$ git log --oneline --graph 2227a957e1
> * 2227a957e1d5b sched/eevdf: Sort the rbtree by virtual deadline
> * 84db47ca7146d sched/numa: Fix mm numa_scan_seq based unconditional scan  <-- parent

Thanks for clarifying, Oliver. And can you please check the parent's
dmesg for the log:

	pr_err("EEVDF scheduling fail, picking leftmost\n");

which potentially turns a kernel panic to a message.

