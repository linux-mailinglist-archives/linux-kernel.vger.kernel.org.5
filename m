Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83987642A9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 01:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjGZXjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 19:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjGZXjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 19:39:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A362129;
        Wed, 26 Jul 2023 16:39:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61A3761BAF;
        Wed, 26 Jul 2023 23:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D37AC433C7;
        Wed, 26 Jul 2023 23:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690414752;
        bh=sfunVsnMWERN48DM0YzJqq7VJ8IHu3t3TGXl+mBD1wM=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=j3eWnpvnLpyUHYMc55EEsguhJtFbhkMkfU+UlBjNCDhKQdDpUoGBP6udEtVyH0U/s
         Y0ZXRmzgd+5KoJ8OUGvkU3xC0VCZQnuqhyeQPCq63mts5nujLkbUwd4YdAUhnYPQtj
         Q7gZA6/Ecr8tDF3zQmrQUQOof1oJBWfvhGdhQliyH9g8OvRDWA5MS/FFbFJupqK7TT
         k7KZsdw9kD1de/L3s1cyfHu+MPTGhW+sD+VKns9qhzKHOWj1hD/i6eR12k1W6T/vBN
         y3m3cbSEh8NlOyOZveS1i6dD2ImHR2KAy3rR6aNT1Rv2ldYY5i3o281NONTBUVoz6R
         pMVFNxzNUEGlg==
Message-ID: <c70caa9e-164c-fee5-8f85-67f6d02373ab@kernel.org>
Date:   Thu, 27 Jul 2023 08:39:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Damien Le Moal <dlemoal@kernel.org>
Subject: Re: Scsi_bus_resume+0x0/0x90 returns -5 when resuming from s3 sleep
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        TW <dalzot@gmail.com>
Cc:     regressions@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Bart Van Assche <bvanassche@acm.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
References: <0e272abe-292d-d58f-cf80-55868e793abc@gmail.com>
 <6b66dd9a-8bd5-2882-9168-8e6e0848c454@leemhuis.info>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <6b66dd9a-8bd5-2882-9168-8e6e0848c454@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/23 22:47, Thorsten Leemhuis wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker.
> 
> On 26.07.23 13:54, TW wrote:
>> I have been having issues with the 6.x series of kernels resuming from
>> suspend with one of my drives. Far as I can tell it has trouble with the
>> cache on the drive when coming out of s3 sleep. Tried a few different
>> distros (Manjaro, OpenMandriva Rome, EndeavourOS) all that give the same
>> error message. It appears to work fine on the 5.15 kernel just fine
>> however.
>>
>> This is the error or errors that I have been getting and assume has been
>> holding up the system from resuming from suspend.
>>
>> Jul 20 04:13:41 rageworks kernel: ata10.00: device reported invalid CHS sector 0
>> Jul 20 04:13:41 rageworks kernel: sd 9:0:0:0: [sdc] Start/Stop Unit failed: Result: hostbyte=DID_OK driverbyte=DRIVER_OK
>> Jul 20 04:13:41 rageworks kernel: sd 9:0:0:0: [sdc] Sense Key : Illegal Request [current]
>> Jul 20 04:13:41 rageworks kernel: sd 9:0:0:0: [sdc] Add. Sense: Unaligned write command

This sense is garbage. This issue was reported already, but it is hard
to deal with as it seems to be due to drives/adapters not correctly
reporting status bits. So for now, let's ignore this sense codes.

The start/stop unit failure is weird. On another case, I am suspecting
that this command is causing a delay on resume, but not an error like this.

>> Jul 20 04:13:41 rageworks kernel: sd 9:0:0:0: PM: dpm_run_callback(): scsi_bus_resume+0x0/0x90 returns -5
>> Jul 20 04:13:41 rageworks kernel: sd 9:0:0:0: PM: failed to resume async: error -5 
> 
> Thx for your report. I CCed a few people, with a bit of luck they have
> an idea. But I doubt it. If no one replies you likely will need a
> bisection to find the root of the problem. But before going down that
> route you want to check if latest mainline kernel (vanilla!) works better.
> 
> FWIW, this is not my area of expertise, so the following might be a
> misleading comment, but the problem looks somewhat similar to this one
> that iirc was never solved:
> https://bugzilla.kernel.org/show_bug.cgi?id=216087
> 
>> Jul 20 04:12:51 rageworks systemd[1]: nvidia-suspend.service: Deactivated successfully.
>> Jul 20 04:12:51 rageworks systemd[1]: Finished NVIDIA system suspend actions.
>> Jul 20 04:12:51 rageworks systemd[1]: Starting System Suspend... 
> 
> That sounds like you are using out-of tree drivers which can cause all
> sorts of issues. Please recheck if the problem happens without those as
> well and do not use them in all further tests to debug the issue.

Yes. Please retest with the latest 6.5-rc3.

And can you try this patch to see if it solves your issue ?

commit 29e81d11812ee924d19425343ec69acd34af9d35
Author: Damien Le Moal <dlemoal@kernel.org>
Date:   Mon Jul 24 13:23:14 2023 +0900

    ata,scsi: do not issue START STOP UNIT on resume

    Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 370d18aca71e..6184c7bcc16c 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1100,7 +1100,13 @@ int ata_scsi_dev_config(struct scsi_device *sdev, struct
ata_device *dev)
 		}
 	} else {
 		sdev->sector_size = ata_id_logical_sector_size(dev->id);
+		/*
+		 * Stop the drive on suspend but do not issue START STOP UNIT
+		 * on resume as this is not necessary: the port is reset on
+		 * resume, which wakes up the drive.
+		 */
 		sdev->manage_start_stop = 1;
+		sdev->no_start_on_resume = 1;
 	}

 	/*
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 68b12afa0721..b8584fe3123e 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3876,7 +3876,7 @@ static int sd_suspend_runtime(struct device *dev)
 static int sd_resume(struct device *dev)
 {
 	struct scsi_disk *sdkp = dev_get_drvdata(dev);
-	int ret;
+	int ret = 0;

 	if (!sdkp)	/* E.g.: runtime resume at the start of sd_probe() */
 		return 0;
@@ -3885,7 +3885,8 @@ static int sd_resume(struct device *dev)
 		return 0;

 	sd_printk(KERN_NOTICE, sdkp, "Starting disk\n");
-	ret = sd_start_stop_device(sdkp, 1);
+	if (!sdkp->device->no_start_on_resume)
+		ret = sd_start_stop_device(sdkp, 1);
 	if (!ret)
 		opal_unlock_from_suspend(sdkp->opal_dev);
 	return ret;
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 75b2235b99e2..b9230b6add04 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -194,6 +194,7 @@ struct scsi_device {
 	unsigned no_start_on_add:1;	/* do not issue start on add */
 	unsigned allow_restart:1; /* issue START_UNIT in error handler */
 	unsigned manage_start_stop:1;	/* Let HLD (sd) manage start/stop */
+	unsigned no_start_on_resume:1; /* Do not issue START_STOP_UNIT on resume */
 	unsigned start_stop_pwr_cond:1;	/* Set power cond. in START_STOP_UNIT */
 	unsigned no_uld_attach:1; /* disable connecting to upper level drivers */
 	unsigned select_no_atn:1;


-- 
Damien Le Moal
Western Digital Research

