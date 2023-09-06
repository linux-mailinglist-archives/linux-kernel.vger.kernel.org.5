Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF38A793A88
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjIFLBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236475AbjIFLBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:01:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE831709
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 04:01:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C116420292;
        Wed,  6 Sep 2023 11:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693998067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aIHWHExCJytwauktI33lV3y52fadr8OCAogXiegZGCA=;
        b=tesi9F604i11g5ZFa2kCst6kVHn4Ry2YYi5tZhAWLtcJnzc3CahI0w9Fj2kcs1Oe94iCUk
        Pe0g4OvUblEZH8szJLxs7gGxl4UgNnYxxLk1GwjJBxpcsLvdhlMLdg9Ot5YM9FvOsSKCwj
        hz92raVHnrqaelOAn7ukVdfIUsGTlEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693998067;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aIHWHExCJytwauktI33lV3y52fadr8OCAogXiegZGCA=;
        b=9NHaJrY3I/BtxPTeEklQQuMZExZeeys//52dnrX3QGUytjqG9jZauyQ8+NH2vVSo6ezBNq
        0HrtvvO2O9k5FYAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70C631333E;
        Wed,  6 Sep 2023 11:01:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WFuPF/Nb+GSOQgAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 06 Sep 2023 11:01:07 +0000
Message-ID: <3a540950-8ca7-4ff6-9f01-be194c346411@suse.de>
Date:   Wed, 6 Sep 2023 13:01:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 2/4] nvmet-trace: null terminate device name string
 correctly
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
References: <20230829091350.16156-1-dwagner@suse.de>
 <20230829091350.16156-3-dwagner@suse.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230829091350.16156-3-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/23 11:13, Daniel Wagner wrote:
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/trace.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/trace.h b/drivers/nvme/target/trace.h
> index 6997bd7e45cf..9ba466b49613 100644
> --- a/drivers/nvme/target/trace.h
> +++ b/drivers/nvme/target/trace.h
> @@ -55,8 +55,8 @@ static inline void __assign_req_name(char *name, struct nvmet_req *req)
>   		return;
>   	}
>   
> -	strncpy(name, req->ns->device_path,
> -		min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
> +	strscpy(name, req->ns->device_path,
> +		min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path) + 1));
>   }
>   #endif
>   
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes

