Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF52B7EB011
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjKNMoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjKNMoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:44:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2F7189
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 04:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699965843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ix8jzUm8kKsvjeA/9wvH9vgqBJk06pyG8tZ3W2P8ymo=;
        b=jDt6Kif0eoQucNvByayMu9XD8JwBv4owiDPXg2WxCHLt4q5uLL2LWWoUBLCHUvIQeppMxg
        bZ3gXz6oSqQsFtyJht25thNlZ9JZIHximmzUCrY0r1Qeko56D+NxoAUgCWQfaX0Qxm1GCV
        fmvEK1oHLoN+SRd+hkzEdDvRtNmFhEQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-D93YYUD-OeCaYJxLZka-pw-1; Tue, 14 Nov 2023 07:44:02 -0500
X-MC-Unique: D93YYUD-OeCaYJxLZka-pw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-99bca0b9234so389075666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 04:44:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699965841; x=1700570641;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ix8jzUm8kKsvjeA/9wvH9vgqBJk06pyG8tZ3W2P8ymo=;
        b=oLv9sI4R5xc/w7dlAuNJbyciYn97rRPGWd+hBYShuUZuuQMP2dhA6xzXUoBC0JYxq1
         NTsafmWxJ4p7bGwvHhd816o1tClQq842ECqz+7g5iv6GWBTGnm4cKRfJSRtEBgLLpOgh
         UVm7a3TIBWvIcHId0WsLy4ubDXbIgXOSo7RR/jtqfKMZyPTSQNhFFeByQts0/MVPESNa
         FOYVToqG+ezficJQmV+uZkZY8PvCZY326eo6WlHCkwGh3xeRgkkMVTaKQDQjpnT3JKe9
         H2KjJvx1zbOwOAOEeGVdR7ELO962zcEidfLSEw4WZkSbT3WdoqmDc/xGjFjetIVqkNS1
         EN4w==
X-Gm-Message-State: AOJu0YwPEtLb4vO3kv0ZMG2pDqXmpxai+MV0ygBpuethUwzmISWPtOMB
        o3Oq91jy2nBBEv5bisJZXH9PJMpNyAv/r1WQHViIQetIHAVTJ2SX9APod94jy9VX/MTF0AXUUXd
        O/HfRo1MX38bFmJMxfMyPu3T/hsX15h6C
X-Received: by 2002:a17:907:98e:b0:9ba:fe6:225 with SMTP id bf14-20020a170907098e00b009ba0fe60225mr8852205ejc.55.1699965841454;
        Tue, 14 Nov 2023 04:44:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiiu2pOUMDooVpl8+wE4QxGVP90caAP8s/9uHkOVMA0bdTVHsINaHFoVvuXKygRp4mX3y3/A==
X-Received: by 2002:a17:907:98e:b0:9ba:fe6:225 with SMTP id bf14-20020a170907098e00b009ba0fe60225mr8852191ejc.55.1699965841178;
        Tue, 14 Nov 2023 04:44:01 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id s4-20020a170906168400b009aa292a2df2sm5465278ejd.217.2023.11.14.04.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 04:44:00 -0800 (PST)
Message-ID: <b3d2f6aa-4dc4-4570-9c00-54b7211fb851@redhat.com>
Date:   Tue, 14 Nov 2023 13:43:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] platform/x86: hp-bioscfg: Fix error handling in
 hp_add_other_attributes()
Content-Language: en-US, nl
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     Jorge Lopez <jorge.lopez2@hp.com>,
        Mark Gross <markgross@kernel.org>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, dan.carpenter@linaro.org,
        kernel-janitors@vger.kernel.org, error27@gmail.com,
        vegard.nossum@oracle.com, kernel test robot <lkp@intel.com>
References: <20231113200742.3593548-1-harshit.m.mogalapalli@oracle.com>
 <20231113200742.3593548-3-harshit.m.mogalapalli@oracle.com>
 <36e7a170-bd87-4462-fc6b-eec446fbb551@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <36e7a170-bd87-4462-fc6b-eec446fbb551@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilpo,

On 11/14/23 11:31, Ilpo Järvinen wrote:
> On Mon, 13 Nov 2023, Harshit Mogalapalli wrote:
> 
>> 'attr_name_kobj' is allocated using kzalloc, but on all the error paths
>> it is not freed, hence we have a memory leak.
>>
>> Fix the error path before kobject_init_and_add() by adding kfree().
>>
>> kobject_put() must be always called after passing the object to
>> kobject_init_and_add(). Only the error path which is immediately next
>> to kobject_init_and_add() calls kobject_put() and not any other error
>> path after it.
>>
>> Fix the error handling after kobject_init_and_add() by moving the
>> kobject_put() into the goto label err_other_attr_init that is already
>> used by all the error paths after kobject_init_and_add().
>>
>> Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <error27@gmail.com>
>> Closes: https://lore.kernel.org/r/202309201412.on0VXJGo-lkp@intel.com/
>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>> ---
>> This is based on static analysis, only compile tested.
>>
>> v3->v4: Add more explicit statement on how we are fixing it, suggested
>> by Ilpo
> 
> Thanks a lot, this looks fine too now.
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thank you for reviewing this series. I believe that it is best
to submit this as fixes for the current cycle.

Under the assumption that you agree with this I've delegated
these 4 patches to you (Ilpo) in patchwork.

Regards,

Hans


