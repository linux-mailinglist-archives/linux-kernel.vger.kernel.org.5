Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62495800242
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 04:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377237AbjLADsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 22:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjLADsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 22:48:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B169D1715
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 19:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701402523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/3AzxV0WgKZTUkZI9KNfIOtjrPxu2v3xdf2PUplwrRY=;
        b=fAmVaU1qLwGmSYFnif6OOQLTppkStrvz9HlB+dDY0FVN1DzUGN+rfk46fdUGhOZdsm6aua
        9gfLBi9A2KYYXO1BbDLJqa5HDkp3kveq3OY5y0t9TU2FgeFuTSJLEy7G6ApGvCp0bCsnVR
        OpifonJc6p5VOu46qy/dSkGbMDIIas4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-_7CGGDx0P9ehnCLXGoiDbw-1; Thu, 30 Nov 2023 22:48:42 -0500
X-MC-Unique: _7CGGDx0P9ehnCLXGoiDbw-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1d04ce0214dso1635105ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 19:48:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701402521; x=1702007321;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3AzxV0WgKZTUkZI9KNfIOtjrPxu2v3xdf2PUplwrRY=;
        b=CLR4Aak2bGIKNsshUO70R47c5StDjqFKNllop71HVv2NZnvv3FdJxhmP7DyZnDTKFL
         hj2KX+6Wzs4mSrhtzn9G/8w2aLMPVpsGyY0lhwm6OqxWNy0WCbfXsfqBHe3gzgExeNh1
         BXOI9PEevxcRh2DT+8An6d2Jq5PPow6pGYj7O/upJ2ROjKPHPnb+4O6zTHYwlFknvXSr
         0NOflvNcbtiZyQ8KbmKqW3nX6x2dKD6QAENdD6UjXxFV/zlRZ4gZuv/0yWw9zEBl2Q7f
         qDsp8+QxXYwo1DnZPnXXyCdoxdxuiQGHy0BZmsscENIUR72zLZdb+1OSufkPSbDWG/Ql
         ltCg==
X-Gm-Message-State: AOJu0YxFsH/8Hd/VqPLc+zhygLit8r8fs9AJQ7XQBV8YNhhn6pDleIBy
        ekDuhWD9I0f6+efeD4O6V9G2xDv0y2h3rmBF3t2lvpfXj9ggqK7AEAKAkbaEP64CpWY8RMktc9t
        /7/AFKRQPmTDjgYO4HkjTh59z
X-Received: by 2002:a17:903:22cc:b0:1d0:1c45:fca6 with SMTP id y12-20020a17090322cc00b001d01c45fca6mr8848386plg.55.1701402521009;
        Thu, 30 Nov 2023 19:48:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPJHgKJ9VKrBg6ysMgalrHEAISDmXhJQ0ZqsSvXKSLoKD01csDbzaLvkOj/ql3EV9F3wt2Rw==
X-Received: by 2002:a17:903:22cc:b0:1d0:1c45:fca6 with SMTP id y12-20020a17090322cc00b001d01c45fca6mr8848375plg.55.1701402520729;
        Thu, 30 Nov 2023 19:48:40 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902e74500b001cfc1a593f7sm2185691plf.217.2023.11.30.19.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 19:48:40 -0800 (PST)
Message-ID: <86e58855-c5c9-42d0-b983-bf36a8b9b2b0@redhat.com>
Date:   Fri, 1 Dec 2023 14:48:33 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/21] drivers: base: Move cpu_dev_init() after
 node_dev_init()
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
References: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
 <E1r5R3R-00CszO-C0@rmk-PC.armlinux.org.uk>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r5R3R-00CszO-C0@rmk-PC.armlinux.org.uk>
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

On 11/22/23 00:44, Russell King (Oracle) wrote:
> From: James Morse <james.morse@arm.com>
> 
> NUMA systems require the node descriptions to be ready before CPUs are
> registered. This is so that the node symlinks can be created in sysfs.
> 
> Currently no NUMA platform uses GENERIC_CPU_DEVICES, meaning that CPUs
> are registered by arch code, instead of cpu_dev_init().
> 
> Move cpu_dev_init() after node_dev_init() so that NUMA architectures
> can use GENERIC_CPU_DEVICES.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Note: Jonathan's comment still needs addressing - see
>    https://lore.kernel.org/r/20230914121612.00006ac7@Huawei.com
> ---
>   drivers/base/init.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

