Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3287DC2EF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 00:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjJ3W4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 18:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjJ3W4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 18:56:02 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CDA6E4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 15:55:54 -0700 (PDT)
X-AuditID: a67dfc5b-d6dff70000001748-81-654034790898
Date:   Tue, 31 Oct 2023 07:55:48 +0900
From:   Byungchul Park <byungchul@sk.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel_team@skhynix.com, akpm@linux-foundation.org,
        ying.huang@intel.com, namit@vmware.com, xhao@linux.alibaba.com,
        mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
        david@redhat.com, peterz@infradead.org, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Subject: Re: [v3 0/3] Reduce TLB flushes under some specific conditions
Message-ID: <20231030225548.GB900@system.software.com>
References: <20231030072540.38631-1-byungchul@sk.com>
 <08c82a91-87d1-42c7-93c4-4028f3725340@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08c82a91-87d1-42c7-93c4-4028f3725340@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsXC9ZZnoW6liUOqwZ42S4s569ewWXze8I/N
        4tPLB4wWLza0M1p8Xf+L2eLppz4Wi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfVdDxkt
        jvceYLLYvGkqs8XvH0B1c6ZYWZycNZnFQdDje2sfi8eCTaUem1doeSze85LJY9OqTjaPTZ8m
        sXu8O3eO3ePEjN8sHjsfWnrMOxno8X7fVTaPrb/sPD5vkvN4N/8tWwBfFJdNSmpOZllqkb5d
        AlfGztd9TAX/uCuWzLrP3sC4mrOLkZNDQsBEYuHkG6ww9o3Zt1lAbBYBVYlbu+6C2WwC6hI3
        bvxkBrFFgOxTK5ezdzFycTALNDFLXFu/GaxZWMBd4mXHFkYQm1fATOLJq5tgDUICGRJfmjuZ
        IOKCEidnPgEbyiygJXHj30ugOAeQLS2x/B8HSJhTwFbiYe9vsBJRAWWJA9uOM4HskhBYxy5x
        4/5ZJohDJSUOrrjBMoFRYBaSsbOQjJ2FMHYBI/MqRqHMvLLcxMwcE72MyrzMCr3k/NxNjMB4
        XFb7J3oH46cLwYcYBTgYlXh4N/TYpwqxJpYVV+YeYpTgYFYS4WV2tEkV4k1JrKxKLcqPLyrN
        SS0+xCjNwaIkzmv0rTxFSCA9sSQ1OzW1ILUIJsvEwSnVwFjxvXxb0+d7WwSnCO0Tddv+63HP
        KlujO8b3PqgXrPpbs06YZaOvrVrqbb/+5n9nD21sWSC44brFfMvXtotvPZ1W9/H1zNQzdmzf
        d6bwOtyZ+0leq+66320dESfXZuFJGnbGCQuPb/P6u+7e4h8CjWJ5h78dT4x1/RjLpxb2Oipq
        y4d2ng2ul82UWIozEg21mIuKEwFJU9JxwwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsXC5WfdrFtp4pBqsH+PisWc9WvYLD5v+Mdm
        8enlA0aLFxvaGS2+rv/FbPH0Ux+LxeG5J1ktLu+aw2Zxb81/Vovzu9ayWuxYuo/J4tKBBUwW
        13c9ZLQ43nuAyWLzpqnMFr9/ANXNmWJlcXLWZBYHIY/vrX0sHgs2lXpsXqHlsXjPSyaPTas6
        2Tw2fZrE7vHu3Dl2jxMzfrN47Hxo6THvZKDH+31X2TwWv/jA5LH1l53H501yHu/mv2UL4I/i
        sklJzcksSy3St0vgytj5uo+p4B93xZJZ99kbGFdzdjFyckgImEjcmH2bBcRmEVCVuLXrLpjN
        JqAucePGT2YQWwTIPrVyOXsXIxcHs0ATs8S19ZtZQRLCAu4SLzu2MILYvAJmEk9e3QRrEBLI
        kPjS3MkEEReUODnzCdhQZgEtiRv/XgLFOYBsaYnl/zhAwpwCthIPe3+DlYgKKEsc2HacaQIj
        7ywk3bOQdM9C6F7AyLyKUSQzryw3MTPHVK84O6MyL7NCLzk/dxMjMLqW1f6ZuIPxy2X3Q4wC
        HIxKPLwbeuxThVgTy4orcw8xSnAwK4nwMjvapArxpiRWVqUW5ccXleakFh9ilOZgURLn9QpP
        TRASSE8sSc1OTS1ILYLJMnFwSjUwZj9WLH/JlG787BR7fO7J8JldizYUdk19YrJe6FaczJ6N
        lxkvPvjqbqhQHrIq/8cKwQL/67yr3bo0z4Xp6jSoLMjYU2WxPEKq9meOsPfMu1lbpp56dOn4
        /TCb/U6VxkW6RQvMTmwMV87p+/5y+e/ZT7OveR+I+Mgr1Hdnhdnfs0HlTwpU7BxKlViKMxIN
        tZiLihMB1bFmnqoCAAA=
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 10:55:07AM -0700, Dave Hansen wrote:
> On 10/30/23 00:25, Byungchul Park wrote:
> > I'm suggesting a mechanism to reduce TLB flushes by keeping source and
> > destination of folios participated in the migrations until all TLB
> > flushes required are done, only if those folios are not mapped with
> > write permission PTE entries at all. I worked Based on v6.6-rc5.
> 
> There's a lot of common overhead here, on top of the complexity in general:
> 
>  * A new page flag
>  * A new cpumask_t in task_struct
>  * A new zone list
>  * Extra (temporary) memory consumption
> 
> and the benefits are ... "performance improved a little bit" on one
> workload.  That doesn't seem like a good overall tradeoff to me.
> 
> There will certainly be workloads that, before this patch, would have
> little or no memory pressure and after this patch would need to do reclaim.

'if (gain - cost) > 0 ?'" is a difficult problem. I think the followings
are already big benefit in general:

	1. big reduction of IPIs #
	2. big reduction of TLB flushes #
	3. big reduction of TLB misses #

Of course, I or we need to keep trying to see a better number in
end-to-end performance.

> Also, looking with my arch/x86 hat on, there's really nothing
> arch-specific here.  Please try to keep stuff out of arch/x86 unless
> it's very much arch-specific.

Okay. I will try to keep it out of arch code. I should give up an
optimization that can be achieved by working on arch code tho.

	Byungchul
