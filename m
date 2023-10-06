Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD8D7BBC73
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjJFQGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbjJFQGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:06:36 -0400
Received: from mp-relay-02.fibernetics.ca (mp-relay-02.fibernetics.ca [208.85.217.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C20D4D;
        Fri,  6 Oct 2023 09:06:18 -0700 (PDT)
Received: from mailpool-fe-02.fibernetics.ca (mailpool-fe-02.fibernetics.ca [208.85.217.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mp-relay-02.fibernetics.ca (Postfix) with ESMTPS id B4E5975C23;
        Fri,  6 Oct 2023 16:06:17 +0000 (UTC)
Received: from localhost (mailpool-mx-01.fibernetics.ca [208.85.217.140])
        by mailpool-fe-02.fibernetics.ca (Postfix) with ESMTP id 9CA07609E6;
        Fri,  6 Oct 2023 16:06:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at 
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mailpool-fe-02.fibernetics.ca ([208.85.217.145])
        by localhost (mail-mx-01.fibernetics.ca [208.85.217.140]) (amavisd-new, port 10024)
        with ESMTP id KjewNH7qp8jC; Fri,  6 Oct 2023 16:06:15 +0000 (UTC)
Received: from [192.168.48.17] (host-104-157-209-188.dyn.295.ca [104.157.209.188])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail.ca.inter.net (Postfix) with ESMTPSA id D05BD6091D;
        Fri,  6 Oct 2023 16:06:14 +0000 (UTC)
Message-ID: <8c48129a-1afe-4189-a1f8-3c60e2375ad2@interlog.com>
Date:   Fri, 6 Oct 2023 12:06:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v5 07/10] scsi: scsi_debug: Add new error injection abort
 failed
To:     Wenchao Hao <haowenchao2@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, louhongxiang@huawei.com
References: <20230922092906.2645265-1-haowenchao2@huawei.com>
 <20230922092906.2645265-8-haowenchao2@huawei.com>
Content-Language: en-CA
From:   Douglas Gilbert <dgilbert@interlog.com>
In-Reply-To: <20230922092906.2645265-8-haowenchao2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-22 05:29, Wenchao Hao wrote:
> Add error injection type 3 to make scsi_debug_abort() return FAILED.
> Fail abort command foramt:

s/foramt/format/

> 
>    +--------+------+-------------------------------------------------------+
>    | Column | Type | Description                                           |
>    +--------+------+-------------------------------------------------------+
>    |   1    |  u8  | Error type, fixed to 0x3                              |
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
> will make the device return FAILED when abort inquiry command 10 times.

Tested with:
    # sg_raw -t 10 -r 1k /dev/sg1 12 00 00 00 60 00

After 10 seconds (the timeout specified to sg_raw) I saw this:
    >>> transport error: Host_status=0x03 [DID_TIME_OUT]

And the
     # cat /sys/kernel/debug/scsi_debug/1\:0\:0\:0/error

Count value changed from -10 up to 0 for each invocation of the INQUIRY
command. Thereafter the INQUIRY command worked.

Looks good.

   Tested-by: Douglas Gilbert <dgilbert@interlog.com>

> 
> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
> ---
>   drivers/scsi/scsi_debug.c | 40 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
> index fe1f7421f617..8a16cb9642a6 100644
> --- a/drivers/scsi/scsi_debug.c
> +++ b/drivers/scsi/scsi_debug.c
> @@ -293,6 +293,8 @@ enum sdebug_err_type {
>   	ERR_FAIL_CMD		= 2,	/* make specific scsi command's */
>   					/* queuecmd return succeed but */
>   					/* with errors set in scsi_cmnd */
> +	ERR_ABORT_CMD_FAILED	= 3,	/* control return FAILED from */
> +					/* scsi_debug_abort() */
>   };
>   
>   struct sdebug_err_inject {
> @@ -970,6 +972,7 @@ static int sdebug_error_show(struct seq_file *m, void *p)
>   	list_for_each_entry_rcu(err, &devip->inject_err_list, list) {
>   		switch (err->type) {
>   		case ERR_TMOUT_CMD:
> +		case ERR_ABORT_CMD_FAILED:
>   			seq_printf(m, "%d\t%d\t0x%x\n", err->type, err->cnt,
>   				err->cmd);
>   		break;
> @@ -1031,6 +1034,7 @@ static ssize_t sdebug_error_write(struct file *file, const char __user *ubuf,
>   
>   	switch (inject_type) {
>   	case ERR_TMOUT_CMD:
> +	case ERR_ABORT_CMD_FAILED:
>   		if (sscanf(buf, "%d %d %hhx", &inject->type, &inject->cnt,
>   			   &inject->cmd) != 3)
>   			goto out_error;
> @@ -5504,9 +5508,39 @@ static void stop_all_queued(void)
>   	mutex_unlock(&sdebug_host_list_mutex);
>   }
>   
> +static int sdebug_fail_abort(struct scsi_cmnd *cmnd)
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
> +		if (err->type == ERR_ABORT_CMD_FAILED &&
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
>   static int scsi_debug_abort(struct scsi_cmnd *SCpnt)
>   {
>   	bool ok = scsi_debug_abort_cmnd(SCpnt);
> +	u8 *cmd = SCpnt->cmnd;
> +	u8 opcode = cmd[0];
>   
>   	++num_aborts;
>   
> @@ -5515,6 +5549,12 @@ static int scsi_debug_abort(struct scsi_cmnd *SCpnt)
>   			    "%s: command%s found\n", __func__,
>   			    ok ? "" : " not");
>   
> +	if (sdebug_fail_abort(SCpnt)) {
> +		scmd_printk(KERN_INFO, SCpnt, "fail abort command 0x%x\n",
> +			    opcode);
> +		return FAILED;
> +	}
> +
>   	return SUCCESS;
>   }
>   

