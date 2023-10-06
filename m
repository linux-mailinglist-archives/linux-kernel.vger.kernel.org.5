Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704967BC0EC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjJFVEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbjJFVEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:04:38 -0400
Received: from mp-relay-01.fibernetics.ca (mp-relay-01.fibernetics.ca [208.85.217.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF94EA;
        Fri,  6 Oct 2023 14:04:36 -0700 (PDT)
Received: from mailpool-fe-02.fibernetics.ca (mailpool-fe-02.fibernetics.ca [208.85.217.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mp-relay-01.fibernetics.ca (Postfix) with ESMTPS id A30AAE179C;
        Fri,  6 Oct 2023 21:04:34 +0000 (UTC)
Received: from localhost (mailpool-mx-02.fibernetics.ca [208.85.217.141])
        by mailpool-fe-02.fibernetics.ca (Postfix) with ESMTP id 89C6C60BBD;
        Fri,  6 Oct 2023 21:04:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at 
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from mailpool-fe-02.fibernetics.ca ([208.85.217.145])
        by localhost (mail-mx-02.fibernetics.ca [208.85.217.141]) (amavisd-new, port 10024)
        with ESMTP id zZQtcZxEEU-n; Fri,  6 Oct 2023 21:04:33 +0000 (UTC)
Received: from [192.168.2.19] (lnsm3-torontoxn-142-116-140-195.internet.virginmobile.ca [142.116.140.195])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail.ca.inter.net (Postfix) with ESMTPSA id CB7066091D;
        Fri,  6 Oct 2023 21:04:32 +0000 (UTC)
Message-ID: <fd68ba92-7736-4924-945e-4bb238a02860@interlog.com>
Date:   Fri, 6 Oct 2023 17:04:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v5 08/10] scsi: scsi_debug: Add new error injection reset
 lun failed
To:     Wenchao Hao <haowenchao2@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, louhongxiang@huawei.com
References: <20230922092906.2645265-1-haowenchao2@huawei.com>
 <20230922092906.2645265-9-haowenchao2@huawei.com>
Content-Language: en-CA
From:   Douglas Gilbert <dgilbert@interlog.com>
In-Reply-To: <20230922092906.2645265-9-haowenchao2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-22 05:29, Wenchao Hao wrote:
> Add error injection type 3 to make scsi_debug_device_reset() return FAILED.
> Fail abort command foramt:

s/foramt/format/

> 
>    +--------+------+-------------------------------------------------------+
>    | Column | Type | Description                                           |
>    +--------+------+-------------------------------------------------------+
>    |   1    |  u8  | Error type, fixed to 0x4                              |
>    +--------+------+-------------------------------------------------------+
>    |   2    |  s32 | Error count                                           |
>    |        |      |  0: this rule will be ignored                         |
>    |        |      |  positive: the rule will always take effect           |
>    |        |      |  negative: the rule takes effect n times where -n is  |
>    |        |      |            the value given. Ignored after n times     |
>    +--------+------+-------------------------------------------------------+
>    |   3    |  x8  | SCSI command opcode, 0xff for all commands            |
>    +--------+------+-------------------------------------------------------+
> 
> Examples:
>      error=/sys/kernel/debug/scsi_debug/0:0:0:1/error
>      echo "0 -10 0x12" > ${error}

These examples are misleading. Same with the one in patch 7/10 . The example
should be showing an invocation that exercises _this_ patch. So the first
byte of the echo should be 4 not the 0 shown above.

Doug Gilbert

> will make the device return FAILED when try to reset lun with inquiry
> command 10 times.
>      error=/sys/kernel/debug/scsi_debug/0:0:0:1/error
>      echo "0 -10 0xff" > ${error}
> will make the device return FAILED when try to reset lun 10 times.
> 
> Usually we do not care about what command it is when trying to perform
> reset LUN, so 0xff could be applied.
> 
> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
> ---
>   drivers/scsi/scsi_debug.c | 39 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
> index 8a16cb9642a6..db8ab6cad078 100644
> --- a/drivers/scsi/scsi_debug.c
> +++ b/drivers/scsi/scsi_debug.c
> @@ -295,6 +295,8 @@ enum sdebug_err_type {
>   					/* with errors set in scsi_cmnd */
>   	ERR_ABORT_CMD_FAILED	= 3,	/* control return FAILED from */
>   					/* scsi_debug_abort() */
> +	ERR_LUN_RESET_FAILED	= 4,	/* control return FAILED from */
> +					/* scsi_debug_device_reseLUN_RESET_FAILEDt() */
>   };
>   
>   struct sdebug_err_inject {
> @@ -973,6 +975,7 @@ static int sdebug_error_show(struct seq_file *m, void *p)
>   		switch (err->type) {
>   		case ERR_TMOUT_CMD:
>   		case ERR_ABORT_CMD_FAILED:
> +		case ERR_LUN_RESET_FAILED:
>   			seq_printf(m, "%d\t%d\t0x%x\n", err->type, err->cnt,
>   				err->cmd);
>   		break;
> @@ -1035,6 +1038,7 @@ static ssize_t sdebug_error_write(struct file *file, const char __user *ubuf,
>   	switch (inject_type) {
>   	case ERR_TMOUT_CMD:
>   	case ERR_ABORT_CMD_FAILED:
> +	case ERR_LUN_RESET_FAILED:
>   		if (sscanf(buf, "%d %d %hhx", &inject->type, &inject->cnt,
>   			   &inject->cmd) != 3)
>   			goto out_error;
> @@ -5578,10 +5582,40 @@ static void scsi_debug_stop_all_queued(struct scsi_device *sdp)
>   				scsi_debug_stop_all_queued_iter, sdp);
>   }
>   
> +static int sdebug_fail_lun_reset(struct scsi_cmnd *cmnd)
> +{
> +	struct scsi_device *sdp = cmnd->device;
> +	struct sdebug_dev_info *devip = (struct sdebug_dev_info *)sdp->hostdata;
> +	struct sdebug_err_inject *err;
> +	unsigned char *cmd = cmnd->cmnd;
> +	int ret = 0;
> +
> +	if (devip == NULL)
> +		return 0;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(err, &devip->inject_err_list, list) {
> +		if (err->type == ERR_LUN_RESET_FAILED &&
> +		    (err->cmd == cmd[0] || err->cmd == 0xff)) {
> +			ret = !!err->cnt;
> +			if (err->cnt < 0)
> +				err->cnt++;
> +
> +			rcu_read_unlock();
> +			return ret;
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	return 0;
> +}
> +
>   static int scsi_debug_device_reset(struct scsi_cmnd *SCpnt)
>   {
>   	struct scsi_device *sdp = SCpnt->device;
>   	struct sdebug_dev_info *devip = sdp->hostdata;
> +	u8 *cmd = SCpnt->cmnd;
> +	u8 opcode = cmd[0];
>   
>   	++num_dev_resets;
>   
> @@ -5592,6 +5626,11 @@ static int scsi_debug_device_reset(struct scsi_cmnd *SCpnt)
>   	if (devip)
>   		set_bit(SDEBUG_UA_POR, devip->uas_bm);
>   
> +	if (sdebug_fail_lun_reset(SCpnt)) {
> +		scmd_printk(KERN_INFO, SCpnt, "fail lun reset 0x%x\n", opcode);
> +		return FAILED;
> +	}
> +
>   	return SUCCESS;
>   }
>   

