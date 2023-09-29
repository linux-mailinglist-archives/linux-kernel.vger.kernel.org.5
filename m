Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1422B7B31A1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 13:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbjI2LpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 07:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbjI2Lo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 07:44:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C60CD2;
        Fri, 29 Sep 2023 04:44:50 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:df6a:b81:b9d2:d824] (unknown [IPv6:2a01:e0a:120:3210:df6a:b81:b9d2:d824])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 04BA56607348;
        Fri, 29 Sep 2023 12:44:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695987888;
        bh=qgaeyAMHCG+vDRMksveND+A3wHNRH8b2/UFj4DAMjMQ=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=E2gyREQFb3Z5hHHpe0PUlvDOQz6LZ1w93kmSBfjX/ebIDNTelIvirjTyBrXxDwNbA
         dq6ISfWAFcBg1yoO2svpKImhQ6wrPYCu5jE913mEusNWtDAtaMpoB0rk15KVxt+A21
         rrlzNZl2bbaqiLYiSsdpb6GXL/2g7BXlunEXOP1dqkbcEsWYx/X6fT8nHHyKAaf7rB
         7E7E1nYjN2DSNmLMTReQmjdc3hrhjBOS/ZXW+tBoq9WFfmICUGzMZ+nHrk/tZl+UJn
         GYRB6W6nQiWn7ukXFvR3XvmilkAKwPEAwYztzN25mtK0yyfX2JCmrCNtzes7sIbeEt
         RLq3JZzL9c0BQ==
Message-ID: <38ec1120-7c92-833b-6e59-35086f4a3c10@collabora.com>
Date:   Fri, 29 Sep 2023 13:44:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v8 00/53] Add DELETE_BUF ioctl
Content-Language: en-US
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>, mchehab@kernel.org,
        tfiga@chromium.org, m.szyprowski@samsung.com, ming.qian@nxp.com,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
References: <20230927153558.159278-1-benjamin.gaignard@collabora.com>
 <ce043b11-aea9-4127-ba00-6c351651dc1e@xs4all.nl>
 <5cc5a999-e22d-4ef8-c857-ffd77630eeb9@collabora.com>
In-Reply-To: <5cc5a999-e22d-4ef8-c857-ffd77630eeb9@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 28/09/2023 à 15:16, Benjamin Gaignard a écrit :
>
> Le 28/09/2023 à 15:04, Hans Verkuil a écrit :
>> Hi Benjamin,
>>
>> On 27/09/2023 17:35, Benjamin Gaignard wrote:
>>> Unlike when resolution change on keyframes, dynamic resolution change
>>> on inter frames doesn't allow to do a stream off/on sequence because
>>> it is need to keep all previous references alive to decode inter 
>>> frames.
>>> This constraint have two main problems:
>>> - more memory consumption.
>>> - more buffers in use.
>>> To solve these issue this series introduce DELETE_BUFS ioctl and remove
>>> the 32 buffers limit per queue.
>>>
>>> VP9 conformance tests using fluster give a score of 210/305.
>>> The 24 resize inter tests (vp90-2-21-resize_inter_* files) are ok
>>> but require to use postprocessor.
>>>
>>> Kernel branch is available here:
>>> https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/commits/remove_vb2_queue_limit_v8 
>>>
>>>
>>> GStreamer branch to use DELETE_BUF ioctl and testing dynamic resolution
>>> change is here:
>>> https://gitlab.freedesktop.org/benjamin.gaignard1/gstreamer/-/commits/VP9_drc 
>>>
>> I applied patches 1-46 on top of staging and applied patch 1/2 of 
>> v4l-utils. I chose
>> 1-46 since those would be the first batch to be merged.
>>
>> I had to apply a small patch on top, since amphion was still using 
>> max_allowed_buffers:
>>
>> https://git.linuxtv.org/hverkuil/media_tree.git/commit/?h=delbuf&id=fce79aa0239a3a4e5c7634b9b7ffc356057b70b4 
>>
>>
>> With that change everything compiled cleanly.
>>
>> But running the regression tests (test-media script) failed with a 
>> kernel oops:
>>
>> Buffer ioctls (Input 0):
>>                  fail: v4l2-test-buffers.cpp(611): q.reqbufs(node, 1)
>>          test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: FAIL
>> [   25.309343] general protection fault, probably for non-canonical 
>> address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN
>> [   25.310067] KASAN: null-ptr-deref in range 
>> [0x0000000000000008-0x000000000000000f]
>> [   25.310471] CPU: 0 PID: 187 Comm: v4l2-compliance Not tainted 
>> 6.6.0-rc3+ #1
>> [   25.310837] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
>> BIOS 1.16.2-debian-1.16.2-1 04/01/2014
>> [   25.311334] RIP: 0010:__vb2_queue_alloc+0x34c/0xd00 
>> [videobuf2_common]
>> [   25.311688] Code: 89 f8 48 c1 e8 03 80 3c 18 00 0f 85 0c 07 00 00 
>> 49 8b b7 40 01 00 00 44 89 f0 4c 8d 2c c6 41 39 ce 73 18 4c 89 e8 48 
>> c1 e8 03 <80> 3c 18 00 0f 85 d2 08 00 00 49 83 7d 00 00 74 02
>> 0f 0b 4c 89 e8
>> [   25.312670] RSP: 0018:ffff88810afef930 EFLAGS: 00010212
>> [   25.312948] RAX: 0000000000000001 RBX: dffffc0000000000 RCX: 
>> 0000000000000040
>> [   25.313331] RDX: ffff88810ce08814 RSI: 0000000000000000 RDI: 
>> ffff88810cfb72e0
>> [   25.313708] RBP: ffff88810ce08800 R08: 0000000000001800 R09: 
>> 0000000000000001
>> [   25.314097] R10: ffffffff91560b0f R11: ffffffff8f40006a R12: 
>> ffff88810afefa74
>> [   25.314470] R13: 0000000000000008 R14: 0000000000000001 R15: 
>> ffff88810cfb71a0
>> [   25.314854] FS:  00007fa524908440(0000) GS:ffff88811aa00000(0000) 
>> knlGS:0000000000000000
>> [   25.315281] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   25.315594] CR2: 0000562855948270 CR3: 0000000109e21000 CR4: 
>> 0000000000350ef0
>> [   25.315982] Call Trace:
>> [   25.316122]  <TASK>
>> [   25.316243]  ? die_addr+0x37/0xa0
>> [   25.316433]  ? exc_general_protection+0x144/0x210
>> [   25.316693]  ? asm_exc_general_protection+0x22/0x30
>> [   25.316955]  ? entry_SYSCALL_64_after_hwframe+0x46/0xb0
>> [   25.317235]  ? __vb2_queue_alloc+0x34c/0xd00 [videobuf2_common]
>> [   25.317555]  vb2_core_create_bufs+0x5a0/0xce0 [videobuf2_common]
>> [   25.317879]  ? __vb2_queue_alloc+0xd00/0xd00 [videobuf2_common]
>> [   25.318213]  vb2_create_bufs+0x680/0x7f0 [videobuf2_v4l2]
>> [   25.318506]  ? __kasan_kmalloc+0x83/0x90
>> [   25.318729]  ? __kmalloc+0x5c/0x150
>> [   25.318924]  ? __video_do_ioctl+0x3a5/0xc20 [videodev]
>> [   25.319223]  ? __copy_timestamp+0x270/0x270 [videobuf2_v4l2]
>> [   25.319532]  ? v4l_sanitize_format+0x121/0x340 [videodev]
>> [   25.319839]  vb2_ioctl_create_bufs+0x280/0x440 [videobuf2_v4l2]
>> [   25.320162]  ? check_fmt+0x15/0x5e0 [videodev]
>> [   25.320420]  v4l_create_bufs+0xa8/0x150 [videodev]
>> [   25.320693]  __video_do_ioctl+0x8d0/0xc20 [videodev]
>> [   25.320975]  ? v4l_prepare_buf+0xa0/0xa0 [videodev]
>> [   25.321250]  ? __might_fault+0x112/0x170
>> [   25.321463]  ? __might_fault+0x112/0x170
>> [   25.321675]  video_usercopy+0x48c/0xd00 [videodev]
>> [   25.321949]  ? v4l_prepare_buf+0xa0/0xa0 [videodev]
>> [   25.322228]  ? v4l_enumstd+0x60/0x60 [videodev]
>> [   25.322497]  ? selinux_bprm_creds_for_exec+0xa90/0xa90
>> [   25.322779]  ? rseq_ip_fixup+0x304/0x480
>> [   25.322995]  ? __up_read+0x10b/0x750
>> [   25.323201]  ? rseq_get_rseq_cs+0x680/0x680
>> [   25.323430]  v4l2_ioctl+0x17f/0x1f0 [videodev]
>> [   25.323689]  __x64_sys_ioctl+0x127/0x190
>> [   25.323905]  do_syscall_64+0x35/0x80
>> [   25.324105]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
>> [   25.324372] RIP: 0033:0x7fa524bf44eb
>> [   25.324564] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 
>> 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 
>> 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b
>> 04 25 28 00 00
>> [   25.325533] RSP: 002b:00007ffc888efee0 EFLAGS: 00000246 ORIG_RAX: 
>> 0000000000000010
>> [   25.325933] RAX: ffffffffffffffda RBX: 00007ffc888f0350 RCX: 
>> 00007fa524bf44eb
>> [   25.326314] RDX: 00007ffc888effb0 RSI: 00000000c100565c RDI: 
>> 0000000000000023
>> [   25.326702] RBP: 00007ffc888f8550 R08: 0000000000000000 R09: 
>> 0000000000000001
>> [   25.327081] R10: 0000000000000016 R11: 0000000000000246 R12: 
>> 0000000000000000
>> [   25.327468] R13: 0000000000000001 R14: 00007ffc888f8010 R15: 
>> 00007ffc888f1790
>> [   25.327852]  </TASK>
>> [   25.327979] Modules linked in: vivid videobuf2_dma_contig v4l2_tpg 
>> v4l2_dv_timings cec videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 
>> videodev videobuf2_common mc rc_core
>> [   25.328835] ---[ end trace 0000000000000000 ]---
>> [   25.329083] RIP: 0010:__vb2_queue_alloc+0x34c/0xd00 
>> [videobuf2_common]
>> [   25.329434] Code: 89 f8 48 c1 e8 03 80 3c 18 00 0f 85 0c 07 00 00 
>> 49 8b b7 40 01 00 00 44 89 f0 4c 8d 2c c6 41 39 ce 73 18 4c 89 e8 48 
>> c1 e8 03 <80> 3c 18 00 0f 85 d2 08 00 00 49 83 7d 00 00 74 02
>> 0f 0b 4c 89 e8
>> [   25.330417] RSP: 0018:ffff88810afef930 EFLAGS: 00010212
>> [   25.330812] RAX: 0000000000000001 RBX: dffffc0000000000 RCX: 
>> 0000000000000040
>> [   25.331194] RDX: ffff88810ce08814 RSI: 0000000000000000 RDI: 
>> ffff88810cfb72e0
>> [   25.331594] RBP: ffff88810ce08800 R08: 0000000000001800 R09: 
>> 0000000000000001
>> [   25.331978] R10: ffffffff91560b0f R11: ffffffff8f40006a R12: 
>> ffff88810afefa74
>> [   25.332360] R13: 0000000000000008 R14: 0000000000000001 R15: 
>> ffff88810cfb71a0
>> [   25.332746] FS:  00007fa524908440(0000) GS:ffff88811aa00000(0000) 
>> knlGS:0000000000000000
>> [   25.333170] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   25.333486] CR2: 0000562855948270 CR3: 0000000109e21000 CR4: 
>> 0000000000350ef0
>> [   25.333861] Kernel panic - not syncing: Fatal exception
>> [   25.334179] Kernel Offset: 0xbe00000 from 0xffffffff81000000 
>> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>> [   25.334748] Rebooting in 30 seconds..
>>
>> I use the build scripts as described here:
>>
>> https://lore.kernel.org/linux-media/18989016-6392-a77b-6cf7-1223c9161def@xs4all.nl/ 
>>
>>
>> I use this command to run the regression tests:
>>
>> ./build.sh -virtme -virtme-utils-path /usr/local/bin none delbuf
>>
>> (delbuf is the name of my branch)
>>
>> I don't really want to spend time reviewing this series until this is 
>> fixed...
>
> Yes that make sense.
> It will work on it and let you now when I had fix it.
> Regards,
> Benjamin

This patch fix the problem:

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c 
b/drivers/media/common/videobuf2/videobuf2-core.c
index 320f37e46343..0598c1e4e9b5 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -428,6 +428,8 @@ static void vb2_queue_add_buffer(struct vb2_queue 
*q, struct vb2_buffer *vb, uns
   */
  static void vb2_queue_remove_buffer(struct vb2_buffer *vb)
  {
+    if (vb->vb2_queue->num_buffers)
+        vb->vb2_queue->num_buffers--;
      vb->vb2_queue->bufs[vb->index] = NULL;
      vb->vb2_queue = NULL;
  }
@@ -641,8 +643,8 @@ static void __vb2_queue_free(struct vb2_queue *q, 
unsigned int buffers)
  #endif

      /* Free vb2 buffers */
-    for (i = q->max_num_buffers, buffer = 0; i > 0 && buffer < buffers; 
i--) {
-        struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
+    for (i = q->max_num_buffers, buffer = 0; i >= 0 && buffer < 
buffers; i--) {
+        struct vb2_buffer *vb = vb2_get_buffer(q, i);

          if (!vb)
              continue;
@@ -2541,6 +2543,7 @@ void vb2_core_queue_release(struct vb2_queue *q)
      __vb2_queue_free(q, q->max_num_buffers);
      kfree(q->bufs);
      q->bufs = NULL;
+    q->num_buffers = 0;
      mutex_unlock(&q->mmap_lock);
  }
  EXPORT_SYMBOL_GPL(vb2_core_queue_release);

I'm preparing a v9 with this + your patch for Amphion driver:

https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/commits/remove_vb2_queue_limit_v9

Regards,

Benjamin


>
>>
>> Regards,
>>
>>     Hans
>>
>>> changes in version 8:
>>> - Add V4L2_BUF_CAP_SUPPORTS_SET_MAX_BUFS and new 'max_buffers' field 
>>> in v4l2_create_buffers
>>>    structure to report the maximum number of buffers that a queue 
>>> could allocate.
>>> - Add V4L2_BUF_CAP_SUPPORTS_DELETE_BUFS to indicate that a queue 
>>> support
>>>    DELETE_BUFS ioctl.
>>> - Make some test drivers use more than 32 buffers and DELETE_BUFS 
>>> ioctl.
>>> - Fix remarks done by Hans
>>> - Move "media: core: Rework how create_buf index returned value is
>>>    computed" patch to the top of the serie.
>>>
>>> changes in version 7:
>>> - Use a bitmap to know which entries are valid in queue bufs array.
>>>    The number of buffers in the queue could must calculated from the
>>>    bitmap so num_buffers becomes useless. This led to add quite few
>>>    patches to remove it from all the drivers.
>>>    Note: despiste my attention I may have miss some calls to
>>>    num_buffers...
>>> - Split patches to make them more readable.
>>> - Run v4l2-compliance with additional delete-bufs tests.
>>> - Run ./test-media -kmemleak vivid and no more failures.
>>>    Note: I had to remove USERPTR streaming test because they to much
>>>    frequentely hit get_framevec bug. It is not related to my series
>>>    since this happens all the time on master branch.
>>> - Fix Hans remarks on v6
>>>
>>> changes in version 6:
>>> - Get a patch per driver to use vb2_get_buffer() instead of directly 
>>> access
>>>    to queue buffers array.
>>> - Add lock in vb2_core_delete_buf()
>>> - Use vb2_buffer instead of index
>>> - Fix various comments
>>> - Change buffer index name to BUFFER_INDEX_MASK
>>> - Stop spamming kernel log with unbalanced counters
>>>
>>> changes in version 5:
>>> - Rework offset cookie encoding pattern is n ow the first patch of the
>>>    serie.
>>> - Use static array instead of allocated one for postprocessor buffers.
>>>
>>> changes in version 4:
>>> - Stop using Xarray, instead let queues decide about their own maximum
>>>    number of buffer and allocate bufs array given that value.
>>> - Rework offset cookie encoding pattern.
>>> - Change DELETE_BUF to DELETE_BUFS because it now usable for
>>>    range of buffer to be symetrical of CREATE_BUFS.
>>> - Add fixes tags on couple of Verisilicon related patches.
>>> - Be smarter in Verisilicon postprocessor buffers management.
>>> - Rebase on top of v6.4
>>>
>>> changes in version 3:
>>> - Use Xarray API to store allocated video buffers.
>>> - No module parameter to limit the number of buffer per queue.
>>> - Use Xarray inside Verisilicon driver to store postprocessor buffers
>>>    and remove VB2_MAX_FRAME limit.
>>> - Allow Versilicon driver to change of resolution while streaming
>>> - Various fixes the Verisilicon VP9 code to improve fluster score.
>>>   changes in version 2:
>>> - Use a dynamic array and not a list to keep trace of allocated 
>>> buffers.
>>>    Not use IDR interface because it is marked as deprecated in kernel
>>>    documentation.
>>> - Add a module parameter to limit the number of buffer per queue.
>>> - Add DELETE_BUF ioctl and m2m helpers.
>>>
>>> Regards,
>>> Benjamin
>>>
>>> Benjamin Gaignard (53):
>>>    media: videobuf2: Rework offset 'cookie' encoding pattern
>>>    media: videobuf2: Stop spamming kernel log with all queue counter
>>>    media: videobuf2: Use vb2_buffer instead of index
>>>    media: amphion: Use vb2_get_buffer() instead of directly access to
>>>      buffers array
>>>    media: mediatek: jpeg: Use vb2_get_buffer() instead of directly 
>>> access
>>>      to buffers array
>>>    media: mediatek: vdec: Remove useless loop
>>>    media: sti: hva: Use vb2_get_buffer() instead of directly access to
>>>      buffers array
>>>    media: visl: Use vb2_get_buffer() instead of directly access to
>>>      buffers array
>>>    media: atomisp: Use vb2_get_buffer() instead of directly access to
>>>      buffers array
>>>    media: dvb-core: Use vb2_get_buffer() instead of directly access to
>>>      buffers array
>>>    media: videobuf2: Access vb2_queue bufs array through helper 
>>> functions
>>>    media: videobuf2: Be more flexible on the number of queue stored
>>>      buffers
>>>    media: Report the maximum possible number of buffers for the queue
>>>    media: test-drivers: vivid: Increase max supported buffers for 
>>> capture
>>>      queues
>>>    media: test-drivers: vicodec: Increase max supported capture queue
>>>      buffers
>>>    media: verisilicon: Refactor postprocessor to store more buffers
>>>    media: verisilicon: Store chroma and motion vectors offset
>>>    media: verisilicon: g2: Use common helpers to compute chroma and mv
>>>      offsets
>>>    media: verisilicon: vp9: Allow to change resolution while streaming
>>>    media: Remove duplicated index vs q->num_buffers check
>>>    media: core: Add helper to get queue number of buffers
>>>    media: dvb-core: Do not initialize twice queue num_buffer field
>>>    media: dvb-frontends: rtl2832_srd: Use queue min_buffers_needed 
>>> field
>>>    media: video-i2c: Set min_buffers_needed to 2
>>>    media: pci: cx18: Set correct value to min_buffers_needed field
>>>    media: pci: dt3155: Remove useless check
>>>    media: pci: netup_unidvb: Remove useless number of buffers check
>>>    media: pci: tw68: Stop direct calls to queue num_buffers field
>>>    media: pci: tw686x: Set min_buffers_needed to 3
>>>    media: amphion: Stop direct calls to queue num_buffers field
>>>    media: coda: Stop direct calls to queue num_buffers field
>>>    media: mediatek: vcodec: Stop direct calls to queue num_buffers 
>>> field
>>>    media: nxp: Stop direct calls to queue num_buffers field
>>>    media: renesas: Set min_buffers_needed to 16
>>>    media: ti: Use queue min_buffers_needed field to set the min 
>>> number of
>>>      buffers
>>>    media: verisilicon: Stop direct calls to queue num_buffers field
>>>    media: test-drivers: Stop direct calls to queue num_buffers field
>>>    media: usb: airspy: Set min_buffers_needed to 8
>>>    media: usb: cx231xx: Set min_buffers_needed to CX231XX_MIN_BUF
>>>    media: usb: hackrf: Set min_buffers_needed to 8
>>>    media: usb: usbtv: Set min_buffers_needed to 2
>>>    media: atomisp: Stop direct calls to queue num_buffers field
>>>    media: imx: Stop direct calls to queue num_buffers field
>>>    media: meson: vdec: Stop direct calls to queue num_buffers field
>>>    touchscreen: sur40: Stop direct calls to queue num_buffers field
>>>    sample: v4l: Stop direct calls to queue num_buffers field
>>>    media: cedrus: Stop direct calls to queue num_buffers field
>>>    media: core: Rework how create_buf index returned value is computed
>>>    media: core: Add bitmap manage bufs array entries
>>>    media: core: Free range of buffers
>>>    media: v4l2: Add DELETE_BUFS ioctl
>>>    media: v4l2: Add mem2mem helpers for DELETE_BUFS ioctl
>>>    media: test-drivers: Use helper for DELETE_BUFS ioctl
>>>
>>>   .../userspace-api/media/v4l/user-func.rst     |   1 +
>>>   .../media/v4l/vidioc-create-bufs.rst          |   8 +-
>>>   .../media/v4l/vidioc-delete-bufs.rst          |  80 +++
>>>   .../media/v4l/vidioc-reqbufs.rst              |   2 +
>>>   drivers/input/touchscreen/sur40.c             |   5 +-
>>>   .../media/common/videobuf2/videobuf2-core.c   | 556 
>>> +++++++++++-------
>>>   .../media/common/videobuf2/videobuf2-v4l2.c   | 121 +++-
>>>   drivers/media/dvb-core/dvb_vb2.c              |  17 +-
>>>   drivers/media/dvb-frontends/rtl2832_sdr.c     |   9 +-
>>>   drivers/media/i2c/video-i2c.c                 |   5 +-
>>>   drivers/media/pci/cx18/cx18-streams.c         |  13 +-
>>>   drivers/media/pci/dt3155/dt3155.c             |   2 -
>>>   .../pci/netup_unidvb/netup_unidvb_core.c      |   4 +-
>>>   drivers/media/pci/tw68/tw68-video.c           |   6 +-
>>>   drivers/media/pci/tw686x/tw686x-video.c       |  13 +-
>>>   drivers/media/platform/amphion/vpu_dbg.c      |  30 +-
>>>   drivers/media/platform/amphion/vpu_v4l2.c     |   4 +-
>>>   .../media/platform/chips-media/coda-common.c  |   2 +-
>>>   .../platform/mediatek/jpeg/mtk_jpeg_core.c    |   7 +-
>>>   .../vcodec/decoder/vdec/vdec_vp9_req_lat_if.c |   9 +-
>>>   .../mediatek/vcodec/encoder/mtk_vcodec_enc.c  |   2 +-
>>>   drivers/media/platform/nxp/imx7-media-csi.c   |   7 +-
>>>   drivers/media/platform/renesas/rcar_drif.c    |   8 +-
>>>   drivers/media/platform/st/sti/hva/hva-v4l2.c  |   9 +-
>>>   .../media/platform/ti/am437x/am437x-vpfe.c    |   7 +-
>>>   drivers/media/platform/ti/cal/cal-video.c     |   5 +-
>>>   .../media/platform/ti/davinci/vpif_capture.c  |   5 +-
>>>   .../media/platform/ti/davinci/vpif_display.c  |   5 +-
>>>   drivers/media/platform/ti/omap/omap_vout.c    |   5 +-
>>>   drivers/media/platform/verisilicon/hantro.h   |   9 +-
>>>   .../media/platform/verisilicon/hantro_drv.c   |   5 +-
>>>   .../media/platform/verisilicon/hantro_g2.c    |  14 +
>>>   .../platform/verisilicon/hantro_g2_hevc_dec.c |  18 +-
>>>   .../platform/verisilicon/hantro_g2_vp9_dec.c  |  28 +-
>>>   .../media/platform/verisilicon/hantro_hw.h    |   7 +-
>>>   .../platform/verisilicon/hantro_postproc.c    |  93 ++-
>>>   .../media/platform/verisilicon/hantro_v4l2.c  |  27 +-
>>>   .../media/test-drivers/vicodec/vicodec-core.c |   3 +
>>>   drivers/media/test-drivers/vim2m.c            |   2 +
>>>   .../media/test-drivers/vimc/vimc-capture.c    |   2 +
>>>   drivers/media/test-drivers/visl/visl-dec.c    |  32 +-
>>>   drivers/media/test-drivers/visl/visl-video.c  |   2 +
>>>   drivers/media/test-drivers/vivid/vivid-core.c |  14 +
>>>   .../media/test-drivers/vivid/vivid-meta-cap.c |   3 -
>>>   .../media/test-drivers/vivid/vivid-meta-out.c |   5 +-
>>>   .../test-drivers/vivid/vivid-touch-cap.c      |   5 +-
>>>   .../media/test-drivers/vivid/vivid-vbi-cap.c  |   5 +-
>>>   .../media/test-drivers/vivid/vivid-vbi-out.c  |   5 +-
>>>   .../media/test-drivers/vivid/vivid-vid-cap.c  |   5 +-
>>>   .../media/test-drivers/vivid/vivid-vid-out.c  |   5 +-
>>>   drivers/media/usb/airspy/airspy.c             |   9 +-
>>>   drivers/media/usb/cx231xx/cx231xx-417.c       |   4 +-
>>>   drivers/media/usb/cx231xx/cx231xx-video.c     |   4 +-
>>>   drivers/media/usb/hackrf/hackrf.c             |   9 +-
>>>   drivers/media/usb/usbtv/usbtv-video.c         |   3 +-
>>>   drivers/media/v4l2-core/v4l2-dev.c            |   1 +
>>>   drivers/media/v4l2-core/v4l2-ioctl.c          |  21 +-
>>>   drivers/media/v4l2-core/v4l2-mem2mem.c        |  20 +
>>>   .../staging/media/atomisp/pci/atomisp_ioctl.c |   4 +-
>>>   drivers/staging/media/imx/imx-media-capture.c |   7 +-
>>>   drivers/staging/media/meson/vdec/vdec.c       |  13 +-
>>>   .../staging/media/sunxi/cedrus/cedrus_h264.c  |   8 +-
>>>   .../staging/media/sunxi/cedrus/cedrus_h265.c  |   9 +-
>>>   include/media/v4l2-ioctl.h                    |   4 +
>>>   include/media/v4l2-mem2mem.h                  |  12 +
>>>   include/media/videobuf2-core.h                |  65 +-
>>>   include/media/videobuf2-v4l2.h                |  13 +
>>>   include/uapi/linux/videodev2.h                |  24 +-
>>>   samples/v4l/v4l2-pci-skeleton.c               |   5 +-
>>>   69 files changed, 969 insertions(+), 502 deletions(-)
>>>   create mode 100644 
>>> Documentation/userspace-api/media/v4l/vidioc-delete-bufs.rst
>>>
>> _______________________________________________
>> Kernel mailing list -- kernel@mailman.collabora.com
>> To unsubscribe send an email to kernel-leave@mailman.collabora.com
