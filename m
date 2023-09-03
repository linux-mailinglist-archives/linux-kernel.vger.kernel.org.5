Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B1D790BD4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 14:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236979AbjICMHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 08:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjICMHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 08:07:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5900F124
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 05:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693742823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ww/X9A++x5CfrbV8/KeMYfQ017da0o9tfjIpanjcu1A=;
        b=gYIHUzJIXKocEn1kdMKrMDOjyXm1JIyMZ8gefz0MwMX+73mPfsWB5WcUWre3cv5uiSH64B
        BiARikvuiX0lZ15aqGUmCkewZZjBf7xknQVr9Cq9ERRm13W5NihvJmRiWBqgNsjcie9vLs
        ozx4OoBgPfjuEg98ZlMLkKhYYMfew/M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-F5Dfa1eGMVus1TbPL21WlQ-1; Sun, 03 Sep 2023 08:07:01 -0400
X-MC-Unique: F5Dfa1eGMVus1TbPL21WlQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94a34a0b75eso35989466b.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 05:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693742821; x=1694347621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ww/X9A++x5CfrbV8/KeMYfQ017da0o9tfjIpanjcu1A=;
        b=XboBwlNfFmuMZCVOuJk2+krv53+RxErEhcYEc18Sh/acsRhjIxQk1po3jhQhYazscI
         6zj2XaSULIMXsW/zB/V42c00cfteHkcOSaff1oXq2TCkgedk/1mgqCaLGotLiBOEPDrk
         Y6ZqJm001nd4Ydp+pXOA63ec0j2ahwx2dQqDA1CWn7GcFjyjxWBa5/YB07tz5wOiIiCL
         IEbsAn8FrecTviBpWShZHl7Cz3BdtgNJL/5YwsdP+0XYl7Kw30omIAJc6wOXcOzvUln+
         v7gYtJM1LVsJztJF87D2Fe0mMS73F6btWTrRcOMVlgdThBmCrglAr26gC9552fpPh8Y8
         mASA==
X-Gm-Message-State: AOJu0YyupdqywQ9snpqzFGv8fuFidSvpoiAb9IwogYU6TA2mM/TwXi60
        7jx/+0lomkeF8JRG/XW7W9z1HnAHBRPy9wBVIzQ5yh17QT4Qk/kgHTx5pzSYKcixcmXdllHQomD
        +GYHKIq6v2mxJbcaLSBq9sJMA
X-Received: by 2002:a17:907:2c77:b0:9a1:be50:ae61 with SMTP id ib23-20020a1709072c7700b009a1be50ae61mr4520755ejc.69.1693742820840;
        Sun, 03 Sep 2023 05:07:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZI9cDOCy5Of03hhWcDQWRttrAYSGtOIHFJh+LXh/+REb+CH5467mefoQoU9OhSTXlKuV8Rg==
X-Received: by 2002:a17:907:2c77:b0:9a1:be50:ae61 with SMTP id ib23-20020a1709072c7700b009a1be50ae61mr4520740ejc.69.1693742820494;
        Sun, 03 Sep 2023 05:07:00 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ov22-20020a170906fc1600b00992c92af6f4sm4781695ejb.144.2023.09.03.05.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 05:06:59 -0700 (PDT)
Message-ID: <da3fe9b0-9a64-e912-d8ec-b3e9acd1813e@redhat.com>
Date:   Sun, 3 Sep 2023 14:06:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: ld.lld: error: undefined symbol: sysfs_format_mac
To:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        David Thompson <davthompson@nvidia.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Shravan Kumar Ramani <shravankr@nvidia.com>
References: <202309031058.JvwNDBKt-lkp@intel.com>
 <e566266a-f6f8-bad2-884d-22c394be52be@infradead.org>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <e566266a-f6f8-bad2-884d-22c394be52be@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/3/23 06:32, Randy Dunlap wrote:
> 
> 
> On 9/2/23 19:39, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   92901222f83d988617aee37680cb29e1a743b5e4
>> commit: 7e38a7422f128e7d7ba24b444e957d585dbb272f mlxbf-bootctl: Support sysfs entries for MFG fields
>> date:   10 days ago
>> config: arm64-randconfig-r024-20230902 (https://download.01.org/0day-ci/archive/20230903/202309031058.JvwNDBKt-lkp@intel.com/config)
>> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230903/202309031058.JvwNDBKt-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202309031058.JvwNDBKt-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>>
>>>> ld.lld: error: undefined symbol: sysfs_format_mac
>>    >>> referenced by xarray.c
> 
> I don't see what xarray.c has to do with this.
> 
> This happens when CONFIG_NET is not enabled.

Right, so this suggests that config MLXBF_BOOTCTL in
drivers/platform/mellanox/Kconfig needs a:

	depends on NET

David, Vadim, can one of you submit a patch for this?

Then I'll get that queued up as a 6.6 fix.

Regards,

Hans


p.s.

I wonder if it would not be better to just turn into
a static inline helper instead of an exported symbol.

It is really just a small wrapper around sysfs_emit():

ssize_t sysfs_format_mac(char *buf, const unsigned char *addr, int len)
{
        return sysfs_emit(buf, "%*phC\n", len, addr);
}
EXPORT_SYMBOL(sysfs_format_mac);

Making this a static inline thus should not grow the code
size, while removing a symbol from the exported symbol list.

Regards,

Hans




>>    >>>               vmlinux.o:(oob_mac_show)
>>
> 

