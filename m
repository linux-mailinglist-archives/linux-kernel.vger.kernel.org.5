Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DFB7702D4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjHDOUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjHDOUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:20:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1EA11B;
        Fri,  4 Aug 2023 07:20:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3285E1F8B0;
        Fri,  4 Aug 2023 14:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691158836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CSB5apA+271QhFsINBD70EU+4xw+qMjisa/GtmIDpPg=;
        b=Q1wX933b9Q4sPjTYKayx5kBeJJR3hF0gKtW/dzIc0F2MBXwRNhiVakyaDk//JxSvsbpZh8
        BOSjSnXkmHUjQgAc+6x6nLoX3xj5vWOUqMizNQ9ZiJIpCQTDPIveDffvFGpVxpLOL1qXyX
        Cxxk7pOcp9BRAzYdQNZwvXiozP6a5Xg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691158836;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CSB5apA+271QhFsINBD70EU+4xw+qMjisa/GtmIDpPg=;
        b=oE3q6r8GQVlE26fq8v7Sy1kkRKsOziGkK8+HbsyWEDg+GQqqQFuxi+RwHDbjq6uvaTe67+
        YSChD46rELjkSTAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F20DE13904;
        Fri,  4 Aug 2023 14:20:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rMS/OTMJzWSgMQAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 04 Aug 2023 14:20:35 +0000
Message-ID: <273c9c99-dc2f-2854-bbc1-70b22b5589d8@suse.de>
Date:   Fri, 4 Aug 2023 16:20:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: XFS metadata CRC errors on zram block device on ppc64le
 architecture
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Dusty Mabe <dusty@dustymabe.com>, wq@lst.de,
        Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, marmijo@redhat.com
References: <b2d40565-7868-ba15-4bb1-fca6f0df076b@dustymabe.com>
 <20230802094106.GA28187@lst.de>
 <3f36882c-b429-3ece-989b-a6899c001cbd@suse.de>
 <43843fec-f30a-1edc-b428-1d38ddb1050f@dustymabe.com>
 <a0f05188-d142-82f2-74aa-6c9a6ae2bbc9@dustymabe.com>
 <20230804032523.GA81493@google.com> <20230804134248.GA26611@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230804134248.GA26611@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/23 15:42, Christoph Hellwig wrote:
> FYI, I've found an arm64 system with 16k page size support, and while
> I can't reproduce the exact issue, I do see corruption with I/O test
> on zram that don't show on the same system with 4k pages.  I'm trying
> to understand the details at the moment.
> 
For some reason zram run with a logical block size of 4k:

#define ZRAM_LOGICAL_BLOCK_SHIFT 12
#define ZRAM_LOGICAL_BLOCK_SIZE (1 << ZRAM_LOGICAL_BLOCK_SHIFT)

so we'll have sub-page accesses for larger page sizes.
My bet is that the issue goes away if we set the logical block size to 
page size ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

