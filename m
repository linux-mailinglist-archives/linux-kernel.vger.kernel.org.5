Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4327BE0ED
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377280AbjJINpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377473AbjJINo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:44:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE6E9C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 06:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696859046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dgVwLob78uVvWxqVfg4zqMaAddDB0vpZ0W6bwhsW9yw=;
        b=GXDl9OBlqPNBjdtCEoGNn5rmFBQNfVOnBFBUG9fMwf7FiwpzIFVIiNdcpWXCZI8VfZm7ba
        b16tahayloysz4ycCyzy2O1G2tnRQuBmTdj3ceBPQoutmmtqxeUmgXugrnf49fuUkGb8ES
        nqHwNP3YBDvG8ccyFPiDC9J2gsdr7tE=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-naiAGWBKPfSO9LViuYpY0A-1; Mon, 09 Oct 2023 09:43:59 -0400
X-MC-Unique: naiAGWBKPfSO9LViuYpY0A-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-45787667498so664309137.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 06:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696859039; x=1697463839;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dgVwLob78uVvWxqVfg4zqMaAddDB0vpZ0W6bwhsW9yw=;
        b=lE33dmrTkFDQWje4npPBy8CUOFhWndHWKb3HDwHpmp8vu6hUpYsMLxpaBMb3P0UaqV
         Te1Jzg066uPg+7tSST5y/gagIg0gWE+MoJMeF1y9PllQQd0/VR+xghxIMKcxCZmRXEme
         EgBoZArDBUmkFuvE/c/pZyPRtk82BhHSX5dyeCHB1aQRxsZfZoOTnjUGcNAMFW9v9QRp
         S7F5wEQCeXLF6WxpzeqHifHKBZETsAL8bppdLBLilvxOgUpjDJPxD2GliO5DoRSHz0tm
         kFufmDDixvA8aZy78DkQGOzYq8QgJqS5vu7tVyDD+GX3GQ1586FcyQ0Q4LJBe626dwpv
         XMkw==
X-Gm-Message-State: AOJu0YwsEh0SaxRTTp+wQjP+2tLClGCLSUKdQvPn7kexVbgX2NRIVP6g
        pbSbyBrNdM30mOySvinGV8XjKZWbu+tG+OYFsKQQAPJxsg+KGthAO+G5vrFkGZqP0Uvpdc9I6DL
        wdTFbF2GzLtnyMzYvaJ8IYes=
X-Received: by 2002:a05:6102:356f:b0:452:6d5b:f4b9 with SMTP id bh15-20020a056102356f00b004526d5bf4b9mr13544994vsb.12.1696859039176;
        Mon, 09 Oct 2023 06:43:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMiyX3vPUB0H+bkfRQHXVRvuUKXsgH2Jy6MJ+UVxjMplNQkJTmD1pcF0O3B2p0n5I7uw3sgA==
X-Received: by 2002:a05:6102:356f:b0:452:6d5b:f4b9 with SMTP id bh15-20020a056102356f00b004526d5bf4b9mr13544978vsb.12.1696859038847;
        Mon, 09 Oct 2023 06:43:58 -0700 (PDT)
Received: from [192.168.9.16] (net-2-34-30-58.cust.vodafonedsl.it. [2.34.30.58])
        by smtp.gmail.com with ESMTPSA id hg3-20020a05622a610300b0041977932fc6sm3636280qtb.18.2023.10.09.06.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 06:43:58 -0700 (PDT)
Message-ID: <3b832a39-1775-00ad-a319-06ea5b717235@redhat.com>
Date:   Mon, 9 Oct 2023 15:43:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Kunit: BUG: KASAN: null-ptr-deref in __fpga_bridge_get+0x88/0x100
 [fpga_bridge]
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org, David Gow <davidgow@google.com>,
        Rae Moar <rmoar@google.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, kunit-dev@googlegroups.com,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <CA+G9fYuOYvGL9ugszrpJdqO3EibfJz=1a1pg4mcUukjDwMQPSA@mail.gmail.com>
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <CA+G9fYuOYvGL9ugszrpJdqO3EibfJz=1a1pg4mcUukjDwMQPSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-10-08 08:29, Naresh Kamboju wrote:
> Following kernel bug and warning noticed while running fpga_bridge on
> arm64 Juno-r2 device running Linux next 6.6.0-rc4-next-20231006 tag.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Hi Naresh, and thanks for reporting. This issue has been already fixed:

https://lore.kernel.org/linux-fpga/20230929152057.85047-1-marpagan@redhat.com/

> 
> KUNIT_TEST_MODULE=snd-hda-cirrus-scodec-test.ko
> [  239.069569] KTAP version 1
> [  239.072540] 1..1
> [  239.074962]     KTAP version 1
> [  239.078060]     # Subtest: fpga_bridge
> [  239.081928]     # module: fpga_bridge_test
> [  239.082011]     1..3
> [  239.100750] ==================================================================
> [  239.108037] BUG: KASAN: null-ptr-deref in
> __fpga_bridge_get+0x88/0x100 [fpga_bridge]
> [  239.115958] Read of size 8 at addr 0000000000000010 by task
> kunit_try_catch/2052
> [  239.123410]
> [  239.124932] CPU: 3 PID: 2052 Comm: kunit_try_catch Tainted: G    B
>           N 6.6.0-rc4-next-20231006 #1
> [  239.134660] Hardware name: ARM Juno development board (r2) (DT)
> [  239.140624] Call trace:
> [  239.143097]  dump_backtrace+0x9c/0x128
> [  239.146913]  show_stack+0x20/0x38
> [  239.150278]  dump_stack_lvl+0x60/0xb0
> [  239.154005]  print_report+0x2f0/0x5d8
> [  239.157729]  kasan_report+0xc8/0x118
> [  239.161362]  __asan_load8+0x68/0xc0
> [  239.164911]  __fpga_bridge_get+0x88/0x100 [fpga_bridge]
> [  239.170290]  fpga_bridge_get+0x48/0x78 [fpga_bridge]
> [  239.175405]  fpga_bridge_test_get+0xa0/0x1a8 [fpga_bridge_test]
> [  239.181469]  kunit_try_run_case+0x84/0x110
> [  239.185633]  kunit_generic_run_threadfn_adapter+0x38/0x60
> [  239.191109]  kthread+0x18c/0x1a8
> [  239.194385]  ret_from_fork+0x10/0x20
> [  239.198017] ==================================================================
> [  239.205450] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000010
> [  239.214507] Mem abort info:
> [  239.217327]   ESR = 0x0000000096000004
> [  239.221158]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  239.226533]   SET = 0, FnV = 0
> [  239.229608]   EA = 0, S1PTW = 0
> [  239.233339]   FSC = 0x04: level 0 translation fault
> [  239.238263] Data abort info:
> [  239.241181]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [  239.246716]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [  239.251820]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [  239.257179] user pgtable: 4k pages, 48-bit VAs, pgdp=00000008ac6ec000
> [  239.263670] [0000000000000010] pgd=0000000000000000, p4d=0000000000000000
> [  239.270544] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> [  239.276840] Modules linked in: fpga_bridge_test(+) fpga_bridge
> tda998x hdlcd onboard_usb_hub cec crct10dif_ce drm_dma_helper
> drm_kms_helper drm fuse backlight dm_mod ip_tables x_tables
> [  239.293440] CPU: 1 PID: 2052 Comm: kunit_try_catch Tainted: G    B
>           N 6.6.0-rc4-next-20231006 #1
> [  239.303135] Hardware name: ARM Juno development board (r2) (DT)
> [  239.309076] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  239.316066] pc : __fpga_bridge_get+0x88/0x100 [fpga_bridge]
> [  239.321710] lr : __fpga_bridge_get+0x88/0x100 [fpga_bridge]
> [  239.327341] sp : ffff800089237d00
> [  239.330666] x29: ffff800089237d00 x28: 0000000000000000 x27: 0000000000000000
> [  239.337849] x26: ffff000800a6c600 x25: ffff8000892673e8 x24: ffff8000809cc528
> [  239.345031] x23: ffff000800a6c108 x22: 0000000000000000 x21: ffff000828683000
> [  239.352215] x20: ffff000828683300 x19: ffff000828683008 x18: 0000000000000000
> [  239.359400] x17: 3d3d3d3d3d3d3d3d x16: 3d3d3d3d3d3d3d3d x15: 3d3d3d3d3d3d3d3d
> [  239.366585] x14: 3d3d3d3d3d3d3d3d x13: 3d3d3d3d3d3d3d3d x12: ffff700010eb79f1
> [  239.373765] x11: 1ffff00010eb79f0 x10: ffff700010eb79f0 x9 : dfff800000000000
> [  239.380948] x8 : 00008fffef148610 x7 : ffff8000875bcf87 x6 : 0000000000000001
> [  239.388130] x5 : ffff8000875bcf80 x4 : ffff700010eb79f1 x3 : 0000000000000000
> [  239.395309] x2 : 0000000000040020 x1 : ffff00082d182300 x0 : 0000000000000001
> [  239.402488] Call trace:
> [  239.404943]  __fpga_bridge_get+0x88/0x100 [fpga_bridge]
> [  239.410232]  fpga_bridge_get+0x48/0x78 [fpga_bridge]
> [  239.415254]  fpga_bridge_test_get+0xa0/0x1a8 [fpga_bridge_test]
> [  239.421230]  kunit_try_run_case+0x84/0x110
> [  239.425362]  kunit_generic_run_threadfn_adapter+0x38/0x60
> [  239.430799]  kthread+0x18c/0x1a8
> [  239.434047]  ret_from_fork+0x10/0x20
> [  239.437656] Code: 9431930e f94036d6 910042c0 9431930b (f9400ac0)
> [  239.443769] ---[ end trace 0000000000000000 ]---
> [  545.778709]     # fpga_bridge_test_get: try timed out
> [  545.783886] ------------[ cut here ]------------
> [  545.788568] refcount_t: addition on 0; use-after-free.
> [  545.793835] WARNING: CPU: 1 PID: 2051 at lib/refcount.c:25
> refcount_warn_saturate+0x14c/0x178
> [  545.802410] Modules linked in: fpga_bridge_test(+) fpga_bridge
> tda998x hdlcd onboard_usb_hub cec crct10dif_ce drm_dma_helper
> drm_kms_helper drm fuse backlight dm_mod ip_tables x_tables
> [  545.819009] CPU: 1 PID: 2051 Comm: modprobe Tainted: G    B D
>    N 6.6.0-rc4-next-20231006 #1
> [  545.828090] Hardware name: ARM Juno development board (r2) (DT)
> [  545.834028] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  545.841017] pc : refcount_warn_saturate+0x14c/0x178
> [  545.845919] lr : refcount_warn_saturate+0x14c/0x178
> [  545.850819] sp : ffff8000892670c0
> [  545.854145] x29: ffff8000892670c0 x28: ffff8000820cdf40 x27: ffff80007f8d7480
> [  545.861328] x26: ffff8000892673f8 x25: ffff00082d182300 x24: ffff8000892673d0
> [  545.868510] x23: ffff800089267410 x22: ffff00082ea86e00 x21: ffff00082d182328
> [  545.875690] x20: ffff00082d182328 x19: 0000000000000002 x18: 0000000000000000
> [  545.882869] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [  545.890047] x14: 0000000000000000 x13: 2e656572662d7265 x12: ffff70001124cdb9
> [  545.897225] x11: 1ffff0001124cdb8 x10: ffff70001124cdb8 x9 : ffff8000801a10b8
> [  545.904405] x8 : 00008fffeedb3248 x7 : ffff800089266dc7 x6 : 0000000000000001
> [  545.911583] x5 : ffff800089266dc0 x4 : ffff70001124cdb9 x3 : dfff800000000000
> [  545.918762] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff00082d9e3480
> [  545.925940] Call trace:
> [  545.928394]  refcount_warn_saturate+0x14c/0x178
> [  545.932947]  kthread_stop+0x230/0x318
> [  545.936629]  kunit_try_catch_run+0x248/0x2a8
> [  545.940927]  kunit_run_case_catch_errors+0xdc/0x1b0
> [  545.945831]  kunit_run_tests+0x6d8/0x860
> [  545.949776]  __kunit_test_suites_init+0x9c/0xf0
> [  545.954332]  kunit_exec_run_tests+0x9c/0xb8
> [  545.958539]  kunit_module_notify+0x2f0/0x318
> [  545.962832]  notifier_call_chain+0x90/0x1c8
> [  545.967038]  blocking_notifier_call_chain_robust+0xc8/0x148
> [  545.972637]  load_module+0x296c/0x2d50
> [  545.976408]  init_module_from_file+0xdc/0x138
> [  545.980789]  __arm64_sys_finit_module+0x23c/0x458
> [  545.985517]  invoke_syscall+0x68/0x198
> [  545.989290]  el0_svc_common.constprop.0+0x80/0x150
> [  545.994108]  do_el0_svc+0x38/0x50
> [  545.997438]  el0_svc+0x3c/0x80
> [  546.000516]  el0t_64_sync_handler+0x120/0x130
> [  546.004897]  el0t_64_sync+0x190/0x198
> [  546.008577] ---[ end trace 0000000000000000 ]---
> [  546.013383] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000000
> [  546.022243] Mem abort info:
> [  546.025101]   ESR = 0x0000000096000004
> [  546.028922]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  546.034303]   SET = 0, FnV = 0
> [  546.037422]   EA = 0, S1PTW = 0
> [  546.040622]   FSC = 0x04: level 0 translation fault
> [  546.045556] Data abort info:
> [  546.048477]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [  546.054019]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [  546.059128]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [  546.064501] user pgtable: 4k pages, 48-bit VAs, pgdp=00000008b2af1000
> [  546.071027] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
> [  546.077909] Internal error: Oops: 0000000096000004 [#2] PREEMPT SMP
> [  546.084206] Modules linked in: fpga_bridge_test(+) fpga_bridge
> tda998x hdlcd onboard_usb_hub cec crct10dif_ce drm_dma_helper
> drm_kms_helper drm fuse backlight dm_mod ip_tables x_tables
> [  546.100801] CPU: 1 PID: 2051 Comm: modprobe Tainted: G    B D W
>    N 6.6.0-rc4-next-20231006 #1
> [  546.109884] Hardware name: ARM Juno development board (r2) (DT)
> [  546.115823] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  546.122811] pc : kthread_stop+0x1f4/0x318
> [  546.126846] lr : kthread_stop+0x78/0x318
> [  546.130788] sp : ffff8000892670e0
> [  546.134118] x29: ffff8000892670e0 x28: ffff8000820cdf40 x27: ffff80007f8d7480
> [  546.141300] x26: ffff8000892673f8 x25: ffff00082d182300 x24: ffff8000892673d0
> [  546.148480] x23: ffff800089267410 x22: ffff00082ea86e00 x21: ffff00082d182328
> [  546.155661] x20: 0000000000000000 x19: ffff00082d182300 x18: 0000000000000000
> [  546.162840] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [  546.170017] x14: 0000000000000000 x13: 2e656572662d7265 x12: ffff70001124cdb9
> [  546.177196] x11: 1ffff0001124cdb8 x10: ffff70001124cdb8 x9 : ffff8000801a10b8
> [  546.184375] x8 : ffff8000892670c0 x7 : 0000000000000000 x6 : 0000000000000001
> [  546.191559] x5 : 0000000000000000 x4 : ffff00082d9e3480 x3 : 0000000000000000
> [  546.198737] x2 : 0000000000000001 x1 : ffff80008760bd60 x0 : 0000000000000001
> [  546.205920] Call trace:
> [  546.208373]  kthread_stop+0x1f4/0x318
> [  546.212056]  kunit_try_catch_run+0x248/0x2a8
> [  546.216354]  kunit_run_case_catch_errors+0xdc/0x1b0
> [  546.221259]  kunit_run_tests+0x6d8/0x860
> [  546.225207]  __kunit_test_suites_init+0x9c/0xf0
> [  546.229762]  kunit_exec_run_tests+0x9c/0xb8
> [  546.233970]  kunit_module_notify+0x2f0/0x318
> [  546.238263]  notifier_call_chain+0x90/0x1c8
> [  546.242467]  blocking_notifier_call_chain_robust+0xc8/0x148
> [  546.248069]  load_module+0x296c/0x2d50
> [  546.251841]  init_module_from_file+0xdc/0x138
> [  546.256222]  __arm64_sys_finit_module+0x23c/0x458
> [  546.260954]  invoke_syscall+0x68/0x198
> [  546.264730]  el0_svc_common.constprop.0+0x80/0x150
> [  546.269548]  do_el0_svc+0x38/0x50
> [  546.272878]  el0_svc+0x3c/0x80
> [  546.275954]  el0t_64_sync_handler+0x120/0x130
> [  546.280336]  el0t_64_sync+0x190/0x198
> [  546.284024] Code: c8017e60 35ffffa1 17ffffae f9800291 (c85f7e80)
> [  546.290138] ---[ end trace 0000000000000000 ]---
> Segmentation fault
> modprobe-fpga-bridge-test fail
> 
> Links:
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231006/testrun/20279429/suite/log-parser-test/test/check-kernel-bug/log
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231006/testrun/20279429/suite/log-parser-test/tests/
>  - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2WO7UKXuHh4Z2jX19cmUhNchbyq
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2WO7RQfyDFoIvCa0HgqR2mRxOu8/
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2WO7RQfyDFoIvCa0HgqR2mRxOu8/config
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2WO7RQfyDFoIvCa0HgqR2mRxOu8/vmlinux.xz
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2WO7RQfyDFoIvCa0HgqR2mRxOu8/System.map
> 
> Step to reproduce:
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2WO7RQfyDFoIvCa0HgqR2mRxOu8/tuxmake_reproducer.sh
>  - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2WO7UKXuHh4Z2jX19cmUhNchbyq/reproducer
> 
> 
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
> 

