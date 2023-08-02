Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB99A76CB68
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbjHBLDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbjHBLDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:03:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8441FC3;
        Wed,  2 Aug 2023 04:03:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A28641F749;
        Wed,  2 Aug 2023 11:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690974227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7mCqh70c56B99LFYpEgpynueQhpFOzazSCA++MMtA2o=;
        b=tZ2ppa2kr4CLr5YWTwkasZluSsvIK4383Jj33YMEDmO0SUo3u4ch0Ukz7FvQbh3wD+up+x
        UlswJk23DOmx/uoEZlPcErxLVOMkcCvqUgDAYLganeTsb/3JHPv3K4Kl9dlgf1gOxjbX+2
        bMsMYnFJ62qmI321xYoVufYY6g8lH+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690974227;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7mCqh70c56B99LFYpEgpynueQhpFOzazSCA++MMtA2o=;
        b=TbVUxGtNfbtW1NUuRUNAyJJI9DdYT7xovBxNQgz+b7Dffdw/Zz0QoouqI47kHIk/mLJwzy
        kQBNXfBz3Xv1jYBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8BB4D13919;
        Wed,  2 Aug 2023 11:03:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FMeuIRM4ymQfGwAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 02 Aug 2023 11:03:47 +0000
Message-ID: <3f36882c-b429-3ece-989b-a6899c001cbd@suse.de>
Date:   Wed, 2 Aug 2023 13:03:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: XFS metadata CRC errors on zram block device on ppc64le
 architecture
Content-Language: en-US
To:     wq@lst.de, Dusty Mabe <dusty@dustymabe.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>, marmijo@redhat.com
References: <b2d40565-7868-ba15-4bb1-fca6f0df076b@dustymabe.com>
 <20230802094106.GA28187@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230802094106.GA28187@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/23 11:41, Christoph Hellwig wrote:
> On Tue, Aug 01, 2023 at 11:31:37PM -0400, Dusty Mabe wrote:
>> We ran a kernel bisect and narrowed it down to offending commit af8b04c6:
>>
>> ```
>> [root@ibm-p8-kvm-03-guest-02 linux]# git bisect good
>> af8b04c63708fa730c0257084fab91fb2a9cecc4 is the first bad commit
>> commit af8b04c63708fa730c0257084fab91fb2a9cecc4
>> Author: Christoph Hellwig <hch@lst.de>
>> Date:   Tue Apr 11 19:14:46 2023 +0200
>>
>>      zram: simplify bvec iteration in __zram_make_request
>>      
>>      bio_for_each_segment synthetize bvecs that never cross page boundaries, so
>>      don't duplicate that work in an inner loop.
> 
>> Any ideas on how to fix the problem?
> 
> So the interesting cases are:
> 
>    - ppc64 usually uses 64k page sizes
>    - ppc64 is somewhat cache incoherent (compared to say x86)
> 
> Let me think of this a bit more.

Would need to be confirmed first that 64k pages really are in use
(eg we compile ppc64le with 4k page sizes ...).
Dusty?
For which page size did you compile your kernel?

Cheers,

Hannes

