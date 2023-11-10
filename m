Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295957E766D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 02:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345533AbjKJBJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 20:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345556AbjKJBJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 20:09:00 -0500
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6978CBC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 17:08:58 -0800 (PST)
X-AuditID: a67dfc5b-d85ff70000001748-66-654d82a977b2
Date:   Fri, 10 Nov 2023 10:08:52 +0900
From:   Byungchul Park <byungchul@sk.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel_team@skhynix.com, akpm@linux-foundation.org,
        ying.huang@intel.com, namit@vmware.com, xhao@linux.alibaba.com,
        mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
        david@redhat.com, peterz@infradead.org, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Subject: Re: [v4 0/3] Reduce TLB flushes under some specific conditions
Message-ID: <20231110010852.GB72073@system.software.com>
References: <20231109045908.54996-1-byungchul@sk.com>
 <64cb078b-d2e7-417f-8125-b38d423163ce@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64cb078b-d2e7-417f-8125-b38d423163ce@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsXC9ZZnke7KJt9Ug0MXFSzmrF/DZvF5wz82
        i08vHzBavNjQzmjxdf0vZounn/pYLC7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFtd3PWS0
        ON57gMli86apzBa/fwDVzZliZXFy1mQWB0GP7619LB4LNpV6bF6h5bF4z0smj02rOtk8Nn2a
        xO7x7tw5do8TM36zeOx8aOkx72Sgx/t9V9k8tv6y8/i8Sc7j3fy3bAF8UVw2Kak5mWWpRfp2
        CVwZyz7sZivo4Ki49PwJcwPjKrYuRk4OCQETiZmNp1lh7EOzvrCA2CwCqhLrXyxgArHZBNQl
        btz4yQxiiwDZp1YuZ+9i5OJgFmhilri2fjNYs7CAu8SuU3fAingFLCTObZrMCGILCWRIHH89
        hx0iLihxcuYTsAXMAloSN/69BFrAAWRLSyz/xwES5hSwldjf8AzsNlEBZYkD244zgeySENjE
        LrH4108WiEMlJQ6uuMEygVFgFpKxs5CMnYUwdgEj8ypGocy8stzEzBwTvYzKvMwKveT83E2M
        wHhcVvsnegfjpwvBhxgFOBiVeHgvXPdJFWJNLCuuzD3EKMHBrCTCe8EEKMSbklhZlVqUH19U
        mpNafIhRmoNFSZzX6Ft5ipBAemJJanZqakFqEUyWiYNTqoGxqPrTD0XpH802wbm7jVefnB3c
        vsJjgmDbvqk7Lzw9mzN3c2Wo4Pz/71gkcr1MUkV+X3BZ+DDv2+uqCd9ePMuv2T+ftY5P4e3L
        ojsL8/zFJzDpF2p4XT0fHnvpz8UX+zcErZ2e0/LsraRGjWqGBs8c9pvyN21+Gto53Jv/puni
        ppOGVw9bfZDsVmIpzkg01GIuKk4EALWTFe3DAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsXC5WfdrLuyyTfVYOccAYs569ewWXze8I/N
        4tPLB4wWLza0M1p8Xf+L2eLppz4Wi8NzT7JaXN41h83i3pr/rBbnd61ltdixdB+TxaUDC5gs
        ru96yGhxvPcAk8XmTVOZLX7/AKqbM8XK4uSsySwOQh7fW/tYPBZsKvXYvELLY/Gel0wem1Z1
        snls+jSJ3ePduXPsHidm/Gbx2PnQ0mPeyUCP9/uusnksfvGByWPrLzuPz5vkPN7Nf8sWwB/F
        ZZOSmpNZllqkb5fAlbHsw262gg6OikvPnzA3MK5i62Lk5JAQMJE4NOsLC4jNIqAqsf7FAiYQ
        m01AXeLGjZ/MILYIkH1q5XL2LkYuDmaBJmaJa+s3s4IkhAXcJXadugNWxCtgIXFu02RGEFtI
        IEPi+Os57BBxQYmTM5+ALWAW0JK48e8l0AIOIFtaYvk/DpAwp4CtxP6GZ2D3iAooSxzYdpxp
        AiPvLCTds5B0z0LoXsDIvIpRJDOvLDcxM8dUrzg7ozIvs0IvOT93EyMwupbV/pm4g/HLZfdD
        jAIcjEo8vBeu+6QKsSaWFVfmHmKU4GBWEuG9YAIU4k1JrKxKLcqPLyrNSS0+xCjNwaIkzusV
        npogJJCeWJKanZpakFoEk2Xi4JRqYLzgaTtJ99Yq28M+v9ZX9S917HCpYU+7MLsv/LtuS9dm
        p4LvV1/WTZ1unpWYtFF3zc8XcQyTymK2CDle/3z/bJev6ImDzet+OR/+X2f/YEXN8bBntTbb
        aioZolbo+yu+W/xdp/1pSPLpKw0B5+41rtP28lX+cDt798te1uUHfieyZqZ8eF4yM0KJpTgj
        0VCLuag4EQBQQNp5qgIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 06:26:08AM -0800, Dave Hansen wrote:
> On 11/8/23 20:59, Byungchul Park wrote:
> > Can you believe it? I saw the number of TLB full flush reduced about
> > 80% and iTLB miss reduced about 50%, and the time wise performance
> > always shows at least 1% stable improvement with the workload I tested
> > with, XSBench. However, I believe that it would help more with other
> > ones or any real ones. It'd be appreciated to let me know if I'm missing
> > something.
> 
> I see that you've moved a substantial amount of code out of arch/x86.
> That's great.
> 
> But there doesn't appear to be any improvement in the justification or
> performance data.  The page flag is also here, which is horribly frowned
> upon.  It's an absolute no-go with this level of justification.
> 
> I'd really suggest not sending any more of these out until those issues
> are rectified.  I know I definitely won't be reviewing them in this state.

Make sense. Lemme think it more and improve it.

	Byungchul
