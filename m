Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3E6785055
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 08:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjHWGEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 02:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjHWGEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 02:04:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FABFB;
        Tue, 22 Aug 2023 23:04:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0F1281F45A;
        Wed, 23 Aug 2023 06:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692770653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i8K0uqA75zgrqeyQqMOjA4vyh8El/ZLPyoR7z7nwmbY=;
        b=cVwNHGclP/hGyDqH09K5eBIX+15NxFuAWXP9obLtWgsIrqBFik+JVFV33qZj8egkv0XI0Q
        sUzwMNfxy6zm5sKHsJiQd699ZDKUOpnp3eko0oEJX6p6O/UoK53WGM8TjNZHcy1eIxrgP3
        6I4QtU+HMax/BNSoUVAj8IYF4iPs4RA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692770653;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i8K0uqA75zgrqeyQqMOjA4vyh8El/ZLPyoR7z7nwmbY=;
        b=dCjAtT+gGxw8t9YU35qqSEBvQBmVXVmwCzK64k9GxMCsAdxBGxgtknr0p2f5MeHYZEYB7s
        1XH8fgkYjRTAhRCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1779F13458;
        Wed, 23 Aug 2023 06:04:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +z4gOVqh5WQ5GwAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 23 Aug 2023 06:04:10 +0000
Message-ID: <c7454021-5559-6556-e9ec-de856e00f1fb@suse.de>
Date:   Wed, 23 Aug 2023 08:04:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Infiniate systemd loop when power off the machine with multiple
 MD RAIDs
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        Carlos Carvalho <carlos@fisica.ufpr.br>,
        Song Liu <song@kernel.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Christoph Hellwig <hch@lst.de>, AceLan Kao <acelan@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux RAID <linux-raid@vger.kernel.org>,
        "yukuai (C)" <yukuai3@huawei.com>,
        "yangerkun@huawei.com" <yangerkun@huawei.com>
References: <028a21df-4397-80aa-c2a5-7c754560f595@gmail.com>
 <CAPhsuW5Od9tczboEBxC8gn+2XLkEbirfCUm7WuJBey5MKQjwDA@mail.gmail.com>
 <ZOUI9yDzjxuFP68E@fisica.ufpr.br>
 <909a6669-01af-dbe7-b64b-84a5f3bc75a3@huaweicloud.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <909a6669-01af-dbe7-b64b-84a5f3bc75a3@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/23 03:28, Yu Kuai wrote:
> Hi,
> 
> 在 2023/08/23 3:13, Carlos Carvalho 写道:
>> Song Liu (song@kernel.org) wrote on Tue, Aug 22, 2023 at 03:56:04PM -03:
>>> >From systemd code, i.e. function delete_md(), this error:
>>>
>>> [ 205.957004] systemd-shutdown[1]: Stopping MD /dev/md124p1 (259:6).
>>> [ 205.964177] systemd-shutdown[1]: Could not stop MD /dev/md124p1:
>>> Device or resource busy
>>>
>>> is most likely triggered by ioctl(STOP_ARRAY).
>>>
>>> And based on the code, I think the ioctl fails here:
>>>
>>>          if (cmd == STOP_ARRAY || cmd == STOP_ARRAY_RO) {
>>>                  /* Need to flush page cache, and ensure no-one else 
>>> opens
>>>                   * and writes
>>>                   */
>>>                  mutex_lock(&mddev->open_mutex);
>>>                  if (mddev->pers && atomic_read(&mddev->openers) > 1) {
>>>                          mutex_unlock(&mddev->open_mutex);
>>>                          err = -EBUSY;
>>>                          goto out;        ////////////////////// HERE
> 
> Yes, I suspect here as well, but I do some test with error injection to
> gurantee that ioctl(STOP_ARRAY) always return -EBUSY, but I found that
> system reboot didn't hang, it'll try a few times but eventually reboot
> finished.
> 
>>>                  }
>>>                  if (test_and_set_bit(MD_CLOSING, &mddev->flags)) {
>>>                          mutex_unlock(&mddev->open_mutex);
>>>                          err = -EBUSY;
>>>                          goto out;
>>>                  }
>>>                  did_set_md_closing = true;
>>>                  mutex_unlock(&mddev->open_mutex);
>>>                  sync_blockdev(bdev);
>>>          }
>>
>> Probably. The problem is why doesn't it manage to flush the page 
>> cache? I find
>> strange that the problem appears only when trying to stop the array, I 
>> get it
>> when trying to umount the filesystem, where it also hangs because of 
>> the same
>> reason. The kworker thread runs continuously using 100% cpu of only 1 
>> core.
> 
> The kworker do you mean the daemon thread or the sync thread?  runs
> continuously using 100% cpu doen't sounds correct to me.
> 
That sounds more like kworker waiting on a mutex to be released.
Can you trigger a kdump while in that state?
Or do a sysrq-T to get a stack trace of all running processes?
That should tell you where exactly the 100% cpu time is being
wasted.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

