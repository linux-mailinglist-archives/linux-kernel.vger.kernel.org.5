Return-Path: <linux-kernel+bounces-40798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3C383E5D7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD5751F246B4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B8F2563C;
	Fri, 26 Jan 2024 22:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IeyC/7Ef"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C49250F9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706309528; cv=none; b=iYpvBU+CDb65ekApCb0DGZHRI+0MJk1pye1uPiEo0jX4H63AfgU7con83PHiXTAJVidKvLFjUzE7r4EFr5lHH4W+okXOf7eCwp7ZmfMnS5//mU0/3O2C+derIJFZWkGXWNIc1swieZFTzt12aBDKuH22T7kK6HyqsADoU2vDOUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706309528; c=relaxed/simple;
	bh=ef4owu+rd6RmxzoFUAeQNbh1aTgQihpj9io+RmhTUhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e7tUwqy7+wA3Vl5GA9Zw2H1vDDCT2uJBBhrVNHKDVQC0WQl4MqNJISpZ4Wy4FE1oeJi88tq7DBD8AGFMR/ICjPEHPlQk+QUFXkpo6V2Gn5nZFRK2Lnp1bDoAL2Spqw1To4SXSpqHPqXz4/LsdW8aHc5+SJKfncrWucy69ZK8MlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IeyC/7Ef; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55c89dbef80so1031a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706309525; x=1706914325; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nv6CuAe+GsEY4s10INbXlJWjCo/P1ReTexRtJp+fto4=;
        b=IeyC/7EfXnckqrv+rdq3+Z+tEkdBFFFgG5xhysxqcyZkThE+LOTyadxowOQxxlUwJG
         zGp0QEDhHL0/NpVlhfjcK1uNpgg4t0RPc+yuBspJmU5tx0dgnbfzc88yUNwu3ZKBV5GZ
         QjiL4J/cclTvlVY8lI2sO73obtEAVe8yOUg3XEdNpA72mB+bs5gIgEPpmSAuvJyutvrr
         HCH1BZzR/2k+zMzXWbTBQO+f++MixFCKmDbQ6hrb8tew2h2Gdn6zYQxTDmfFBKAT0bKt
         O78v7R9NcKJwwwO9Gm5uLpZ/xAqo2UnCUpo+Qq2vMzhHeyOJljUsFft/lm3g5+rhiuq6
         iZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706309525; x=1706914325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nv6CuAe+GsEY4s10INbXlJWjCo/P1ReTexRtJp+fto4=;
        b=Ccf8dCfTqgak8GXbr8sw4FdhyNqZ/3Z8D0CI4QxjS9YNTffAan0hQQ7d4ySsGLfePg
         eb8JpcVHnoSr95v5nbMPDaBwY/TndSl6ZEWK+BR9CjUmDGToDDFCKib6k5PJOmsqJfYt
         Cf1G6yoPm8Ba7CS+9VZNYuYFnNRWnMreqgsgmLPbpX1ed6f7tlFl42eE3/83ObRDD+ZT
         uxuOgA2vnRQ0St2trBhPKx88KV6Gf18fbyDuVylP68eNHP832ez/uML6Msbb49BPcid1
         0pMBnIE8JBc8CNyBH7zMrAucJ9dGOCalJJcDX9cKeSsWO6D+rL4Lr0/JuuxYR3xySLnF
         oymQ==
X-Gm-Message-State: AOJu0Ywvh27AxvXHpEocnMUe3oEPhe86MCSVnndN9oAP99bdTRdRY407
	usSzMJv0np/50GqCP+EQAW4Zsr4NBebQIZY6oOZyD5L8+BaWkY3hLcpAPzjWy4+JwbGV+GXfoQ2
	jSlFNoNZKLV/tQ6Ou1fmFGC/1F6Xr+bbgVkDf
X-Google-Smtp-Source: AGHT+IGaDtH7FpFYdEdiLIZCdiJulfrgpMDcdlLq96DsjIw+rzeyCE7D1PNmdFGY3OHVKPpNWFRD6bNf66BchO9id9w=
X-Received: by 2002:a05:6402:a43:b0:55c:8eda:6e19 with SMTP id
 bt3-20020a0564020a4300b0055c8eda6e19mr254822edb.2.1706309524959; Fri, 26 Jan
 2024 14:52:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1699104759.git.quic_charante@quicinc.com>
 <a8e16f7eb295e1843f8edaa1ae1c68325c54c896.1699104759.git.quic_charante@quicinc.com>
 <ZUy1dNvbvHc6gquo@tiehlicka> <5c7f25f9-f86b-8e15-8603-e212b9911cac@quicinc.com>
 <ZVNQdQKQAMjgOK9y@tiehlicka> <342a8854-eef5-f68a-15e5-275de70e3f01@quicinc.com>
 <CAAa6QmRnfTOCD0uaxVbbiDRWtwzC9y+gZDFOjYF2YWDTrXyMNQ@mail.gmail.com>
 <5adb12eb-8403-5860-28eb-5f6ab12f3c04@quicinc.com> <ZbOQC0mYNsX0voKM@tiehlicka>
In-Reply-To: <ZbOQC0mYNsX0voKM@tiehlicka>
From: "Zach O'Keefe" <zokeefe@google.com>
Date: Fri, 26 Jan 2024 14:51:26 -0800
Message-ID: <CAAa6QmQwSRn=XdHjyjNxX0PrBCKbOovBVCYaDHKAzAzYYFZwug@mail.gmail.com>
Subject: Re: [PATCH V3 3/3] mm: page_alloc: drain pcp lists before oom kill
To: Michal Hocko <mhocko@suse.com>
Cc: Charan Teja Kalla <quic_charante@quicinc.com>, akpm@linux-foundation.org, 
	mgorman@techsingularity.net, david@redhat.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, quic_pkondeti@quicinc.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Axel Rasmussen <axelrasmussen@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"

Hey Michal,

> Do you have any example OOM reports? [..]

Sure, here is one on a 1TiB, 128-physical core machine running a
5.10-based kernel (sorry, it reads pretty awkwardly when wrapped):

---8<---
mytask invoked oom-killer: gfp_mask=0x100cca(GFP_HIGHUSER_MOVABLE),
order=0, oom_score_adj=0
<...>
oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=sdc,mems_allowed=0-1,global_oom,task_memcg=/sdc,task=mytask,pid=835214,uid=0
Out of memory: Killed process 835214 (mytask) total-vm:787716604kB,
anon-rss:787536152kB, file-rss:64kB, shmem-rss:0kB, UID:0
pgtables:1541224kB oom_score_adj:0, hugetlb-usage:0kB
Mem-Info:
active_anon:320 inactive_anon:198083493 isolated_anon:0
 active_file:128283 inactive_file:290086 isolated_file:0
 unevictable:3525 dirty:15 writeback:0
 slab_reclaimable:35505 slab_unreclaimable:272917
 mapped:46414 shmem:822 pagetables:64085088
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:325793 free_pcp:263277 free_cma:0
Node 0 active_anon:1112kB inactive_anon:268172556kB
active_file:270992kB inactive_file:254612kB unevictable:12404kB
isolated(anon):0kB isolated(file):0kB mapped:147240kB dirty:52kB
writeback:0kB shmem:304kB shmem_thp:0kB shmem_pmdmapped:0kB
anon_thp:1310720kB writeback_tmp:0kB kernel_stack:32000kB
pagetables:255483108kB sec_pagetables:0kB all_unreclaimable? yes
Node 1 active_anon:168kB inactive_anon:524161416kB
active_file:242140kB inactive_file:905732kB unevictable:1696kB
isolated(anon):0kB isolated(file):0kB mapped:38416kB dirty:8kB
writeback:0kB shmem:2984kB shmem_thp:0kB shmem_pmdmapped:0kB
anon_thp:267732992kB writeback_tmp:0kB kernel_stack:8520kB
pagetables:857244kB sec_pagetables:0kB all_unreclaimable? yes
Node 0 Crash free:72kB min:108kB low:220kB high:332kB
reserved_highatomic:0KB active_anon:0kB inactive_anon:111940kB
active_file:280kB inactive_file:316kB unevictable:0kB writepending:4kB
present:114284kB managed:114196kB mlocked:0kB bounce:0kB
free_pcp:1528kB local_pcp:24kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA32 free:66592kB min:2580kB low:5220kB high:7860kB
reserved_highatomic:0KB active_anon:8kB inactive_anon:19456kB
active_file:4kB inactive_file:224kB unevictable:0kB writepending:0kB
present:2643512kB managed:2643512kB mlocked:0kB bounce:0kB
free_pcp:8040kB local_pcp:244kB free_cma:0kB
lowmem_reserve[]: 0 0 16029 16029
Node 0 Normal free:513048kB min:513192kB low:1038700kB high:1564208kB
reserved_highatomic:0KB active_anon:1104kB inactive_anon:268040520kB
active_file:270708kB inactive_file:254072kB unevictable:12404kB
writepending:48kB present:533969920kB managed:525510968kB
mlocked:12344kB bounce:0kB free_pcp:790040kB local_pcp:7060kB
free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 1 Normal free:723460kB min:755656kB low:1284080kB high:1812504kB
reserved_highatomic:0KB active_anon:168kB inactive_anon:524161416kB
active_file:242140kB inactive_file:905732kB unevictable:1696kB
writepending:8kB present:536866816kB managed:528427664kB
mlocked:1588kB bounce:0kB free_pcp:253500kB local_pcp:12kB
free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 Crash: 0*4kB 0*8kB 1*16kB (M) 0*32kB 0*64kB 0*128kB 0*256kB
0*512kB 0*1024kB 0*2048kB 0*4096kB = 16kB
Node 0 DMA32: 80*4kB (UME) 74*8kB (UE) 23*16kB (UME) 21*32kB (UME)
40*64kB (UE) 35*128kB (UME) 3*256kB (UE) 9*512kB (UME) 13*1024kB (UM)
19*2048kB (UME) 0*4096kB = 66592kB
Node 0 Normal: 1999*4kB (UE) 259*8kB (UM) 465*16kB (UM) 114*32kB (UE)
54*64kB (UME) 14*128kB (U) 74*256kB (UME) 128*512kB (UE) 96*1024kB (U)
56*2048kB (U) 46*4096kB (U) = 512292kB
Node 1 Normal: 2280*4kB (UM) 12667*8kB (UM) 8859*16kB (UME) 5221*32kB
(UME) 1631*64kB (UME) 899*128kB (UM) 330*256kB (UME) 0*512kB 0*1024kB
0*2048kB 0*4096kB = 723208kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0
hugepages_size=1048576kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0
hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0
hugepages_size=1048576kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0
hugepages_size=2048kB
420675 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 268435456kB
Total swap = 268435456kB
---8<---

Node 0/1 Normal free memory is below respective min watermarks, with
790040kB+253500kB ~= 1GiB of memory on pcp lists.

With this patch, the GFP_HIGHUSER_MOVABLE + unrestricted mems_allowed
allocation would have allowed us to access all that memory, very
likely avoiding the oom.

> [..] There were recent changes to scale
> the pcp pages and it would be good to know whether they work reasonably
> well even under memory pressure.

I'm not familiar with these changes, but a quick check of recent
activity points to v6.7 commit fa8c4f9a665b ("mm: fix draining remote
pageset") ; is this what you are referring to?

Thanks, and have a great day,
Zach



>
> I am not objecting to the patch discussed here but it would be really
> good to understand the underlying problem and the scale of it.
>
> Thanks!
> --
> Michal Hocko
> SUSE Labs

