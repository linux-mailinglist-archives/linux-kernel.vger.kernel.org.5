Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B9F7F84EB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 20:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346080AbjKXTvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 14:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345941AbjKXTvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:51:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032AD1BE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700855504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=OM2PxDAWg5kx5QEMWQSTwhnPULld33btKgMTQUPUfDc=;
        b=eXp3kka2GITIvtpNEkIKRAsOT7iMg4XNBHxW+MEFwg0B93xFGnllqF4edjdV3i01F0+hr2
        ciCQV8wUG1oIXt6CdDzdK3shQH76y8xa3LQZ+PTwaWt7C1WG/nHIGCbyQysWY9tMd2Ljjd
        WxZMZt0OkEKHBSCidqTuBWOJHAS+kcc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-8QkZCYolN32B9V0zoRNBew-1; Fri, 24 Nov 2023 14:51:42 -0500
X-MC-Unique: 8QkZCYolN32B9V0zoRNBew-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-332d40b72cbso1265538f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:51:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700855501; x=1701460301;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OM2PxDAWg5kx5QEMWQSTwhnPULld33btKgMTQUPUfDc=;
        b=FBdLc7ZnNqYaJGpmNO7mBesp3rjOaeFxKNmLpD1C8MoHtoCjB2NAtMIXokQCvHKaxB
         Hm7odGohmPwWc93Gk+tKD5Utwz36td+MN0r2sZTbqMfmwwwRqsszaIDgFIqmXudWpD5U
         gul5Lb+LJwW1tM5iD2X/XC3toyr+7Ewx1N0wPbDpOzCviYsB+i8/eN9DPZz2SsBrbbZ3
         3nc5K3ZLcIVbArbCb7rJCSFWvQGZcMRc/PKqM53SSBMqiB6wN0Z0KSlP+9bYff3s6CEc
         tKYYa5ZFejfGeTluOm+m50PeWbyBVkubDVCB/V96AKOQRDJk0kYKz7ev36cDswYH+a/N
         3T/Q==
X-Gm-Message-State: AOJu0YzbPauoZW/3mbrP1BisY+iJMKJBGfgb3bYHB9BTIGmhnGGBS9GY
        ZMy3v/vU36QtOsuowXcl6Ytxwp9S6vICSVo7CDYhUpi1WKt36Kf6sLFJuD/wx5YLEyhjCPWLa0h
        4kUUav0uertUKZCxlK0dMsGNQ
X-Received: by 2002:a05:6000:b44:b0:331:6e10:e51d with SMTP id dk4-20020a0560000b4400b003316e10e51dmr3516296wrb.31.1700855501401;
        Fri, 24 Nov 2023 11:51:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHR+klacAa3ex/J93BAG94yzf34ZO2KgUyGSEVLDRRi0OCs9p1XGrjiniBUp5LdHCT2XI2b1Q==
X-Received: by 2002:a05:6000:b44:b0:331:6e10:e51d with SMTP id dk4-20020a0560000b4400b003316e10e51dmr3516280wrb.31.1700855501001;
        Fri, 24 Nov 2023 11:51:41 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:a000:7426:f6b4:82a3:c6ab? (p200300cbc721a0007426f6b482a3c6ab.dip0.t-ipconnect.de. [2003:cb:c721:a000:7426:f6b4:82a3:c6ab])
        by smtp.gmail.com with ESMTPSA id c13-20020adfe70d000000b003316aeb280esm4965195wrm.104.2023.11.24.11.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 11:51:40 -0800 (PST)
Message-ID: <91c5d2e2-57b1-4172-88e0-cd07a8d85af4@redhat.com>
Date:   Fri, 24 Nov 2023 20:51:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 13/27] arm64: mte: Make tag storage depend on
 ARCH_KEEP_MEMBLOCK
Content-Language: en-US
To:     Alexandru Elisei <alexandru.elisei@arm.com>,
        catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
        maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
        rppt@kernel.org, hughd@google.com
Cc:     pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
        vincenzo.frascino@arm.com, eugenis@google.com, kcc@google.com,
        hyesoo.yu@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <20231119165721.9849-14-alexandru.elisei@arm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231119165721.9849-14-alexandru.elisei@arm.com>
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

On 19.11.23 17:57, Alexandru Elisei wrote:
> Tag storage memory requires that the tag storage pages used for data are
> always migratable when they need to be repurposed to store tags.
> 
> If ARCH_KEEP_MEMBLOCK is enabled, kexec will scan all non-reserved
> memblocks to find a suitable location for copying the kernel image. The
> kernel image, once loaded, cannot be moved to another location in physical
> memory. The initialization code for the tag storage reserves the memblocks
> for the tag storage pages, which means kexec will not use them, and the tag
> storage pages can be migrated at any time, which is the desired behaviour.
> 
> However, if ARCH_KEEP_MEMBLOCK is not selected, kexec will not skip a
> region unless the memory resource has the IORESOURCE_SYSRAM_DRIVER_MANAGED
> flag, which isn't currently set by the tag storage initialization code.
> 
> Make ARM64_MTE_TAG_STORAGE depend on ARCH_KEEP_MEMBLOCK to make it explicit
> that that the Kconfig option required for it to work correctly.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>   arch/arm64/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 047487046e8f..efa5b7958169 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2065,6 +2065,7 @@ config ARM64_MTE
>   if ARM64_MTE
>   config ARM64_MTE_TAG_STORAGE
>   	bool "Dynamic MTE tag storage management"
> +	depends on ARCH_KEEP_MEMBLOCK
>   	select CONFIG_CMA
>   	help
>   	  Adds support for dynamic management of the memory used by the hardware

Doesn't arm64 select that unconditionally? Why is this required then?

-- 
Cheers,

David / dhildenb

