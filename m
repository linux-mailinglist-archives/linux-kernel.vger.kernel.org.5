Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29877EC87C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjKOQZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjKOQZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:25:13 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795D183;
        Wed, 15 Nov 2023 08:25:08 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc5916d578so62053395ad.2;
        Wed, 15 Nov 2023 08:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700065508; x=1700670308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hqfdN49Q+vOScFGNTJSUGSerhaeKJX/vdLTTz0PDYuU=;
        b=fjis3OveIoXcKOHxsrR7F3RlAuvKCv2ZfU9lo819/m7F2kpDoTPb4ImNPkJ3W8yWwl
         p/8R0Pegt6g6BdjzqlFA4ElNd5oBHLJJ55Koh+IHrhFwMb2hDUkK9L38dSKd5NciA8LG
         ZVdwKIVo4yKYQ+vD9GmlR7C9P7KdPPV20O6T17pNNGSj79Ml3vOvLdU2az4QfY16Mrv2
         NgiO8sTLhCHe7E2VkArfq/IhtQX+i1jhIYozfnQPzov24Hdwekkmf+g0VA4y7WxaLIHe
         WsGvBYNuKDO14VrQVMON4UfcqNZPNkxe1WpBOD5Bl261jYokTHymPosUSkXBpOPMltc3
         Ytcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700065508; x=1700670308;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hqfdN49Q+vOScFGNTJSUGSerhaeKJX/vdLTTz0PDYuU=;
        b=Gh6OV+9Ue7Rfj0i0b6iqZtljw8nqfjJK8Q1kXIdY5r6/xsOWp3auNsLftW3XJLwbxq
         PsjGufGnDwRHDEGf/JD94fOuFbKa2HgqC/45Nk4/vyVdBgsbIQObMYDDbGmvS+TF0G9N
         5KEduVcKcQ6FPPvzLl4EHGehXi3x9GaL6RUbK9iWSv9O9aZkbR/jmYoKExeosIU3dQJK
         ghmtzvF1SoC8bRkJth3TOnutyFxBLW3B4RN/I9czK2Lbx7qBXFKfHhDd1NDP25TMeU+p
         M0nnACOBAbkwLNjkpolhmZsG5H3bB9CFKEzqnwJm/+6+UUIurr2BonBRzgBqOM68PO2Y
         wTxQ==
X-Gm-Message-State: AOJu0YwPzyfYuJpy527T4XSo9sVCHNpHUdG30M+gyXlsw4qT61hrTovf
        rzXgbp4Rsa8kyriJ0swSiuw=
X-Google-Smtp-Source: AGHT+IHQ/tvJpqXZWs1nlPIw6VrlreayZv2+4UE0N9kL/rrHXfNZPlKybny0RXOnaam5n306lM33oA==
X-Received: by 2002:a17:903:1108:b0:1c3:c687:478c with SMTP id n8-20020a170903110800b001c3c687478cmr7739795plh.8.1700065507795;
        Wed, 15 Nov 2023 08:25:07 -0800 (PST)
Received: from [0.0.0.0] (74.211.104.32.16clouds.com. [74.211.104.32])
        by smtp.gmail.com with ESMTPSA id y12-20020a170902ed4c00b001c9ba6c7287sm7576200plb.143.2023.11.15.08.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 08:25:07 -0800 (PST)
Message-ID: <b33a6052-572e-4e4b-b521-dd407c8b32b6@gmail.com>
Date:   Thu, 16 Nov 2023 00:24:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] scsi: scsi_core: Fix IO hang when device removing
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>,
        Wenchao Hao <haowenchao2@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20231016020314.1269636-1-haowenchao2@huawei.com>
 <20231016020314.1269636-5-haowenchao2@huawei.com>
 <b95cf250-9a58-4a9f-8b55-4b6d00a6a6c2@oracle.com>
 <b00a9920-f16f-4187-9a7c-6083c5d98fb8@oracle.com>
From:   Wenchao Hao <haowenchao22@gmail.com>
In-Reply-To: <b00a9920-f16f-4187-9a7c-6083c5d98fb8@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/23 5:47 AM, Mike Christie wrote:
> On 11/14/23 3:23 PM, Mike Christie wrote:
>> On 10/15/23 9:03 PM, Wenchao Hao wrote:
>>> shost_for_each_device() would skip devices which is in progress of
>>> removing, so scsi_run_queue() for these devices would be skipped in
>>> scsi_run_host_queues() after blocking hosts' IO.
>>>
>>> IO hang would be caused if return true when state is SDEV_CANCEL with
>>> following order:
>>>
>>> T1:					    T2:scsi_error_handler
>>> __scsi_remove_device()
>>>   scsi_device_set_state(sdev, SDEV_CANCEL)
>>>   ...
>>>   sd_remove()
>>>   del_gendisk()
>>>   blk_mq_freeze_queue_wait()
>>>   					    scsi_eh_flush_done_q()
>>> 					      scsi_queue_insert(scmd,...)
>>>
>>> scsi_queue_insert() would not kick device's queue since commit
>>> 8b566edbdbfb ("scsi: core: Only kick the requeue list if necessary")
>>>
>>> After scsi_unjam_host(), the scsi error handler would call
>>> scsi_run_host_queues() to trigger run queue for devices, while it
>>> would not run queue for devices which is in progress of removing
>>> because shost_for_each_device() would skip them.
>>>
>>> So the requests added to these queues would not be handled any more,
>>> and the removing device process would hang too.
>>>
>>> Fix this issue by using shost_for_each_device_include_deleted() in
>>> scsi_run_host_queues() to trigger a run queue for devices in removing.
>>>
>>> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
>>> ---
>>>  drivers/scsi/scsi_lib.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
>>> index 195ca80667d0..40f407ffd26f 100644
>>> --- a/drivers/scsi/scsi_lib.c
>>> +++ b/drivers/scsi/scsi_lib.c
>>> @@ -466,7 +466,7 @@ void scsi_run_host_queues(struct Scsi_Host *shost)
>>>  {
>>>  	struct scsi_device *sdev;
>>>  
>>> -	shost_for_each_device(sdev, shost)
>>> +	shost_for_each_device_include_deleted(sdev, shost)
>>>  		scsi_run_queue(sdev->request_queue);
>>
>> What happens if there were no commands for the device that
>> was destroyed and we race with this code and device deletion?
>>
>> So thread1 has set the device state tp SDEV_DEL and has finished
>> blk_mq_destroy_queue because there were no commands running.
>>
>> The above eh thread, then is calling:
>>
>> scsi_run_queue -> blk_mq_kick_requeue_list
>>
>> and that queues the requeue work.
>>
>> blk_mq_destroy_queue had done blk_mq_cancel_work_sync but
>> blk_mq_kick_requeue_list just added it back on the kblockd_workqueue.
>>
>> When __scsi_iterate_devices does scsi_device_put it would call
>> scsi_device_dev_release and call blk_put_queue which frees the
>> request_queue while it's requeue work might still be queued on
>> kblockd_workqueue.
>>

Hi Mike, thank you for the review.

Sorry I did not take the above flow into consideration and it's a bug
should be fixed in next version.

> 
> Oh yeah, for your other lun/target reset patches were you trying to
> do something where you have a list for each scsi_device or a list of
> scsi_devices that needed error handler work? If so, maybe break that
> part out and use it here first.
> 

The lun/target reset changes are not general for all drivers in my
design, so it should not work here.

> You can then just loop over the list of devices that needed work and
> start those above.

What about introduce a new flag "recovery" for each scsi_device to mark
if there is error command happened on it, the new flag is set in
scsi_eh_scmd_add() and cleared after error handle finished. 

Since clear is always after scsi_error_handle() is waked up and no more
scsi_eh_scmd_add() would be called after scsi_error_handle() is waked
up, we do not need lock between set and clear this flag.

This change can help me to fix the issue you described above too.

Here is a brief changes:

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index c67cdcdc3ba8..36af294c2cef 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -310,6 +310,8 @@ void scsi_eh_scmd_add(struct scsi_cmnd *scmd)
 	if (shost->eh_deadline != -1 && !shost->last_reset)
 		shost->last_reset = jiffies;

+	scmd->device->recovery = 1;
+
 	scsi_eh_reset(scmd);
 	list_add_tail(&scmd->eh_entry, &shost->eh_cmd_q);
 	spin_unlock_irqrestore(shost->host_lock, flags);
@@ -2149,7 +2151,7 @@ static void scsi_restart_operations(struct Scsi_Host *shost)
 	 * now that error recovery is done, we will need to ensure that these
 	 * requests are started.
 	 */
-	scsi_run_host_queues(shost);
+	scsi_run_host_recovery_queues(shost);

 	/*
 	 * if eh is active and host_eh_scheduled is pending we need to re-run
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index cf3864f72093..0bf4423b6b9a 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -470,6 +470,17 @@ void scsi_run_host_queues(struct Scsi_Host *shost)
 		scsi_run_queue(sdev->request_queue);
 }

+void scsi_run_host_recovery_queues(struct Scsi_Host *shost)
+{
+	struct scsi_device *sdev;
+
+	shost_for_each_device_include_deleted(sdev, shost)
+		if (sdev->recovery) {
+			scsi_run_queue(sdev->request_queue);
+			sdev->recovery = 0;
+		}
+}
+
 static void scsi_uninit_cmd(struct scsi_cmnd *cmd)
 {
 	if (!blk_rq_is_passthrough(scsi_cmd_to_rq(cmd))) {
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 3f0dfb97db6b..3aba8ddd0101 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -107,6 +107,7 @@ extern void scsi_device_unbusy(struct scsi_device *sdev, struct scsi_cmnd *cmd);
 extern void scsi_queue_insert(struct scsi_cmnd *cmd, int reason);
 extern void scsi_io_completion(struct scsi_cmnd *, unsigned int);
 extern void scsi_run_host_queues(struct Scsi_Host *shost);
+extern void scsi_run_host_recovery_queues(struct Scsi_Host *shost);
 extern void scsi_requeue_run_queue(struct work_struct *work);
 extern void scsi_start_queue(struct scsi_device *sdev);
 extern int scsi_mq_setup_tags(struct Scsi_Host *shost);
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 10480eb582b2..b730ceab9996 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -239,6 +239,7 @@ struct scsi_device {

 	unsigned cdl_supported:1;	/* Command duration limits supported */
 	unsigned cdl_enable:1;		/* Enable/disable Command duration limits */
+	unsigned recovery;		/* Mark it error command happened */

 	unsigned int queue_stopped;	/* request queue is quiesced */


