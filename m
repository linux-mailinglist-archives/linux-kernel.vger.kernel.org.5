Return-Path: <linux-kernel+bounces-33800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1D1836F2A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20CF3B326CA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D5752F98;
	Mon, 22 Jan 2024 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NCIqAD7c"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F60A612C6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944179; cv=none; b=Ly2uI3OC+L7hBuhpD3AaCilzrd0802501ztAi93khH/JMVJsSM/bQjFPLXiQcWV+w66w3Lfd/Z8cBKRgJ0cx1Y16EEfEaSLJXOwJ5vcd+42d0xln/rbVhuuebG4LeRQ/yQy6dYXFCG4Gtb7+/GkDekBiGrTMAXq8PJJnVZpNPd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944179; c=relaxed/simple;
	bh=bEHwRRHZEZ5muODAZZTChjTXAGcN8GLNJSdSobXIA0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bb2LZIzEGJI6pFlqCL9ShIumPS6I0vLwkLOUedUy3A+wVB4ZptkkxDLRErXvclsimGGsECtG90NxMQKjIqG1KrmQu9UH0R6fD1NO7cAaHgLxM0yRYdgrsvqxGUYxESsFrjVvrujQCljB35EuUgBKBlEGtkI2hzmKemjzfjb9++c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NCIqAD7c; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6d9ac0521c6so830651b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1705944177; x=1706548977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3cKBLusi5odBbefyu3q7+UJ6/M6hhfLrmEnRO/AYdSg=;
        b=NCIqAD7cPTDcHzPOjo+YrAdQhZRnfiXAizEgkmFr/YbQQIzPn5dYBRVoS31a+ULPw8
         /R5CcIGj6Mm8eLJg3DZK7ZCJPQpjgbfXu8Q11j91CGCoGCU8BY1JBVY6JepkTDzF5D1c
         axZaTBWHcjXBZ4ya9oqXJyJ/HDv68Y293Vi/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705944177; x=1706548977;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3cKBLusi5odBbefyu3q7+UJ6/M6hhfLrmEnRO/AYdSg=;
        b=YZNgBC+pXyb1ufPl9oETO36F0Dd8/BkvRL5CjLvhZF3H6jeyHuimCjcBhDFDXYz4Mb
         UHIyiX2HBku2GeEhqQVH8jBz6oiOyTgRNSw/xmn2/QV+pMiIUfv4QWCia3KgxMUXfw0U
         7vZFBZhEqlS/VtZ7B/DQQFA3hkt89t+EnGGRJ7cGOqb1kZ84fQRgLUtf6vlcrdtUH5k8
         za00ZAVYOqGDy/SS8xCSklKJIZhNziAGDf4jAMJs8rbWv2ULGdO+O7bjEIJUTBmYGmjh
         fekolGRzM2KjU1ZKuiVcOIgb1G2BLkhYHVvA0sMqNqj6Hue8rWvgfND+8km7UyO26Thk
         L5mA==
X-Gm-Message-State: AOJu0YwKek2ZZP7LFVOozPSecL9y3aU5Ue0fdAzlR8YLpDsrKUIXlsfK
	Y0SBkpWSfOQTTI3HjopbHhQMN8IK8QcYVCH/kyemzTOZOd6n1A7TtJKVzOG4XWA=
X-Google-Smtp-Source: AGHT+IGjgFJLDdAfyqDNErB5PR6R2A+VDqHcrvgpf1rrqIFIthJVkNUJsACPjPjML0hqNb41Xog8zQ==
X-Received: by 2002:a62:6204:0:b0:6d9:383b:d91a with SMTP id w4-20020a626204000000b006d9383bd91amr8897256pfb.1.1705944176719;
        Mon, 22 Jan 2024 09:22:56 -0800 (PST)
Received: from [128.240.1.152] ([206.170.126.10])
        by smtp.gmail.com with ESMTPSA id y74-20020a62ce4d000000b006d9a48882f7sm10245573pfg.118.2024.01.22.09.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 09:22:56 -0800 (PST)
Message-ID: <f3ba4181-ab38-4779-987f-9bda47f003be@linuxfoundation.org>
Date: Mon, 22 Jan 2024 10:22:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
Content-Language: en-US
To: Marcos Paulo de Souza <mpdesouza@suse.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 live-patching@vger.kernel.org, skhan@linuxfoundation.org
References: <20240112-send-lp-kselftests-v6-0-79f3e9a46717@suse.com>
 <20240112-send-lp-kselftests-v6-2-79f3e9a46717@suse.com>
 <Zap04ddls7ZvbL/U@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <Zap26MINbbxREt4c@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <53cf93b2efadc0f42712eb92436bd575b5622664.camel@suse.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <53cf93b2efadc0f42712eb92436bd575b5622664.camel@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/22/24 05:55, Marcos Paulo de Souza wrote:
> On Fri, 2024-01-19 at 14:19 +0100, Alexander Gordeev wrote:
>> On Fri, Jan 19, 2024 at 02:11:01PM +0100, Alexander Gordeev wrote:
>>> FWIW, for s390 part:
>>>
>>> Alexander Gordeev <agordeev@linux.ibm.com>
>>
>> Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
> 
> Thanks Alexandre and Joe for testing and supporting the change.
> 
> Shuah, now that the issue found by that Joe was fixed, do you think the
> change is ready to be merged? The patches were reviewed by three
> different people already, and I don't know what else can be missing at
> this point.
> 

I would have liked doc patch and lib.mk separate. However, I am pulling this
now to get testing done. In the future please keep them separate.

thanks,
-- Shuah


