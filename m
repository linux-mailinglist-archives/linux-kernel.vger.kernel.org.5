Return-Path: <linux-kernel+bounces-98812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0897877FC4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186AF1F214C2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E21F3BBF7;
	Mon, 11 Mar 2024 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G6z5Usrg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA32A3D0C4
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 12:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710159247; cv=none; b=Kevet9kaWDMkl+LGNARz6aeudMDYk/M66V2n3T7SXvUSEY9QFUVvxYhdymRWjorQdgHOQPzMqqwIITtqzPQWmhrs8iFTTfQzsHcC1kzCxAjuvYI+dK9JN6OOI+/gnEB/WRwmz5zfLntZinJkxSDSEQFkUNXAyT1VtqD1AqttqbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710159247; c=relaxed/simple;
	bh=6DJzFBMmWQ2NLvNGW+brmaV7Yw5oomBkwLgkECiTVek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZjF31zS2UWj+D6iKz7TIhFgI5FSald0iAWDl/wnx/lQBeRdJWMXyCABiRdp1wakpVuaSWJMaa6WBjR1699KVaVd6Tp4pjmE7RByByC+plkNbamFdOysuBuTrGNom7Kw8CYBSHncugeMTmT2JUO9Xb3OBf0TYtV5XBYivKVkXewI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G6z5Usrg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710159244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QzCDBPX0buczc9+Ev0ZIx0kEFDWZGrh6JBV3mqE9g0E=;
	b=G6z5UsrgFj34hZibvn/gWHqMMfpnVQXgmyIt9tD6L2oHh8FSgL5z2Fp6SmIalsYWVC4piT
	y+MkSkBLCDEsFFY/baTb0V1OvF7lG23EzctmNmhxdxE9wieVxYRIauTryCI/CzeprkS4J+
	p1VzW+04Q9GLtlQUIvSCnG8QyHBRCUo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-Iduwqt1zNGCOvLXINSwJug-1; Mon, 11 Mar 2024 08:14:03 -0400
X-MC-Unique: Iduwqt1zNGCOvLXINSwJug-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-42ef98ebb0cso86829651cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 05:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710159243; x=1710764043;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QzCDBPX0buczc9+Ev0ZIx0kEFDWZGrh6JBV3mqE9g0E=;
        b=UKEsCUR9vOHJQlC7QNUNjGdedinx8RDQQNZ9Kqy+uvDCzb1NAZoXU85AXIYtLNKBXt
         kcJTK5SbJOpk2BaOYGuPrztF5l8MPGUSIhAnGOr8Wku97/qRZUkHFGKWnjPvvtlDeA6N
         OubjUgBTROMj8nI9A3p8W5GbmC8IcZCw8sXI7rbzLmZmYYAFV1P55r0W+fyiO8D23bKX
         KBiHJlbp9g8cSw+MVXJgeiKPr5gcfuL25Gy9lfXbFvkxr5QJ7cZrKys9EWdWJRKDy7Mo
         GoPdAuigMspOnNeWr47/EeA8SF+jsfiW8v8b4B0rvbWpjU1rHPZmPa9ZKbgw/j8eIFW+
         tDJw==
X-Forwarded-Encrypted: i=1; AJvYcCV5M0wfsuNkW+8JltY9ugpLdHaIaxgZO1/eOBZRpt6hazdyxcKaKnoCwfahZzvXCtMVsu5dCouMYF9IQehd7B1tSlV2t6Y/OSSfIPnI
X-Gm-Message-State: AOJu0YzmSIjptg9GHVDJkdE82Rcn7PnA8cRWSMs4GuUAoeIRQIajT/ym
	rnNhLqdzZSOQ1CW2GomrNRokOImEtJtGralBtcutIBzy0OOK1gJzoflD82lAKdevXFXN2l+XaHl
	ykRAcANDGoSrvipk34xALYtB27tIVPv9HYzqXH8BzKT3miMvImWNJECJqvP2NAg==
X-Received: by 2002:a05:622a:104e:b0:42e:7e4d:9b68 with SMTP id f14-20020a05622a104e00b0042e7e4d9b68mr11922615qte.18.1710159242830;
        Mon, 11 Mar 2024 05:14:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaaEEHgfz/XGkgC7OM/cM+pyNBMFMcSUvA0K0p6X2MdL35CNbD+uol0uH63fcKe6BBChws2g==
X-Received: by 2002:a05:622a:104e:b0:42e:7e4d:9b68 with SMTP id f14-20020a05622a104e00b0042e7e4d9b68mr11922589qte.18.1710159242506;
        Mon, 11 Mar 2024 05:14:02 -0700 (PDT)
Received: from [10.16.200.42] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d11-20020ac85acb000000b0042f36f6f9edsm2537980qtd.9.2024.03.11.05.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 05:14:02 -0700 (PDT)
Message-ID: <7591f33e-d64f-49c5-b7c8-deda2b6f0fde@redhat.com>
Date: Mon, 11 Mar 2024 08:14:01 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2023-52605: ACPI: extlog: fix NULL pointer dereference check
Content-Language: en-US
To: Vegard Nossum <vegard.nossum@oracle.com>, cve@kernel.org,
 linux-kernel@vger.kernel.org, linux-cve-announce@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <2024030647-CVE-2023-52605-292a@gregkh>
 <e4906091-598e-4d21-9e8d-4cb088855d6f@oracle.com>
From: Prarit Bhargava <prarit@redhat.com>
In-Reply-To: <e4906091-598e-4d21-9e8d-4cb088855d6f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/10/24 04:10, Vegard Nossum wrote:
> 
> (Added author/maintainer to Cc)
> 
> On 06/03/2024 07:46, Greg Kroah-Hartman wrote:
>> Description
>> ===========
>>
>> In the Linux kernel, the following vulnerability has been resolved:
>>
>> ACPI: extlog: fix NULL pointer dereference check
>>
>> The gcc plugin -fanalyzer [1] tries to detect various
>> patterns of incorrect behaviour.  The tool reports:
>>
>> drivers/acpi/acpi_extlog.c: In function ‘extlog_exit’:
>> drivers/acpi/acpi_extlog.c:307:12: warning: check of ‘extlog_l1_addr’ 
>> for NULL after already dereferencing it [-Wanalyzer-deref-before-check]
>>      |
>>      |  306 |         ((struct extlog_l1_head *)extlog_l1_addr)->flags 
>> &= ~FLAG_OS_OPTIN;
>>      |      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>>      |      |                                                  |
>>      |      |                                                  (1) 
>> pointer ‘extlog_l1_addr’ is dereferenced here
>>      |  307 |         if (extlog_l1_addr)
>>      |      |            ~
>>      |      |            |
>>      |      |            (2) pointer ‘extlog_l1_addr’ is checked for 
>> NULL here but it was already dereferenced at (1)
>>      |
>>
>> Fix the NULL pointer dereference check in extlog_exit().
>>
>> The Linux kernel CVE team has assigned CVE-2023-52605 to this issue.
> 
> This code is in an __exit function:
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index e120a96e1eaee..193147769146e 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -303,9 +303,10 @@ err:
>   static void __exit extlog_exit(void)
>   {
>       mce_unregister_decode_chain(&extlog_mce_dec);
> -    ((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
> -    if (extlog_l1_addr)
> +    if (extlog_l1_addr) {
> +        ((struct extlog_l1_head *)extlog_l1_addr)->flags &= 
> ~FLAG_OS_OPTIN;
>           acpi_os_unmap_iomem(extlog_l1_addr, l1_size);
> +    }
>       if (elog_addr)
>           acpi_os_unmap_iomem(elog_addr, elog_size);
>       release_mem_region(elog_base, elog_size);
> 
> This can only run when you unload a module, which is a privileged
> operation (restricted to CAP_SYS_MODULE).
> 
> Moreover, extlog_l1_addr is only ever assigned in the corresponding
> module init function, and it looks like it will never be NULL if the
> module was loaded successfully, at least on a recent mainline kernel.
> 
> Since the module exit won't be called unless module init succeeded, I
> don't see a way to trigger this bug. Is this a vulnerability?
> 

This is certainly not a CVE.

> It might be better to just delete the NULL check altogether.
> 
> As usual, I could be wrong...
> 

When I made this code change I thought the same thing: Perhaps it's 
better to remove the NULL check given the status of the code.  I assumed 
that the check was there as a failsafe on unload.

P.

> 
> Vegard
> 


