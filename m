Return-Path: <linux-kernel+bounces-94326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52ED5873D69
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ECC72836E4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2B013BAEC;
	Wed,  6 Mar 2024 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fRm7+o8X"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1E9139569
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709745716; cv=none; b=mTVymAX9CQfbAzXDnT+gWaikotnDTGBTMA2FA7fb724nJdRGbmA+uG1Azv7FKShfmQ7135fSuz87W8pMOOT+9FH6XwB2hBNhqSh3gApyBkMkF3mFWuSO0yEzfHHbNr1vUViDiAPSnRrjuOLgLT+RRF4qmMW6GXV5D9X9ebC+9bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709745716; c=relaxed/simple;
	bh=wJSO9638b0C0bTkeAKGbBDFerfuAF+ha8QNh1SaDGgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQetdLaeXNx6QkAX4i+vgsLKD0iIn/l5waWoreArcI+2IkvRVmJmMHNVoXo9+k8YQRRiLQlDhJDyLC248rg2EA7Fx+Bn03Yz/g8RRnAzZ8C/6tG3XWOj/BZmTUyjPP8EOqkVAdCwOwvHaxb9TEsz/yNet8Ze3CDuDcl9UGhUAZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fRm7+o8X; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a44ad785a44so468566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 09:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709745712; x=1710350512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aZepAgoRBGZH9lV/EuYJdoD5pQyR7I1LHPo56Sgxp+s=;
        b=fRm7+o8X6luHbtIn0MekEH46F83uCtuC4tahRjMW97WTYDobyq0VtK4aZjq8I7yHyQ
         RY4NamcNIL/JQzT5MUreXbsXnmHxlRhYtpfyVpFuzeZSkCGW25/2BxNZ8aHDvy+mCcI4
         9sfJsde7Xkd0E/yyqgL9fe4NXLLXH8OyJRM6na/HtAFYOIhXXotyw1F2+wLN2udv/Zkw
         u1KwJpdBpLgqDVrPpJwKFh5RlguJsL5quhcuOFWwEVjeAeuZUiDqzkncunowgW2ZKCEm
         QJpugBmtKhmUwQvuvIsHs8yhXw9jKr3/G6ajey2h7HvC6mT3wZoc7C+ZTilEoqdWvRs+
         z3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709745712; x=1710350512;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aZepAgoRBGZH9lV/EuYJdoD5pQyR7I1LHPo56Sgxp+s=;
        b=GKe/huqEq90CRBHibrcbFnMp6RM5i4VbFwQZOYaQ5pSeOjaLMX1luEUeHVwXJRHXOT
         8AVhkGw6Suhkb9lMkzL/tGu7j2mAVfmrVn+mKnpb9hmNUfiVgn6emib9F4fJcsl6qNIv
         6wt1kUAT0g1hHyckoERUgcant/K3wZXCqLNvnMBvU42dchCdLPum85TmC1lwi2u+gSNJ
         t3fwJY6f0/ydghHlZXIQkLv1aNfUFmhwiFnGmCjxaTpKpusCFVrtMBQ7plSG21NTO05H
         hBKv+KExfs8iZjayL1vYKbroGeVfmfw8RXBrZZW+sdOIcI4W02EzMjk7vrOWsCcfApVn
         ePdA==
X-Forwarded-Encrypted: i=1; AJvYcCWHY4H2HqBbuRRgjsrtF2/tfjYQMb0T4WCpyRiILbk/fPmv77NlI+RvqTvcVWOBsWy4CoKUr7Ybf3iUGrJkubQCbhoeRpgwpF72B9CA
X-Gm-Message-State: AOJu0YxIqVDjQ7rgeAOJjtz3zMXYYQqQOYbxToGdzmoYoYHx1vObTrtB
	s08J7V6Qw5GK4k9RC/7jA6cnHsKlgEKD/bn2dSmIiKFDJmD3D4oyDmRDGefM4ME=
X-Google-Smtp-Source: AGHT+IG5Ek2K8BgwD0/SVHizIWQQJr+PjUabNHq1xlLEvApHUtlN0BPvjHeIrpzAR3rfE2HBylF2Og==
X-Received: by 2002:a17:906:37d6:b0:a45:f05:7e10 with SMTP id o22-20020a17090637d600b00a450f057e10mr8072132ejc.24.1709745711674;
        Wed, 06 Mar 2024 09:21:51 -0800 (PST)
Received: from ?IPV6:2001:a61:1366:6801:b2db:904d:e0b0:46ec? ([2001:a61:1366:6801:b2db:904d:e0b0:46ec])
        by smtp.gmail.com with ESMTPSA id fw17-20020a170906c95100b00a4576dd5a8csm2978506ejb.201.2024.03.06.09.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 09:21:51 -0800 (PST)
Message-ID: <b836152b-72a6-4815-a4d0-ee4956331a8d@suse.com>
Date: Wed, 6 Mar 2024 18:21:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: usbnet: Remove generic .ndo_get_stats64
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, Oliver Neukum <oneukum@suse.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 dsahern@kernel.org,
 "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>
References: <20240306142643.2429409-1-leitao@debian.org>
 <20240306142643.2429409-2-leitao@debian.org>
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20240306142643.2429409-2-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06.03.24 15:26, Breno Leitao wrote:
> Commit 3e2f544dd8a33 ("net: get stats64 if device if driver is
> configured") moved the callback to dev_get_tstats64() to net core, so,
> unless the driver is doing some custom stats collection, it does not
> need to set .ndo_get_stats64.
> 
> Since this driver is now relying in NETDEV_PCPU_STAT_TSTATS, then, it
> doesn't need to set the dev_get_tstats64() generic .ndo_get_stats64
> function pointer.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Oliver Neukum <oneukum@suse.com>

