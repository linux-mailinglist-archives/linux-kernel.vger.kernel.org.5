Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E312E7AFB09
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjI0G0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjI0G0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:26:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2330D1A8;
        Tue, 26 Sep 2023 23:26:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B655921873;
        Wed, 27 Sep 2023 06:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695795966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iMMMAkXIfCJBA1fnhBXlrKaQDS1jkKA6gpwpqc4OApU=;
        b=ktWgBJDUGFFX22xHnBuwDLIabwT1AksbzWTA7mv7gKbegGZMI0DqlqBKjZF1a8F0FnFEkZ
        +/gmw3ZKTYYD6cIztyrG1Tqqa1IA+N1m+gwm9AcnG5JhmsnC+J6Fd7Pd27wQGLx92/C2IY
        E4hGHgb3EfWuoebiy454mRdL9jQsVrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695795966;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iMMMAkXIfCJBA1fnhBXlrKaQDS1jkKA6gpwpqc4OApU=;
        b=itz5ji7XRrmNIUxMaFZVmHJkUG0I1y0AmNVOaciU2yssUCqPtPXOyoDmUykHdoB9R1uGzO
        SfA0yR1+Pec/jdDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C355113479;
        Wed, 27 Sep 2023 06:26:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Vqo9Kv3KE2VMIwAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 27 Sep 2023 06:26:05 +0000
Message-ID: <d837ebda-2dbd-46d9-b04a-3d086ab5ba92@suse.de>
Date:   Wed, 27 Sep 2023 08:26:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/18] scsi: scsi_error: Introduce new error handle
 mechanism
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Mike Christie <michael.christie@oracle.com>
Cc:     Wenchao Hao <haowenchao2@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        louhongxiang@huawei.com, lixiaokeng@huawei.com
References: <20230901094127.2010873-1-haowenchao2@huawei.com>
 <ZRGfc73BSW0yyUtI@infradead.org>
 <47bed3cb-f307-ec55-5c28-051687dab1ea@huawei.com>
 <a92f5e0c-1976-4fc6-ba48-7ff49546318a@oracle.com>
 <ZRKHokGtOE/AgAFY@infradead.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZRKHokGtOE/AgAFY@infradead.org>
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

On 9/26/23 09:26, Christoph Hellwig wrote:
> On Mon, Sep 25, 2023 at 12:54:48PM -0500, Mike Christie wrote:
>> I think we want to figure out Hannes's patches first.
> 
> Yes.
> 
>> For a new EH design we will want to be able to do multiple TMFs in parallel
>> on the same host/target right?
>>
>> The problem is that we need to be able to make forward progress in the EH
>> path and not fail just because we can't allocate memory for a TMF related
>> struct. To accomplish this now, drivers will use mempools, preallocate TMF
>> related structs/mem/tags with their scsi_cmnd related structs, preallocate
>> per host/target/device related structs or ignore what I wrote above and just
>> fail.
>>
>> Hannes's patches fix up the eh callouts so they don't pass in a scsi_cmnd
>> when it's not needed. That seems nice because after that, then for your new
>> EH we can begin to standardize on how to handle preallocation of drivers
>> resources needed to perform TMFs for your new EH. It could be a per
>> device/target/host callout to allow drivers to preallocate, then scsi-ml calls
>> into the drivers with that data. It doesn't have to be exactly like that or
>> anything close. It would be nice for drivers to not have to think about this
>> type of thing and scsi-ml just to handle the resource management for us when
>> there are multiple TMFs in progress.
> 
> Exactly!

Yeah, thanks for the vote of support.
Last time I tried the attempt got shot down, as it had been using the 
'wrong' interface. But seeing that there's renewed interest I'll be 
reposting them.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

