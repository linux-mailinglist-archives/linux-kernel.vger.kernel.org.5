Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972E57B334D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjI2NRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjI2NRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:17:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CACB7;
        Fri, 29 Sep 2023 06:17:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED1BC433C7;
        Fri, 29 Sep 2023 13:17:10 +0000 (UTC)
Message-ID: <9c38c002-8452-4fb7-a7ee-cc8e9e1b849e@xs4all.nl>
Date:   Fri, 29 Sep 2023 15:17:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/53] Add DELETE_BUF ioctl
Content-Language: en-US, nl
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
References: <20230927153558.159278-1-benjamin.gaignard@collabora.com>
 <ce043b11-aea9-4127-ba00-6c351651dc1e@xs4all.nl>
 <5cc5a999-e22d-4ef8-c857-ffd77630eeb9@collabora.com>
 <38ec1120-7c92-833b-6e59-35086f4a3c10@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <38ec1120-7c92-833b-6e59-35086f4a3c10@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2023 13:44, Benjamin Gaignard wrote:
> 
> Le 28/09/2023 à 15:16, Benjamin Gaignard a écrit :
>>
>> Le 28/09/2023 à 15:04, Hans Verkuil a écrit :
>>> Hi Benjamin,
>>>
>>> On 27/09/2023 17:35, Benjamin Gaignard wrote:
>>>> Unlike when resolution change on keyframes, dynamic resolution change
>>>> on inter frames doesn't allow to do a stream off/on sequence because
>>>> it is need to keep all previous references alive to decode inter frames.
>>>> This constraint have two main problems:
>>>> - more memory consumption.
>>>> - more buffers in use.
>>>> To solve these issue this series introduce DELETE_BUFS ioctl and remove
>>>> the 32 buffers limit per queue.
>>>>
>>>> VP9 conformance tests using fluster give a score of 210/305.
>>>> The 24 resize inter tests (vp90-2-21-resize_inter_* files) are ok
>>>> but require to use postprocessor.
>>>>
>>>> Kernel branch is available here:
>>>> https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/commits/remove_vb2_queue_limit_v8
>>>>
>>>> GStreamer branch to use DELETE_BUF ioctl and testing dynamic resolution
>>>> change is here:
>>>> https://gitlab.freedesktop.org/benjamin.gaignard1/gstreamer/-/commits/VP9_drc
>>> I applied patches 1-46 on top of staging and applied patch 1/2 of v4l-utils. I chose
>>> 1-46 since those would be the first batch to be merged.
>>>
>>> I had to apply a small patch on top, since amphion was still using max_allowed_buffers:
>>>
>>> https://git.linuxtv.org/hverkuil/media_tree.git/commit/?h=delbuf&id=fce79aa0239a3a4e5c7634b9b7ffc356057b70b4
>>>
>>> With that change everything compiled cleanly.
>>>
>>> But running the regression tests (test-media script) failed with a kernel oops:
>>>
>>> Buffer ioctls (Input 0):
>>>                  fail: v4l2-test-buffers.cpp(611): q.reqbufs(node, 1)
>>>          test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: FAIL
>>> [   25.309343] general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN
>>> [   25.310067] KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
>>> [   25.310471] CPU: 0 PID: 187 Comm: v4l2-compliance Not tainted 6.6.0-rc3+ #1
>>> [   25.310837] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
>>> [   25.311334] RIP: 0010:__vb2_queue_alloc+0x34c/0xd00 [videobuf2_common]
>>> [   25.311688] Code: 89 f8 48 c1 e8 03 80 3c 18 00 0f 85 0c 07 00 00 49 8b b7 40 01 00 00 44 89 f0 4c 8d 2c c6 41 39 ce 73 18 4c 89 e8 48 c1 e8 03 <80> 3c 18 00 0f 85 d2 08 00 00 49 83 7d 00 00 74 02
>>> 0f 0b 4c 89 e8
>>> [   25.312670] RSP: 0018:ffff88810afef930 EFLAGS: 00010212
>>> [   25.312948] RAX: 0000000000000001 RBX: dffffc0000000000 RCX: 0000000000000040
>>> [   25.313331] RDX: ffff88810ce08814 RSI: 0000000000000000 RDI: ffff88810cfb72e0
>>> [   25.313708] RBP: ffff88810ce08800 R08: 0000000000001800 R09: 0000000000000001
>>> [   25.314097] R10: ffffffff91560b0f R11: ffffffff8f40006a R12: ffff88810afefa74
>>> [   25.314470] R13: 0000000000000008 R14: 0000000000000001 R15: ffff88810cfb71a0
>>> [   25.314854] FS:  00007fa524908440(0000) GS:ffff88811aa00000(0000) knlGS:0000000000000000
>>> [   25.315281] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [   25.315594] CR2: 0000562855948270 CR3: 0000000109e21000 CR4: 0000000000350ef0
>>> [   25.315982] Call Trace:
>>> [   25.316122]  <TASK>
>>> [   25.316243]  ? die_addr+0x37/0xa0
>>> [   25.316433]  ? exc_general_protection+0x144/0x210
>>> [   25.316693]  ? asm_exc_general_protection+0x22/0x30
>>> [   25.316955]  ? entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>> [   25.317235]  ? __vb2_queue_alloc+0x34c/0xd00 [videobuf2_common]
>>> [   25.317555]  vb2_core_create_bufs+0x5a0/0xce0 [videobuf2_common]
>>> [   25.317879]  ? __vb2_queue_alloc+0xd00/0xd00 [videobuf2_common]
>>> [   25.318213]  vb2_create_bufs+0x680/0x7f0 [videobuf2_v4l2]
>>> [   25.318506]  ? __kasan_kmalloc+0x83/0x90
>>> [   25.318729]  ? __kmalloc+0x5c/0x150
>>> [   25.318924]  ? __video_do_ioctl+0x3a5/0xc20 [videodev]
>>> [   25.319223]  ? __copy_timestamp+0x270/0x270 [videobuf2_v4l2]
>>> [   25.319532]  ? v4l_sanitize_format+0x121/0x340 [videodev]
>>> [   25.319839]  vb2_ioctl_create_bufs+0x280/0x440 [videobuf2_v4l2]
>>> [   25.320162]  ? check_fmt+0x15/0x5e0 [videodev]
>>> [   25.320420]  v4l_create_bufs+0xa8/0x150 [videodev]
>>> [   25.320693]  __video_do_ioctl+0x8d0/0xc20 [videodev]
>>> [   25.320975]  ? v4l_prepare_buf+0xa0/0xa0 [videodev]
>>> [   25.321250]  ? __might_fault+0x112/0x170
>>> [   25.321463]  ? __might_fault+0x112/0x170
>>> [   25.321675]  video_usercopy+0x48c/0xd00 [videodev]
>>> [   25.321949]  ? v4l_prepare_buf+0xa0/0xa0 [videodev]
>>> [   25.322228]  ? v4l_enumstd+0x60/0x60 [videodev]
>>> [   25.322497]  ? selinux_bprm_creds_for_exec+0xa90/0xa90
>>> [   25.322779]  ? rseq_ip_fixup+0x304/0x480
>>> [   25.322995]  ? __up_read+0x10b/0x750
>>> [   25.323201]  ? rseq_get_rseq_cs+0x680/0x680
>>> [   25.323430]  v4l2_ioctl+0x17f/0x1f0 [videodev]
>>> [   25.323689]  __x64_sys_ioctl+0x127/0x190
>>> [   25.323905]  do_syscall_64+0x35/0x80
>>> [   25.324105]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>> [   25.324372] RIP: 0033:0x7fa524bf44eb
>>> [   25.324564] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b
>>> 04 25 28 00 00
>>> [   25.325533] RSP: 002b:00007ffc888efee0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>>> [   25.325933] RAX: ffffffffffffffda RBX: 00007ffc888f0350 RCX: 00007fa524bf44eb
>>> [   25.326314] RDX: 00007ffc888effb0 RSI: 00000000c100565c RDI: 0000000000000023
>>> [   25.326702] RBP: 00007ffc888f8550 R08: 0000000000000000 R09: 0000000000000001
>>> [   25.327081] R10: 0000000000000016 R11: 0000000000000246 R12: 0000000000000000
>>> [   25.327468] R13: 0000000000000001 R14: 00007ffc888f8010 R15: 00007ffc888f1790
>>> [   25.327852]  </TASK>
>>> [   25.327979] Modules linked in: vivid videobuf2_dma_contig v4l2_tpg v4l2_dv_timings cec videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videodev videobuf2_common mc rc_core
>>> [   25.328835] ---[ end trace 0000000000000000 ]---
>>> [   25.329083] RIP: 0010:__vb2_queue_alloc+0x34c/0xd00 [videobuf2_common]
>>> [   25.329434] Code: 89 f8 48 c1 e8 03 80 3c 18 00 0f 85 0c 07 00 00 49 8b b7 40 01 00 00 44 89 f0 4c 8d 2c c6 41 39 ce 73 18 4c 89 e8 48 c1 e8 03 <80> 3c 18 00 0f 85 d2 08 00 00 49 83 7d 00 00 74 02
>>> 0f 0b 4c 89 e8
>>> [   25.330417] RSP: 0018:ffff88810afef930 EFLAGS: 00010212
>>> [   25.330812] RAX: 0000000000000001 RBX: dffffc0000000000 RCX: 0000000000000040
>>> [   25.331194] RDX: ffff88810ce08814 RSI: 0000000000000000 RDI: ffff88810cfb72e0
>>> [   25.331594] RBP: ffff88810ce08800 R08: 0000000000001800 R09: 0000000000000001
>>> [   25.331978] R10: ffffffff91560b0f R11: ffffffff8f40006a R12: ffff88810afefa74
>>> [   25.332360] R13: 0000000000000008 R14: 0000000000000001 R15: ffff88810cfb71a0
>>> [   25.332746] FS:  00007fa524908440(0000) GS:ffff88811aa00000(0000) knlGS:0000000000000000
>>> [   25.333170] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [   25.333486] CR2: 0000562855948270 CR3: 0000000109e21000 CR4: 0000000000350ef0
>>> [   25.333861] Kernel panic - not syncing: Fatal exception
>>> [   25.334179] Kernel Offset: 0xbe00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>>> [   25.334748] Rebooting in 30 seconds..
>>>
>>> I use the build scripts as described here:
>>>
>>> https://lore.kernel.org/linux-media/18989016-6392-a77b-6cf7-1223c9161def@xs4all.nl/
>>>
>>> I use this command to run the regression tests:
>>>
>>> ./build.sh -virtme -virtme-utils-path /usr/local/bin none delbuf
>>>
>>> (delbuf is the name of my branch)
>>>
>>> I don't really want to spend time reviewing this series until this is fixed...
>>
>> Yes that make sense.
>> It will work on it and let you now when I had fix it.
>> Regards,
>> Benjamin
> 
> This patch fix the problem:
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index 320f37e46343..0598c1e4e9b5 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -428,6 +428,8 @@ static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, uns
>   */
>  static void vb2_queue_remove_buffer(struct vb2_buffer *vb)
>  {
> +    if (vb->vb2_queue->num_buffers)
> +        vb->vb2_queue->num_buffers--;
>      vb->vb2_queue->bufs[vb->index] = NULL;
>      vb->vb2_queue = NULL;
>  }
> @@ -641,8 +643,8 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>  #endif
> 
>      /* Free vb2 buffers */
> -    for (i = q->max_num_buffers, buffer = 0; i > 0 && buffer < buffers; i--) {
> -        struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
> +    for (i = q->max_num_buffers, buffer = 0; i >= 0 && buffer < buffers; i--) {
> +        struct vb2_buffer *vb = vb2_get_buffer(q, i);
> 
>          if (!vb)
>              continue;
> @@ -2541,6 +2543,7 @@ void vb2_core_queue_release(struct vb2_queue *q)
>      __vb2_queue_free(q, q->max_num_buffers);
>      kfree(q->bufs);
>      q->bufs = NULL;
> +    q->num_buffers = 0;
>      mutex_unlock(&q->mmap_lock);
>  }
>  EXPORT_SYMBOL_GPL(vb2_core_queue_release);
> 
> I'm preparing a v9 with this + your patch for Amphion driver:
> 
> https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/commits/remove_vb2_queue_limit_v9

Even with this patch I still get errors. Did you just test vivid?

Run 'test-media mc' to test it for all virtual drivers. I get both compliance
failures, a WARN_ON in drivers/media/common/videobuf2/videobuf2-core.c:2489,
and memory leaks. It currently fails and exists completely with the vimc tests,
but things may already have gone pear-shaped with the vim2m test.

I'll mail you the full output from a test run with the build scripts
separately (it's a bit too big to add here).

I don't know if you can run the build script with the -virtme option, instructions
for that are currently only available for debian 12. If not, then ask Sebastian
Fricke (he is working on a docker for this), alternatively you can take
configs/virtme.config from the build scripts git repo and use that as the kernel
config to test under. This config enables memory leak detection and a whole bunch
of other debugging stuff.

Regards,

	Hans
