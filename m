Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0546B7EDD55
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbjKPJFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjKPJFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:05:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17071AE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700125526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HW09tjosuLlc9IkvvasWeHjFLCSejIF+D/lcOlPe2PY=;
        b=T3IwFE3R5jlitHrH4h8E6uJay4d9Y6S9UDCBQS+mb1NYqNO3znN7pqLB6AGAsvlBwMC9NI
        +YSuJCLi346Xq5isCgPOxb3yx6cB+m4jvExb6GHsYtT69A/7x6NVP6NIpSCjDwo45+1Cdo
        ft4XbZFw93A6xQZ1h/p3l6za3zHg1NE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-lnap-8-nPTSYFTTbVUvFtg-1; Thu, 16 Nov 2023 04:05:24 -0500
X-MC-Unique: lnap-8-nPTSYFTTbVUvFtg-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cc3619a245so1581035ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:05:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700125523; x=1700730323;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HW09tjosuLlc9IkvvasWeHjFLCSejIF+D/lcOlPe2PY=;
        b=atQoa7DF0t8iZGm5arWH5PXQ56vmtjDbdkWHg1GHmJwjvkZoJL4lktN8P1/lgG9V3S
         HWXBVRVsV0Y5/CPTvEdyCyoTiI+m5r6hidB15KY/Qus5TeyA2IBlsldKc6qpCPY20e67
         t78fhJLmEvbjjdEvmMb+UVUkU40rQavKKfJryTFqIPunlO5MGMb5cLmiMcorXNix8lMD
         +H6F9WcFMXd5nkCwiEUDigf4C9jsD5zzZdKpByNNlBGU4EbTbcQnZHGSPEbhsz5r4NpH
         tbVWBdIstaHhFk5kgH42CRY5K13rFPfaAs7AIAfm2URFIcrQucjxdHHg14Y3Orx38RuR
         aXaQ==
X-Gm-Message-State: AOJu0YyYl7UvNOPaE/hvNuX7X2kc5CcK3u69eyF0fYdzpkBB0srI47WU
        6aQ2rzRwaqH7zrDMUm0H7Wgz5fBvhIx+hThbRUOYD8IuA29g40KF7gy0uz8/Bdb0ohUxVqboq+o
        BkiTQ/hA2bm27EKruKqA+u30M
X-Received: by 2002:a05:6a20:da85:b0:185:ffb1:2776 with SMTP id iy5-20020a056a20da8500b00185ffb12776mr5777475pzb.4.1700125523606;
        Thu, 16 Nov 2023 01:05:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpzJ8NCXgCdrgY9veZ9iNfzdjqjrlFzdYTsmckCamkB75PNTPATHoLb/gCB8hW7r3u59OTaQ==
X-Received: by 2002:a05:6a20:da85:b0:185:ffb1:2776 with SMTP id iy5-20020a056a20da8500b00185ffb12776mr5777452pzb.4.1700125523306;
        Thu, 16 Nov 2023 01:05:23 -0800 (PST)
Received: from [10.72.112.142] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g16-20020a056a00079000b006bd9422b279sm4067107pfu.54.2023.11.16.01.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 01:05:22 -0800 (PST)
Message-ID: <ffb47630-44eb-5b6c-5fc5-c8b007c391c5@redhat.com>
Date:   Thu, 16 Nov 2023 17:05:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] KVM: arm64: selftests: Clean up the GIC[D,R]_BASE_GPA
Content-Language: en-US
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231115153449.17815-1-shahuang@redhat.com>
 <ZVTmk-u-zUKC4Nrw@linux.dev>
From:   Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <ZVTmk-u-zUKC4Nrw@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/23 23:41, Oliver Upton wrote:
> On Wed, Nov 15, 2023 at 10:34:48AM -0500, Shaoqin Huang wrote:
>> The GIC[D,R]_BASE_GPA has been defined in multiple files with the same
>> value, define it in one place to make the code clean.
>>
>> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> 
> Colton already posted a fix for this as part of his selftests series
> 
> https://lore.kernel.org/kvmarm/20231103192915.2209393-2-coltonlewis@google.com/
> 

I see. Thanks for notification.

-- 
Shaoqin

