Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130DF7B6EFF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240525AbjJCQz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjJCQzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:55:22 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBE8B7;
        Tue,  3 Oct 2023 09:55:18 -0700 (PDT)
Received: from [192.168.1.103] (178.176.78.48) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Tue, 3 Oct 2023
 19:55:08 +0300
Subject: Re: [PATCH 3/4] pata_parport: add custom version of wait_after_reset
To:     Damien Le Moal <dlemoal@kernel.org>, Ondrej Zary <linux@zary.sk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
CC:     Christoph Hellwig <hch@lst.de>, Tim Waugh <tim@cyberelk.net>,
        <linux-parport@lists.infradead.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230930191511.24994-1-linux@zary.sk>
 <20230930191511.24994-4-linux@zary.sk>
 <d2fd9a3c-3efd-dbfe-7b2a-dc36989b8379@kernel.org>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <14129ea5-1597-efce-e782-23a95f3c0bd9@omp.ru>
Date:   Tue, 3 Oct 2023 19:55:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <d2fd9a3c-3efd-dbfe-7b2a-dc36989b8379@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.78.48]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 10/03/2023 16:33:34
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 180330 [Oct 03 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 535 535 da804c0ea8918f802fc60e7a20ba49783d957ba2
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;178.176.78.48:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: {rdns complete}
X-KSE-AntiSpam-Info: {fromrtbl complete}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.78.48
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=none header.from=omp.ru;spf=none
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/03/2023 16:37:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10/3/2023 12:09:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/23 3:55 AM, Damien Le Moal wrote:

[...]
>> Some parallel adapters (e.g. EXP Computer MC-1285B EPP Cable) return
>> bogus values when there's no master device present. This can cause
>> reset to fail, preventing the lone slave device (such as EXP Computer
>> CD-865) from working.
>>
>> Add custom version of wait_after_reset that ignores master failure when
>> a slave device is present. The custom version is also needed because
>> the generic ata_sff_wait_after_reset uses direct port I/O for slave
>> device detection.
>>
>> Signed-off-by: Ondrej Zary <linux@zary.sk>
>> ---
>>  drivers/ata/pata_parport/pata_parport.c | 65 ++++++++++++++++++++++++-
>>  1 file changed, 64 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
>> index cf87bbb52f1f..b3db953e615a 100644
>> --- a/drivers/ata/pata_parport/pata_parport.c
>> +++ b/drivers/ata/pata_parport/pata_parport.c
>> @@ -80,6 +80,69 @@ static bool pata_parport_devchk(struct ata_port *ap, unsigned int device)
>>  	return (nsect == 0x55) && (lbal == 0xaa);
>>  }
>>  
>> +static int pata_parport_wait_after_reset(struct ata_link *link,
>> +					 unsigned int devmask,
>> +					 unsigned long deadline)
>> +{
>> +	struct ata_port *ap = link->ap;
>> +	struct pi_adapter *pi = ap->host->private_data;
>> +	unsigned int dev0 = devmask & (1 << 0);
>> +	unsigned int dev1 = devmask & (1 << 1);
>> +	int rc, ret = 0;
>> +
>> +	ata_msleep(ap, ATA_WAIT_AFTER_RESET);
>> +
>> +	/* always check readiness of the master device */
>> +	rc = ata_sff_wait_ready(link, deadline);
>> +	/* some adapters return bogus values if master device is not present,
>> +	 * so don't abort now if a slave device is present
>> +	 */
> 
> In addition to Sergey's comment, please move this comment inside the "if", or
> even better, merge it with the otherwise not very useful "always check
> readiness..." comment.

   That comment was copied from ata_sff_wait_after_reset(), I think...

[...]
>> +	/* if device 1 was found in ata_devchk, wait for register
>> +	 * access briefly, then wait for BSY to clear.
>> +	 */
>> +	if (dev1) {
>> +		int i;
>> +
>> +		pata_parport_dev_select(ap, 1);
>> +
>> +		/* Wait for register access.  Some ATAPI devices fail
>> +		 * to set nsect/lbal after reset, so don't waste too
>> +		 * much time on it.  We're gonna wait for !BSY anyway.
>> +		 */
>> +		for (i = 0; i < 2; i++) {
>> +			u8 nsect, lbal;
>> +
>> +			nsect = pi->proto->read_regr(pi, 0, ATA_REG_NSECT);
>> +			lbal = pi->proto->read_regr(pi, 0, ATA_REG_LBAL);
>> +			if ((nsect == 1) && (lbal == 1))
>> +				break;
>> +			ata_msleep(ap, 50);	/* give drive a breather */
> 
> Please move the comment on its own line above the sleep call.

   Again, copied verbatim from ata_sff_wait_after_reset()...

>> +		}
>> +
>> +		rc = ata_sff_wait_ready(link, deadline);
>> +		if (rc) {
>> +			if (rc != -ENODEV)
>> +				return rc;
>> +			ret = rc;
>> +		}
>> +	}
>> +
>> +	/* is all this really necessary? */
> 
> I don't know. It is your driver... So either drop this comment, or clearly
> explain why this is done.

   And again, copied verbatim from ata_sff_wait_after_reset()...

>> +	pata_parport_dev_select(ap, 0);
>> +	if (dev1)
>> +		pata_parport_dev_select(ap, 1);
>> +	if (dev0)
>> +		pata_parport_dev_select(ap, 0);
> 
> Can you have dev1 && dev0 == true ? This seems like the second if should be an
> "else if", but it is not clear what this is doing.

   I guess this tries to leave the valid taskfile regs readable on a channel, instead
of just 0xff...

[...]

MBR, Sergey
