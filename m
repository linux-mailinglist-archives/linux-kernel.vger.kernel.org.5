Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F517E85EB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 23:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjKJW7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 17:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjKJW7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 17:59:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C708EB0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 14:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699657124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9j28lXvsEf9BPZXTXKi6AXZ8wcoBFGBKcddSWxqVXIY=;
        b=CYW1g7s8CdcKQal1KPNFamYY0gIZFpS0A4c7Mx35kJx4hIaDz8uc7D+qL5k2ZHwsNophyX
        DcAEeqsYUKR18Pf8znXpMdp3gda1wFYLgxw4c2ebC0Fu3+Pk77MYwINC+/C0FCFPZxJ6uu
        KIzsuJRpWu0MWqfoE5gu7R+UviYo80I=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-Yi8HGiRmNzC1cggRu0_jlg-1; Fri, 10 Nov 2023 17:58:43 -0500
X-MC-Unique: Yi8HGiRmNzC1cggRu0_jlg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-421ad98a611so15868981cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 14:58:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699657122; x=1700261922;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9j28lXvsEf9BPZXTXKi6AXZ8wcoBFGBKcddSWxqVXIY=;
        b=jyzH+3VlLsSeY64Te/3cSeaYlx0kB8zuq1Gobs87ImGzu4fB99CDJX1FYIKf1o1z4P
         6mal4HNa8Ihe2CNNcqGcBUqYeQRihsaVztxgBdYNM9mOdrkJ/Qa+MbDCZQY6L669P6Tb
         vh+CFH+LfS/Nvl0/XmpqERPM+YM3H7idE/S23m180Fm8bddN8z9VfuDjuZmUCl5HzROW
         eNHr8PA7ZNeGuB5KWrTSAa+hkHvCscEEKskhk4yDUUZH5qpqbrGgXfbh72jdFn9gd+dg
         wtlZNzIF2W2fGx7zXg/qgdsAJ+orChpNQQH1wbHSVSQtpFKNBCO5K4hiZU52N6fonVQI
         pYlA==
X-Gm-Message-State: AOJu0YwNNp26pMqR8be2CxPVLID0wn03J+Mm/3sB16CF81fT8ps+wAUT
        LQeOeyOIGl8KMWGcznemtEF0LDcccylbRYS+ekfzZIRhHwJphL9bHrPhCrt6fv+PBIAgG8VIbLs
        OEHC6IExjVgq/Ga92n5SHO4Av4ZBqoKg=
X-Received: by 2002:a05:622a:1113:b0:417:9c63:391c with SMTP id e19-20020a05622a111300b004179c63391cmr486227qty.52.1699657122315;
        Fri, 10 Nov 2023 14:58:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqNcVi5ZpAoz5E4DZnIcE33eRoScJUzOJxPAsBq0IMcrHzgjOg6abO3/Fb1UdR07aav7i0ew==
X-Received: by 2002:a05:622a:1113:b0:417:9c63:391c with SMTP id e19-20020a05622a111300b004179c63391cmr486214qty.52.1699657122006;
        Fri, 10 Nov 2023 14:58:42 -0800 (PST)
Received: from [192.168.9.16] (net-2-34-31-107.cust.vodafonedsl.it. [2.34.31.107])
        by smtp.gmail.com with ESMTPSA id o2-20020ac841c2000000b0041803dfb240sm154082qtm.45.2023.11.10.14.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 14:58:41 -0800 (PST)
Message-ID: <5c3c3905-67c2-4cc2-8477-c6fc74676fc9@redhat.com>
Date:   Fri, 10 Nov 2023 23:58:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Marco Pagani <marpagan@redhat.com>
Subject: Re: [RFC PATCH] fpga: remove module reference counting from core
 components
To:     Xu Yilun <yilun.xu@linux.intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Alan Tull <atull@opensource.altera.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231027152928.184012-1-marpagan@redhat.com>
 <ZT9qENE9fE3Z0KCW@yilunxu-OptiPlex-7050>
 <ae202b70-b106-4805-9ce0-ffbb2738bb04@redhat.com>
 <ZUuu1CgVd4h3Qqu7@yilunxu-OptiPlex-7050>
Content-Language: en-US
In-Reply-To: <ZUuu1CgVd4h3Qqu7@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-11-08 16:52, Xu Yilun wrote:
> On Fri, Nov 03, 2023 at 09:31:02PM +0100, Marco Pagani wrote:
>>
>>
>> On 2023-10-30 09:32, Xu Yilun wrote:
>>> On Fri, Oct 27, 2023 at 05:29:27PM +0200, Marco Pagani wrote:
>>>> Remove unnecessary module reference counting from the core components
>>>> of the subsystem. Low-level driver modules cannot be removed before
>>>> core modules since they use their exported symbols.
>>>
>>> Could you help show the code for this conclusion?
>>>
>>> This is different from what I remember, a module cannot be removed when
>>> its exported symbols are being used by other modules. IOW, the core
>>> modules cannot be removed when there exist related low-level driver
>>> modules. But the low-level driver modules could be removed freely
>>> without other protecting mechanism.
>>>
>>
>> My understanding was that we wanted to remove module reference counting
>> from the fpga core and ease it from the responsibility of preventing
>> low-level driver modules from being unloaded. 
> 
> FPGA core needs to prevent low-level driver module unloading sometimes,
> e.g. when region reprograming is in progress. That's why we get fpga
> region driver modules & bridge modules in fpga_region_program_fpga().
> 
> But we try best to get them only necessary. Blindly geting them all the
> time results in no way to unload all modules (core & low level modules).
> 
>>
>> If we want to keep reference counting in the fpga core, we could add a
>> struct module *owner field in the struct fpga_manager_ops (and others
>> core *_ops) so that the low-level driver can set it to THIS_MODULE.
>> In this way, we can later use it in fpga_mgr_register() to bump up the
> 
> Yes, we should pass the module owner in fpga_mgr_register(), but could
> not bump up its refcount at once.
> 
>> refcount of the low-level driver module by calling
>> try_module_get(mgr->mops->owner) directly when it registers the manager.
>> Finally, fpga_mgr_unregister() would call module_put(mgr->mops->owner)
>> to allow unloading the low-level driver module.
> 
> As mentioned above, that makes problem. Most of the low level driver
> modules call fpga_mgr_unregister() on module_exit(), but bumping up
> their module refcount prevents module_exit() been executed. That came
> out to be a dead lock.
>

Initially, I considered calling try_module_get(mgr->mops->owner)
in fpga_mgr_get(). But then, the new kernel-doc description of
try_module_get() (1) made me question the safety of that approach.
My concern is that the low-level driver could be removed right when
someone is calling fpga_mgr_get() and hasn't yet reached
try_module_get(mgr->mops->owner). In that case, the struct mops
(along with the entire low-level driver module) and the manager dev
would "disappear" under the feet of fpga_mgr_get().

(1) 557aafac1153 ("kernel/module: add documentation for try_module_get()")
 
>>
>> In this way, it would no longer be necessary to call try_module_get()
>> in fpga_mrg_get() since we could use a kref (included in the struct
>> fpga_manager) to do refcounting for the in-kernel API users. Only when
>> the kref reaches zero fpga_mgr_unregister() would succeed and put the
>> low-level driver module.
>>
>> I think this approach would be safer since it would avoid the crash
>> that can currently happen if the low-level driver module is removed
>> right when executing try_module_get() in fpga_mrg_get(). The possible
>> caveat is that it would be required to call fpga_mgr_unregister()
>> before being able to remove the low-level driver module.
>>


[...]

Thanks,
Marco

