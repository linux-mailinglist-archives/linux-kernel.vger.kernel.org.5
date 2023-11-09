Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EADC7E6337
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 06:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjKIFfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 00:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKIFfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 00:35:53 -0500
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1F462696
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 21:35:50 -0800 (PST)
X-AuditID: a67dfc5b-d85ff70000001748-d2-654c6fb5fb50
Date:   Thu, 9 Nov 2023 14:35:44 +0900
From:   Byungchul Park <byungchul@sk.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "kernel_team@skhynix.com" <kernel_team@skhynix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "xhao@linux.alibaba.com" <xhao@linux.alibaba.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "hughd@google.com" <hughd@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "david@redhat.com" <david@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [v3 2/3] mm: Defer TLB flush by keeping both src and dst folios
 at migration
Message-ID: <20231109053544.GA75729@system.software.com>
References: <20231030072540.38631-1-byungchul@sk.com>
 <20231030072540.38631-3-byungchul@sk.com>
 <63C530D3-3A1D-4BE9-8AA7-EFF5B895BE80@vmware.com>
 <20231030125129.GD81877@system.software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030125129.GD81877@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsXC9ZZnke7WfJ9Ug7fHrS3mrF/DZvF5wz82
        ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeL6roeMFsd7DzBZ
        bN40ldni9w+gujlTrCxOzprM4iDg8b21j8VjwaZSj80rtDwW73nJ5LFpVSebx6ZPk9g93p07
        x+5xYsZvFo+dDy095p0M9Hi/7yqbx9Zfdh6fN8l5vJv/li2AL4rLJiU1J7MstUjfLoEro6vf
        p2AqS8X6k51sDYxLmbsYOTkkBEwkPnQeZYWxZ/Y+YQKxWQRUJE6fW8sGYrMJqEvcuPETrF5E
        QFHi0P57jCA2s8A7VonvnzRBbGGBaIlPe1+xg9i8AhYSj1u6gWwuDiGBI4wSW+/sYoFICEqc
        nPmEBaJZS+LGv5dAyziAbGmJ5f84QMKcApYS31ccBpsvKqAscWDbcSaQORICq9glNrXcYoM4
        VFLi4IobLBMYBWYhGTsLydhZCGMXMDKvYhTKzCvLTczMMdHLqMzLrNBLzs/dxAiMwWW1f6J3
        MH66EHyIUYCDUYmH98Zf71Qh1sSy4srcQ4wSHMxKIrwXTHxShXhTEiurUovy44tKc1KLDzFK
        c7AoifMafStPERJITyxJzU5NLUgtgskycXBKNTA2vNkyu+WLwlHFQotWrTsB0zzOGx+rjfrm
        1VMdGRnuN7l8tX34X6VZzxqd+1akXjzYdOrmDZZLkik5e/u3+8ucOeFw5tD1l9IiUz6wHHoj
        HtDmkPJE/uD7tNNfmrbuXby/IHuD6JGt/+UWt3JLHnm4YdKPDZZnT2Vf2qWwrr1UyDL/Tvia
        KTt/K7EUZyQaajEXFScCAOOTmUa9AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsXC5WfdrLs13yfV4M9/BYs569ewWXze8I/N
        4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfVdDxkt
        jvceYLLYvGkqs8XvH0B1c6ZYWZycNZnFQdDje2sfi8eCTaUem1doeSze85LJY9OqTjaPTZ8m
        sXu8O3eO3ePEjN8sHjsfWnrMOxno8X7fVTaPxS8+MHls/WXn8XmTnMe7+W/ZAvijuGxSUnMy
        y1KL9O0SuDK6+n0KprJUrD/ZydbAuJS5i5GTQ0LARGJm7xMmEJtFQEXi9Lm1bCA2m4C6xI0b
        P8FqRAQUJQ7tv8cIYjMLvGOV+P5JE8QWFoiW+LT3FTuIzStgIfG4pRvI5uIQEjjCKLH1zi4W
        iISgxMmZT1ggmrUkbvx7CbSMA8iWllj+jwMkzClgKfF9xWGw+aICyhIHth1nmsDIOwtJ9ywk
        3bMQuhcwMq9iFMnMK8tNzMwx1SvOzqjMy6zQS87P3cQIjKhltX8m7mD8ctn9EKMAB6MSD2/C
        FO9UIdbEsuLK3EOMEhzMSiK8F0x8UoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzeoWnJggJpCeW
        pGanphakFsFkmTg4pRoYH0zefKA8vfoiO+fG749WLU5jN/f7IjxrReS1kBjhxaLq7qUc7i63
        1zfPnz/zqetU55ktm97ray3Z/W+rk1f71C877mneTf59XaCdg+nKwoDnn+S9Yt5OXvF7xZ01
        s+aX1nUwXrwnKlL3sHFDOuO/+wYLZ2ZPnb9/wSoD5+1lB0/wrxByu6zK3KvEUpyRaKjFXFSc
        CAD43uR+pAIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 09:51:30PM +0900, Byungchul Park wrote:
> On Mon, Oct 30, 2023 at 08:50:20AM +0000, Nadav Amit wrote:
> > I do not follow the ordering that ensures a migrated page would not
> > become writable before the migration is over. Perhaps a comment on what
> > guarantees the order would help.

IIUC, it'd be safe because unmap is performed first at the beginning of
each migration so as to be safe with page fault handlers. So I don't
think it should be a concern. Or am I missing something?

	Byungchul
