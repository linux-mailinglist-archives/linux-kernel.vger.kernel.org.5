Return-Path: <linux-kernel+bounces-126320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E52893531
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04365B26434
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B10E1465A2;
	Sun, 31 Mar 2024 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QhtcaSDW"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA252145FF4
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711904606; cv=none; b=cNN4KtRfqf07xbUWORruLYKUYCjLRceKpOJ4iSsX4Phczr9ZiOgTBukxI/vqfFJPs8PqgMZxrWM7L6b6Dk2Iyq17oqEVMlsKk4zwTWiI5Dch/bNwExL8G3TrEZkDX+ctJmAhJifbi/bit1dYiWvSGVPk6wi4QnP+ya9Ci1ylXik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711904606; c=relaxed/simple;
	bh=5HEKTAEcMZpIQzdxLBhC6r70+TY5nEFPngXSLpbCCms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8kvslG0UGoMt/fluPbsXMetDTwYGC3APE6HE4xZTGfQzml6DwWqolKM1hmAXWcjVCmsys0IHSdJV5hPztLxkDOTVbgMygxYyGeTz3X0TWZHhNhhOcP+yDh+376XGgUAr2Hc8rtc6rnUdF4Agl5s9+kpifHbM/n9XPHViocCqx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QhtcaSDW; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-415612da358so3156885e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 10:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1711904602; x=1712509402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3uwWnHPVpblUNndWNcz6VpnPUH+KrUQEUI99rXTfFq8=;
        b=QhtcaSDWK1toHcsaFm/le3n317/jOqZS/3/MHqJRHTCRd62ku5cJltF9QH7WfKo+eo
         HDUuMjyHm4hmHAPjB0UGjOesqcghL/UY8zDSBw25qj5Fe8QEqJ9dG92W4dRuZZInEexu
         B1a7yV/+2obvX5zDBYfqzQ4AidjLmJPId8IMRsg94dApMkjlk05CrO8xKDrzRfb6fFYC
         Y45ZdZHfdnFyP9ye6Be2SRwOzL0qq9ZjtrxE2w+lgoPgU/u4GlyL3Tn8Qx2xLQl1T4TF
         VwXKpoKgGY3aKFNxeIi7y9yYRmRRU1o2Ntv/0sD9uY3XNgMsae6eP4yqpNw2/o2xhjod
         Slcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711904602; x=1712509402;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3uwWnHPVpblUNndWNcz6VpnPUH+KrUQEUI99rXTfFq8=;
        b=iWgrLaoCKKXGvr5ZQ+5uw1YtqBd0uhv7va933SSbDV3TeEuIytREzrKuspJP6cGfUU
         n+H9tOPjQ8vKTAgO0px8UITTE0d+fWd4b077RTtG4K3Wq7dWAN9FU1nDthECKfBSOljl
         KLWCGNowPeymjwrivB602d0ZNpV7e9rVsZP0TlcTX1L982Zup7i3XDCVNo1s76SWWMk8
         FCO6WK0A+7iw8gnCVnMgKahZBy4jD5VQBL0k+PUnSgiLTZf57eQ/wlYtMd6KErDE+0dw
         GHokNS8apYtNV6NVz5KlM+D9ZP93ZWfRsyzEKL33bDk2KmelUeYaTbBkSkSvqBrZB3LW
         oZhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRRveeZ6uIZy91bbuEqjoZ4LUtKk0wzB49jZ53uM4JrRSo1+hWLJEXMVnowNwFUNPh3Gzi/dNMjxlD3WV4tua8vvBwFF+yEHCQXCsV
X-Gm-Message-State: AOJu0YyaSXJJC10uRFMlX3xNvU/t3C5Orj2z95TJ0FHNdfyyWJFAvH6H
	RBXXV+pjGg/ujo8N7HCOOAp09XwEGkg8B0xG/m7sSQ6Jfcqrbf7hRvY6VdnUgvM=
X-Google-Smtp-Source: AGHT+IG2JDa1xRHcEDZbv+eTvKj5g66Ts2hqoZlYumJbpfHyjM2ZtfG17xOyZVT224cpD6eBDJCAgg==
X-Received: by 2002:a05:600c:3502:b0:414:222:ad5e with SMTP id h2-20020a05600c350200b004140222ad5emr5730504wmq.11.1711904602142;
        Sun, 31 Mar 2024 10:03:22 -0700 (PDT)
Received: from ?IPV6:2001:a61:1366:6801:7ce4:a9a1:7f22:a638? ([2001:a61:1366:6801:7ce4:a9a1:7f22:a638])
        by smtp.gmail.com with ESMTPSA id d11-20020a05600c34cb00b004156497e973sm1098064wmq.9.2024.03.31.10.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Mar 2024 10:03:21 -0700 (PDT)
Message-ID: <cce06da2-8e98-4b51-b363-bf3e368e49ef@suse.com>
Date: Sun, 31 Mar 2024 19:03:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] usbnet: fix cyclical race on disconnect with
 work queue
To: Sai Krishna Gajula <saikrishnag@marvell.com>,
 Oliver Neukum <oneukum@suse.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "syzbot+9665bf55b1c828bbcd8a@syzkaller.appspotmail.com"
 <syzbot+9665bf55b1c828bbcd8a@syzkaller.appspotmail.com>
References: <20240321124758.6302-1-oneukum@suse.com>
 <SA1PR18MB470955BBB332D3A9F9A6F247A0312@SA1PR18MB4709.namprd18.prod.outlook.com>
 <04cfa214-4d45-48b1-87ba-500e3e501977@suse.com>
 <BY3PR18MB47078BF3C2AC43AF71D068F9A0382@BY3PR18MB4707.namprd18.prod.outlook.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <BY3PR18MB47078BF3C2AC43AF71D068F9A0382@BY3PR18MB4707.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 31.03.24 14:07, Sai Krishna Gajula wrote:
>>>> --- a/drivers/net/usb/usbnet.c
>>>> +++ b/drivers/net/usb/usbnet.c
>>>> @@ -467,10 +467,12 @@ static enum skb_state defer_bh(struct usbnet
>>>> *dev, struct sk_buff *skb,  void usbnet_defer_kevent (struct usbnet
>>>> *dev, int work)
>>>
>>> space prohibited between function name and open parenthesis '('
>>
>> I am sorry, but this is the context of the diff. You are not suggesting to mix
>> gratitious format changes into a bug fix, are you?
> 
> Checkpatch does a primary check and triggered warning if we use space between fn name and '('.  It is advisable to follow the upstreaming process steps(clean checkpatch output) to have uniformity across patches. Also check comments from Gregkh bot regarding this patch.

Hi,

at the risk of repeating myself:

This is a very old driver written long before these conventions.
I did not introduce these spaces. Nevertheless, a format change
has no place in a bug fix.

	Regards
		Oliver


