Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47AE7F6AD1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 04:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjKXDIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 22:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXDIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 22:08:35 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0247D43
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 19:08:17 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cfa3f7fcd4so505735ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 19:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700795297; x=1701400097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Of6E7DUYOHQDJJkmAD9imFrmBVxslEORWEoCGdZehnU=;
        b=XEszFfeachsLqfH0wLpmcEGRfs6IlbLWJZgjFLvFD96dp1FVCNrX8wv4oh77n2P5gr
         kdJzInrroxQJsK40WndSYb4ahJztuglJl2lyQWfHz5c1D2MJt0UPqaKJ7G/nBoty59V+
         /+ViPLRozN6QHBDHKwIq6F47JE+9wMuOAvVXyPWXvslP3Sg3IMdH2WTluxbTf0W2/5Mk
         tx9R96BkStPqTgCYI63QzIRbPkAN/ck9+AxScppPEfKUpZa4DinMta3dZyt/XjORpt1X
         wphKo1j5lolBtQ88bnImBd9siusiLRY0XSeprocRtrU+y8S8bidwPI/KXi4BvEZGSH3X
         KBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700795297; x=1701400097;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Of6E7DUYOHQDJJkmAD9imFrmBVxslEORWEoCGdZehnU=;
        b=eP6Vczp+Lw3U/XSK7zu5Xl6/DbvWm0oDVTJKlmSoK2RX6tH+bIlyrvH+qXq7bURwSc
         lrYpeYFaZ0ESlKo+r9zmCWIP+to0X8B8zFQFUpkeehtzH7TeLUsE/3K+VyY6OHGG7wJx
         j1xsbROIH/Xoxf2VWOGE1EZCRSlnIuaK5VT4DdEm3PMJR/Lt6wn/aCwQw7diZardAPRT
         gWNLb4NBnJzXdu98MZoZS7ju2C7nc1h9zmp2JSYtnDGta0x2Tux4TSIlOjK8nN2YUXRE
         PSYRw7Ktl988gAijKB0L8gC9o2/24/pk8iSZOhKMnTKtnSWdsBOE6H27yz7r5eKY+roN
         /wzg==
X-Gm-Message-State: AOJu0YyzL9cxCTv8nn/yIpHdlLw4eS6EdJ5lVsIA2UEfhxVd/JftJZ+6
        Z8ejG5SDyErhvBYI/9B+Xs7VIA==
X-Google-Smtp-Source: AGHT+IEx+FidCfta6MJRPBWFmlQ7eGWZ+QXFWJzCNwBSRnDUgk0mWX1laAdNUMh/DE/9iYO2kIpTwQ==
X-Received: by 2002:a05:6a20:5499:b0:14e:2c56:7b02 with SMTP id i25-20020a056a20549900b0014e2c567b02mr2100530pzk.0.1700795297115;
        Thu, 23 Nov 2023 19:08:17 -0800 (PST)
Received: from [10.84.152.29] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id jk2-20020a170903330200b001cf68e1c5a1sm2094203plb.4.2023.11.23.19.08.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 19:08:16 -0800 (PST)
Message-ID: <4caadff7-1df0-45cc-9d43-e616f9e4ddb3@bytedance.com>
Date:   Fri, 24 Nov 2023 11:08:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] mm: shrinker: Add a .to_text() method for shrinkers
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Dave Chinner <david@fromorbit.com>
References: <20231122232515.177833-1-kent.overstreet@linux.dev>
 <20231122232515.177833-3-kent.overstreet@linux.dev>
 <deed9bb1-02b9-4e89-895b-38a84e5a9408@gmail.com>
 <20231123212411.s6r5ekvkklvhwfra@moria.home.lan>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20231123212411.s6r5ekvkklvhwfra@moria.home.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kent,

On 2023/11/24 05:24, Kent Overstreet wrote:
> On Thu, Nov 23, 2023 at 11:32:59AM +0800, Qi Zheng wrote:
>>> +	void (*to_text)(struct seq_buf *, struct shrinker *);
>>
>> The "to_text" looks a little strange, how about naming it
>> "stat_objects"?
> 
> The convention I've been using heavily in bcachefs is
> typename_to_text(), or type.to_text(), for debug reports. The

OK.

> consistency is nice.

However, this is inconsistent with the name style of other
shrinker callbacks. Please use the "objects" suffix. As for
bcachefs's own callback function, you can use typename_to_text()
to ensure consistency.

Thanks,
Qi

> 
>>
>>>    	long batch;	/* reclaim batch size, 0 = default */
>>>    	int seeks;	/* seeks to recreate an obj */
>>> @@ -110,7 +114,6 @@ struct shrinker {
>>>    #endif
>>>    #ifdef CONFIG_SHRINKER_DEBUG
>>>    	int debugfs_id;
>>> -	const char *name;
>>
>> The name will only be allocated memory when the CONFIG_SHRINKER_DEBUG is
>> enabled, otherwise its value is NULL. So you can't move it out and use
>> it while CONFIG_SHRINKER_DEBUG is disabled.
> 
> Good catch
> 
>>> +void shrinkers_to_text(struct seq_buf *out)
>>> +{
>>> +	struct shrinker *shrinker;
>>> +	struct shrinker_by_mem {
>>> +		struct shrinker	*shrinker;
>>> +		unsigned long	mem;
>>
>> The "mem" also looks a little strange, how about naming it
>> "freeable"?
> 
> The type is just used in this one function, but sure.
> 
>>
>>> +	} shrinkers_by_mem[10];
>>> +	int i, nr = 0;
>>> +
>>> +	if (!mutex_trylock(&shrinker_mutex)) {
>>> +		seq_buf_puts(out, "(couldn't take shrinker lock)");
>>> +		return;
>>> +	}
>>
>> We now have lockless method (RCU + refcount) to iterate shrinker_list,
>> please refer to shrink_slab().
> 
> Will do!
