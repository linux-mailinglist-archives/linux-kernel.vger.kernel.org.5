Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345837DED99
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 08:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343624AbjKBHrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 03:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKBHrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 03:47:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9480F128;
        Thu,  2 Nov 2023 00:46:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4C1B21F74D;
        Thu,  2 Nov 2023 07:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698911216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eQ98sLZVgs2EamM/TLyV0BNyqZ57PCqtEKvbK7a0HLw=;
        b=OhpmDea81eWy4dcl+Bqw9+/6RbEUWfqPuEurM1cP92foUwTlh/0n9ptvUv2a98+OBRXJzM
        CBXv5E9348CmzESVAfLnQtZGxJsNq+oDhugBxsa6rhAHHrpeOhIeLfLa1SfFDlINihZskr
        4lFAZfNZKAzOGf4mJVmJkPHhpNKrYvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698911216;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eQ98sLZVgs2EamM/TLyV0BNyqZ57PCqtEKvbK7a0HLw=;
        b=9UxxB0P5FuzYMU2aEevxcUHydgA8lVapZZdFZr0vY4hRH45dsmKms2CkDbWbIBu2TNd2Xd
        V82Q1POfe0uTVhBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CBD9C138EC;
        Thu,  2 Nov 2023 07:46:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0OL0L+9TQ2WuOAAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 02 Nov 2023 07:46:55 +0000
Message-ID: <b431d9d6-1c6d-4df4-92c3-2f8fdf0fb7b7@suse.de>
Date:   Thu, 2 Nov 2023 08:46:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] scsi: fnic: Define stats to track multiqueue
 (MQ) IOs
Content-Language: en-US
To:     Karan Tilak Kumar <kartilak@cisco.com>, sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231027180302.418676-1-kartilak@cisco.com>
 <20231027180302.418676-9-kartilak@cisco.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231027180302.418676-9-kartilak@cisco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/23 20:02, Karan Tilak Kumar wrote:
> Define an array to track IOs for the different queues,
> print the IO stats in fnic get stats data.
> 
> Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
> Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
> Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
> ---
>   drivers/scsi/fnic/fnic_stats.h |  2 ++
>   drivers/scsi/fnic/fnic_trace.c | 11 +++++++++++
>   2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/scsi/fnic/fnic_stats.h b/drivers/scsi/fnic/fnic_stats.h
> index 07d1556e3c32..9d7f98c452dd 100644
> --- a/drivers/scsi/fnic/fnic_stats.h
> +++ b/drivers/scsi/fnic/fnic_stats.h
> @@ -2,6 +2,7 @@
>   /* Copyright 2013 Cisco Systems, Inc.  All rights reserved. */
>   #ifndef _FNIC_STATS_H_
>   #define _FNIC_STATS_H_
> +#define FNIC_MQ_MAX_QUEUES 64
>   
>   struct stats_timestamps {
>   	struct timespec64 last_reset_time;
> @@ -26,6 +27,7 @@ struct io_path_stats {
>   	atomic64_t io_btw_10000_to_30000_msec;
>   	atomic64_t io_greater_than_30000_msec;
>   	atomic64_t current_max_io_time;
> +	atomic64_t ios[FNIC_MQ_MAX_QUEUES];
>   };
>   
>   struct abort_stats {
> diff --git a/drivers/scsi/fnic/fnic_trace.c b/drivers/scsi/fnic/fnic_trace.c
> index be0d7c57b242..aaa4ea02fb7c 100644
> --- a/drivers/scsi/fnic/fnic_trace.c
> +++ b/drivers/scsi/fnic/fnic_trace.c
> @@ -204,6 +204,7 @@ int fnic_get_stats_data(struct stats_debug_info *debug,
>   	int len = 0;
>   	int buf_size = debug->buf_size;
>   	struct timespec64 val1, val2;
> +	int i = 0;
>   
>   	ktime_get_real_ts64(&val1);
>   	len = scnprintf(debug->debug_buffer + len, buf_size - len,
> @@ -266,6 +267,16 @@ int fnic_get_stats_data(struct stats_debug_info *debug,
>   		  (u64)atomic64_read(&stats->io_stats.io_btw_10000_to_30000_msec),
>   		  (u64)atomic64_read(&stats->io_stats.io_greater_than_30000_msec));
>   
> +	len += scnprintf(debug->debug_buffer + len, buf_size - len,
> +			"------------------------------------------\n"
> +			"\t\tIO Queues and cumulative IOs\n"
> +			"------------------------------------------\n");
> +
> +	for (i = 0; i < FNIC_MQ_MAX_QUEUES; i++) {
> +		len += scnprintf(debug->debug_buffer + len, buf_size - len,
> +				"Q:%d -> %lld\n", i, (u64)atomic64_read(&stats->io_stats.ios[i]));
> +	}
> +
>   	len += scnprintf(debug->debug_buffer + len, buf_size - len,
>   		  "\nCurrent Max IO time : %lld\n",
>   		  (u64)atomic64_read(&stats->io_stats.current_max_io_time));

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

