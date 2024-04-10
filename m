Return-Path: <linux-kernel+bounces-138574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9253589F3EA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D881C25B1E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C53315E7FD;
	Wed, 10 Apr 2024 13:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nRkwB28A"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAA115F413
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755082; cv=none; b=dkdCdrbA54/0i5GKr5PLyTLa1hyJXfGk+FbnXFKowzpFJNQoEh9vrL61dl6YvUvtUB8Z5hd/jpf1NIVeGmz2qd3h3rJXKIRi6cekLdXI+hT3WCN/tljSqnYXntH34IBCzxsdjFAhwuJI3Zzc0O/E+xcIfsjfDnwze0bspgQGNLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755082; c=relaxed/simple;
	bh=VOgr6VHmhrmiYYoVSszTIXqcLbkSs0q81/guFPLUVaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rT9AS7mMhLvWOYo/qlN8TbCjgcafeoR821m8PffhA+kZXOMPDCkbBJezIB53DNS2mIIOwjquh2c8CXNImUk3JJw+uPIgGSl1IXeDd2gF7HHMYJWv7wHMziF+xvFmR4Mhxm0huMmLCwFSGyoRc+wGFCGEPEUfVjy+EY3CAWHTSi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nRkwB28A; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e694337fffso1352580b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712755078; x=1713359878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=njz1AW0Oux+Oa/KGjRNDjX/xkDqdEMgcLJEf5/RjX/U=;
        b=nRkwB28AJuCbmIcJh2Vn1WUxFD/hyTKlqbwaS9FbeYzCyM1K59thWDX7ikS/2SYy+L
         jrbFQrwqrfYwV4Xzcs50ySJjTDCNtxgrnwkl/K8mMUFu77q9q7CyoBVnLtV//tUqj9CW
         bpgFRRT9dNFHnetF1CxiPGk68SxJelfWs7O5xqZiiBW1blvRpJWWI6mjylDHZ79waBtN
         IjRornVmJO1QBNQQCZKFMzpe+guEs0Qx5Fwr00a+OhsxZIRTvfFgsocd/sHzTU2g5+aS
         ORRRw1JvM8c6LE23CiK+8r+wZg51HcKma2h0VFCnF91yHzskIeI9HKt7Eet9xSfy9rY9
         5p2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712755078; x=1713359878;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=njz1AW0Oux+Oa/KGjRNDjX/xkDqdEMgcLJEf5/RjX/U=;
        b=IVpUqDMaX8SwDLASSCftcf779vXvEDEKG+w3KjCUJT5GN2BVnnu1uYkNp6V/n9MkTt
         xmZghXOOWzcDdoxbXCic5aM4xPzxUM+Cg917nJB9OiKXRBOTpmSM/cGHWqAYa/4ODlWO
         p6nTMU0DAlV+aMYTraw1mVAQ540TO54bdd/u6rSNncYo/8jOPXK24GY069oO/GvRG0lc
         rIkklnaNUl2tCZFaO3Glp/0TYdWb8Qy6w/Plf0n4tf/iASSZw76m4MErvAnu/5ZSs1uG
         6CQvcXWADIkPNBd2kavWsL4txvSnAyFkgwnD8fjKNdq9pta4akETemFFrZdwU40mUXk1
         iZtA==
X-Forwarded-Encrypted: i=1; AJvYcCVk9hrpzglvfNmVjq1RarOHJhKfXFy5sEucocYmmGaAqMtobE1yiX6LSX9jonk/NhZ8fd+5WaQTK02wDJNkGW2zlRi+wkXX+2b/6Y/x
X-Gm-Message-State: AOJu0YwVdp8of+5PqB/F4RPWntlSgwdHQAik9IZs6DCoRktU9UOhWKTQ
	haPxz1toA+iEsEAFdjRaGyy2NBQts84LP5pnYfhQ1gkBYY8SC06OuI3baHwAb5YhlX9OAnCtOES
	e
X-Google-Smtp-Source: AGHT+IEIFpsL4LtW0ZbD2Xz5VGwmcWpFzG5evWJ+aq8CnJ6YJSYed8HXZnvFoHPWv77z01hKnhWxeQ==
X-Received: by 2002:a05:6a00:4785:b0:6ea:6f18:887a with SMTP id dh5-20020a056a00478500b006ea6f18887amr2524844pfb.1.1712755078317;
        Wed, 10 Apr 2024 06:17:58 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id lb14-20020a056a004f0e00b006ecf3e302ffsm10461581pfb.174.2024.04.10.06.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 06:17:57 -0700 (PDT)
Message-ID: <5a67c4f7-4794-45b4-838c-7b739372d3a5@kernel.dk>
Date: Wed, 10 Apr 2024 07:17:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: add max_dispatch to sysfs
Content-Language: en-US
To: Dongliang Cui <dongliang.cui@unisoc.com>
Cc: ke.wang@unisoc.com, hongyu.jin.cn@gmail.com, niuzhiguo84@gmail.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cuidongliang390@gmail.com
References: <20240410101858.1149134-1-dongliang.cui@unisoc.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240410101858.1149134-1-dongliang.cui@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/24 4:18 AM, Dongliang Cui wrote:
> The default configuration in the current code is that when the device
> is not busy, a single dispatch will attempt to pull 'nr_requests'
> requests out of the schedule queue.
> 
> I tried to track the dispatch process:
> 
> COMM            TYPE    SEC_START       IOPRIO       INDEX
> fio-17304       R	196798040	0x2005	     0
> fio-17306       R	197060504	0x2005	     1
> fio-17307       R	197346904	0x2005	     2
> fio-17308       R	197609400	0x2005	     3
> fio-17309       R	197873048	0x2005	     4
> fio-17310       R	198134936	0x2005	     5
> ...
> fio-17237       R	197122936	  0x0	    57
> fio-17238       R	197384984	  0x0	    58
> <...>-17239     R	197647128	  0x0	    59
> fio-17240       R	197909208	  0x0	    60
> fio-17241       R	198171320	  0x0	    61
> fio-17242       R	198433432	  0x0	    62
> fio-17300       R	195744088	0x2005	     0
> fio-17301       R	196008504	0x2005	     0
> 
> The above data is calculated based on the block event trace, with each
> column containing: process name, request type, sector start address,
> IO priority.
> 
> The INDEX represents the order in which the requests are extracted from
> the scheduler queue during a single dispatch process.
> 
> Some low-speed devices cannot process these requests at once, and they will
> be requeued to hctx->dispatch and wait for the next issuance.
> 
> There will be a problem here, when the IO priority is enabled, if you try
> to dispatch "nr_request" requests at once, the IO priority will be ignored
> from the scheduler queue and all requests will be extracted.
> 
> In this scenario, if a high priority request is inserted into the scheduler
> queue, it needs to wait for the low priority request in the hctx->dispatch
> to be processed first.
> 
> --------------------dispatch 1st----------------------
> fio-17241       R       198171320         0x0       61
> fio-17242       R       198433432         0x0       62
> --------------------dispatch 2nd----------------------
> fio-17300       R       195744088       0x2005       0
> 
> In certain scenarios, we hope that requests can be processed in order of io
> priority as much as possible.
> 
> Maybe max_dispatch should not be a fixed value, but can be adjusted
> according to device conditions.
> 
> So we give a interface to control the maximum value of single dispatch
> so that users can configure it according to devices characteristics.

I agree that pulling 'nr_requests' out of the scheduler will kind of
defeat the purpose of the scheduler to some extent. But rather than add
another knob that nobody knows about or ever will touch (and extra queue
variables that just take up space), why not just default to something a
bit saner? Eg we could default to 1/8 or 1/4 of the scheduler depth
instead.

-- 
Jens Axboe


