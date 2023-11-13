Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000997E9386
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 01:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjKMAMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 19:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjKMAMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 19:12:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB0D1FD7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 16:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699834313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UQiJJ/dxNEHd77f2PC0oaN2B9+v5Hs6KtuITs8AqQVc=;
        b=XCXMkA5QOB0SBJCrwFOA7lVQxltMIBDSjs7jIsXedmQuofdQWUtIZ9ikOs3jAVZ2aDmDSk
        2rBOsrF/wDFq/DXq8lfzWT9nAzjusb9F/vQfsgK8yZzK8HJsrPQcLjyx2UJUwliD5GIWNX
        qJFOwcRalWgqYeM61if0BTvFpaSaY3M=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-GPqZLz8IOHG_dsVdhNaF1w-1; Sun, 12 Nov 2023 19:11:52 -0500
X-MC-Unique: GPqZLz8IOHG_dsVdhNaF1w-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cc274dbbc6so45122385ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 16:11:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699834311; x=1700439111;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UQiJJ/dxNEHd77f2PC0oaN2B9+v5Hs6KtuITs8AqQVc=;
        b=j0N1ZZEBFc/oeTXcGFW4Pr/bmmlKWT2HXuk1jqPlqhnz+KdOdhO6VApN0/X29HGopa
         hGsbnZddpA57fIrqX0S52T4YreCRp7XUdDWN2cZ4Arrc9MlQMLnke3iUpbvC5pNQj4T9
         +8+wfl8pPnPCjSpkoFLxGNZAdH2FdeMqOrhm38jxn/zd/XrsHf6yzmgvzzzGJrZTeNfV
         hv2Eq7qfF9zWA0z0SJvkP7efmZTFxqo22/eyeq8EcPPCc0QXNm/CRub21jxTB6ec0qpY
         uO5H/MDowM5PyWX/PilKW/LSbGkpxc8qgEYIGDTPrnH6k+ClilMX4Ju4sUGhMJGOSL4b
         wE3g==
X-Gm-Message-State: AOJu0YzWBpNCQ6R3/tTqyqQS17Wg0Ijpnr1FYUy9uJ9JubMNtclBmNfT
        wGSM1iofJIIcezby5EziwzdwwSZjMTnF75Oj+cXFNP4rm+oktqaOg8wi4zisTMabJJ1Gju5LGXa
        lVK1xQs36qHbG3P2kGuM1bRNs
X-Received: by 2002:a17:902:eecd:b0:1c3:4b24:d89d with SMTP id h13-20020a170902eecd00b001c34b24d89dmr6067392plb.40.1699834311417;
        Sun, 12 Nov 2023 16:11:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdqJareZ27x0vWYdkv//f/HJqmqCsdd3lWu5y3OyZlPyNdejWbYRbuSoSv157Xo1Ur4thQ4Q==
X-Received: by 2002:a17:902:eecd:b0:1c3:4b24:d89d with SMTP id h13-20020a170902eecd00b001c34b24d89dmr6067370plb.40.1699834311176;
        Sun, 12 Nov 2023 16:11:51 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id m16-20020a170902db1000b001c9b8f76a89sm3022112plx.82.2023.11.12.16.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 16:11:50 -0800 (PST)
Message-ID: <fffd8a37-bb23-4c76-aec7-aec2f1361817@redhat.com>
Date:   Mon, 13 Nov 2023 10:11:42 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 04/22] Loongarch: remove arch_*register_cpu() exports
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
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JL0-00CTwm-VX@rmk-PC.armlinux.org.uk>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JL0-00CTwm-VX@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/23 20:29, Russell King (Oracle) wrote:
> arch_register_cpu() and arch_unregister_cpu() are not used by anything
> that can be a module - they are used by drivers/base/cpu.c and
> drivers/acpi/acpi_processor.c, neither of which can be a module.
> 
> Remove the exports.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>   arch/loongarch/kernel/topology.c | 2 --
>   1 file changed, 2 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

