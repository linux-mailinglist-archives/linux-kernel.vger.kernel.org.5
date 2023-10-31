Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F4F7DC491
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 03:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbjJaChj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 22:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbjJaCh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 22:37:29 -0400
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F7A6126
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 19:37:13 -0700 (PDT)
X-AuditID: a67dfc5b-d6dff70000001748-98-654068553d78
Date:   Tue, 31 Oct 2023 11:37:04 +0900
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
Message-ID: <20231031023704.GA39338@system.software.com>
References: <20231030072540.38631-1-byungchul@sk.com>
 <08c82a91-87d1-42c7-93c4-4028f3725340@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08c82a91-87d1-42c7-93c4-4028f3725340@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsXC9ZZnoW5ohkOqwf5GFYs569ewWXze8I/N
        4tPLB4wWLza0M1p8Xf+L2eLppz4Wi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfVdDxkt
        jvceYLLYvGkqs8XvH0B1c6ZYWZycNZnFQdDje2sfi8eCTaUem1doeSze85LJY9OqTjaPTZ8m
        sXu8O3eO3ePEjN8sHjsfWnrMOxno8X7fVTaPrb/sPD5vkvN4N/8tWwBfFJdNSmpOZllqkb5d
        AlfGinWbWQpWS1Xse7iatYGxW6iLkZNDQsBEYuKJJyww9pEHE5hAbBYBVYn+jr9gNpuAusSN
        Gz+ZQWwRIPvUyuXsXYxcHMwCTcwS19ZvZgVJCAu4S7zs2MIIYvMKWEhc+bQMzBYSyJD40tzJ
        BBEXlDg5E2IZs4CWxI1/L4HiHEC2tMTyfxwgYU4BW4mHvb/BSkQFlCUObDvOBLJLQmAdu8SD
        Ny/ZIA6VlDi44gbLBEaBWUjGzkIydhbC2AWMzKsYhTLzynITM3NM9DIq8zIr9JLzczcxAuNx
        We2f6B2Mny4EH2IU4GBU4uHd0GOfKsSaWFZcmXuIUYKDWUmE97CpQ6oQb0piZVVqUX58UWlO
        avEhRmkOFiVxXqNv5SlCAumJJanZqakFqUUwWSYOTqkGRvmLy/f/rLd7uPBE0bLJS1cHNumy
        JqnpZnbO99dmMIg5MCtRZoVph1Pu11Zrs4QvKpdbzNgM2tc8qWg5/Mxvt+HsSNkp7q+fMb72
        ncb+8kubQ4nK7aJXizeIbPRSWMhgE51Y+C7u/wKB1Vu2i5eGlFx6LFvO82OZ/IYqDuaoal7d
        +L+Hfj2vVGIpzkg01GIuKk4EAFzyABvDAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsXC5WfdrBua4ZBq0D5LwGLO+jVsFp83/GOz
        +PTyAaPFiw3tjBZf1/9itnj6qY/F4vDck6wWl3fNYbO4t+Y/q8X5XWtZLXYs3cdkcenAAiaL
        67seMloc7z3AZLF501Rmi98/gOrmTLGyODlrMouDkMf31j4WjwWbSj02r9DyWLznJZPHplWd
        bB6bPk1i93h37hy7x4kZv1k8dj609Jh3MtDj/b6rbB6LX3xg8tj6y87j8yY5j3fz37IF8Edx
        2aSk5mSWpRbp2yVwZaxYt5mlYLVUxb6Hq1kbGLuFuhg5OSQETCSOPJjABGKzCKhK9Hf8BbPZ
        BNQlbtz4yQxiiwDZp1YuZ+9i5OJgFmhilri2fjMrSEJYwF3iZccWRhCbV8BC4sqnZWC2kECG
        xJfmTiaIuKDEyZlPWEBsZgEtiRv/XgLFOYBsaYnl/zhAwpwCthIPe3+DlYgKKEsc2HacaQIj
        7ywk3bOQdM9C6F7AyLyKUSQzryw3MTPHVK84O6MyL7NCLzk/dxMjMLqW1f6ZuIPxy2X3Q4wC
        HIxKPLwVNg6pQqyJZcWVuYcYJTiYlUR4D5sChXhTEiurUovy44tKc1KLDzFKc7AoifN6hacm
        CAmkJ5akZqemFqQWwWSZODilGhhtlO48vWctqSvo2+Dz/ps/270ni+w2Mq/wWciqEHKw9fvp
        GYrXQjbdn7uIeeXd8p7Zqg/XPzUsqEkNq+b4fqFxEteeG7P3v56yhzuixrHkxvKWo+oPbhyu
        envR/4M+Q/O87T6WD/ZOuP5GiM/7TiKnfeLGnLqL9W2bDOLEP2y8+jmneeqZOY5blFiKMxIN
        tZiLihMBaA/TCaoCAAA=
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

I tested it under limited conditions to get stable results e.g. not to
use hyper-thread, dedicate cpu times to the test and so on. However, I'm
conviced that this patch set is more worth developing than you think it
is. Lemme share the results I've just got after changing # of CPUs
participated in the test, 16 -> 80, in the system with 80 CPUs. This is
just for your information - not that stable tho.

	Byungchul

---

Architecture - x86_64                                               
QEMU - kvm enabled, host cpu                                        
Numa - 2 nodes (80 CPUs 1GB, no CPUs 8GB)                           
Linux Kernel - v6.6-rc5, numa balancing tiering on, demotion enabled
Benchmark - XSBench -p 50000000 (-p option makes the runtime longer)

mainline kernel
===============

   The 1st try)
   =====================================
   Threads:     64                      
   Runtime:     233.118 seconds         
   =====================================
   numa_pages_migrated 758334           
   pgmigrate_success 1724964            
   nr_tlb_remote_flush 305706           
   nr_tlb_remote_flush_received 18598543
   nr_tlb_local_flush_all 19092         
   nr_tlb_local_flush_one 4518717       
   
   The 2nd try)
   =====================================
   Threads:     64                      
   Runtime:     221.725 seconds         
   =====================================
   numa_pages_migrated 633209           
   pgmigrate_success 2156509            
   nr_tlb_remote_flush 261977           
   nr_tlb_remote_flush_received 14289256
   nr_tlb_local_flush_all 11738         
   nr_tlb_local_flush_one 4520317       
   
mainline kernel + migrc
=======================

   The 1st try)
   =====================================
   Threads:     64                     
   Runtime:     212.522 seconds        
   ====================================
   numa_pages_migrated 901264          
   pgmigrate_success 1990814           
   nr_tlb_remote_flush 151280          
   nr_tlb_remote_flush_received 9031376
   nr_tlb_local_flush_all 21208        
   nr_tlb_local_flush_one 4519595      
   
   The 2nd try)
   =====================================
   Threads:     64                     
   Runtime:     204.410 seconds        
   ====================================
   numa_pages_migrated 929260          
   pgmigrate_success 2729868           
   nr_tlb_remote_flush 166722          
   nr_tlb_remote_flush_received 8238273
   nr_tlb_local_flush_all 13717        
   nr_tlb_local_flush_one 4519582      
