Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5747628B9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 04:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjGZC1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 22:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjGZC1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 22:27:30 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232D22688
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 19:27:29 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-7680e3910dfso640215485a.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 19:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690338448; x=1690943248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Viglh2d5OeFZB4xvJ6G2it4K8JrKHO/8Dv7RWTjX6kM=;
        b=qiuBPF2hMgALZZur5FAR+HdKzYGyMy5aZ4P02N3w7FWd1Bq1UCB24KYv3PIzmkcwgn
         5jL+7wud0KqGkqddn84+oqqhrKYTN1xB2JXK1F6UxnuCdlSY5ZOT1qOIqulX1RsjL/Z8
         yj36fZTmlZ3DLWqG8W+JgUSduItc0u9Q60U1ymm3J2MXaYg2kilpRR61x6fTwGuBaDi7
         LzILlbb/HJK1siWIEbmUXa68+IQjPCzlYUI0vsPQPXSj4cM9bPulYjGXXSmfd+fT0Wkr
         lcr3/ssxb2Lgj5vA5tRzhnAQmjQM9GKuiVBM0zZTbyi41QuJkedPdVJi3S6GxN4qVIXJ
         1GCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690338448; x=1690943248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Viglh2d5OeFZB4xvJ6G2it4K8JrKHO/8Dv7RWTjX6kM=;
        b=lyXeUj7CKCt0cfmEIe7e4jGnSWkQW8htDA6WQdl/kV+pbFaI3a279aXuTMuAlv1f2F
         iDdz1xJxD92WZMU7wdSOHmupV6wWAfbvHJMzBN+pTRqTSFSlGWNTHkzR4nNfZ2d+H66e
         Qa0+6UuKP1jKQ2pUlkIZ79Z8s4Gexk6he1/vvuB6RCnBsezIj7Yx6w8IrnbogzLzqGcX
         dC3f6z5VCbBzeaMNKZhACBynzNnL6Tv+jJTQJVeRdqHn/7BiKvYsp9fuWYXwEq7cnmBt
         mXghlOkmgBv5MmvRm6Em31dcblre1pMW5AHl4nvX6Que3hra22QQHiyuHkAchoBN+HKa
         r8Cg==
X-Gm-Message-State: ABy/qLYazAUtQlp87iMYztdfV2eZ1jCD+3ahlumLVmgeligtOaupPQuk
        T1HyT7r3ZK2JJ+IX2rDx4lk6BA==
X-Google-Smtp-Source: APBJJlHoou/JhXl86qfNBbCvOwucbpA2OuUZCVJ3udRUMF0veeQza39o7kfYXYRLWZCd1fWcueXZRA==
X-Received: by 2002:a05:620a:44c4:b0:767:dfc8:a944 with SMTP id y4-20020a05620a44c400b00767dfc8a944mr997383qkp.41.1690338448296;
        Tue, 25 Jul 2023 19:27:28 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:f680:ab7f:7b75:8135:310])
        by smtp.gmail.com with ESMTPSA id d18-20020a17090ac25200b00263dee538b1sm219346pjx.25.2023.07.25.19.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 19:27:27 -0700 (PDT)
Date:   Tue, 25 Jul 2023 19:27:25 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     James Morse <james.morse@arm.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Peter Newman <peternewman@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "Pitre, Nicolas" <npitre@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "aricciardi@baylibre.com" <aricciardi@baylibre.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [RFC PATCH 0/2] Resctrl - rewrite (WIP)
Message-ID: <ZMCEjZgyi5oI+KWh@x1>
References: <20230620033702.33344-1-tony.luck@intel.com>
 <ZJqhDYLG+/Kr44sp@x1>
 <SJ1PR11MB60832BA425B43CA19C778100FC27A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZJ4clUlN2OujgHlC@agluck-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJ4clUlN2OujgHlC@agluck-desk3>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 05:06:45PM -0700, Tony Luck wrote:
> On Tue, Jun 27, 2023 at 04:33:52PM +0000, Luck, Tony wrote:
> > I've made some significant changes since I posted those patches. I pushed
> > the latest version to:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git    resctrl2_v64
> 
> I just pushed one big commit with all the bits I've updated so far
> this week. Fixes some serious issues as well as general cleanup.
> 
> HEAD is now:
> 
> afb7cdd4d640 resctrl2: Many cleanups, fixes, and new functionality
> 
> If you've started writing your own architecture specific modules there
> are some small interface changes. Most should be found by the compiler
> barfing, but the new ".reset()" resource function called during unmount
> of /sys/fs/resctrl might be less obvious.
> 
> -Tony

I have access to a Xeon Silver 4310 machine which reports to have
cat_l3, cqm_mbm_local, cqm_mbm_total and mba.

I would like to test resctrl2 on it so I can better understand how it
works. I think that will help me understand how to adapt the RISC-V
CBQRI resctrl proof-of-concept to use resctrl2.

Would you be able to provide an example of how you loaded the necessary
resctrl2 kernel modules?

Also, is resctrl2_v65rc1 the latest to branch to test?

Thank you,
Drew
