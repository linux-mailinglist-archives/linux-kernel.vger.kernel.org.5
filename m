Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11897E9371
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 01:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjKMAEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 19:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjKMAEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 19:04:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303CD1FE4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 16:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699833810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ZHIbA5dSDa0YFUBZZETUQKKTVizuf5JaF0jClraxRM=;
        b=d1f23R4z4J7igoUx6O4n+PBCHwLpONwfAsSnhIgC4GvGIowSKfk6qf6UxT80F9sjTYJzZu
        zcKuhjWoyb/e+4Y8YDWci5HlDbhlMNjvZNoNy2g4lJZj8ByT6vYo6XLB5znFJVYAcKpLM/
        yPWvUpsFCOLgfemle8hx1EqVVrxEumU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-jVCEYEFWNXWOuIId9on6dw-1; Sun, 12 Nov 2023 19:03:28 -0500
X-MC-Unique: jVCEYEFWNXWOuIId9on6dw-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cc1682607eso43531855ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 16:03:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699833808; x=1700438608;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZHIbA5dSDa0YFUBZZETUQKKTVizuf5JaF0jClraxRM=;
        b=oaGH+NKRU9NGkycViLLLBhz4F/Yiaa7BL6ADTx/u3zrX11mEvwNDNSYl9JmJUuxbEu
         B6e2p9ODwPqN1d6i4UJU57GVkKRBJPMeB5I5/UxFD+xnkuMitSuEcpPc1r2TzYzrF/oO
         VJNUnpnPgSZRxgaJU9ApCfsge7bWxz+a/Fghl4PHhDDjoLJeh3JmD3p4fNfnAqGpIQAt
         ssZlNZvYsM/V43Q21QN/JLsfJHf40CixoA3v27Lk0Q/ujdbPXJBfBq27FBEJTqIO2SM/
         ziumpQn3ga1gWJTiNCJabZ5tRRtrL4U9HHhmWkI2re7RUH2IEMu5U2Q8uOVEmmsxOZiK
         v2tg==
X-Gm-Message-State: AOJu0YwBt057nQCVfgYPiURfRet//I8f0MpsKqCaJ9KINUZCXrGjO4M0
        gs9PiqvFZtGZyEuUN6yUCK6DgrvEUPkEIqSp2VFeB50amz5Cr/hyYKgabJat0KIDr3HlOj8MLIu
        4pw3Rt0uURJfiSCHT5X9kPHG7
X-Received: by 2002:a17:903:124a:b0:1ca:7f91:aa5d with SMTP id u10-20020a170903124a00b001ca7f91aa5dmr7816446plh.16.1699833807797;
        Sun, 12 Nov 2023 16:03:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECTuRNfb72TOfAtkV7pMmjD+8xBNsdITfj8lqsTmhB+HwPaZ/5CGTlMF5gZ/CbtXGVZnzltA==
X-Received: by 2002:a17:903:124a:b0:1ca:7f91:aa5d with SMTP id u10-20020a170903124a00b001ca7f91aa5dmr7816433plh.16.1699833807525;
        Sun, 12 Nov 2023 16:03:27 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id jj3-20020a170903048300b001cc29ffcd96sm3038705plb.192.2023.11.12.16.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 16:03:27 -0800 (PST)
Message-ID: <e4f752f9-3c8c-4d96-8efd-d9dc157cc976@redhat.com>
Date:   Mon, 13 Nov 2023 10:03:17 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 02/22] x86: intel_epb: Don't rely on link order
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
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JKq-00CTwZ-Mh@rmk-PC.armlinux.org.uk>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JKq-00CTwZ-Mh@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/23 20:29, Russell King (Oracle) wrote:
> From: James Morse <james.morse@arm.com>
> 
> intel_epb_init() is called as a subsys_initcall() to register cpuhp
> callbacks. The callbacks make use of get_cpu_device() which will return
> NULL unless register_cpu() has been called. register_cpu() is called
> from topology_init(), which is also a subsys_initcall().
> 
> This is fragile. Moving the register_cpu() to a different
> subsys_initcall()  leads to a NULL dereference during boot.
> 
> Make intel_epb_init() a late_initcall(), user-space can't provide a
> policy before this point anyway.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> subsys_initcall_sync() would be an option, but moving the register_cpu()
> calls into ACPI also means adding a safety net for CPUs that are online
> but not described properly by firmware. This lives in subsys_initcall_sync().
> ---
>   arch/x86/kernel/cpu/intel_epb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

