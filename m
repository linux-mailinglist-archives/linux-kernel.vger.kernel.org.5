Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882897A09ED
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241299AbjINP70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240667AbjINP7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:59:22 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CDC1BE5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 08:59:18 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c4084803f1so152185ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 08:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694707158; x=1695311958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfmpMYsBKyFcd+9UHQ0S+ea09v02Pbj16LK2Jiwz1tI=;
        b=1YA9QHr0j9tiQMxlES4aht57u0M/dDsKpr7hxHQwW2dFGaWJMOK1zSOrQ3BnSBlg1o
         erxAU2pyhdRihLnm4LCxR1CfWSI9u50+oEc3MYjo/e6sWlRyYsA4pVgGfkqVLVs19oha
         AihqCXEYJn/FIQo2bE6lEDGYC9aHM0aJThvKk7UEIbdevGrRupnL+K3TcmrolQY5ot78
         e2+zWCJom6mOwf49P77VVJPIwhJifpO1WvCxfzccteo0fyOuCAft827zxUsC9OBTUR+o
         7WKGe0XflLgpjnAV+AsI6+k/io94a2JLCRZA6fFt9q4+YBQheUA4faiC6avN3wm6d+E/
         AgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694707158; x=1695311958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfmpMYsBKyFcd+9UHQ0S+ea09v02Pbj16LK2Jiwz1tI=;
        b=AWALGjxqSLT/amI/LobV8baiqzMM704vWhOOjfDDcxZAgohn0XO/q7cYjbg16Pw5Tk
         h/som0v4oB6kzISohvKVoL1Jglna55eARVNvMf3Tb/NqsjxmxsLUY7l5Ynsb/oKFC4Ng
         /thHzuoG+n1WBrCOWtTLatS16J0bp0lcaMueO6GigCxZw1wyH1DyGrNLH05GnTWQsQGv
         EbQtKHt4iekjRGvxhcrJDK7P75BCYM03ujxhQq3dgt9t5jZRJzy4vXXCR8CgtTA9t7j3
         62V+DfjdvemTuRBPhLGgvyhBnEpbcKE/E78QyXEflI8+rRE1X8agXfX8N1HL9ct1cXxH
         PGBg==
X-Gm-Message-State: AOJu0Yy9d/jQ9PlZEmNOw99rX5yYMnlxwoFNquXwJdiX5TWI1f5fYsUr
        SUXXT4hMo9oRSafhJSu2WqK+Xws5bRs2FAU+IPJjxgcDTC3Wh6J+8Q0=
X-Google-Smtp-Source: AGHT+IE8liTYNts6LYhs1mQ+j8PNdKTP6jzfQ6qXeikGkdhI1DHiwJ2EWuxCkJDZaKyMlHdavIpVr3571Zh3gEtVmPY=
X-Received: by 2002:a17:902:db0e:b0:1b8:89fd:61ea with SMTP id
 m14-20020a170902db0e00b001b889fd61eamr446273plx.1.1694707157596; Thu, 14 Sep
 2023 08:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230914152139.100822-1-hannes@cmpxchg.org>
In-Reply-To: <20230914152139.100822-1-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 14 Sep 2023 08:59:05 -0700
Message-ID: <CALvZod7dzQh9O0CE9Xfu0n6m0dNjH33QQt9sCiQ8scDR1G4CKw@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: fix GFP_NOFS recursion in memory.high enforcement
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Breno Leitao <leitao@debian.org>,
        Josef Bacik <josef@toxicpanda.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 8:21=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> Breno and Josef report a deadlock scenario from cgroup reclaim
> re-entering the filesystem:
>
> [  361.546690] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  361.559210] WARNING: possible circular locking dependency detected
> [  361.571703] 6.5.0-0_fbk700_debug_rc0_kbuilder_13159_gbf787a128001 #1 T=
ainted: G S          E
> [  361.589704] ------------------------------------------------------
> [  361.602277] find/9315 is trying to acquire lock:
> [  361.611625] ffff88837ba140c0 (&delayed_node->mutex){+.+.}-{4:4}, at: _=
_btrfs_release_delayed_node+0x68/0x4f0
> [  361.631437]
> [  361.631437] but task is already holding lock:
> [  361.643243] ffff8881765b8678 (btrfs-tree-01){++++}-{4:4}, at: btrfs_tr=
ee_read_lock+0x1e/0x40
>
> [  362.904457]  mutex_lock_nested+0x1c/0x30
> [  362.912414]  __btrfs_release_delayed_node+0x68/0x4f0
> [  362.922460]  btrfs_evict_inode+0x301/0x770
> [  362.982726]  evict+0x17c/0x380
> [  362.988944]  prune_icache_sb+0x100/0x1d0
> [  363.005559]  super_cache_scan+0x1f8/0x260
> [  363.013695]  do_shrink_slab+0x2a2/0x540
> [  363.021489]  shrink_slab_memcg+0x237/0x3d0
> [  363.050606]  shrink_slab+0xa7/0x240
> [  363.083382]  shrink_node_memcgs+0x262/0x3b0
> [  363.091870]  shrink_node+0x1a4/0x720
> [  363.099150]  shrink_zones+0x1f6/0x5d0
> [  363.148798]  do_try_to_free_pages+0x19b/0x5e0
> [  363.157633]  try_to_free_mem_cgroup_pages+0x266/0x370
> [  363.190575]  reclaim_high+0x16f/0x1f0
> [  363.208409]  mem_cgroup_handle_over_high+0x10b/0x270
> [  363.246678]  try_charge_memcg+0xaf2/0xc70
> [  363.304151]  charge_memcg+0xf0/0x350
> [  363.320070]  __mem_cgroup_charge+0x28/0x40
> [  363.328371]  __filemap_add_folio+0x870/0xd50
> [  363.371303]  filemap_add_folio+0xdd/0x310
> [  363.399696]  __filemap_get_folio+0x2fc/0x7d0
> [  363.419086]  pagecache_get_page+0xe/0x30
> [  363.427048]  alloc_extent_buffer+0x1cd/0x6a0
> [  363.435704]  read_tree_block+0x43/0xc0
> [  363.443316]  read_block_for_search+0x361/0x510
> [  363.466690]  btrfs_search_slot+0xc8c/0x1520
>
> This is caused by the mem_cgroup_handle_over_high() not respecting the
> gfp_mask of the allocation context. We used to only call this function
> on resume to userspace, where no locks were held. But c9afe31ec443
> ("memcg: synchronously enforce memory.high for large overcharges")
> added a call from the allocation context without considering the gfp.
>
> Reported-by: Breno Leitao <leitao@debian.org>
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Fixes: c9afe31ec443 ("memcg: synchronously enforce memory.high for large =
overcharges")
> Cc: stable@vger.kernel.org # 5.17+
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Shakeel Butt <shakeelb@google.com>
