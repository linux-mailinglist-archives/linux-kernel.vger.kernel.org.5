Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905F2753500
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbjGNI0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbjGNI0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:26:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0869B;
        Fri, 14 Jul 2023 01:26:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 43CA91FD8E;
        Fri, 14 Jul 2023 08:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689323168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fks1WScsSrOgkleCsjnUGYtvL8hJjpfw+GXcKVrd4Cc=;
        b=WulcpL0qvQltYlR9ph9oGtrmlDGzPveFHunO2MGoiLrwrMpp9JHS4u16B4gHtodoBuGZCS
        CKCo2FxPqOueJOeaZlsjfrGRIba6MSZDlRvbCet4KO6g/2t5skOpN8DRFsq4RWQAXdOgL9
        JKLB4M/ftVP5RQh1S2j8Z8MuhsRNbPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689323168;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fks1WScsSrOgkleCsjnUGYtvL8hJjpfw+GXcKVrd4Cc=;
        b=DERqA/i5gSqcbt3I3iT9HLa67XOi7yzmv5oKPmqERX0k+bLFm6qlso+QHecdA3yu1psp6D
        FAzxXJJz2h1/2HCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB98413A15;
        Fri, 14 Jul 2023 08:26:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id G1jjNJ8GsWQOVAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 14 Jul 2023 08:26:07 +0000
Message-ID: <d9f96152-e48e-7a1f-cd00-b7d508c5560f@suse.cz>
Date:   Fri, 14 Jul 2023 10:26:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5] Randomized slab caches for kmalloc()
Content-Language: en-US
To:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        gongruiqi1@huawei.com
References: <20230714064422.3305234-1-gongruiqi@huaweicloud.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230714064422.3305234-1-gongruiqi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/23 08:44, GONG, Ruiqi wrote:
> When exploiting memory vulnerabilities, "heap spraying" is a common
> technique targeting those related to dynamic memory allocation (i.e. the
> "heap"), and it plays an important role in a successful exploitation.
> Basically, it is to overwrite the memory area of vulnerable object by
> triggering allocation in other subsystems or modules and therefore
> getting a reference to the targeted memory location. It's usable on
> various types of vulnerablity including use after free (UAF), heap out-
> of-bound write and etc.
> 
> There are (at least) two reasons why the heap can be sprayed: 1) generic
> slab caches are shared among different subsystems and modules, and
> 2) dedicated slab caches could be merged with the generic ones.
> Currently these two factors cannot be prevented at a low cost: the first
> one is a widely used memory allocation mechanism, and shutting down slab
> merging completely via `slub_nomerge` would be overkill.
> 
> To efficiently prevent heap spraying, we propose the following approach:
> to create multiple copies of generic slab caches that will never be
> merged, and random one of them will be used at allocation. The random
> selection is based on the address of code that calls `kmalloc()`, which
> means it is static at runtime (rather than dynamically determined at
> each time of allocation, which could be bypassed by repeatedly spraying
> in brute force). In other words, the randomness of cache selection will
> be with respect to the code address rather than time, i.e. allocations
> in different code paths would most likely pick different caches,
> although kmalloc() at each place would use the same cache copy whenever
> it is executed. In this way, the vulnerable object and memory allocated
> in other subsystems and modules will (most probably) be on different
> slab caches, which prevents the object from being sprayed.
> 
> Meanwhile, the static random selection is further enhanced with a
> per-boot random seed, which prevents the attacker from finding a usable
> kmalloc that happens to pick the same cache with the vulnerable
> subsystem/module by analyzing the open source code. In other words, with
> the per-boot seed, the random selection is static during each time the
> system starts and runs, but not across different system startups.
> 
> The overhead of performance has been tested on a 40-core x86 server by
> comparing the results of `perf bench all` between the kernels with and
> without this patch based on the latest linux-next kernel, which shows
> minor difference. A subset of benchmarks are listed below:
> 
>                 sched/  sched/  syscall/       mem/       mem/
>              messaging    pipe     basic     memcpy     memset
>                  (sec)   (sec)     (sec)   (GB/sec)   (GB/sec)
> 
> control1         0.019   5.459     0.733  15.258789  51.398026
> control2         0.019   5.439     0.730  16.009221  48.828125
> control3         0.019   5.282     0.735  16.009221  48.828125
> control_avg      0.019   5.393     0.733  15.759077  49.684759
> 
> experiment1      0.019   5.374     0.741  15.500992  46.502976
> experiment2      0.019   5.440     0.746  16.276042  51.398026
> experiment3      0.019   5.242     0.752  15.258789  51.398026
> experiment_avg   0.019   5.352     0.746  15.678608  49.766343
> 
> The overhead of memory usage was measured by executing `free` after boot
> on a QEMU VM with 1GB total memory, and as expected, it's positively
> correlated with # of cache copies:
> 
>            control  4 copies  8 copies  16 copies
> 
> total       969.8M    968.2M    968.2M     968.2M
> used         20.0M     21.9M     24.1M      26.7M
> free        936.9M    933.6M    931.4M     928.6M
> available   932.2M    928.8M    926.6M     923.9M
> 
> Co-developed-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> Signed-off-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks! Pushed to slab/for-6.6/random_kmalloc and for-next.


