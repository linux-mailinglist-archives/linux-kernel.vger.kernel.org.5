Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56347A764A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbjITIuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbjITIt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:49:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D7BDC;
        Wed, 20 Sep 2023 01:49:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 419801FE0A;
        Wed, 20 Sep 2023 08:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695199791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HX5pPg3EIgB5tnraIeoBZTHS0SCTNA9W4l/mVV5w2no=;
        b=LHVFHkXQ55/j0xSp+zPQLMOZ3OlKzq82cbMsy3h/grCDs2mXdcylirJP/DxG52b++qCDfG
        fI5JcmZV4PWWa+4eARqDxPaBl37nm9P76+W/o166WPruHNXqO1Ah+UKqIJ4Ka41VbbsgLl
        oq7pJ0qfkb0s2fwF4g5ljtQA0ePPK4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695199791;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HX5pPg3EIgB5tnraIeoBZTHS0SCTNA9W4l/mVV5w2no=;
        b=t468LGTetz8kGMyaGPGD279qVaYSRjdOcZU+YgTSUTf4EincTWPBRpxxEq7xwQqDQiYU2z
        BdCfOFI9FPXSBZCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF004132C7;
        Wed, 20 Sep 2023 08:49:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4e28MS6yCmXeYAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 20 Sep 2023 08:49:50 +0000
Message-ID: <40bc28e5-c971-055f-eff4-b9d67fe768cc@suse.cz>
Date:   Wed, 20 Sep 2023 10:49:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 00/14] Prevent cross-cache attacks in the SLUB
 allocator
Content-Language: en-US
To:     Matteo Rizzo <matteorizzo@google.com>,
        "Lameter, Christopher" <cl@os.amperecomputing.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, luto@kernel.org, peterz@infradead.org,
        jannh@google.com, evn@google.com, poprdi@google.com,
        jordyzomer@google.com, Mike Rapoport <rppt@kernel.org>
References: <20230915105933.495735-1-matteorizzo@google.com>
 <7a4f5128-28fd-3c5f-34c2-1c34f4448174@intel.com>
 <1d7573c0-ebbc-6ed2-f152-1045eb0542f9@os.amperecomputing.com>
 <CAHKB1w+rVyww0UrHhzeGfPA7FM482Z-7ApzXvekVqLHvTDAV3Q@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAHKB1w+rVyww0UrHhzeGfPA7FM482Z-7ApzXvekVqLHvTDAV3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/23 14:08, Matteo Rizzo wrote:
> On Fri, 15 Sept 2023 at 18:30, Lameter, Christopher
>> Problems:
>>
>> - Overhead due to more TLB lookups
>>
>> - Larger amounts of TLBs are used for the OS. Currently we are trying to
>> use the maximum mappable TLBs to reduce their numbers. This presumably
>> means using 4K TLBs for all slab access.
> 
> Yes, we are using 4K pages for the slab mappings which is going to increase
> TLB pressure. I also tried writing a version of the patch that uses 2M
> pages which had slightly better performance, but that had its own problems.
> For example most slabs are much smaller than 2M, so we would need to create
> and map multiple slabs at once and we wouldn't be able to release the
> physical memory until all slabs in the 2M page are unused which increases
> fragmentation.
 At last LSF/MM [1] we basically discarded direct map fragmentation
avoidance as solving something that turns out to be insignificant, with the
exception of kernel code. As kernel code is unlikely to be allocated from
kmem caches due to W^X, we can hopefully assume it's also insignificant for
the virtual slab area.

[1] https://lwn.net/Articles/931406/
