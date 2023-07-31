Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC96769C7C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjGaQ3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjGaQ3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:29:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4E52693;
        Mon, 31 Jul 2023 09:28:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B3D4822147;
        Mon, 31 Jul 2023 16:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690820881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kvhqVbeDEmUV6PN2wba2FNyJnxnf3msKSymDgqRJ+yw=;
        b=OEriT2aHNyDmTiiYxpMshLL+xG8DlZJUiPE/d4IyTPQ5bys98KwXALgj3XbWjmZEBtqm/F
        aGrqWGcK0U5MTCP4XT5gruqJoQ8DmXkfOe9YPE91PdYrYdyNDZisY4Vs58UOzIBtVSQfv9
        Z6ACpCpdOvT5V7B7Uwp7hL6uxO21EXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690820881;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kvhqVbeDEmUV6PN2wba2FNyJnxnf3msKSymDgqRJ+yw=;
        b=YodQ61z4oGRgZb8dvKs0VH9lLPVxxvkIUm8AOpmnJkpIZRMbPvvg3v/Fy+BMQ8vdLRRJ4M
        Aue+nM+fOKLYv7Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 870E01322C;
        Mon, 31 Jul 2023 16:28:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T5oAIBHhx2SkEwAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 31 Jul 2023 16:28:01 +0000
Message-ID: <de6ba52c-0f14-670f-7262-93f2aced926a@suse.de>
Date:   Mon, 31 Jul 2023 18:28:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/4] blk-flush: flush_rq should inherit first_rq's
 cmd_flags
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
References: <20230725130102.3030032-1-chengming.zhou@linux.dev>
 <20230725130102.3030032-2-chengming.zhou@linux.dev>
 <20230731060957.GA30409@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230731060957.GA30409@lst.de>
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

On 7/31/23 08:09, Christoph Hellwig wrote:
> On Tue, Jul 25, 2023 at 09:00:59PM +0800, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> The cmd_flags in blk_kick_flush() should inherit the original request's
>> cmd_flags, but the current code looks buggy to me:
> 
> Should it?  I know the code is kinda trying to do it, but does it really
> make sense?  Adding Hannes who originally added this inheritance and
> discussing the details below:
> 
Yeah, it does.
The flush machinery is sending flushes before and/or after the original 
request (preflush/postflush). For blocked transports (ie during FC RSCN 
handling) the transport will error out commands depending on the 
FAILFAST setting. If FAILFAST is set the SCSI layer gets an 
STS_TRANSPORT error (causing the I/O to be retried), but STS_ERROR if 
not set (causing I/O to failed).

So if the FAILFAST setting is _not_ aligned between flush_rq and the 
original we'll get an error on the flush rq and a retry on the original 
rq, causing the entire command to fail.

I guess we need to align them.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

