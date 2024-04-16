Return-Path: <linux-kernel+bounces-147766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E618A7961
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E62C1F23619
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C43813AA43;
	Tue, 16 Apr 2024 23:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eKuhO5D7"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897D413A894
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 23:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713311649; cv=none; b=bKv2MU8PZ70m2svYzsDkqZkUj8nypQ/FJSNmoHmUzjm6bJP2oW+ql0fCiUmEUjtZw2mGkqP62kYLlNZISrRS/W3i9drG1n3AK+1MO8urSOG1yk/AvwxZ0EkCu3oGfu5sng5iyWaMKFQlKJYsvOJrNVNB99c77nxn3bo0Vj6V0nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713311649; c=relaxed/simple;
	bh=lELwXqX2GnBMmAHfLBmNlByJmdmG/bVTILIylDcO+sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XHIN5Ug4XlwdbD/I9AYldd48Bb/zf9OOqCe9mxTwrOvLX3zs+2zf4S02B/IUZkNR0EFtG6EU/EIUnw113ltcbGQ8LI66V5DTrSAJnzYtQ8hcWnClBEWeFTHQflIpRvycLmwb3shBBubIc570QmVWLJiXt4IY/GCcNcKD71mOE3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eKuhO5D7; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6eb7a4d64e8so1082569a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1713311647; x=1713916447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TR0TEYbFqb6c5b6HzlrOARuCR9bvnLhVJNRPXv/Uaxs=;
        b=eKuhO5D7NVn72l1tCE7RCzD/rUsZvcYyMJQfwJqLEZebFqp+49LbN5ZSV3euBbHikF
         3DJXX6vQjbW6r1osZKpWfI0JcEDY04hpWAcz21ALUw6oRP3NkAEXlyZ+MJKXWlV9ZhCU
         m0FvX21gH4jfmfPXX3TprnV1ulpwdOeVFSfnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713311647; x=1713916447;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TR0TEYbFqb6c5b6HzlrOARuCR9bvnLhVJNRPXv/Uaxs=;
        b=fZcoP1zqXUQfGO+bebvgG8E7YES28q3vNj1Afhx0vTZCQplq6db+eNbWMt+pkF+ZyQ
         kSkQtiTsPzJD79sTOsoUUx8ry2v230ctPTXRgm6gukU1/2CWzrSyWWIcsEYXf5trX8Zu
         swh67STei4S8CwaRZ9dD2U/EtddfxuyO1AsT0L8JRwP0W2JnCN2U029A19VJ9SUnCSZc
         h9vVTc8I6xE4M5zPfNz2ILl/uMEKThIu3/v/3U1uxeWBJuzUmlYDTh4JCG5UXypltw+k
         DM2caKNmCgyCGp1ue8gG+08PZUi57uuGEpPh2Rd2asNbcOUijQw9wtKQ1LqGdMZU+C5q
         Ie0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUF2jYwleWMPD/z3j1F/AKiAHnp7JnPPaK4wcEhpZVcwoaBYXTjwIMpizhV26KRPAQKDLpq3//Dm9Ji1gAqF3h0f/nYcioPU/JreAO0
X-Gm-Message-State: AOJu0YxBHnxnBaxCGqtaGADf/JonyLfx6ze4RSsPIgLZAIjXuQdFeryP
	b4G06UnbuC0aYv+ETVoldl7RatCBwLYryeB3s628XrHW3Ws5FYOMiR5MsWjMuKZvbeYeli1fCur
	kDMA=
X-Google-Smtp-Source: AGHT+IE0deEqv8RHKhl0RXyrVo47Iv1fvvJ8qSc+8jrpMU3Gj5qxW82X+IK0E4xoncbed3xqI33B5w==
X-Received: by 2002:a4a:bb18:0:b0:5aa:14ff:4128 with SMTP id f24-20020a4abb18000000b005aa14ff4128mr14940743oop.1.1713311647605;
        Tue, 16 Apr 2024 16:54:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ay27-20020a056820151b00b005a47a6b8f67sm2795689oob.29.2024.04.16.16.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 16:54:06 -0700 (PDT)
Message-ID: <69d0c6c6-ed82-410c-9102-09ed3b95ae05@linuxfoundation.org>
Date: Tue, 16 Apr 2024 17:54:05 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the kselftest tree with the tip tree
To: Stephen Rothwell <sfr@canb.auug.org.au>, Shuah Khan <shuah@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: John Stultz <jstultz@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240412155545.7b8ad20b@canb.auug.org.au>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240412155545.7b8ad20b@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/24 23:55, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the kselftest tree got a conflict in:
> 
>    tools/testing/selftests/timers/valid-adjtimex.c
> 
> between commit:
> 
>    076361362122 ("selftests: timers: Fix valid-adjtimex signed left-shift undefined behavior")
> 
> from the tip tree and commit:
> 
>    8e222dcf92a8 ("selftests: timers: Fix valid-adjtimex signed left-shift undefined behavior")
> 
> from the kselftest tree.
> 

Thank you. I dropped 8e222dcf92a8 from linux-kselftest next

> Slightly different versions of the same patch (whitespace differences).
> 
> I fixed it up (I (arbitrarily) used the former version) and can carry the
> fix as necessary. This is now fixed as far as linux-next is concerned,
> but any non trivial conflicts should be mentioned to your upstream
> maintainer when your tree is submitted for merging.  You may also want
> to consider cooperating with the maintainer of the conflicting tree to
> minimise any particularly complex conflicts.
> 

thanks,
-- Shuah

