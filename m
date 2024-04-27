Return-Path: <linux-kernel+bounces-160976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91D48B4556
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 11:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24CEB1C2122A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 09:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01514645B;
	Sat, 27 Apr 2024 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QiPa9/+3"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1288BFC
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 09:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714210069; cv=none; b=HfRo7eL3p72WTavuv4zy0urLOPeKQrGu8/7X8Fm44WQkt5Nh2WFWsGBUXJLbIHlOSmIM0Dp6oZEOBpiVRZz1AKGLZo8PR/3w73WT0jaLG+2cRrcZpO2UxuVohEhVCv31qAR3UbI3vJKrFtENLoyE7Xj+YqKUBLBQVpJUjqaa768=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714210069; c=relaxed/simple;
	bh=XgEgUI7ErWK/JeyKa2xwDIBHe9mB7sfhnipyV6AhvZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=huuHRWReSQ3GmW50tdtPcc9c1/hRsjszpXmLf7ko7uy6jMPDGK5tDGo0Ah9Je8S7g6IOAj+UhNI2rosQrWdT7ZHTVRcSKDz/y+f7/m8O/zJTmNfgnASoR+kar+9aWSbapXbFnAs9+UblJe/SxHMSQXky2frsdjbw+PRj+n8URpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QiPa9/+3; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2b0fb1b6acfso50562a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 02:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1714210067; x=1714814867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HC+DEWqPr/SHJQELXAMN85jRxEJor1SyjNScMksjbwY=;
        b=QiPa9/+3BhfNoxm0VbTrscmhIUphKwMSXo54Ecv9p/1woLMnOlhQPyhcor5aLKNXFb
         Q8VsqWbQcKC0SZxJHvIWoL6tYrrAe5aqdszYeiZw3acWOkpqSyR8s2MXy7PEJ3A26dhp
         GtZpACab7o1hrjWuIxb+QuUGVf8RKS9MFyaW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714210067; x=1714814867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HC+DEWqPr/SHJQELXAMN85jRxEJor1SyjNScMksjbwY=;
        b=svF+85cI2b7qrDTHlJDyjd5Nto5o4MFWEPAurTrcd18YTWYQSV0q7UYBiNOsmnTsSu
         KTx3m/lvz42MT/WPzwIYOxJiGkO3ILFppaAWGLw8WKRzuHmj5eaw92LLyeAjygbFMLw1
         L2uFerVD5HFWFmH7+D1gK81jAmB2SL1suHSCVcVBO2Munj9inBKjHeGatYnHA0siPyhw
         MJcHO8SYjW1cYj5OYTRHHWP5wOcP+E4xf/t97ruLnokNrSZ9n33/38VHIt5BrcBVJqJ5
         D1NhhKhfMf6yoS3xxnPYCokja9m5C9r1xYmj+xTlU2JvsOwsypH1+/Gtc9mdvO8g3JZk
         Mdrg==
X-Gm-Message-State: AOJu0YxJ6NN0ZN11+Vy07Lkxs4eb787dlHdGFyx4xWjoyT3TPETrl7fO
	0aKDHlmMn3XiEFCdQAba+2VBly6Ud2hZq8jg3plJ36Abi+kS+evee6Ob1tJgKyk=
X-Google-Smtp-Source: AGHT+IG5YITf8M8bO/7UKrWIc1Fu3ECl/f6FxkHT9butXm/uHItwUrpt9os6XRbpSFM1U6DjZtA66A==
X-Received: by 2002:a05:6a20:7207:b0:1a3:c621:da8d with SMTP id y7-20020a056a20720700b001a3c621da8dmr4528692pzb.1.1714210067142;
        Sat, 27 Apr 2024 02:27:47 -0700 (PDT)
Received: from [192.168.43.82] ([223.185.79.208])
        by smtp.gmail.com with ESMTPSA id e16-20020aa79810000000b006ea6ca5295bsm16024707pfl.164.2024.04.27.02.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Apr 2024 02:27:46 -0700 (PDT)
Message-ID: <f872c56b-ed45-4b45-8c40-52ddb3f2c809@linuxfoundation.org>
Date: Sat, 27 Apr 2024 03:27:41 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the kselftest tree with the mm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>, Shuah Khan <shuah@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240426154414.4d408fd7@canb.auug.org.au>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240426154414.4d408fd7@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/25/24 23:44, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the kselftest tree got a conflict in:
> 
>    tools/testing/selftests/mm/soft-dirty.c
> 
> between commit:
> 
>    258ff696db6b ("selftests/mm: soft-dirty should fail if a testcase fails")
> 
> from the mm-unstable branch of the mm tree and commit:
> 
>    e6162a96c81d ("selftests/mm: ksft_exit functions do not return")
> 
> from the kselftest tree.
> 
> I fixed it up (I used the former) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 

Thank you Stephen. I will keep track of this when I send pull request to Linus.

thanks,
-- Shuah

