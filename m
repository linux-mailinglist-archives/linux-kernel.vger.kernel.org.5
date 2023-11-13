Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2F47E95DB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 05:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbjKMEFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 23:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbjKMEF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 23:05:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F02173E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 20:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699848284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tws2IAPG/pAuM74CEbXNr6MwlBLqAXS5OKA1cYLHSOM=;
        b=gKTgeOFNfraf444v85mYjNzi6usPb90nRId2v1OdGnZhfCmRiadIWTYlI894C7gqd0J1zS
        teEpXc0U8t5amj8Z/k5ED1COKpf/UFw+7+I9j35gz4SdxpR8hDfVTg8cvMkni7Api6Vypx
        UVSY5Mi6cdpeilcd54jQzw95nT6floc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-O4fBtmpnM56Y5bRgJXcdeg-1; Sun, 12 Nov 2023 23:04:43 -0500
X-MC-Unique: O4fBtmpnM56Y5bRgJXcdeg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cc2786a8ebso54604185ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 20:04:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699848282; x=1700453082;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tws2IAPG/pAuM74CEbXNr6MwlBLqAXS5OKA1cYLHSOM=;
        b=tdEPBI7ekWG4Yg9cgtrJiPk+tsPeoJHc/VO02mQrW+1Yc7le8M3MS+hluLQgru2ruE
         r8ZBaWQgs3xAXgP1I41qCabV7VlotEfDPnfX4v7bbm1jJ7SFbh8ZBhMrTtkiGDYZHfJq
         S/RQAe8VZ2HNAZDvlgrRk5fPp4RPMeoQKsISEvYXcDkWTN3k4nZHXiiGVdFzdHpwYXOr
         U1bl2f5iZ/QefmlYvzAO7hmZwcHTwt7nSyFJ0adLNlPtnAMJIuEtITzoB43CTIiblwEB
         9Of0v9f2FRTFQ25OlMPotVVrGViOsFyyvEp6zjwL+rLamliSnipnK7BrAvTq8n50hMaa
         a/9w==
X-Gm-Message-State: AOJu0YwsY4NFyQA6X0KTYG6vG6iLb2aEEbpYbMF72dAn5SrzSgOi1Thr
        iMo5kCEhAjkcqlsw+MGcWkZEWIPKhZLx8O4FUzo3cc6LtOLXJwp2bQreSXMx5Emu5Qd1VH1Jy7z
        2nC37gdHsrLaEapeGPsIkNzSBHQ4h2eK/
X-Received: by 2002:a17:902:c40d:b0:1b0:f8:9b2d with SMTP id k13-20020a170902c40d00b001b000f89b2dmr6899001plk.29.1699848281707;
        Sun, 12 Nov 2023 20:04:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYR2VwJDEptBEIbrqjgd8Zx/CSzLVMmBQUVzyl+4ab4Yq5iFKzjqaERsoMDmohw8xGXwqYvw==
X-Received: by 2002:a17:902:c40d:b0:1b0:f8:9b2d with SMTP id k13-20020a170902c40d00b001b000f89b2dmr6898988plk.29.1699848281368;
        Sun, 12 Nov 2023 20:04:41 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902eb4600b001c61073b076sm3230467pli.144.2023.11.12.20.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 20:04:41 -0800 (PST)
Message-ID: <955f2b95-76e4-4e68-830b-e6dd9f122dc1@redhat.com>
Date:   Mon, 13 Nov 2023 14:04:32 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 11/22] drivers: base: remove unnecessary call to
 register_cpu_under_node()
Content-Language: en-US
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, linux-csky@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org
Cc:     Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        James Morse <james.morse@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JLa-00CTxY-Uv@rmk-PC.armlinux.org.uk>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JLa-00CTxY-Uv@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/23 20:30, Russell King (Oracle) wrote:
> Since "drivers: base: Move cpu_dev_init() after node_dev_init()", we
> can remove some redundant code.
> 
> node_dev_init() will walk through the nodes calling register_one_node()
> on each. This will trickle down to __register_one_node() which walks
> all present CPUs, calling register_cpu_under_node() on each.
> 
> register_cpu_under_node() will call get_cpu_device(cpu) for each, which
> will return NULL until the CPU is registered using register_cpu(). This
> now happens _after_ node_dev_init().
> 
> Therefore, calling register_cpu_under_node() from __register_one_node()
> becomes a no-op, and can be removed.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>   drivers/base/node.c | 7 -------
>   1 file changed, 7 deletions(-)
> 

__register_one_node() can be called in memory hot add path either. In that path,
a new NUMA node can be presented and becomes online. Does this become a problem
after the logic of associating CPU with newly added NUMA node?

Thanks,
Gavin

> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 493d533f8375..4d5ac7cf8757 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -867,7 +867,6 @@ void register_memory_blocks_under_node(int nid, unsigned long start_pfn,
>   int __register_one_node(int nid)
>   {
>   	int error;
> -	int cpu;
>   
>   	node_devices[nid] = kzalloc(sizeof(struct node), GFP_KERNEL);
>   	if (!node_devices[nid])
> @@ -875,12 +874,6 @@ int __register_one_node(int nid)
>   
>   	error = register_node(node_devices[nid], nid);
>   
> -	/* link cpu under this node */
> -	for_each_present_cpu(cpu) {
> -		if (cpu_to_node(cpu) == nid)
> -			register_cpu_under_node(cpu, nid);
> -	}
> -
>   	INIT_LIST_HEAD(&node_devices[nid]->access_list);
>   	node_init_caches(nid);
>   

