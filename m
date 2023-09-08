Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C57798199
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 07:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239793AbjIHFvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 01:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjIHFvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 01:51:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D5C19BA;
        Thu,  7 Sep 2023 22:51:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C371F218EA;
        Fri,  8 Sep 2023 05:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694152276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I1jlw6dXRzKXinGxUT2SY0IMhDQLif42Och5k8NNLJE=;
        b=TXzTuy5WCuaYAiImqFlBiXBtuAbEKWlz5ZoimisX1yskMoAvGRqbnZnv5r2xSdTUO1wCT2
        v1a9nvXIHgpP0bVZeR/klHO6eOuYgMuwAPcrg+RyWLjcqk4Pj52ltJSam6cDuv2Gy/rQ9m
        9rlEXJJBR+MKJ+i7iEf/o1LBaLeiuUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694152276;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I1jlw6dXRzKXinGxUT2SY0IMhDQLif42Och5k8NNLJE=;
        b=9zF2l2QhmQhF3pFOWbf90bVcKsaxsmS9oxZ2Hl0NlNckhBRAi5tTNPdMt0UbHTPbFIGtiF
        9U1zhzzZNfKmMCBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97CA0132FA;
        Fri,  8 Sep 2023 05:51:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VntUI1S2+mTYYgAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 08 Sep 2023 05:51:16 +0000
Message-ID: <98a47b9b-45ee-4166-aad7-6a2c05c201a0@suse.de>
Date:   Fri, 8 Sep 2023 07:51:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: fix tags UAF when shrink nr_hw_queues
To:     chengming.zhou@linux.dev, axboe@kernel.dk, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Yi Zhang <yi.zhang@redhat.com>
References: <20230908005702.2183908-1-chengming.zhou@linux.dev>
Content-Language: en-US
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230908005702.2183908-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/23 02:57, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> When nr_hw_queues shrink, we free the excess tags before realloc
> hw_ctxs for each queue, during that we may need to access those
> tags, like blk_mq_tag_idle(hctx) will access queue shared tags.
> 
> So slab-use-after-free caused and reported by KASAN. Fix it by
> moving the releasing of excess tags to the end.
> 
> Fixes: e1dd7bc93029 ("blk-mq: fix tags leak when shrink nr_hw_queues")
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/all/CAHj4cs_CK63uoDpGBGZ6DN4OCTpzkR3UaVgK=LX8Owr8ej2ieQ@mail.gmail.com/
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>   block/blk-mq.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

