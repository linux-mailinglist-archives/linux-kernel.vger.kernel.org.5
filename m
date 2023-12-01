Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2280380023B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 04:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377217AbjLADr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 22:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbjLADrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 22:47:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AAE1724
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 19:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701402481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lkYkgQb1oSonM5Ah318XDYvX5RNZmhN/5LooxGJ95vQ=;
        b=W8b8xMzqUkxOrqytylop2P45XZpFjvsavV5pZXo+tGWZbO9elj9KP6uJYne8jUIExklptg
        u6ww96604We+YyRgjyBXFBhxAJsfo0CKdg8IrtDpcONUpMnHCCUGkz0LpWYqnlFdyW02Bv
        SGE3hrPWZgKRYdTLnVWafXUopmHJa1s=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-l4ag8GICO5GKvd0qSJW2Iw-1; Thu, 30 Nov 2023 22:47:58 -0500
X-MC-Unique: l4ag8GICO5GKvd0qSJW2Iw-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6cdfbba2c4dso678990b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 19:47:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701402478; x=1702007278;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lkYkgQb1oSonM5Ah318XDYvX5RNZmhN/5LooxGJ95vQ=;
        b=FuyKB5lmIsKsnDStrawGgWYqDP9qInj6RXOnBKbHujtUiUmVS2Zg4z800fXFo0wN1Q
         XFaXsPVV1axMtnhcAXcs5aGXq4pXyBAyLubJHyafzgxY+1kPNdZp6vSoPy0EuQwlWYub
         q7wcqhEDVAirL2U1MKBmmrYLkHFP0vcVRwbOtugUdbb8900T9MzcUnydfnKHVUFF5+m6
         UmYZDy2tS3kqXf+3FwyTIzEoe2gAQuvx4bYCwzgzLtLQUHHztHOTiIs9/CF7opesWupG
         gF2P1kjXN3AAY/PJPSZMfTRd1yJcReMarBicuRKGQIeOb+vQ8Y3MwOJntKS0eRN5T730
         cDvQ==
X-Gm-Message-State: AOJu0YxmwUoV2OR1TQ2/sgqCGihy8pwWAI90tTQNDayLHVbXQdU12TE3
        N11Neoue2MT1BtQf9CVOkUVWeNXZNFo3l4KLJcOey79sWQ3biPrq/C6zzpFM3+FtYWvo3qgrOxH
        ogxnYfGIfn2LMbb4U0Xi1uTY3
X-Received: by 2002:a05:6a21:3513:b0:18b:236d:3f0 with SMTP id zc19-20020a056a21351300b0018b236d03f0mr27000773pzb.43.1701402477953;
        Thu, 30 Nov 2023 19:47:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhKtgcw5NHksOzMAUau0Dc/qB+PpJdNsaezOVmfl0zRSeeAEUNdBUUxpUuWqCHC+jsRZjfoQ==
X-Received: by 2002:a05:6a21:3513:b0:18b:236d:3f0 with SMTP id zc19-20020a056a21351300b0018b236d03f0mr27000757pzb.43.1701402477684;
        Thu, 30 Nov 2023 19:47:57 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902e74500b001cfc1a593f7sm2185691plf.217.2023.11.30.19.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 19:47:57 -0800 (PST)
Message-ID: <c01d4958-1cf7-4428-9d97-f6a893f175ce@redhat.com>
Date:   Fri, 1 Dec 2023 14:47:49 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/21] drivers: base: add arch_cpu_is_hotpluggable()
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
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
References: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
 <E1r5R3M-00CszH-6r@rmk-PC.armlinux.org.uk>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r5R3M-00CszH-6r@rmk-PC.armlinux.org.uk>
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

On 11/22/23 00:44, Russell King (Oracle) wrote:
> The differences between architecture specific implementations of
> arch_register_cpu() are down to whether the CPU is hotpluggable or not.
> Rather than overriding the weak version of arch_register_cpu(), provide
> a function that can be used to provide this detail instead.
> 
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>   drivers/base/cpu.c  | 11 ++++++++++-
>   include/linux/cpu.h |  1 +
>   2 files changed, 11 insertions(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

