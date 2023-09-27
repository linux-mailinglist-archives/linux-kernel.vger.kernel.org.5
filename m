Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2657AFD73
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjI0IAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjI0IAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:00:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC87199;
        Wed, 27 Sep 2023 01:00:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3188A1F8C4;
        Wed, 27 Sep 2023 08:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695801600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YVNRHsJW7fxIPxX1otv++5oBWUMe5xuAPdK1iJf8KC8=;
        b=yqQ+sWh7IiBbT93CC8DmJVICOWpZ5i8ZWR5rGk8VAo1Fepqay+lF2t2glLXe4nueaSkgt4
        u9RA1ctmgqroHgROpZ6fBEzHM2XbtvsEwOrdg5FDO7FNecGJuOs0aUAs6BkMwf2vZT0naU
        57BE1ZZKPePUfFJLiMiM8XNOauiuIgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695801600;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YVNRHsJW7fxIPxX1otv++5oBWUMe5xuAPdK1iJf8KC8=;
        b=LGr2tbFw1b9AVN9EsdnzZruuKyWWnGmNugeXOKBFn/zwqczS0pjkbzoOfcQCrC7VBM4IPg
        zdbDG0rlm7e44mBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9BE4713479;
        Wed, 27 Sep 2023 07:59:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jzEYI//gE2UvWQAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 27 Sep 2023 07:59:59 +0000
Message-ID: <c3763949-c810-4a1f-87cc-e2248bfdc40b@suse.de>
Date:   Wed, 27 Sep 2023 09:59:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/18] scsi: scsi_error: Introduce new error handle
 mechanism
Content-Language: en-US
To:     Wenchao Hao <haowenchao2@huawei.com>,
        Mike Christie <michael.christie@oracle.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        louhongxiang@huawei.com, lixiaokeng@huawei.com
References: <20230901094127.2010873-1-haowenchao2@huawei.com>
 <ZRGfc73BSW0yyUtI@infradead.org>
 <47bed3cb-f307-ec55-5c28-051687dab1ea@huawei.com>
 <a92f5e0c-1976-4fc6-ba48-7ff49546318a@oracle.com>
 <06268327-cfed-f266-34a7-fda69411ef2a@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <06268327-cfed-f266-34a7-fda69411ef2a@huawei.com>
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

On 9/26/23 14:57, Wenchao Hao wrote:
> On 2023/9/26 1:54, Mike Christie wrote:
>> On 9/25/23 10:07 AM, Wenchao Hao wrote:
>>> On 2023/9/25 22:55, Christoph Hellwig wrote:
>>>> Before we add another new error handling mechanism we need to fix the
>>>> old one first.  Hannes' work on not passing the scsi_cmnd to the 
>>>> various
>>>> reset handlers hasn't made a lot of progress in the last five years and
>>>> we'll need to urgently fix that first before adding even more
>>>> complexity.
>>>>
>>> I observed Hannes's patches posted about one year ago, it has not been
>>> applied yet. I don't know if he is still working on it.
>>>
>>> My patches do not depend much on that work, I think the conflict can be
>>> solved fast between two changes.
>>
>> I think we want to figure out Hannes's patches first.
>>
>> For a new EH design we will want to be able to do multiple TMFs in 
>> parallel
>> on the same host/target right?
>>
> 
> It's not necessary to do multiple TMFs in parallel, it's ok to make sure
> each TMFs do not affect each other.
> 
> For example, we have two devices: 0:0:0:0 and 0:0:0:1
> 
> Both of them request device reset, they do not happened in parallel, but
> would in serial. If 0:0:0:0 is performing device reset in progress, 0:0:0:1
> just wait 0:0:0:0 to finish.
> 
Well, not quite. Any higher-order TMFs are serialized by virtue of 
SCSI-EH, but command aborts (which also devolve down to TMFs on certain 
drivers) do run in parallel, and there we will be requiring multiple TMFs.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

