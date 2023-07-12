Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AF27510FE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 21:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjGLTKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 15:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjGLTKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 15:10:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEB71BF8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689188969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iVqzN+gEicp3rJj4Bqvo5xYs3/pSCObCBEs+9bPEbpA=;
        b=PEQ/pCYPQUZ1Wzt8eLRl1f2DjsneFPWUoS00X5lvwCZLo6aDnPyTtJ2W3/K+G7GgquV/Pa
        /dUYT3ExTwE36D06a3BSw1g8kuTTUFPr1+hAB2KkUvT3Upap5PY/NtR2aI0XGbXLsJR9WR
        mLofv13gSv2gHvxcvTsYlKqrToSXxOE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-9RsP1BDNNwaYp0z9ewyzKQ-1; Wed, 12 Jul 2023 15:09:27 -0400
X-MC-Unique: 9RsP1BDNNwaYp0z9ewyzKQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-315af0252c2so530866f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689188967; x=1691780967;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iVqzN+gEicp3rJj4Bqvo5xYs3/pSCObCBEs+9bPEbpA=;
        b=gXK+PshmFKaRjQWT0b3Sx+Lkqb8nkc8w/VMIOW+lRvR7RkBTa4EuW1/Qxz32ISy5NO
         KOquaS7RxhWPYY/STPoUqgOqD6TiNR0GGP+9F120vOwMgknAfMSdBHHmAEgra4oMr6Rt
         yhUDq96cSyKzdBvAsxFm1TSpHaSZcRQDSL2JeJ29pwAqOguV0Vf9/HufCoDQmSImEDjE
         oBaHwmB/kCDPcnQXdEYRsHmmtig8NbL7krGUK3tBDb7a1hhn2tcvTBys7Rs2wftf3Tpf
         JsrOq3A2dcJ+3VfoxDAOh6avaJIcMULczyYGkJSbrpwRAGOHVcwfJUKH2QvxTEc5Yvij
         4yMw==
X-Gm-Message-State: ABy/qLYyWbMVCLqA6g1MdBmX768JMOjPQb92dcW7FMvyQUqxKMeiMwkW
        8pO7deUIDBb0dpXZHUzGektuolOGLg0gRyde0rzg7DryHqR2vvXsvDyhHvyc+VGgpoigReK2hGK
        /iVy7y5HqZTdxoEo2T5Yramxp
X-Received: by 2002:adf:ffca:0:b0:313:f704:5450 with SMTP id x10-20020adfffca000000b00313f7045450mr17948895wrs.38.1689188966791;
        Wed, 12 Jul 2023 12:09:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGMK+WYDzTjQtshzShQXsCucWYnUSAX3VLVEDUYHUPnftGCYTbdQEGcxTHN4+POng/GRwpVKA==
X-Received: by 2002:adf:ffca:0:b0:313:f704:5450 with SMTP id x10-20020adfffca000000b00313f7045450mr17948880wrs.38.1689188966442;
        Wed, 12 Jul 2023 12:09:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3700:3eea:ace6:5bde:4478? (p200300cbc70737003eeaace65bde4478.dip0.t-ipconnect.de. [2003:cb:c707:3700:3eea:ace6:5bde:4478])
        by smtp.gmail.com with ESMTPSA id f6-20020adff586000000b003142eb75724sm5825120wro.24.2023.07.12.12.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 12:09:25 -0700 (PDT)
Message-ID: <7449914a-1ae3-9ea8-b60b-f0314999b790@redhat.com>
Date:   Wed, 12 Jul 2023 21:09:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1] mm/memory_hotplug: document the signal_pending() check
 in offline_pages()
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230711174050.603820-1-david@redhat.com>
 <ZK2/3Kq8VlDwcCpc@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZK2/3Kq8VlDwcCpc@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.07.23 22:47, Michal Hocko wrote:
> On Tue 11-07-23 19:40:50, David Hildenbrand wrote:
>> Let's update the documentation that any signal is sufficient, and
>> add a comment that not only checking for fatal signals is historical
>> baggage: changing it now could break existing user space. although
>> unlikely.
>>
>> For example, when an app provides a custom SIGALRM handler and triggers
>> memory offlining, the timeout cmd would no longer stop memory offlining,
>> because SIGALRM would no longer be considered a fatal signal.
> 
> Yes, and it is likely goot to mention here that this is an antipattern
> for many other kernel operations like IO (e.g. write) but it is a long
> term behavior that somebody might depend on and it is safer to reflect
> the documentation to the realitity rather than other way around (which
> would be imho better).
> 

You mean adding something like

"Note that using signal_pending() instead of fatal_signal_pending() is 
an anti-pattern, but slowly deprecating that behavior to eventually 
change it in the far future is probably not worth the effort. If this 
ever becomes relevant for user-space, we might want to rethink."


Thanks!

-- 
Cheers,

David / dhildenb

