Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81CE7E9380
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 01:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjKMAJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 19:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjKMAJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 19:09:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2960A258E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 16:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699834133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LZoVE59pXWGm0JQT+CMJNCgS+fu8REHYPUoz78JAFk8=;
        b=Qn4gWjNHcrEuRH4DStbrWmBp5aL5c4MNSCh8FasXLDJdhpieh/Z+RyyCy9cKi0emrSBGu9
        q1ppty/M+jGnw4rwHik2nssoQT3QdezOgAqYlMHxnkRApTIwqNo70v65Hwp1OcsvhDQXz6
        GvzmgLg27FNRjj0wES2jtiw0i3CJm2Y=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-59ntU2YJNQuPYilKW9BD-w-1; Sun, 12 Nov 2023 19:08:51 -0500
X-MC-Unique: 59ntU2YJNQuPYilKW9BD-w-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6c415e09b2cso3923442b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 16:08:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699834130; x=1700438930;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LZoVE59pXWGm0JQT+CMJNCgS+fu8REHYPUoz78JAFk8=;
        b=iviMXjvkT0V0f0TQ74ozexLT3Tm1EO7fNRIGn7zS44itUefjj3jWdnUHsNor6zu8AG
         3kautil5UU/K52Ma8FKxfndxMH+hrldKWX3DfE7YX9EGisfrvRXPhzGvpb1aeJFoLvkz
         vxVCOrv8qEFGnM0iq7l1RJqo4e2iHhLkjoVvT3CTThrXEws0xgmbz+guU8U3/h68uObI
         N5eweXdpWb1zH0W4Rf/3CKRT8y9l4NYvppJTy02Xlc8z1dH6ghiCR+N8JboO29xff42G
         t6sFTXaPLnTQW/XPa8N8ObzU5O8KseFZ3rnfpBPB57fqezyUyDwS8vBOlHs3HR6lVtQ+
         ASpQ==
X-Gm-Message-State: AOJu0YwGUDUfEjLhC4awVl60GIzx9xZshGMHGIuVp9RTgIw424ZusmBl
        VxA3BmGeg3kxfPpIeaGZhZLwtZPjEme3WkdeejT0Jmpe3zvEfeDDwICuaehfRDE1XWaIGVv9JNf
        xYH7Qpu1mA4a/vGocx8W9rU/MmF+efYd6
X-Received: by 2002:a05:6a20:748b:b0:186:603b:6b53 with SMTP id p11-20020a056a20748b00b00186603b6b53mr1091860pzd.0.1699834130297;
        Sun, 12 Nov 2023 16:08:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuXsyqcDEY3uU8V/1tkBaOM8ZFpVTqspPi9KzQF+bgKRFukH+13LuLcTE/aP13+7JgHA4Nsg==
X-Received: by 2002:a05:6a20:748b:b0:186:603b:6b53 with SMTP id p11-20020a056a20748b00b00186603b6b53mr1091836pzd.0.1699834129822;
        Sun, 12 Nov 2023 16:08:49 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id y18-20020a1709027c9200b001b53c8659fesm2998333pll.30.2023.11.12.16.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 16:08:49 -0800 (PST)
Message-ID: <baa98649-1840-48aa-89ac-0c27a08559d5@redhat.com>
Date:   Mon, 13 Nov 2023 10:08:40 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 03/22] x86/topology: remove arch_*register_cpu()
 exports
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
 <E1r0JKv-00CTwf-R9@rmk-PC.armlinux.org.uk>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JKv-00CTwf-R9@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
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
>   arch/x86/kernel/topology.c | 2 --
>   1 file changed, 2 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

