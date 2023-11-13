Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE7A7E95F7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 05:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbjKMEK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 23:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbjKMEK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 23:10:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CC0172B
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 20:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699848575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r2bRjfP7yOuv9SAdAE0QP2CBFoAYrMs60Lu0SjYCCHg=;
        b=DdpZOw9EVotEnA6JMbayfVU34Nqdbkfl5tXWxMWEq74e96U6Cc/tzAjDYiGhQ/nxRcPtmC
        MneTD6b24WTrT3Z+UtfAts8QcgzVIliWl+gQJKvHVnzEoraERYQD8zddj5Is6kjGa9kX0l
        od8Kq4p8qalCcd5SVpupiwp5nJ/PZPw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-UilAKkMTNYOtz4xvPII1Ug-1; Sun, 12 Nov 2023 23:09:33 -0500
X-MC-Unique: UilAKkMTNYOtz4xvPII1Ug-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c17cff57f9so1166247a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 20:09:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699848572; x=1700453372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r2bRjfP7yOuv9SAdAE0QP2CBFoAYrMs60Lu0SjYCCHg=;
        b=X3OhVo9SkaAK/+CotM2NMaNG++5+gVArQDVHhxBVp1EzPlb7fUbAEcGCmkPrrIBffY
         JhVFurFpf/LAl+bhRskB52BzLakqwetSRKA+sIl0/S5Pt+6ADZlfCobRajYVtwritQoP
         97tBu9HHa/DdL3vmFPcJNK4rwR44EjQUZB8q10ugR8rzmKVgEgkJZWtfbriq7tX+JqOd
         f5fynBJAANTI527Xm/OabM7PHB9cHO+1gprEROdTlJBU3l9MXF4y+ceV04Y3F19dpdha
         tycx8Sgj5EN/3tlwvqEPiOkhKfkBYeNeXQhiWMuGdmW3KTUCfwygRs/ijSMx7noHrF6O
         JYLA==
X-Gm-Message-State: AOJu0YxEpyzhq4wwncOuUiGqx0gMf8R17fBYgJysvAuBjSdisYlD4gao
        xbeDYTy8zN8yzXO+8/R96mhxlaN6QEdJqlVxNYECAKqOROJNerMljYYxM8dJO3cO5pRKTqwVR3/
        8+hvh+44PPJJLaq2ji1UUbmg3
X-Received: by 2002:a17:90b:1a8c:b0:27d:ba33:6990 with SMTP id ng12-20020a17090b1a8c00b0027dba336990mr3197170pjb.10.1699848572564;
        Sun, 12 Nov 2023 20:09:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2k5SwVakWG7zKK4WUWbKBo4uYLTXEgbcXMEekUsR8f4+eMr6ksf4A21GkOdsMSomj6DSw2A==
X-Received: by 2002:a17:90b:1a8c:b0:27d:ba33:6990 with SMTP id ng12-20020a17090b1a8c00b0027dba336990mr3197155pjb.10.1699848572281;
        Sun, 12 Nov 2023 20:09:32 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id b1-20020a170903228100b001cc3098c9f8sm3225162plh.275.2023.11.12.20.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 20:09:31 -0800 (PST)
Message-ID: <55e640c3-491c-4f55-b432-a41f48405a02@redhat.com>
Date:   Mon, 13 Nov 2023 14:09:25 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 14/22] arm64: convert to arch_cpu_is_hotpluggable()
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JLq-00CTxq-CF@rmk-PC.armlinux.org.uk>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JLq-00CTxq-CF@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/7/23 20:30, Russell King (Oracle) wrote:
> Convert arm64 to use the arch_cpu_is_hotpluggable() helper rather than
> arch_register_cpu().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>   arch/arm64/kernel/setup.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

