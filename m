Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9773C7F4094
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjKVIwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjKVIwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:52:49 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABECBC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 00:52:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CF7521F8D5;
        Wed, 22 Nov 2023 08:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1700643163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DoxYngXQcBFrKZBU45orWpD1iA1J/+o8DuRF+eOgloU=;
        b=3Arli7k6WNSX8bcUEmcQRyjqvj+1qU+cZjSRNVfojx/A+ovbMNjlFNylncumtGaWczSrbD
        /CQpYlANV2iyfP1aZYIqfUBxVsw+1Aw1lSxJE+T5pC0tPmrDi2+ZQ7fsoRvbyB/DGZe4lB
        x7c5Z84s5dZyEjchA//ddMIlqcFQfP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1700643163;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DoxYngXQcBFrKZBU45orWpD1iA1J/+o8DuRF+eOgloU=;
        b=AhqcFv0phVJeAnHWr6PQPGlc9ySTSoizDQgnSz5m3d5rqbqIcwhpcQZq+C7+uknnr3tPYh
        voC16BNXhuGwQgAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC36C139FD;
        Wed, 22 Nov 2023 08:52:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wLVdKVvBXWXpYgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 22 Nov 2023 08:52:43 +0000
Message-ID: <8810621b-6711-dca5-db34-3b12b73a2316@suse.cz>
Date:   Wed, 22 Nov 2023 09:52:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 6/9] slub: Delay freezing of partial slabs
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Chengming Zhou <chengming.zhou@linux.dev>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231102032330.1036151-1-chengming.zhou@linux.dev>
 <20231102032330.1036151-7-chengming.zhou@linux.dev>
 <4f3bc1bd-ea87-465d-b58a-0ed57b15187b@sirena.org.uk>
 <c8bb9dd9-ae18-4fab-a664-6ec4b0cb2e30@linux.dev>
 <ZVwIFNdABN1b+qWC@finisterre.sirena.org.uk>
 <b3bc868f-bf83-4b86-bcf0-13e99d0b7c7e@linux.dev>
 <ZVz1M9AYRepPRBxm@finisterre.sirena.org.uk>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZVz1M9AYRepPRBxm@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -3.96
X-Spamd-Result: default: False [-3.96 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         RCVD_TLS_ALL(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         BAYES_HAM(-0.16)[69.08%];
         RCPT_COUNT_TWELVE(0.00)[12];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/23 19:21, Mark Brown wrote:
> On Tue, Nov 21, 2023 at 11:47:26PM +0800, Chengming Zhou wrote:
> 
>> Ah yes, there is no NMI on ARM, so CPU 3 maybe running somewhere with
>> interrupts disabled. I searched the full log, but still haven't a clue.
>> And there is no any WARNING or BUG related to SLUB in the log.
> 
> Yeah, nor anything else particularly.  I tried turning on some debug
> options:
> 
> CONFIG_SOFTLOCKUP_DETECTOR=y
> CONFIG_DETECT_HUNG_TASK=y
> CONFIG_WQ_WATCHDOG=y
> CONFIG_DEBUG_PREEMPT=y
> CONFIG_DEBUG_LOCKING=y
> CONFIG_DEBUG_ATOMIC_SLEEP=y
> 
> https://validation.linaro.org/scheduler/job/4017828
> 
> which has some additional warnings related to clock changes but AFAICT
> those come from today's -next rather than the debug stuff:
> 
> https://validation.linaro.org/scheduler/job/4017823
> 
> so that's not super helpful.

For the record (and to help debugging focus) on IRC we discussed that with
CONFIG_SLUB_CPU_PARTIAL=n the problem persists:
https://validation.linaro.org/scheduler/job/4017863
Which limits the scope of where to look so that's good :)

>> I wonder how to reproduce it locally with a Qemu VM since I don't have
>> the ARM machine.
> 
> There's sample qemu jobs available from for example KernelCI:
> 
>    https://storage.kernelci.org/next/master/next-20231120/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-virt-gicv3.html
> 
> (includes the command line, though it's not using Debian testing like my
> test was).  Note that I'm testing a bunch of platforms with the same
> kernel/rootfs combination and it was only the Raspberry Pi 3 which blew
> up.  It is a bit tight for memory which might have some influence?
> 
> I'm really suspecting this may have made some underlying platform bug
> more obvious :/

