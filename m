Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C383777EAF3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346222AbjHPUnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346250AbjHPUnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:43:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D022708
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692218548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Dcr9awbp01H1CoQcQY28YU+zOq3gLrw7va+rOtopp8=;
        b=OJ48mmhGTRHLQWU5vjhCrc6hHFOsd6nIVeKiCYgcAbx8ZRzgeSAkCKFo0k61TEngEd9Yym
        fmjdgLjKy7valgMWLISEt+CWGBS/jn1+neeF4kEckRABofdRI0UVoSRhDw7vUYLEd5Nca/
        ieEF3kiYgIEYGT8sMgHL8F229eRaBvQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-686-WvFTTRhQNZ-CNATJ-EXJfA-1; Wed, 16 Aug 2023 16:42:24 -0400
X-MC-Unique: WvFTTRhQNZ-CNATJ-EXJfA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61F9F8DC664;
        Wed, 16 Aug 2023 20:42:23 +0000 (UTC)
Received: from [10.22.17.252] (unknown [10.22.17.252])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA6471121314;
        Wed, 16 Aug 2023 20:42:20 +0000 (UTC)
Message-ID: <0c238ca2-691f-b69c-76d3-efac330570da@redhat.com>
Date:   Wed, 16 Aug 2023 16:42:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 0/4] x86/speculation: Disable IBRS when idle
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20230727184600.26768-1-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230727184600.26768-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/23 14:45, Waiman Long wrote:
>   v6:
>    - Fix allyesconfig build error by moving __update_spec_ctrl()
>      helper from nospec-branch.h to spec-ctrl.h and include it in files
>      that need the helper.
>
>   v5:
>    - Update comment in patch 1.
>    - Minor doc update and code twist in patch 4 as suggested by Peter and
>      Randy.
>
>   v4:
>    - Add a new __update_spec_ctrl() helper in patch 1.
>    - Rebased to the latest linux kernel.
>
>   v3:
>    - Drop patches 1 ("x86/speculation: Provide a debugfs file to dump
>      SPEC_CTRL MSRs") and 5 ("x86/idle: Disable IBRS entering mwait idle
>      and enable it on wakeup") for now.
>    - Drop the MSR restoration code in ("x86/idle: Disable IBRS when cpu
>      is offline") as native_play_dead() does not return.
>    - For patch ("intel_idle: Add ibrs_off module parameter to force
>      disable IBRS"), change the name from "no_ibrs" to "ibrs_off" and
>      document the new parameter in intel_idle.rst.
>
> For Intel processors that need to turn on IBRS to protect against
> Spectre v2 and Retbleed, the IBRS bit in the SPEC_CTRL MSR affects
> the performance of the whole core even if only one thread is turning
> it on when running in the kernel. For user space heavy applications,
> the performance impact of occasionally turning IBRS on during syscalls
> shouldn't be significant. Unfortunately, that is not the case when the
> sibling thread is idling in the kernel. In that case, the performance
> impact can be significant.
>
> When DPDK is running on an isolated CPU thread processing network packets
> in user space while its sibling thread is idle. The performance of the
> busy DPDK thread with IBRS on and off in the sibling idle thread are:
>
>                                  IBRS on         IBRS off
>                                  -------         --------
>    packets/second:                  7.8M           10.4M
>    avg tsc cycles/packet:         282.26          209.86
>
> This is a 25% performance degradation. The test system is a Intel Xeon
> 4114 CPU @ 2.20GHz.
>
> Commit bf5835bcdb96 ("intel_idle: Disable IBRS during long idle")
> disables IBRS when the CPU enters long idle (C6 or below). However, there
> are existing users out there who have set "intel_idle.max_cstate=1"
> to decrease latency. Those users won't be able to benefit from this
> commit. This patch series extends this commit by providing a new
> "intel_idle.ibrs_off" module parameter to force disable IBRS even when
> "intel_idle.max_cstate=1" at the expense of increased IRQ response
> latency. It also includes a commit to allow the disabling of IBRS when
> a CPU becomes offline.
>
> Waiman Long (4):
>    x86/speculation: Add __update_spec_ctrl() helper
>    x86/idle: Disable IBRS when cpu is offline
>    intel_idle: Use __update_spec_ctrl() in intel_idle_ibrs()
>    intel_idle: Add ibrs_off module parameter to force disable IBRS
>
>   Documentation/admin-guide/pm/intel_idle.rst | 17 ++++++++++++++++-
>   arch/x86/include/asm/spec-ctrl.h            | 11 +++++++++++
>   arch/x86/kernel/smpboot.c                   |  8 ++++++++
>   drivers/idle/intel_idle.c                   | 18 +++++++++++++-----
>   4 files changed, 48 insertions(+), 6 deletions(-)
>
Peter,

Is this patch series good enough to be merged?

Thanks,
Longman

