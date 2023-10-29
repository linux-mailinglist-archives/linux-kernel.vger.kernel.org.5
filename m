Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0577DAD44
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 17:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjJ2Qo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 12:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJ2Qo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 12:44:27 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E324BA
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 09:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1698597862; x=1698857062;
        bh=Ux15uBsDVRNF990iW+poZdFvmDjLyPM8ii5MUJdjiHo=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=tKIP+KN0K3WIgiFxDca/OGMTw1ppPHeL/iR7HbSIo2GMjJwA60fotec2TlAV6Czyk
         fNQqKmxctvRziC2Lb2h8Dyt9lkKounxPj1povVLfbVddZ49rzlhPcfcRwtYE807D/k
         6VeEVqtS6w6BnQttHT1Qx5OnUT7028wwm1qRXCqVQmcIeeOfp2uiJTvcuqnB9jmz7m
         AsHcgg0BOpv7ieYjI03MsVgUnX8TRfqqmVsNDbJYUEhOkSjfv2+JvHjtM1UBS74Yrn
         1byzMYuTQXqUiUBHoSWG2NdUToA2uCx7Ht/h/srk0DVZbYTg9zINNNjalpB/KgLJoV
         o+P0w1CsV0D6g==
Date:   Sun, 29 Oct 2023 16:44:18 +0000
To:     be286 <be286@163.com>
From:   Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: fix a crash in hid_debug_events_release
Message-ID: <87zg01l6oy.fsf@protonmail.com>
In-Reply-To: <406a0a08.60e7.18b6116f6a4.Coremail.be286@163.com>
References: <20231023093500.1391443-1-be286@163.com> <87a5s9mldo.fsf@protonmail.com> <406a0a08.60e7.18b6116f6a4.Coremail.be286@163.com>
Feedback-ID: 26003777:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct, 2023 17:49:36 +0800 "be286" <be286@163.com> wrote:
> Hi Rahul,
>
>
> When hid_debug_events_release() was being called, in most case,
> hid_device_release() finish already, the memory of list->hdev
> freed by hid_device_release(), if list->hdev memory =C2=A0
> reallocate by others, and it's modified, zeroed, then
> list->hdev->debug_list_lock occasioned crash come out.
>

This makes sense to me. Thanks for the additional explanation. I would
add this detail to the commit message body of your v2 to make the patch
clearer. With this explanation, I think your patch makes a lot of sense
to me and I understand better why you are seeing the trace you shared.

> The runing order:
>
> [=C2=A0 258.201069] CPU: 0 PID: 203 Comm: kworker/0:2 Not tainted 5.10.11=
0 #255
> [=C2=A0 258.201073] Hardware name: Rockchip RK3588 EVB4 LP4 V10 Board (DT=
)
> [=C2=A0 258.201086] Workqueue: usb_hub_wq hub_event
> [=C2=A0 258.201092] Call trace:
> [=C2=A0 258.201100] dump_backtrace+0x0/0x1f8
> [=C2=A0 258.201105] show_stack+0x1c/0x2c
> [=C2=A0 258.201112] dump_stack_lvl+0xd8/0x12c
> [=C2=A0 258.201116] dump_stack+0x1c/0x60
> [=C2=A0 258.201122] hid_device_release+0x94/0xb4
> [=C2=A0 258.201127] device_release+0x38/0x94
> [=C2=A0 258.201133] kobject_cleanup+0xd0/0x174
> [=C2=A0 258.201137] kobject_put+0x68/0xa8
> [=C2=A0 258.201143] put_device+0x1c/0x2c
> [=C2=A0 258.201146] hid_destroy_device+0x60/0x74
> [=C2=A0 258.201153] usbhid_disconnect+0x5c/0x90
> [=C2=A0 258.201157] usb_unbind_interface+0xc4/0x268
> [=C2=A0 258.201162] device_release_driver_internal+0x184/0x25c
> [=C2=A0 258.201165] device_release_driver+0x1c/0x2c
> [=C2=A0 258.201169] bus_remove_device+0xdc/0x138
> [=C2=A0 258.201173] device_del+0x1d0/0x3d8
> [=C2=A0 258.201177] usb_disable_device+0x108/0x228
> [=C2=A0 258.201181] usb_disconnect+0xf4/0x304
> [=C2=A0 258.201184] usb_disconnect+0xdc/0x304
> [=C2=A0 258.201188] hub_port_connect+0x88/0xa24
> [=C2=A0 258.201191] hub_port_connect_change+0x2d8/0x4cc
> [=C2=A0 258.201195] port_event+0x550/0x614
> [=C2=A0 258.201198] hub_event+0x12c/0x494
> [=C2=A0 258.201203] process_one_work+0x1f4/0x490
> [=C2=A0 258.201207] worker_thread+0x278/0x4dc
> [=C2=A0 258.201211] kthread+0x130/0x338
> [=C2=A0 258.201215] ret_from_fork+0x10/0x30
> [=C2=A0 259.925641] CPU: 1 PID: 2354 Comm: hidt_bridge Not tainted 5.10.1=
10 #255
> [=C2=A0 259.925652] Hardware name: Rockchip RK3588 EVB4 LP4 V10 Board (DT=
)
> [=C2=A0 259.925656] Call trace:
> [=C2=A0 259.925671] dump_backtrace+0x0/0x1f8
> [=C2=A0 259.925676] show_stack+0x1c/0x2c
> [=C2=A0 259.925685] dump_stack_lvl+0xd8/0x12c
> [=C2=A0 259.925689] dump_stack+0x1c/0x60
> [=C2=A0 259.925697] hid_debug_events_release+0x24/0x134
> [=C2=A0 259.925704] full_proxy_release+0x50/0xbc
> [=C2=A0 259.925709] __fput+0xdc/0x238
> [=C2=A0 259.925714] ____fput+0x14/0x24
> [=C2=A0 259.925720] task_work_run+0x90/0x148
> [=C2=A0 259.925725] do_exit+0x1bc/0x8a4
> [=C2=A0 259.925729] do_group_exit+0x8c/0xa4
> [=C2=A0 259.925734] get_signal+0x468/0x744
> [=C2=A0 259.925739] do_signal+0x84/0x280
> [=C2=A0 259.925743] do_notify_resume+0xd8/0x228
> [=C2=A0 259.925747] work_pending+0xc/0x3f0
>
> The crash:
>
> [=C2=A0 120.728477][ T4396] kernel BUG at lib/list_debug.c:53!
> [=C2=A0 120.728505][ T4396] Internal error: Oops - BUG: 0 [#1] PREEMPT SM=
P
> [=C2=A0 120.739806][ T4396] Modules linked in: bcmdhd dhd_static_buf 8822=
cu pcie_mhi r8168
> [=C2=A0 120.747386][ T4396] CPU: 1 PID: 4396 Comm: hidt_bridge Not tainte=
d 5.10.110 #257
> [=C2=A0 120.754771][ T4396] Hardware name: Rockchip RK3588 EVB4 LP4 V10 B=
oard (DT)
> [=C2=A0 120.761643][ T4396] pstate: 60400089 (nZCv daIf +PAN -UAO -TCO BT=
YPE=3D--)
> [=C2=A0 120.768338][ T4396] pc : __list_del_entry_valid+0x98/0xac
> [=C2=A0 120.773730][ T4396] lr : __list_del_entry_valid+0x98/0xac
> [=C2=A0 120.779120][ T4396] sp : ffffffc01e62bb60
> [=C2=A0 120.783126][ T4396] x29: ffffffc01e62bb60 x28: ffffff818ce3a200
> [=C2=A0 120.789126][ T4396] x27: 0000000000000009 x26: 0000000000980000
> [=C2=A0 120.795126][ T4396] x25: ffffffc012431000 x24: ffffff802c6d4e00
> [=C2=A0 120.801125][ T4396] x23: ffffff8005c66f00 x22: ffffffc01183b5b8
> [=C2=A0 120.807125][ T4396] x21: ffffff819df2f100 x20: 0000000000000000
> [=C2=A0 120.813124][ T4396] x19: ffffff802c3f0700 x18: ffffffc01d2cd058
> [=C2=A0 120.819124][ T4396] x17: 0000000000000000 x16: 0000000000000000
> [=C2=A0 120.825124][ T4396] x15: 0000000000000004 x14: 0000000000003fff
> [=C2=A0 120.831123][ T4396] x13: ffffffc012085588 x12: 0000000000000003
> [=C2=A0 120.837123][ T4396] x11: 00000000ffffbfff x10: 0000000000000003
> [=C2=A0 120.843123][ T4396] x9 : 455103d46b329300 x8 : 455103d46b329300
> [=C2=A0 120.849124][ T4396] x7 : 74707572726f6320 x6 : ffffffc0124b8cb5
> [=C2=A0 120.855124][ T4396] x5 : ffffffffffffffff x4 : 0000000000000000
> [=C2=A0 120.861123][ T4396] x3 : ffffffc011cf4f90 x2 : ffffff81fee7b948
> [=C2=A0 120.867122][ T4396] x1 : ffffffc011cf4f90 x0 : 0000000000000054
> [=C2=A0 120.873122][ T4396] Call trace:
> [=C2=A0 120.876259][ T4396]=C2=A0 __list_del_entry_valid+0x98/0xac
> [=C2=A0 120.881304][ T4396]=C2=A0 hid_debug_events_release+0x48/0x12c
> [=C2=A0 120.886617][ T4396]=C2=A0 full_proxy_release+0x50/0xbc
> [=C2=A0 120.891323][ T4396]=C2=A0 __fput+0xdc/0x238
> [=C2=A0 120.895075][ T4396]=C2=A0 ____fput+0x14/0x24
> [=C2=A0 120.898911][ T4396]=C2=A0 task_work_run+0x90/0x148
> [=C2=A0 120.903268][ T4396]=C2=A0 do_exit+0x1bc/0x8a4
> [=C2=A0 120.907193][ T4396]=C2=A0 do_group_exit+0x8c/0xa4
> [=C2=A0 120.911458][ T4396]=C2=A0 get_signal+0x468/0x744
> [=C2=A0 120.915643][ T4396]=C2=A0 do_signal+0x84/0x280
> [=C2=A0 120.919650][ T4396]=C2=A0 do_notify_resume+0xd0/0x218
> [=C2=A0 120.924262][ T4396]=C2=A0 work_pending+0xc/0x3f0
>

If you would like, you can use git notes to add the trace as well to the
notes summary of the patches you send out. This isn't a must but in case
you want to provide additional context in the future without having this
be a part of the commit message body.

  https://git-scm.com/docs/git-format-patch#Documentation/git-format-patch.=
txt---notesltrefgt

>
>
>
>
>
>
>
>
>
> At 2023-10-23 23:03:35, "Rahul Rameshbabu" <sergeantsagara@protonmail.com=
> wrote:
>>Hi Charles,
>>
>>On Mon, 23 Oct, 2023 17:35:00 +0800 "Charles Yi" <be286@163.com> wrote:
>>> hid_debug_events_release() access released memory by
>>> hid_device_release(). This is fixed by the patch.
>>>
>>
>>A couple of things here. Can you add a Fixes: tag?
>>
>>https://www.kernel.org/doc/html/latest/process/submitting-patches.html#de=
scribe-your-changes
>>
>>Before any v2 however, it would be nice to understand where this issue
>>is coming from. I am wondering if it's really a core issue or rather an
>>issue with a higher level device specific driver making use of the hid
>>subsystem. I am having a hard time seeing how this issue occurs
>>currently. A stack trace in a follow-up email to this one pertaining to
>>the crash would be helpful. If you are resolving a syzbot report, a link
>>to that report would suffice.
>>
>>This patch doesn't make a lot of sense to me as-is because
>>hid_debug_events_release is about release resources related to hid debug
>>events (at least from my current understanding). It should not be
>>free-ing the underlying hid device/instance itself.
>>
>>> Signed-off-by: Charles Yi <be286@163.com>
>>> ---

[...]

Sorry for the delay in being able to review this. Excited to see a v2
with a Fixes: tag.

--
Thanks,

Rahul Rameshbabu

