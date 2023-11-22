Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7253D7F44A9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbjKVLDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbjKVLD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:03:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07F11703
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:03:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1919FC433CD;
        Wed, 22 Nov 2023 11:03:03 +0000 (UTC)
Message-ID: <38207856-0310-46b9-85d3-98553a2533a7@xs4all.nl>
Date:   Wed, 22 Nov 2023 12:03:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] [PATCH] media: amphion: Move the blocking
 check_is_responsed() out of wait event loop
Content-Language: en-US, nl
To:     Ming Qian <ming.qian@nxp.com>,
        Xiaolei Wang <xiaolei.wang@windriver.com>,
        Eagle Zhou <eagle.zhou@nxp.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>
Cc:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231024052709.2897714-1-xiaolei.wang@windriver.com>
 <AM6PR04MB6341E9DCD1BC75F6F7773DA9E7DFA@AM6PR04MB6341.eurprd04.prod.outlook.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <AM6PR04MB6341E9DCD1BC75F6F7773DA9E7DFA@AM6PR04MB6341.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2023 09:12, Ming Qian wrote:
>> From: Xiaolei Wang <xiaolei.wang@windriver.com>
>> Sent: 2023年10月24日 13:27
>> To: Ming Qian <ming.qian@nxp.com>; Eagle Zhou <eagle.zhou@nxp.com>;
>> hverkuil-cisco@xs4all.nl; mchehab@kernel.org
>> Cc: linux-media@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: [EXT] [PATCH] media: amphion: Move the blocking
>> check_is_responsed() out of wait event loop
>>
>> Caution: This is an external email. Please take care when clicking links or
>> opening attachments. When in doubt, report the message using the 'Report
>> this email' button
>>
>>
>> The blocking ops can't be used as a condition parameter of
>> wait_event_timeout(), otherwise we would get a warning like below:
>>
>> do not call blocking ops when !TASK_RUNNING; state=2
>> WARNING: CPU: 5 PID: 741 at kernel/sched/core.c:9859
>> __might_sleep+0x80/0xa4
>> CPU: 5 PID: 741 Comm: mxc_v4l2_vpu_te Tainted: G         C         6.1.55-yocto-
>> standard #1
>> Hardware name: Freescale i.MX8QM MEK (DT)
>> pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)  pc :
>> __might_sleep+0x80/0xa4  lr : __might_sleep+0x80/0xa4  sp : ffffffc0123738a0
>> x29: ffffffc0123738a0 x28: ffffffc009194c48 x27: ffffffc00bbc1050
>> x26: ffffff8814b282f0 x25: ffffff8814b280d0 x24: ffffff8814b28080
>> x23: 0000000000000001 x22: 0000000000000032 x21: ffffffc00bbc1000
>> x20: 000000000000011b x19: ffffffc009324670 x18: 00000000fffffffd
>> x17: 30303c5b20746120 x16: 74657320323d6574 x15: 617473203b474e49
>> x14: 00058b5b8b9aa1f1 x13: ffffffc00903cda0 x12: 00000000d744fcc9
>> x11: 000000000000001c x10: 00000000000009a0 x9 : ffffffc0090201f4
>> x8 : ffffff8828245000 x7 : 0000000000000001 x6 : 0000000000000001
>> x5 : 00000000410fd080 x4 : 0000000000000002 x3 : ffffff8815aab4c8
>> x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffff8828244600
>>  Call trace:
>>  __might_sleep+0x80/0xa4
>>  mutex_lock+0x2c/0x80
>>  sync_session_response+0x110/0x310
>>  vpu_session_send_cmd+0x18c/0x244
>>  vpu_session_start+0x38/0x70
>>  vdec_start_session+0x1b4/0x3e0
>>  vpu_vb2_start_streaming+0xa0/0x1c4
>>  vb2_start_streaming+0x74/0x160
>>  vb2_core_qbuf+0x488/0x650
>>  vb2_qbuf+0x9c/0x100
>>  v4l2_m2m_qbuf+0x7c/0x224
>>  v4l2_m2m_ioctl_qbuf+0x20/0x2c
>>  v4l_qbuf+0x50/0x6c
>>  __video_do_ioctl+0x174/0x3f0
>>  video_usercopy+0x210/0x7cc
>>  video_ioctl2+0x20/0x30
>>  v4l2_ioctl+0x48/0x6c
>>
>> It is not easy to convert the check_is_responsed() to a non-block function. In
>> order to fix this issue, use a unwinding implementation of
>> wait_event_timeout().
> 
> Hi Xiaolei,
> 
>     Thanks for your patch, this issue is caused by calling mutex_lock() in condition parameter of
> wait_event_timeout(), I think we can fix this issue, then we can still use wait_event_timeout()
> instead of rewrite it.

Based on this reply I am marking this in patchwork as "Changes Requested".
Let me know if I misinterpreted this.

Regards,

	Hans

> 
> Ming
> 
>>
>> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
>>
>> squash! media: amphion: Move the blocking check_is_responsed() out of wait
>> event loop
>> ---
>> drivers/media/platform/amphion/vpu_cmds.c | 15 ++++++++++++++-
>> 1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/amphion/vpu_cmds.c
>> b/drivers/media/platform/amphion/vpu_cmds.c
>> index c2337812573e..1abec8d9dad5 100644
>> --- a/drivers/media/platform/amphion/vpu_cmds.c
>> +++ b/drivers/media/platform/amphion/vpu_cmds.c
>> @@ -271,6 +271,7 @@ static bool check_is_responsed(struct vpu_inst *inst,
>> unsigned long key)  static int sync_session_response(struct vpu_inst *inst,
>> unsigned long key, long timeout, int try)  {
>>        struct vpu_core *core;
>> +       struct wait_queue_entry wq_entry;
>>
>>        if (!inst || !inst->core)
>>                return -EINVAL;
>> @@ -278,7 +279,19 @@ static int sync_session_response(struct vpu_inst *inst,
>> unsigned long key, long
>>        core = inst->core;
>>
>>        call_void_vop(inst, wait_prepare);
>> -       wait_event_timeout(core->ack_wq, check_is_responsed(inst, key),
>> timeout);
>> +       init_wait_entry(&wq_entry, 0);
>> +       for (;;) {
>> +               if (check_is_responsed(inst, key))
>> +                       break;
>> +
>> +               prepare_to_wait_event(&core->ack_wq, &wq_entry,
>> + TASK_UNINTERRUPTIBLE);
>> +
>> +               timeout = schedule_timeout(timeout);
>> +               if (!timeout)
>> +                       break;
>> +       }
>> +
>> +       finish_wait(&core->ack_wq, &wq_entry);
>>        call_void_vop(inst, wait_finish);
>>
>>        if (!check_is_responsed(inst, key)) {
>> --
>> 2.25.1
> 

