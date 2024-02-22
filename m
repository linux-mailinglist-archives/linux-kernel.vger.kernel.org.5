Return-Path: <linux-kernel+bounces-75701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF67685ED93
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA9EC28455A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193C52904;
	Thu, 22 Feb 2024 00:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAdi4DPu"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF495660;
	Thu, 22 Feb 2024 00:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708560514; cv=none; b=KNQ77QSjbrfYBbfqLQ9LmGj5VaND1qvXVUrVEEmeG0ze8o+QJ/uItgZPpANOtZDt+r80bBo+4a9IU/rrgxs4AszNsNg1gRzLyYv5VEV7OZq3hwIh40TqF78xFgB/IUFbqQcYl3ncDZe2llSL9WSiX8uJnX3DHDGLJDXFLZ/I4Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708560514; c=relaxed/simple;
	bh=Ihd7mrTw7+UrofKPdqAHJJTXadljxW0+2gEGdxs0gag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XlCszDwbqd/KcoyrSddLMo9tvIiidjH1c6kFVaia4k0DMspfjMPK6La4857+vDaSdku1w2veKiB4SfBRIhSJAOVQiHi6hpPZFw1jiUcxGiPJD/oh8QMjLzfp85DAwrTeM+nn5bheZJzs89BvukFfKi4KUgAMPtO2z380JNJ9H88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAdi4DPu; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41275971886so9548565e9.3;
        Wed, 21 Feb 2024 16:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708560511; x=1709165311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JrLVGHWqd42HuRvVm6ka+mAXekU9BySf50ulUs1HdnQ=;
        b=MAdi4DPuAH97VAd039izT/k4E/pGxnXdUBRh4wnJCMXJB5tjHwDAsg/uP7aZlJgq8I
         vXdmYx1XZ9NTKiG3zLFafeUOI0SIdK42RXBNNM9KwayNHp/Gxg3hejF6KcQfrAKPxR2y
         a3+ID1zj1xppJSbjdBSpjDb/ZEojdEFZSeCqWO/CGznP8tkhlSyWds9AgtUyjLJF/DTd
         7uTJGJNcGpL/oMZ4C2of1s5tWWe2s4q0YKHfYO1cifqoDEzWHfJ3RYjyP3BpiwUEiql9
         VP4o+6nZG9CjP7CYzrUHtDLULZnpHyydT74b00aLxGAZ+AMgT8ixMDBcZ3FQs+miDgJ3
         q4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708560511; x=1709165311;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JrLVGHWqd42HuRvVm6ka+mAXekU9BySf50ulUs1HdnQ=;
        b=UIwB0jwcwDZUxFjE0bSG9Eh6f6LwaWQneOx0WODu3ASvPjK6hoCPjkUOCyJzxrsR8i
         0YdPYAigjhh+U9GrzjTmw+sB9jDqK1p0P/Rrz50uFt8mPMD35PSTu89kLl41xBAzDiY+
         SMyL2J//XOibivXzWtTImC3Q48/Iq75LPrf9NyNOfvXiLjvz6e17DJCQKVCWcf1Vcrpx
         R3UW1hMe+R0V3Pos+hvBIyKI7YnrrDfxKGonFFyAmbX+fybJ0E+2AnV4mjGcLduDtTFE
         1qy8dBCFU9dfDvE3r6GEOeQfL90hi3nBgbVwY7CQ7Og99l/0v8ByZWgPRhWXu7fxz+yG
         ZA+w==
X-Forwarded-Encrypted: i=1; AJvYcCXDh2jZ9rQbQ3wYr5VhW0M9qrHCYfXf8M9AQfvtFW3lUucGoY30A7sqTTM29/DBy28qUPVVSueW7CTCrjYk9ftL+7cs0jCmn1lwNpdC11jQ4rotEo9qMuc6gYEzXbYTlb+msuH+m4royhjvO0Xrpu7u24xDyKBXD9WZnAzUthfgpSZ4Kk8G5Q+dbjT2sWA=
X-Gm-Message-State: AOJu0YzpvXJE1lmZqG7Wq1um+arCFuvfkgklXDAhueDsyRxGWmK0J2w5
	jN7M/RI8rfjJyuVLC0Q8VoRHWECfuDKMHaN+zB49K8dng1ZQmOhZ
X-Google-Smtp-Source: AGHT+IH06e4oysCannDPPsoqQTO02G4XnpwkMHVszAA9iSTdrnX0sRQl2H2Vg2qlzUMWKrpS5BM7Fg==
X-Received: by 2002:a05:600c:3515:b0:412:17dd:a227 with SMTP id h21-20020a05600c351500b0041217dda227mr14521005wmq.15.1708560510711;
        Wed, 21 Feb 2024 16:08:30 -0800 (PST)
Received: from [192.168.0.101] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id t11-20020a05600c198b00b0041270c2b95esm6351055wmq.29.2024.02.21.16.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 16:08:30 -0800 (PST)
Message-ID: <cfa4cd82-67e9-4483-9c35-a425859f4a21@gmail.com>
Date: Thu, 22 Feb 2024 00:08:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] bcachefs: remove redundant assignment to variable
 ret
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240221115203.3413554-1-colin.i.king@gmail.com>
 <3qaoftjgf7p2ugutl524b3yin7pqpjrkftjx3frunhduf3so66@tjhcdoq6unk3>
From: "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <3qaoftjgf7p2ugutl524b3yin7pqpjrkftjx3frunhduf3so66@tjhcdoq6unk3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/02/2024 00:04, Kent Overstreet wrote:
> On Wed, Feb 21, 2024 at 11:52:03AM +0000, Colin Ian King wrote:
>> Variable ret is being assigned a value that is never read, it is
>> being re-assigned a couple of statements later on. The assignment
>> is redundant and can be removed.
>>
>> Cleans up clang scan build warning:
>> fs/bcachefs/super-io.c:806:2: warning: Value stored to 'ret' is
>> never read [deadcode.DeadStores]
>>
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> 
> I'll take this, but - entirely too much of the traffic on this list is
> getting taken up by static analyzer bullshit, we need to cut down on
> this

I'll back off then.

Colin

