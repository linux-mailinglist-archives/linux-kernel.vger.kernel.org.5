Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9C0793A6C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbjIFKzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjIFKzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:55:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B0B810C8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 03:55:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B96AC106F;
        Wed,  6 Sep 2023 03:56:14 -0700 (PDT)
Received: from [10.57.93.3] (unknown [10.57.93.3])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2702A3F7C5;
        Wed,  6 Sep 2023 03:55:33 -0700 (PDT)
Message-ID: <b8e13cd6-7be7-1375-c625-a64ff81a49e3@arm.com>
Date:   Wed, 6 Sep 2023 11:55:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v16 20/20] drm/panfrost: Switch to generic memory shrinker
Content-Language: en-GB
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>, Emma Anholt <emma@anholt.net>,
        Melissa Wen <mwen@igalia.com>, kernel@collabora.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
References: <20230903170736.513347-1-dmitry.osipenko@collabora.com>
 <20230903170736.513347-21-dmitry.osipenko@collabora.com>
 <b07f5338-192d-7f11-8c07-bcbfd9617cd4@arm.com>
 <20230905100801.6d523065@collabora.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20230905100801.6d523065@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2023 09:08, Boris Brezillon wrote:
> On Mon, 4 Sep 2023 14:20:24 +0100
> Steven Price <steven.price@arm.com> wrote:
> 
>> On 03/09/2023 18:07, Dmitry Osipenko wrote:
>>> Replace Panfrost's custom memory shrinker with a common drm-shmem
>>> memory shrinker.
>>>
>>> Tested-by: Steven Price <steven.price@arm.com> # Firefly-RK3288  
>>
>> I just gave this version of the series a spin and I can trigger the following 
>> warning:
>>
>> [  477.776163] ------------[ cut here ]------------
>> [  477.781353] WARNING: CPU: 0 PID: 292 at drivers/gpu/drm/drm_gem_shmem_helper.c:227 drm_gem_shmem_free+0x1fc/0x200 [drm_shmem_helper]
>> [  477.794790] panfrost ffa30000.gpu: drm_WARN_ON(refcount_read(&shmem->pages_use_count))
>> [  477.794797] Modules linked in: panfrost gpu_sched drm_shmem_helper
>> [  477.810942] CPU: 0 PID: 292 Comm: glmark2-es2-drm Not tainted 6.5.0-rc2-00527-gc8a0c16fa830 #1
>> [  477.820564] Hardware name: Rockchip (Device Tree)
>> [  477.825820]  unwind_backtrace from show_stack+0x10/0x14
>> [  477.831670]  show_stack from dump_stack_lvl+0x58/0x70
>> [  477.837319]  dump_stack_lvl from __warn+0x7c/0x1a4
>> [  477.842680]  __warn from warn_slowpath_fmt+0x134/0x1a0
>> [  477.848429]  warn_slowpath_fmt from drm_gem_shmem_free+0x1fc/0x200 [drm_shmem_helper]
>> [  477.857199]  drm_gem_shmem_free [drm_shmem_helper] from drm_gem_handle_delete+0x84/0xb0
>> [  477.866163]  drm_gem_handle_delete from drm_ioctl+0x214/0x4ec
>> [  477.872592]  drm_ioctl from sys_ioctl+0x568/0xd48
>> [  477.877857]  sys_ioctl from ret_fast_syscall+0x0/0x1c
>> [  477.883504] Exception stack(0xf0a49fa8 to 0xf0a49ff0)
>> [  477.889148] 9fa0:                   005969c0 bef34880 00000006 40086409 bef34880 00000001
>> [  477.898289] 9fc0: 005969c0 bef34880 40086409 00000036 bef34880 00590b64 00590aec 00000000
>> [  477.907428] 9fe0: b6ec408c bef3485c b6ead42f b6c31f98
>> [  477.913188] irq event stamp: 37296889
>> [  477.917319] hardirqs last  enabled at (37296951): [<c03c1968>] __up_console_sem+0x50/0x60
>> [  477.926531] hardirqs last disabled at (37296972): [<c03c1954>] __up_console_sem+0x3c/0x60
>> [  477.935714] softirqs last  enabled at (37296986): [<c03016cc>] __do_softirq+0x318/0x4d4
>> [  477.944708] softirqs last disabled at (37296981): [<c034f9ec>] __irq_exit_rcu+0x140/0x160
>> [  477.953878] ---[ end trace 0000000000000000 ]---
>>
>> So something, somewhere has gone wrong with the reference counts.
> 
> Missing `got_pages_sgt = true;` in the fault handler, when creating the
> sgt and populating the first 2MB chunk, I guess (should have been part
> of "drm/shmem-helper: Use flag for tracking page count bumped by
> get_pages_sgt()"). This kinda proves my point though: adding flags
> for things that can be inferred from other fields is a bad idea, because
> there's always the risk of not updating all the places that are manually
> filling these other fields...

Yes that seems to fix the problem. And I agree derived fields like this
are often problematic - it's better to avoid them whenever possible.

Steve

