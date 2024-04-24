Return-Path: <linux-kernel+bounces-157744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B18EF8B1543
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42501C21D09
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19FD158852;
	Wed, 24 Apr 2024 21:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xy+gnUVI"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A2E156F4E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 21:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713994870; cv=none; b=F1o2wQ71z+gQEOWGhC7g3M/3/SwRBf8Ja6LpbVodIBTZ/0360pF3uNE5PwpzW50RpjHnRZmyzMOa9V0+pbrVplfHsQSiGUchtNvNj869zdZ8MUjLy/Lyg60wB0syp2HvBIXllgOctGIqJTvl7LUAiQFrwLOzBLcI8JiR85CdLoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713994870; c=relaxed/simple;
	bh=CSAxST9l1ML3bK9B48Kc1gJu93/PFzNoh1S6a1nXHI8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IryoVvN6oG4H8TVhxQrARKeFY8LTXC5Ms547iLeQS59kuZbIe6HVYkHrePIfyN/9/ZEZZ4QQkJYDlHD2nQHssALG2TqREt3tKJ31yxkdH8F9HptL6iaLeM2P8aLV0xlqi9oximqAZeBVO/dVI5iB8H7JHD/PaTcVK/asq/FKY4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xy+gnUVI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e8fce77bb2so2528435ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713994867; x=1714599667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZN4X6k1taEixm9wIK5apcc1Zl8K4ael4BkfXJ2q5v0k=;
        b=Xy+gnUVIU94bJtUxLPVkLT9QDtDzY9yMC+6TWlXjEKMNojNcZDckA//lPc231R9Eh5
         dQsg5NWXpVivDB1MhcvdX3Y7MvQl2xtNhS3xkgRYXL+7tGiK7gOEcVSmyAqnKCtLGVhi
         80I2EjezI7+MtAHjTjjnCmbIKjl0BKBO+4omk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713994867; x=1714599667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZN4X6k1taEixm9wIK5apcc1Zl8K4ael4BkfXJ2q5v0k=;
        b=DV4fIPnnlN0aOaLBxOG2Kr6MMeBjPgf26sXh17sZ9rdiwxkM/qrLClJwryJT+EoGSA
         Wd1G3Jp/LhXgoYYDaOdzczGPWpXwvs04XSICp2cxrrRk4+hmrBcsskRiG9oYTkTKKQhj
         Y7nhhRY5EUv/eskeLBWiGF851Oj5DB2DO9D3xe18Px5+cvC2dArl4i3QASKbEZ7sPE8B
         EQVFfrMahs3If4/iANDBe4XrVHByQGI9F5SoNDqxUZiv2vdUHW9u1Bo9Y15Tvr2ScbSa
         XW2FF5N8kHE4dWRIrgfuefnXaKm/lzXJgwgokz+dxKJQ7b7d3/vbOO4cWtmWN5PpQNIz
         8MOA==
X-Forwarded-Encrypted: i=1; AJvYcCW17VpVKVU+C5XlLYCrfYDFA+x5/uFQgVoE8xh7wsZylYC+vWWkVNn0NwKaUsSYpu9/Dwj5mhU2ESzuZuJ0N8e81tu6mEYZqUX1yyet
X-Gm-Message-State: AOJu0Yy0VeqyW52AeRLA0+cxEt6NOwvn1f3Q0skamhqw/J1iTg35njUb
	0DHo/ObxZupR3RE1LxNZ4pZ+dlhHGtw6yBFMZJKZjksuN8w6gCeSU9l6INBjXQ==
X-Google-Smtp-Source: AGHT+IGsKG0KETtSrCcshPv9+RfF012Av+jDYjVSzUmXh3bqJ3o6ya/7ATIavZVy0HYtqqTaTGzC9Q==
X-Received: by 2002:a17:902:6b42:b0:1e2:aa62:2fbf with SMTP id g2-20020a1709026b4200b001e2aa622fbfmr3421800plt.45.1713994866961;
        Wed, 24 Apr 2024 14:41:06 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902d60500b001e421f98ebdsm12397269plp.280.2024.04.24.14.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 14:41:05 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>,
	Matteo Rizzo <matteorizzo@google.com>,
	Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	julien.voisin@dustri.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 0/6] slab: Introduce dedicated bucket allocator
Date: Wed, 24 Apr 2024 14:40:57 -0700
Message-Id: <20240424213019.make.366-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5704; i=keescook@chromium.org;
 h=from:subject:message-id; bh=CSAxST9l1ML3bK9B48Kc1gJu93/PFzNoh1S6a1nXHI8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmKXxuxwETH4SRJIHb8kWj0m1zUTHql5HJhw+fz
 mdszYRAjJiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZil8bgAKCRCJcvTf3G3A
 JvZTD/0emHHf4xvjdKdDiFBuShtObaN1uKCbv7/oH5gtys3bEISPdgj4zMk/cxYH553top2uDPd
 RkE8sWeyyj1YywWB8kMcsG+gipbi/nmPicqIUT+Oflrdz77pmLG8OtcPued74mQbOa4CgpKaBqx
 DBcWmnImRUGzQr/1wOzAdyj86L/C4nsmiyZWdPKRGVvR/hATQaKsDr1zsQe7LrkFtssFI/oUSA4
 Y0oo8fPFxtaZOlA2R0vL25oC32E0CbbaRdGeVHPZXHT9GH1pUJeBp1EOPOsAhAcQ7yk2xL0exr5
 3Fw+qGigeSVEfglcqdrY7V38sCokZvMOtQV3QLd8BCD5sn4AR8/7qdWwN5MnGRPk/SWa9Efch+w
 q/rAdkA3p6xGbNOFFmafGh4kL4tRjk/cSgG583WJFy5z7oBOsFmloPh0P22kLrQROzYRonqzEna
 8sjKMVDrcp8ROy+2y3nS1PHJSKVyXp4M8AS838x1i5ISBH2xbDPg2ohhIHnQ4rTiojcuEAov/Rn
 gUsbW2iNWBvPn6Hz6iyZQbsSua1vsEDNzODC9VQXJ46DqX7VqJuzGjstmX6hP9RHDdUDco9Fu+N
 Z8O9yOHxrdch8FXScDdJvFD/XRCFPExGKymM9b/Kpor8sO1mMgpyanlizX6I08BYM/pyvSGQFSw
 /QIjFVz lv0QVvPA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

Series change history:

 v3:
  - clarify rationale and purpose in commit log
  - rebase to -next (CONFIG_CODE_TAGGING)
  - simplify calling styles and split out bucket plumbing more cleanly
  - consolidate kmem_buckets_*() family introduction patches
 v2: https://lore.kernel.org/lkml/20240305100933.it.923-kees@kernel.org/
 v1: https://lore.kernel.org/lkml/20240304184252.work.496-kees@kernel.org/

For the cover letter, I'm repeating commit log for patch 4 here, which has
additional clarifications and rationale since v2:

    Dedicated caches are available for fixed size allocations via
    kmem_cache_alloc(), but for dynamically sized allocations there is only
    the global kmalloc API's set of buckets available. This means it isn't
    possible to separate specific sets of dynamically sized allocations into
    a separate collection of caches.
    
    This leads to a use-after-free exploitation weakness in the Linux
    kernel since many heap memory spraying/grooming attacks depend on using
    userspace-controllable dynamically sized allocations to collide with
    fixed size allocations that end up in same cache.
    
    While CONFIG_RANDOM_KMALLOC_CACHES provides a probabilistic defense
    against these kinds of "type confusion" attacks, including for fixed
    same-size heap objects, we can create a complementary deterministic
    defense for dynamically sized allocations that are directly user
    controlled. Addressing these cases is limited in scope, so isolation these
    kinds of interfaces will not become an unbounded game of whack-a-mole. For
    example, pass through memdup_user(), making isolation there very
    effective.
    
    In order to isolate user-controllable sized allocations from system
    allocations, introduce kmem_buckets_create(), which behaves like
    kmem_cache_create(). Introduce kmem_buckets_alloc(), which behaves like
    kmem_cache_alloc(). Introduce kmem_buckets_alloc_track_caller() for
    where caller tracking is needed. Introduce kmem_buckets_valloc() for
    cases where vmalloc callback is needed.
    
    Allows for confining allocations to a dedicated set of sized caches
    (which have the same layout as the kmalloc caches).
    
    This can also be used in the future to extend codetag allocation
    annotations to implement per-caller allocation cache isolation[1] even
    for dynamic allocations.
    
    Memory allocation pinning[2] is still needed to plug the Use-After-Free
    cross-allocator weakness, but that is an existing and separate issue
    which is complementary to this improvement. Development continues for
    that feature via the SLAB_VIRTUAL[3] series (which could also provide
    guard pages -- another complementary improvement).
    
    Link: https://lore.kernel.org/lkml/202402211449.401382D2AF@keescook [1]
    Link: https://googleprojectzero.blogspot.com/2021/10/how-simple-linux-kernel-memory.html [2]
    Link: https://lore.kernel.org/lkml/20230915105933.495735-1-matteorizzo@google.com/ [3]

After the core implementation are 2 patches that cover the most heavily
abused "repeat offenders" used in exploits. Repeating those details here:

    The msg subsystem is a common target for exploiting[1][2][3][4][5][6]
    use-after-free type confusion flaws in the kernel for both read and
    write primitives. Avoid having a user-controlled size cache share the
    global kmalloc allocator by using a separate set of kmalloc buckets.
    
    Link: https://blog.hacktivesecurity.com/index.php/2022/06/13/linux-kernel-exploit-development-1day-case-study/ [1]
    Link: https://hardenedvault.net/blog/2022-11-13-msg_msg-recon-mitigation-ved/ [2]
    Link: https://www.willsroot.io/2021/08/corctf-2021-fire-of-salvation-writeup.html [3]
    Link: https://a13xp0p0v.github.io/2021/02/09/CVE-2021-26708.html [4]
    Link: https://google.github.io/security-research/pocs/linux/cve-2021-22555/writeup.html [5]
    Link: https://zplin.me/papers/ELOISE.pdf [6]
    Link: https://syst3mfailure.io/wall-of-perdition/ [7]

    Both memdup_user() and vmemdup_user() handle allocations that are
    regularly used for exploiting use-after-free type confusion flaws in
    the kernel (e.g. prctl() PR_SET_VMA_ANON_NAME[1] and setxattr[2][3][4]
    respectively).
    
    Since both are designed for contents coming from userspace, it allows
    for userspace-controlled allocation sizes. Use a dedicated set of kmalloc
    buckets so these allocations do not share caches with the global kmalloc
    buckets.
    
    Link: https://starlabs.sg/blog/2023/07-prctl-anon_vma_name-an-amusing-heap-spray/ [1]
    Link: https://duasynt.com/blog/linux-kernel-heap-spray [2]
    Link: https://etenal.me/archives/1336 [3]
    Link: https://github.com/a13xp0p0v/kernel-hack-drill/blob/master/drill_exploit_uaf.c [4]

Thanks!

-Kees


Kees Cook (6):
  mm/slab: Introduce kmem_buckets typedef
  mm/slab: Plumb kmem_buckets into __do_kmalloc_node()
  mm/slab: Introduce __kvmalloc_node() that can take kmem_buckets
    argument
  mm/slab: Introduce kmem_buckets_create() and family
  ipc, msg: Use dedicated slab buckets for alloc_msg()
  mm/util: Use dedicated slab buckets for memdup_user()

 include/linux/slab.h | 44 ++++++++++++++++--------
 ipc/msgutil.c        | 13 +++++++-
 lib/fortify_kunit.c  |  2 +-
 lib/rhashtable.c     |  2 +-
 mm/slab.h            |  6 ++--
 mm/slab_common.c     | 79 +++++++++++++++++++++++++++++++++++++++++---
 mm/slub.c            | 14 ++++----
 mm/util.c            | 21 +++++++++---
 8 files changed, 146 insertions(+), 35 deletions(-)

-- 
2.34.1


