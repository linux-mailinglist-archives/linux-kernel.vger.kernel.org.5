Return-Path: <linux-kernel+bounces-46423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 523DF843F70
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06E95B2CACA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FE879958;
	Wed, 31 Jan 2024 12:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QDfWnokN"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A52B7690E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706704112; cv=none; b=QjbXKhihvJ3KclkHyOQ5gjIa7l49535dvb3BWng6G8L8fjmNh5pZRFRXZNLxjWYvFIzwKWqeDwKMMsGS9qTmeoK8mDlF4lZnVWVuq5bsnkBlfQm0SMsYwfBYGXCHPbO/r/WB8dQq74Glreoy5/3hO+DR4bZXzrLG/+j49vyscyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706704112; c=relaxed/simple;
	bh=tfmIVzpbc4f8nhcF44Q2JTtDgeYljS2rCMhGYPSASCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tUC6wZpsLtAGo2oa+hCUuEsQUqqecoAdfi3udvmZOE/wRfCpUKAgzYRcdcRXp2V5cp3P8InfurVjeLBSAUJiLvDw0zFarvB8+0QF7GRhT/QSE+9ZeXQNzv6nf/FfKz2kwT32Y2OSs2RwOBggk5OH7hd/oMC7rJWr/0VZudduZmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QDfWnokN; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-59a8ee08c23so279610eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 04:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706704110; x=1707308910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CNxGBaaSxXg7VpaG5SnLb4vaf3Z3poEmNpgkXrljdPo=;
        b=QDfWnokNI6hRmmjDm2ofBnCxlQvtSAAsg0Y2X8yOHcjsoN63STl3kdT/biA8Nu48jB
         9pBhTzsL4A+9L0pv1ex70Sp8CDJeG+IhCEiQOd3iLY0ghl9fpMAJlnzvief16RkyW6FJ
         2U/sa6YcqQXwD2STBawsPctb+ex2QgLZOtUeDepxfUWB56VlV2NqGXlZ9B+LTtlafY83
         RKIVgVYYOvPxAxe6GKZwBGsfBzyYcxUzoN8/yGbqqpU9hBNYfOyR6rEbipdyBFZ7cJ8j
         Fx7ZhJWKF4We1OhsJLvgGzMkr5UD5dmzjEBaHDzg5w+fa8tF07BMNEMY6t9F+F0TSilQ
         sf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706704110; x=1707308910;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CNxGBaaSxXg7VpaG5SnLb4vaf3Z3poEmNpgkXrljdPo=;
        b=AwYXklxuQwUagLXTcSVdeJvJ+bmiqTjJqrLfVUFLTkQjSfVpY6SyEIqNsDEPF8NoJb
         xxq4ncEcIMX2F3p/2lCfyMfUAj6VSFsNGY1G82iUOvLPqDZqmsph7pNmqMcac7QPriXb
         9RyhcCHx/b2wNqywtivMO8+b0Dd4Ll5f1fZ0stUq4YzhdiNar3hWOkMN5K9fXfx8dAJH
         +9GpXBiIT8FrgnuhzHlfsM3NjeGQgU8H4M0vEJhXq6X7YueBeM9pfaRiBmf8CWdVuimb
         QuBacJ8phOn2uIVlCaO2iDln3TX54N7IrWIU+XRP3wxJikz7irSjPDuxSOPolSMqSDyn
         jqQw==
X-Gm-Message-State: AOJu0YzqbDWMxOsUp9ohmxcLh5oGMZHHT/oLPrPh4SToAWaB2XH6Ch/T
	KAV8jQgWyf/hnkbSYkIxMFjrTePLMPTR0gxTxD3SmZYIdRhuV6TEGJfh/Op/wkU=
X-Google-Smtp-Source: AGHT+IEZwI90sSbUBYPDxpJwWWSo/z6iYol5bzvi1HebeQc65zRQWcisWYIArBzok8SBfYP1+lV7Aw==
X-Received: by 2002:a05:6358:190d:b0:176:ca53:39e7 with SMTP id w13-20020a056358190d00b00176ca5339e7mr1306083rwm.11.1706704109808;
        Wed, 31 Jan 2024 04:28:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVApRk+Nl6C7odE+YdD0sEDKLDB3ojxqLvTo22j0Qk+X5bOUHrEf04nQTk24XBC1zrHKZxVdyTN3eW/6gonz21ySmhdR+LKj3KGFIhWuA3AdbwqWX4VG5lJ6SxArzD8swpvZll0ArAVUXcBCbmgPvjIVAqQsIWUtBXS/yRI+l5cAC+LVW32VndULsWDH3CllD9bL0RtEksNbP3VMidcGapQnzdRuZzMNbJd1gb85Q8t5Bt3Km4RtGX2
Received: from [10.84.155.124] ([203.208.167.153])
        by smtp.gmail.com with ESMTPSA id u33-20020a056a0009a100b006d9aaee2f57sm9812307pfg.102.2024.01.31.04.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 04:28:29 -0800 (PST)
Message-ID: <5f8f4222-a706-45b1-8eb2-fd4553cc57d8@bytedance.com>
Date: Wed, 31 Jan 2024 20:28:19 +0800
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
To: Tiwei Bie <tiwei.btw@antgroup.com>,
 kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, aubrey.li@linux.intel.com,
 yu.c.chen@intel.com
References: <202401301012.2ed95df0-oliver.sang@intel.com>
 <23cbb613-c8a2-4f07-b83b-fa3104bef642@bytedance.com>
 <8b21e697-c9b9-49aa-a7ad-e88a5d7f9c92@antgroup.com>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <8b21e697-c9b9-49aa-a7ad-e88a5d7f9c92@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/31/24 8:10 PM, Tiwei Bie Wrote:
> On 1/30/24 6:13 PM, Abel Wu wrote:
>> On 1/30/24 3:24 PM, kernel test robot Wrote:
>>>
>>> [  512.079810][ T8305] BUG: kernel NULL pointer dereference, address: 0000002c
>>> [  512.080897][ T8305] #PF: supervisor read access in kernel mode
>>> [  512.081636][ T8305] #PF: error_code(0x0000) - not-present page
>>> [  512.082337][ T8305] *pde = 00000000
>>> [  512.082829][ T8305] Oops: 0000 [#1] PREEMPT SMP
>>> [  512.083407][ T8305] CPU: 1 PID: 8305 Comm: watchdog Tainted: G        W        N 6.7.0-rc1-00006-g2227a957e1d5 #1 819e6d1a8b887f5f97adb4aed77d98b15504c836
>>> [  512.084986][ T8305] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
>>> [ 512.086203][ T8305] EIP: set_next_entity (fair.c:?)
>>
>> There was actually a NULL-test in pick_eevdf() before this commit,
>> but I removed it by intent as I found it impossible to be NULL after
>> examining 'all' the cases.
>>
>> Also cc Tiwei who once proposed to add this check back.
>> https://lore.kernel.org/all/20231208112100.18141-1-tiwei.btw@antgroup.com/
> 
> Thanks for cc'ing me. That's the case I worried about and why I thought
> it might be worthwhile to add the sanity check back. I just sent out a
> new version of the above patch with updated commit log and error message.

I assuming the real problem is why it *can* be NULL at first place.
IMHO the NULL check with a fallback selection doesn't solve this, but
it indeed avoids kernel panic which is absolutely important.

