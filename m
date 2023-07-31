Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B20D769CE4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjGaQi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbjGaQh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:37:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB32E5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:37:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6964A1F854;
        Mon, 31 Jul 2023 16:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690821451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wQexKwbMw/0jrCvp1mBl0Fr7yOygUHw2vHpVI3P30Jc=;
        b=tpuB/uTTqnw/VrWMQsnjA938YOn7XAj5/u+3IcT7fLm22OM7ohWxaZ46+ry10fSQKUObwo
        Ge4MK3ROhvepkY41dTJLmsFqNxdYDuCIQeKpFMSryXLhitmEgw890rFRTLH5duDYphsepO
        rDf6PGvoqoUtQ5Z+diz1gQRUJkKsZ28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690821451;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wQexKwbMw/0jrCvp1mBl0Fr7yOygUHw2vHpVI3P30Jc=;
        b=ez6HW3VZZe0VXx4zFKd0iYlY3rDvtmMHKka+KhRWz1XN/qKqWMvmWQIbfZJDqua7Xl4f7Q
        l1nBPC6r8NC5+rAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3BBF71322C;
        Mon, 31 Jul 2023 16:37:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yREgDUvjx2TuFwAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 31 Jul 2023 16:37:31 +0000
Message-ID: <69d4239c-25b7-5d14-6140-490bb88dccb4@suse.de>
Date:   Mon, 31 Jul 2023 18:37:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/2] nvme-auth: unlock mutex in one place only
Content-Language: en-US
To:     Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, axboe@kernel.dk, kbusch@kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20230731145106.917526-1-shiftee@posteo.net>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230731145106.917526-1-shiftee@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/23 16:51, Mark O'Donovan wrote:
> Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/auth.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index daf5d144a8ea..e1a98647c3a2 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -758,12 +758,11 @@ static void nvme_queue_auth_work(struct work_struct *work)
>   		__func__, chap->qid);
>   	mutex_lock(&ctrl->dhchap_auth_mutex);
>   	ret = nvme_auth_dhchap_setup_host_response(ctrl, chap);
> +	mutex_unlock(&ctrl->dhchap_auth_mutex);
>   	if (ret) {
> -		mutex_unlock(&ctrl->dhchap_auth_mutex);
>   		chap->error = ret;
>   		goto fail2;
>   	}
> -	mutex_unlock(&ctrl->dhchap_auth_mutex);
>   
>   	/* DH-HMAC-CHAP Step 3: send reply */
>   	dev_dbg(ctrl->device, "%s: qid %d send reply\n",
If you insist.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

