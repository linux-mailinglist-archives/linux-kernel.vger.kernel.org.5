Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7A17ADB3F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjIYPWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjIYPV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:21:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7246AA3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695655267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6F9yAieHTq9h+jaWf4yY0Zh/CYQPj4mR3xpxBTrfVFg=;
        b=KR3rCpz2BjIc7T5utp6TW17ukOi3i+RUe4o3ulO/6kVPcB011jjm5TJNAAaJd+Gd7bQc1V
        ovS+1qsUzK3U6M2cAtUB56aZGgY489VX/h4noccXbngmNfoIkLssyzyaFP/wUzcDk2GL9x
        oIX/OtWE5Ka3A8+lTvgs9BjsCkmVC8I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-P-pQKmjOMp2g7fGTvdLKRQ-1; Mon, 25 Sep 2023 11:21:06 -0400
X-MC-Unique: P-pQKmjOMp2g7fGTvdLKRQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3231fceb811so2377230f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695655265; x=1696260065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6F9yAieHTq9h+jaWf4yY0Zh/CYQPj4mR3xpxBTrfVFg=;
        b=W+y6UuDNqXWAxVCDn8etMWYMjtep2Byx2gMpLuyz5UQ/Wbh7GrIgafyAgZXa9gamk1
         uqL33LRgNFLtkTlQniLaTK1f8wz+QBGj3eIweUzmY/wyp26PdIlP7omTxc3hDw6fberH
         x/4ZYaJg9VvPXzJoIt73AIOFpIBkTu5RvI88ISW6zpErczm0IvJ9RFvnN9M5SHzg/bw7
         lL03a4G9ZZIFibxMhGkA5ipN0E4gHTg2lYeIG3Kvk7KlpIj9Ea04XJ7fcnTyFyTLBYH+
         sra9YgHxt0FdOduOw30UvDk4VxyGgO0+mHSu4h5cKwUoxVyrFe/j+3gUU0a6tAFkXWoJ
         oWrQ==
X-Gm-Message-State: AOJu0YzdcRSTH72ve4J2UOwNRibs0P7VsWyAFbr2HLY91VAvPAJOx83w
        LclQjk5PnrbDqUUiBS5FQB7NT32hddAmooAROrlsmnqxvN8llqqqNSuCPoXI582H6P0wHAMFqzJ
        LiDt/gcsZk3XeXcEvdXjxo2ss10A8oCI=
X-Received: by 2002:adf:9bde:0:b0:323:264d:9cef with SMTP id e30-20020adf9bde000000b00323264d9cefmr2736025wrc.12.1695655264769;
        Mon, 25 Sep 2023 08:21:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEksj4POtlqeHJF1nUKXV/J4GYkY5xCrqU7NWas1TrKItCEC+rPt5ImmsPuH+hppRDs19gjrA==
X-Received: by 2002:adf:9bde:0:b0:323:264d:9cef with SMTP id e30-20020adf9bde000000b00323264d9cefmr2736010wrc.12.1695655264450;
        Mon, 25 Sep 2023 08:21:04 -0700 (PDT)
Received: from [192.168.9.16] (net-2-34-30-58.cust.vodafonedsl.it. [2.34.30.58])
        by smtp.gmail.com with ESMTPSA id k17-20020a5d66d1000000b0031759e6b43fsm12082128wrw.39.2023.09.25.08.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 08:21:04 -0700 (PDT)
Message-ID: <c8491399-556a-e55c-e815-4f0dd61c3b82@redhat.com>
Date:   Mon, 25 Sep 2023 17:21:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v10 1/4] fpga: add an initial KUnit suite for the FPGA
 Manager
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
References: <20230718130304.87048-2-marpagan@redhat.com>
 <4d51e87f-830a-adae-d6f7-6aed9433fdc6@huawei.com>
Content-Language: en-US
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <4d51e87f-830a-adae-d6f7-6aed9433fdc6@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-09-25 03:36, Ruan Jinjie wrote:
> 
> 
> On 1970/1/1 8:00, Marco Pagani wrote:
>> The suite tests the basic behaviors of the FPGA Manager including
>> programming using a single contiguous buffer and a scatter gather table.
>>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>

[...]

> modprobe fpga-mgr-test and then the below null-ptr-deref occurs.
> It seems that ctx->pdev->dev->driver is NULL and the pdev->dev need
> to be associated with a platform driver.

Hi, thanks for reporting the issue. I had not noticed it since it does not
happen when running the tests on UML. I will send a fix soon.

Marco


>      general protection fault, probably for non-canonical address
> 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
>      KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
>      CPU: 4 PID: 1866 Comm: kunit_try_catch Tainted: G                 N
> 6.6.0-rc2+ #49
>      Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.15.0-1 04/01/2014
>      RIP: 0010:fpga_mgr_get+0x87/0xd0 [fpga_mgr]
>      Code: 48 8d 7b 68 48 89 fa 48 c1 ea 03 80 3c 02 00 75 59 48 b8 00
> 00 00 00 00 fc ff df 48 8b 5b 68 48 8d 7b 10 48 89 fa 48 c1 ea 03 <80>
> 3c 02 00 75 33 48 8b 7b 10 e8 7a 43 1a e1 84 c0 74 08 4c 89 e0
>      RSP: 0018:ffff8881054cfe18 EFLAGS: 00010202
>      RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff83f6a96c
>      RDX: 0000000000000002 RSI: 0000000000000004 RDI: 0000000000000010
>      RBP: ffff88810d185808 R08: 0000000000000001 R09: ffffed1020d107ca
>      R10: ffff888106883e53 R11: ffff8881054cfa50 R12: ffff88810d185800
>      R13: ffff888106408520 R14: ffff88810683f5a8 R15: ffff888105e4b080
>      FS:  0000000000000000(0000) GS:ffff888119e00000(0000)
> knlGS:0000000000000000
>      CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>      CR2: 00007f537e5ed8a0 CR3: 0000000005086001 CR4: 0000000000770ee0
>      DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>      DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>      PKRU: 55555554
>      Call Trace:
>       <TASK>
>       ? die_addr+0x3d/0xa0
>       ? exc_general_protection+0x144/0x220
>       ? asm_exc_general_protection+0x22/0x30
>       ? kobject_put+0x5c/0x310
>       ? fpga_mgr_get+0x87/0xd0 [fpga_mgr]
>       ? fpga_mgr_get+0x28/0xd0 [fpga_mgr]
>       fpga_mgr_test_get+0xb4/0x1b0 [fpga_mgr_test]
>       ? platform_device_register_resndata.constprop.0+0xc0/0xc0
> [fpga_mgr_test]
>       ? fpga_mgr_test_lock+0x1f0/0x1f0 [fpga_mgr_test]
>       ? __sched_text_end+0xa/0xa
>       ? kunit_try_run_case+0xdd/0x250
>       ? kunit_try_run_case_cleanup+0xe0/0xe0
>       kunit_generic_run_threadfn_adapter+0x4a/0x90
>       ? kunit_try_catch_throw+0x80/0x80
>       kthread+0x2b5/0x380
>       ? kthread_complete_and_exit+0x20/0x20
>       ret_from_fork+0x2d/0x70
>       ? kthread_complete_and_exit+0x20/0x20
>       ret_from_fork_asm+0x11/0x20
>       </TASK>
>      Modules linked in: fpga_mgr_test(+) fpga_mgr
>      Dumping ftrace buffer:
>         (ftrace buffer empty)
>      ---[ end trace 0000000000000000 ]---
>      RIP: 0010:fpga_mgr_get+0x87/0xd0 [fpga_mgr]
>      Code: 48 8d 7b 68 48 89 fa 48 c1 ea 03 80 3c 02 00 75 59 48 b8 00
> 00 00 00 00 fc ff df 48 8b 5b 68 48 8d 7b 10 48 89 fa 48 c1 ea 03 <80>
> 3c 02 00 75 33 48 8b 7b 10 e8 7a 43 1a e1 84 c0 74 08 4c 89 e0
>      RSP: 0018:ffff8881054cfe18 EFLAGS: 00010202
>      RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff83f6a96c
>      RDX: 0000000000000002 RSI: 0000000000000004 RDI: 0000000000000010
>      RBP: ffff88810d185808 R08: 0000000000000001 R09: ffffed1020d107ca
>      R10: ffff888106883e53 R11: ffff8881054cfa50 R12: ffff88810d185800
>      R13: ffff888106408520 R14: ffff88810683f5a8 R15: ffff888105e4b080
>      FS:  0000000000000000(0000) GS:ffff888119e00000(0000)
> knlGS:0000000000000000
>      CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>      CR2: 00007f537e5ed8a0 CR3: 0000000005086001 CR4: 0000000000770ee0
>      DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>      DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>      PKRU: 55555554
>      Kernel panic - not syncing: Fatal exception
>      Dumping ftrace buffer:
>         (ftrace buffer empty)
>      Kernel Offset: disabled
>      Rebooting in 1 seconds..
> 
>     Fixes: ccbc1c302115 ("fpga: add an initial KUnit suite for the FPGA
> Manager")
>     Reported-by: Jinjie Ruan <ruanjinjie@huawei.com>
>

[...]

