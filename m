Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FD176302D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjGZIpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbjGZIok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:44:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43AB9006;
        Wed, 26 Jul 2023 01:34:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 611BE1F74A;
        Wed, 26 Jul 2023 08:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690360492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DNObAGqTS+qyReybr3pgmWoo5MjVeKr0FgRCIVXTNVg=;
        b=cucQRRFtX/YdI8s3iveG5mtAm17SVAuCZTNki8YYp08DO6U850fCw6mNG0Pzn9lZRhUdgQ
        xoNUBewQI8ZtbVeVsNou/SAA0o6gyzPoJp3o+ANxm+dC8xPQLr3ZeZXMp+hC8tbajd6003
        nHLVoecxudbnBiY2ZFZ7V5zu/IW5Xvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690360492;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DNObAGqTS+qyReybr3pgmWoo5MjVeKr0FgRCIVXTNVg=;
        b=BLEvISpBgYWpb5n3MxBk+24/JnmgE4Uzplh0NUj5fLr65tA+65i7STt4qE6EG3rwit97fm
        9PZRn8DMKGZtkfDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2548F139BD;
        Wed, 26 Jul 2023 08:34:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id REZgCKzawGRPSQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 26 Jul 2023 08:34:52 +0000
Message-ID: <89363892-2752-5b6e-d084-79f54d7e455b@suse.cz>
Date:   Wed, 26 Jul 2023 10:34:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] mm/slub: disable slab merging in the default
 configuration
To:     David Rientjes <rientjes@google.com>,
        Julian Pidancet <julian.pidancet@oracle.com>
Cc:     Christoph Lameter <cl@linux.com>,
        "Lameter, Christopher" <cl@os.amperecomputing.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Rafael Aquini <aquini@redhat.com>
References: <20230629221910.359711-1-julian.pidancet@oracle.com>
 <38083ed2-333b-e245-44e4-2f355e4f9249@google.com>
 <CTSGWINSM18Q.3HQ1DN27GNA1R@imme>
 <8813897d-4a52-37a0-fe44-a9157716be9b@google.com>
 <17349901-df3a-494e-fa71-2584d92526b5@google.com>
 <3bcfa538-4474-09b7-1812-b4260b09256a@google.com>
 <7b6b07b3-d8a1-b24f-1df2-bf6080bc5516@google.com>
 <CU5AB77A9U99.1G4IRUW6DZPJP@imme>
 <b9e451a6-087d-4fb6-521b-bb8962da1f5c@google.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <b9e451a6-087d-4fb6-521b-bb8962da1f5c@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/23 01:25, David Rientjes wrote:
> On Tue, 18 Jul 2023, Julian Pidancet wrote:
> 
>> Hi David,
>> 
>> Many thanks for running all these tests. The amount of attention you've
>> given this change is simply amazing. I wish I could have been able to
>> assist you by doing more tests, but I've been lacking the necessary
>> resources to do so.
>> 
>> I'm as surprised as you are regarding the skylake regression. 20% is
>> quite a large number, but perhaps it's less worrying than it looks given
>> that benchmarks are usually very different from real-world workloads?
>> 
> 
> I'm not an expert on context_switch1_per_thread_ops so I can't infere 
> which workloads would be most affected by such a regression other than to 
> point out that -18% is quite substantial.

It might turn out that this regression is accidental in that merging happens
to result in a better caching that benefits the particular skylake cache
hierarchy (but not others), because the workload happens to use two
different classes of objects that are compatible for merging, and uses them
with identical lifetime.

But that would be arguably still a corner case and not something to result
in a hard go/no-go for the change, as similar corner cases would likely
exist that would benefit from not merging.

But it's possible the reason for the regression is something less expectable
than the above hypotehsis, so indeed we should investigate first.

> I'm still hoping to run some benchmarks with 64KB page sizes as Christoph 
> suggested, I should be able to do this with arm64.
> 
> It's ceratinly good news that the overall memory footprint doesn't change 
> much with this change.
> 
>> As Kees Cook was suggesting in his own reply, have you given a thought
>> about including this change in -next and see if there are regressions
>> showing up in CI performance tests results?
>> 
> 
> I assume that anything we can run with CI performance tests can also be 
> run without merging into -next?
> 
> The performance degradation is substantial for a microbenchmark, I'd like 
> to complete the picture on other benchmarks and do a complete analysis 
> with 64KB page sizes since I think the concern Christoph mentions could be 
> quite real.  We just don't have the data yet to make an informed 
> assessment of it.  Certainly would welcome any help that others would like 
> to provide for running benchmarks with this change as well :P
> 
> Once we have a complete picture, we might also want to discuss what we are 
> hoping to achieve with such a change.  I was very supportive of it prior 
> to the -18% benchmark result.  But if most users are simply using whatever 
> their distro defaults to and other users may already be opting into this 
> either by the kernel command line or .config, it's hard to determine 
> exactly the set of users that would be affected by this change.  Suddenly 
> causing a -18% regression overnight for this would be surprising for them.

What I'd hope to achieve is that if we find out that the differences of
merging/not-merging are negligible (modulo corner cases) for both
performance and memory, we'd not only change the default, but even make
merging more exceptional. It should still be done under SLUB_TINY, and maybe
we can keep the slab_merge boot option, but that's it?

Because in case they are comparable, not merging has indeed benefits -
/proc/slabinfo accounting is not misleading, so in case a bug is reported,
it's not neccessary to reboot with nomerge to get the real picture, then
there are the security benefits mentioned etc.
