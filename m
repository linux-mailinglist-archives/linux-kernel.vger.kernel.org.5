Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BEE75932F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjGSKhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjGSKhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:37:31 -0400
Received: from mail-m2838.qiye.163.com (mail-m2838.qiye.163.com [103.74.28.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67525E5;
        Wed, 19 Jul 2023 03:37:21 -0700 (PDT)
Received: from [192.168.181.141] (unknown [171.217.147.3])
        by mail-m2838.qiye.163.com (Hmail) with ESMTPA id 82A4A3C03B0;
        Wed, 19 Jul 2023 18:37:13 +0800 (CST)
Message-ID: <e3463c22-d0ff-2105-dd7d-b152cbcf5c8f@easystack.cn>
Date:   Wed, 19 Jul 2023 18:37:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Close connection aborting an out-of-order cmd will hang
To:     Maurizio Lombardi <mlombard@redhat.com>
Cc:     nab@linux-iscsi.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <d477d789-3e73-9d00-1daf-ff0ed6f18e6c@easystack.cn>
 <CAFL455ni63jgLha_AypB6hW=w2YQjWzbi9CJo9oK8yG1VM-=6A@mail.gmail.com>
From:   Jirong Feng <jirong.feng@easystack.cn>
In-Reply-To: <CAFL455ni63jgLha_AypB6hW=w2YQjWzbi9CJo9oK8yG1VM-=6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTUkaVh1PHUgdHRlNSx5JTlUZERMWGhIXJBQOD1
        lXWRgSC1lBWUpMSlVJSkxVSk9MVUhZV1kWGg8SFR0UWUFZT0tIVUpKS0hKQ1VKS0tVS1kG
X-HM-Tid: 0a896db9b2898420kuqw82a4a3c03b0
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRw6Hgw5FTEyKksJDCNWEDEt
        FwswCQ1VSlVKTUNCTE1IS0hPSk5DVTMWGhIXVRESCRQVHFUdHhUcOx4aCAIIDxoYEFUYFUVZV1kS
        C1lBWUpMSlVJSkxVSk9MVUhZV1kIAVlBTUtKTTcG
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[root@node-6 ~]# uname -r

4.18.0-147.5.1.es8_24.aarch64


Our linux distro is forked from rhel 8.1, whose kernel version is 
kernel-4.18.0-147.5.1.el8_1.


[root@node-6 ~]# modinfo iscsi_target_mod
filename: 
/lib/modules/4.18.0-147.5.1.es8_24.aarch64/extra/target_core/iscsi/iscsi_target_mod.ko
license:        GPL
author:         nab@Linux-iSCSI.org
version:        4.1.x
description:    iSCSI-Target Driver for mainline target infrastructure
rhelversion:    8.1
srcversion:     C986C35ED15D27ACAFD2927
depends:        target_core_mod
name:           iscsi_target_mod
vermagic:       4.18.0-147.5.1.es8_24.aarch64 SMP mod_unload modversions 
aarch64


Regards,

Jirong Feng


在 2023/7/19 17:59, Maurizio Lombardi 写道:
> Hello,
>
> út 18. 7. 2023 v 8:52 odesílatel Jirong Feng <jirong.feng@easystack.cn> napsal:
>> Hi,
>>
>> I recently encountered a hanging issue as follow:
> Can you please provide the kernel version?
>
> Thanks,
> Maurizio
>
>> [root@node-6 ~]# ps -aux | grep ' D '
>> root      8648  0.4  0.0      0     0 ?        D    Jul12  21:04 [iscsi_np]
>> root     17572  0.0  0.0      0     0 ?        D    Jul12   0:09
>> [kworker/7:3+events]
>> root     56555  0.0  0.0 216576  1536 pts/1    S+   14:57   0:00 grep
>> --color=auto  D
>> root     59853  0.0  0.0      0     0 ?        D    Jul12   0:04 [iscsi_trx]
>>
>> the call stack:
>> kworker:
>> PID: 17572  TASK: ffff862470df0e00  CPU: 7   COMMAND: "kworker/7:3"
>>    #0 [ffff0000528afab0] __switch_to at ffff4a49c69e74b8
>>    #1 [ffff0000528afad0] __schedule at ffff4a49c72b60f4
>>    #2 [ffff0000528afb60] schedule at ffff4a49c72b6754
>>    #3 [ffff0000528afb70] schedule_timeout at ffff4a49c72ba980
>>    #4 [ffff0000528afc30] wait_for_common at ffff4a49c72b7504
>>    #5 [ffff0000528afcb0] wait_for_completion at ffff4a49c72b7594
>>    #6 [ffff0000528afcd0] target_put_cmd_and_wait at ffff4a49a3dad38c
>> [target_core_mod]
>>    #7 [ffff0000528afd30] core_tmr_abort_task at ffff4a49a3da55c8
>> [target_core_mod]
>>    #8 [ffff0000528afd80] target_tmr_work at ffff4a49a3daa1c8
>> [target_core_mod]
>>    #9 [ffff0000528afdb0] process_one_work at ffff4a49c6a603c0
>> #10 [ffff0000528afe00] worker_thread at ffff4a49c6a60640
>> #11 [ffff0000528afe60] kthread at ffff4a49c6a67474
>>
>> iscsi_trx:
>> PID: 59853  TASK: ffff8624fe0b5200  CPU: 7   COMMAND: "iscsi_trx"
>>    #0 [ffff000095f6fa50] __switch_to at ffff4a49c69e74b8
>>    #1 [ffff000095f6fa70] __schedule at ffff4a49c72b60f4
>>    #2 [ffff000095f6fb00] schedule at ffff4a49c72b6754
>>    #3 [ffff000095f6fb10] schedule_timeout at ffff4a49c72ba870
>>    #4 [ffff000095f6fbd0] wait_for_common at ffff4a49c72b7504
>>    #5 [ffff000095f6fc50] wait_for_completion_timeout at ffff4a49c72b75d0
>>    #6 [ffff000095f6fc70] __transport_wait_for_tasks at ffff4a49a3da9c28
>> [target_core_mod]
>>    #7 [ffff000095f6fcb0] transport_generic_free_cmd at ffff4a49a3da9dd0
>> [target_core_mod]
>>    #8 [ffff000095f6fd20] iscsit_free_cmd at ffff4a49a3fc4464
>> [iscsi_target_mod]
>>    #9 [ffff000095f6fd50] iscsit_close_connection at ffff4a49a3fccf48
>> [iscsi_target_mod]
>> #10 [ffff000095f6fdf0] iscsit_take_action_for_connection_exit at
>> ffff4a49a3fb7614 [iscsi_target_mod]
>> #11 [ffff000095f6fe20] iscsi_target_rx_thread at ffff4a49a3fcc064
>> [iscsi_target_mod]
>> #12 [ffff000095f6fe60] kthread at ffff4a49c6a67474
>>
>> inspect the aborting cmd in kworker:
>> crash> struct iscsi_cmd FFFFA62592F4B400
>> struct iscsi_cmd {
>>     dataout_timer_flags = (unknown: 0),
>>     dataout_timeout_retries = 0 '\000',
>>     error_recovery_count = 0 '\000',
>>     deferred_i_state = ISTATE_NEW_CMD,
>>     i_state = ISTATE_DEFERRED_CMD,
>>     immediate_cmd = 0 '\000',
>>     immediate_data = 0 '\000',
>>     iscsi_opcode = 1 '\001',
>>     iscsi_response = 0 '\000',
>>     logout_reason = 0 '\000',
>>     logout_response = 0 '\000',
>>     maxcmdsn_inc = 0 '\000',
>>     unsolicited_data = 0 '\000',
>>     reject_reason = 0 '\000',
>>     logout_cid = 0,
>>     cmd_flags = ICF_OOO_CMDSN,
>>     init_task_tag = 2415919152,
>>     targ_xfer_tag = 205,
>>     cmd_sn = 2860352639,
>>     exp_stat_sn = 2502541166,
>>     stat_sn = 0,
>>     data_sn = 0,
>> ...
>>
>> so this is an out-of-order cmd. In my conclusion, trx is waiting for
>> kworker to abort the cmd,  while kworker is waiting for someone to
>> complete the cmd, and that is never going to happen, hence the hanging.
>>
>> Could someone please help me to confirm the case?
>>
>> Regards,
>> Jirong Feng
>>
>>
>
