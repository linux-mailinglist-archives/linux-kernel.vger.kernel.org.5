Return-Path: <linux-kernel+bounces-149076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9478A8B83
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2119F288519
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0EF1D540;
	Wed, 17 Apr 2024 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eNfBF/50"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33A414293
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713379719; cv=none; b=gM7OL95BVsJ53PeGeSNIEMsJxkGzSV6BgQhTCAos0cgjHENqRnrRtcH2DB58Fn7E0avbJ08jAgN8fN3O2Xq+J1Gmdk+cImQ3M4T9/IyqpzYPVKraFB28w1X0CQWLk9XHTg2SqGrMz1L0src7K8CmY5e6tHT6Aul4SDts83vfD2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713379719; c=relaxed/simple;
	bh=33GJmAw2sDbSkSFFJt4hPyK+PJzNLkYwFXEl5cuBGEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QtVLY61oxIM4RJp9AARYJ8UNhyU6T8H0n8MWncwo87CEiGoJOmsowpet3b6ZBaJjPlejucgujkSUt7ZmWAWRTbLAZg8yCe5bIu0bHw7U+oXN0ZzJG/tsXLjbTiCaMB1IVeoml62LZGHxnlPG3YPxAgLJPUgpA2+YYXdl4w+qISs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eNfBF/50; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78f05b62602so2919285a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1713379717; x=1713984517; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1YI/gaWZgcT3i+u9R9mtNtjXf8HFM3Ko9WyaTG2B/WM=;
        b=eNfBF/50QLpE8zhmyG2X8iZYMpVEmYm8Rv3NXdhDenT97lBgEcjiDrarUvDnc1+jvD
         tJzIB1DclrolNTQpx7O7OkLXQAJi7ouKU7qhoMhgK6ptCUcRpDK7H6asJe+6KbhVSmWL
         zd0vzJ7X4/dydsxi+FrTCYwuPbYyQtFdMmFzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713379717; x=1713984517;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YI/gaWZgcT3i+u9R9mtNtjXf8HFM3Ko9WyaTG2B/WM=;
        b=XweF8BDm6jKsOG37/lP7ko8ib8cf21GW17eMk8ulkzIqcmlMkZTLGBAkD/MXxwLnXo
         zSAco3CWUA5dwM8DycQlRpMAsioaI4jQe+zY1035SSCBDXvbeDOCDxtLDezPRMybCRqA
         EAd4j6qBSLBc5PIRaDdWpNT9uWmvIj1XT+vjLjSb5PBZilxSmq2F+yvuQ+9WWArDh5zt
         08io4BiRoBDXYLyigVYz31jWKazC8PZhXLHxcmDcVg6wlzs+T7mmUesv7yvCIMhG7spG
         LOywgmMfbbC77Thhu0e5GqRT4WI7e1b6pk9HGxX6XU6w9sZp9Kg1T+12jlqEp2Rpq/42
         QG3g==
X-Forwarded-Encrypted: i=1; AJvYcCVG/bjXU0c1Foi5C6+duPs9VMWQ8/fuwd98qYd6zYpYratGQNO1B8yn68jiW3BGA6RfG0Mq5nf0TaoWNMKEH4HivLlG5Tbio4e8OSc8
X-Gm-Message-State: AOJu0YyQqGKPzp6nATwyfra7MqdsgcCuU/1KknYkstLETtDXtlphmNmW
	pnsYLVVFm0Ap9JtN3JyQjVJ4qrl1f7hM3sVG3Qyx/Lr7/5fRv6RHIutExybVrw==
X-Google-Smtp-Source: AGHT+IGn1Jwr0Evu14XvWEswhigSmBEwgPjXg6zaGdTvkjzAnsmOn7efor1EG+cGwVcnAt40UCUPww==
X-Received: by 2002:a05:620a:4009:b0:78d:5c65:dc69 with SMTP id h9-20020a05620a400900b0078d5c65dc69mr303097qko.33.1713379716707;
        Wed, 17 Apr 2024 11:48:36 -0700 (PDT)
Received: from [10.69.74.12] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f9-20020a05620a15a900b0078d6b42ca02sm8661713qkk.120.2024.04.17.11.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 11:48:35 -0700 (PDT)
Message-ID: <1f3131a4-fa84-4d25-8c1a-ab0023aace23@broadcom.com>
Date: Wed, 17 Apr 2024 11:48:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bcmasp: fix memory leak when bringing down if
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Simon Horman <horms@kernel.org>, Markus Elfring <Markus.Elfring@web.de>
Cc: bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20240412181631.3488324-1-justin.chen@broadcom.com>
 <6881c322-8fbb-422f-bdbb-392a83d0b326@web.de>
 <9afad2b3-38a5-470d-a66f-10aa2cba3bab@broadcom.com>
 <8ae97386-876f-45cf-9e82-af082d8ea338@web.de>
 <20240417161933.GA2320920@kernel.org>
 <3a5cb80e-7169-4e82-b10c-843ff1eb0fd3@broadcom.com>
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <3a5cb80e-7169-4e82-b10c-843ff1eb0fd3@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000067022f06164f4d18"

--00000000000067022f06164f4d18
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/17/24 9:52 AM, Florian Fainelli wrote:
> On 4/17/24 09:19, Simon Horman wrote:
>> On Mon, Apr 15, 2024 at 09:46:44PM +0200, Markus Elfring wrote:
>>>>>> When bringing down the TX rings we flush the rings but forget to
>>>>>> reclaimed the flushed packets. This lead to a memory leak since we
>>>>>> do not free the dma mapped buffers. …
>>>>>
>>>>> I find this change description improvable.
>>>>>
>>>>> * How do you think about to avoid typos?
>>>>>
>>>>> * Would another imperative wording be more desirable?
>>>>
>>>> The change description makes sense to me. Can you be a bit more 
>>>> specific as to what isn't clear here?
>>>
>>> Spelling suggestions:
>>> + … forget to reclaim …
>>> + … This leads to …
>>
>> Markus, let's cut to the chase.
>>
>> What portion of your responses of this thread were produced
>> by an LLM or similar technology?
>>
>> The suggestions in your second email are correct.
>> But, ironically, your first response appears to be grammatically 
>> incorrect.
>>
>> Specifically:
>>
>> * What does "improvable" mean in this context?
> 
> I read it as "improbable", but this patch came out of an actual bug 
> report we had internally and code inspection revealed the leaks being 
> plugged by this patch.
> 
>> * "How do you think about to avoid typos?"
>>    is, in my opinion, grammatically incorrect.
>>    And, FWIW, I see no typos.
> 
> There was one, "This lead to a memory leak" -> "This leads to a memory 
> leak"
> 
>> * "Would another imperative wording be more desirable?"
>>    is, in my opinion, also grammatically incorrect.
>>
>> And yet your comment is ostensibly about grammar.
>> I'm sorry, but this strikes me as absurd.
> 
> Yeah, I share that too, if you are to nitpick on every single word 
> someone wrote in a commit message, your responses better be squeaky 
> clean such that Shakespeare himself would be proud of you.
> 
> There is a track record of what people might consider bike shedding, 
> others might consider useless, and others might find uber pedantic 
> comments from Markus done under his other email address: 
> elfring@users.sourceforge.net.
> 
> Me personally, I read his comments and apply my own judgement as to 
> whether they justify spinning a new patch just to address the feedback 
> given. He has not landed on my ignore filter, but of course that can 
> change at a moments notice.

I try my best to address feedback. After a bit of thought, I feel the 
feedback given was not out of good faith. I would like to keep the patch 
as-is unless someone else has feedback. That is if the maintainers are 
ok with that.

Thanks,
Justin


--00000000000067022f06164f4d18
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
NhTY3E+cXCB11wty89QStajwXdhGJTYEvUgvsq1h8CwJj9w/38ldAQf5WjhPmApYeJR2ewFrBMCM
4lHkdRJ6TDc9nXoEkypUfjJkJHe7Eal06tosh6JpAgMBAAGjggHZMIIB1TAOBgNVHQ8BAf8EBAMC
BaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGG
NWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0G
A1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxz
aWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3JsMCMGA1UdEQQc
MBqBGGp1c3Rpbi5jaGVuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSME
GDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUIWGeYuaTsnIada5Xx8TR3cheUbgw
DQYJKoZIhvcNAQELBQADggEBAHNQlMqQOFYPYFO71A+8t+qWMmtOdd2iGswSOvpSZ/pmGlfw8ZvY
dRTkl27m37la84AxRkiVMes14JyOZJoMh/g7fbgPlU14eBc6WQWkIA6AmNkduFWTr1pRezkjpeo6
xVmdBLM4VY1TFDYj7S8H2adPuypd62uHMY/MZi+BIUys4uAFA+N3NuUBNjcVZXYPplYxxKEuIFq6
sDL+OV16G+F9CkNMN3txsym8Nnx5WAYZb6+rBUIhMGz70V05xsHQfzvo2s7f0J1tJ5BoRlPPhL0h
VOnWA3h71u9TfSsv+PXVm3P21TfOS2uc1hbzEqyENCP4i5XQ0rv0TmPW42GZ0o4xggJtMIICaQIB
ATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhH
bG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwj8BKLXNpALfemdRAwDQYJ
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIA1XCLNyC+Wb8rPqSYv0kzDh8RqCQtuCbuK1
cpVZW1E2MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQxNzE4
NDgzN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQBO/6B7PupZFCyLoyaQoT8MyS9USUnVvhmvqHIQeJ0YZi91+Y7FkQC/
EAwEhxTkfLv4ESp1wgejHsJZLnFFgmxgJrjHXKwiyOZS4OjJRj8WX81BgD0qx9SUdPxN6/K5VQCA
Z8+U0eLavKCBZ2JrK/1irbxluMaOzH2I2M7LPVXygXsEsUsr09BC5dFQcHd414rQzWUoOhyZX3ev
Ar4LiapgrbTReWwfXwEUX7SICVaf2ZWo7DJB42OKRjw4/6mpny0evs8DYOyn/TiAOHonwjcVYTgx
llIiLnF7XTYIm+88hFF5WTdrXE5x9psBEKLgklR2qK5BZamw52ZrJa2w5mO/
--00000000000067022f06164f4d18--

