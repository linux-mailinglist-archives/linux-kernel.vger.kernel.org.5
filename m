Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5617D61B4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 08:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjJYGdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 02:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJYGdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 02:33:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9931A91
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 23:33:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E10FB1FF19;
        Wed, 25 Oct 2023 06:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698215588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LKf527QDKA1/5ZquYgTSoBOfyqoeO5hVypS2OexNT8U=;
        b=NeK8/4oz3iPBAXaLdN1ODbn0/ZNjY1A7UVmyFtwHcxqRoTVxLSgyoabKpcsshwQRvnlIIe
        WdH4npgjuY+/GW+CAPL5phRvUwFKAVkGoGpyZDUY3AXfe6HkmvgtxoZEfWX+iGwZrKwlQG
        07JiAE8ZtKGACCS5/lIF7lEHhceGlnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698215588;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LKf527QDKA1/5ZquYgTSoBOfyqoeO5hVypS2OexNT8U=;
        b=mOoz4eUQajxJbKgl6M1puu+MBU4V6hdtMejovqaEm5Br/CVyuF9Dq58inAztEaTxPWC6Zw
        ltEV6quIiWXu7VBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 66D0B13524;
        Wed, 25 Oct 2023 06:33:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iOxhEKS2OGV+RQAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 25 Oct 2023 06:33:08 +0000
Message-ID: <7d2e149e-f965-4e06-ac9d-faedeac74046@suse.de>
Date:   Wed, 25 Oct 2023 08:33:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] nvme-tcp: always set valid seq_num in dhchap reply
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>,
        Mark O'Donovan <shiftee@posteo.net>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de, axboe@kernel.dk
References: <20231023140003.58019-1-shiftee@posteo.net>
 <ZTfzetR5o_RUfJGK@kbusch-mbp>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZTfzetR5o_RUfJGK@kbusch-mbp>
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

On 10/24/23 18:40, Keith Busch wrote:
> On Mon, Oct 23, 2023 at 02:00:00PM +0000, Mark O'Donovan wrote:
>> The first patch is a small unrelated fix which makes it clear that the
>> response data section of the Success1 message is not optional.
>>
>> The second patch removes use of the host sequence number (S2) as an
>> indicator of bi-directional authentication.
>>
>> The third patch causes us to always set the host sequence number (S2)
>> to a non-zero value instead of the 0 value reserved for the secure
>> channel feature.
> 
> Should these go in now for 6.6? We're pretty close to the end. If for
> 6.7, there is a merge conflict that I think would be easiest resolved if
> I wait until the block tree resyncs after the 6.7 merge window opens.
> 
I'd suggest to wait, as we'll need to fixup nvmet, too.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

