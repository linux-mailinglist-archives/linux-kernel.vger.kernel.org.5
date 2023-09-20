Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9FB7A862E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbjITOHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbjITOHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:07:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52062D8;
        Wed, 20 Sep 2023 07:07:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CFBC621AFC;
        Wed, 20 Sep 2023 14:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695218819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lT96gdfoI65aK8m45KskVCHA9ZIx8TVMnfjnNxtCDHs=;
        b=agXzR6wQ1ZAXY4KmanWVya+HCJxw+QBKGWEpk9irinuDPjlNo3TbNU+BsR0ih4f+hulH5O
        fZHxc9V5CiHjaWcTxpVQf8gKnue/KmBuqYyhY9mmzJhIxSE376ECSFycK5ktpwm+9O70ec
        BgB0CQsJc3u18fvTBwRiRRdunWhplT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695218819;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lT96gdfoI65aK8m45KskVCHA9ZIx8TVMnfjnNxtCDHs=;
        b=hzbp62C3D2e3S+Fb89T99kUAYSIbcEotcDm0f7YEMs6duf6l1mFHJo7YvAKfzGHStcZU9X
        qtBdCHe8pOkeaRCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19CC61333E;
        Wed, 20 Sep 2023 14:06:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +tDyKoL8CmXfFgAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 20 Sep 2023 14:06:58 +0000
Message-ID: <c7818967-1fea-45da-9713-20de4bcb1c44@suse.de>
Date:   Wed, 20 Sep 2023 16:06:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dm-zoned: free dmz->ddev array in dmz_put_zoned_device
Content-Language: en-US
To:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org, stable@vger.kernel.org
References: <20230920105119.21276-1-pchelkin@ispras.ru>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230920105119.21276-1-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 12:51, Fedor Pchelkin wrote:
> Commit 4dba12881f88 ("dm zoned: support arbitrary number of devices")
> made the pointers to additional zoned devices to be stored in a
> dynamically allocated dmz->ddev array. However, this array is not freed.
> 
> Free it when cleaning up zoned device information inside
> dmz_put_zoned_device(). Assigning NULL to dmz->ddev elements doesn't make
> sense there as they are not supposed to be reused later and the whole dmz
> target structure is being cleaned anyway.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: 4dba12881f88 ("dm zoned: support arbitrary number of devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>   drivers/md/dm-zoned-target.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
> index ad8e670a2f9b..e25cd9db6275 100644
> --- a/drivers/md/dm-zoned-target.c
> +++ b/drivers/md/dm-zoned-target.c
> @@ -753,12 +753,10 @@ static void dmz_put_zoned_device(struct dm_target *ti)
>   	struct dmz_target *dmz = ti->private;
>   	int i;
>   
> -	for (i = 0; i < dmz->nr_ddevs; i++) {
> -		if (dmz->ddev[i]) {
> +	for (i = 0; i < dmz->nr_ddevs; i++)
> +		if (dmz->ddev[i])
>   			dm_put_device(ti, dmz->ddev[i]);
> -			dmz->ddev[i] = NULL;
> -		}
> -	}
> +	kfree(dmz->ddev);
>   }
>   
>   static int dmz_fixup_devices(struct dm_target *ti)

Hmm. I'm not that happy with it; dmz_put_zoned_device() is using 
dm_target as an argument, whereas all of the functions surrounding the 
call sites is using the dmz_target directly.

Mind to modify the function to use 'struct dmz_target' as an argument?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

