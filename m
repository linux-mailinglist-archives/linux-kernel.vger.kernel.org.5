Return-Path: <linux-kernel+bounces-91129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CEC8709DC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6CD71F232D1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7444C79929;
	Mon,  4 Mar 2024 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xli4yDW+"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC48078B46
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709578179; cv=none; b=tKyn0yPFAZJCLSpqCxSzRLl5imiVwAhoC8VpnBI2fMJvXqfNPLrnZOhHyRUziuqWAUmBirgy4LhetlUG7G6A522CbNyI3L878mgnyV4J9jycWvIz04N95I0IddqTBOvRGSbpc/XrqF/kPR7CxNxUZK80NValsjKmCvXWAne/uRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709578179; c=relaxed/simple;
	bh=Z625OVS2xp7R5VmVOq8oa1wppYlZ30y7U3WLqYCRayc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Etdu7Yb2TDQTfPiVAfBe8N4rkIiqRlpMDWLAUHM7ZjnlTARXdQMhgvSxVpt6g78qwgvPaynre7nR0HK0gZOwx2wKTUWbrG3bDoQpjYI7pYn456NgOBdh+q9rCAPWXFA9i8d5qGsaO0QlekmIUeSAQmV7mRtRqn0RZienjlMY5wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xli4yDW+; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6de3141f041so3134031b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 10:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709578177; x=1710182977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wdLvSkRRcYIrR92tCDZgEdSw6ID8B6Ukmhsojy2h3c4=;
        b=Xli4yDW+1jum+RVNpTbdFQgKWZ5W4jIpNCRxQYd/KTggAoySSZQheFBmZqxiU1smww
         8cEGwq2OyfgZ6duTA7piYrGRhqJgEJWlBBOL1T/UMarwnv/07zbYBarkZ4hQU/C3SzNy
         YeDLVEbBSKmDw1Ra8jBUgkfwE5stk1VB8HNtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709578177; x=1710182977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wdLvSkRRcYIrR92tCDZgEdSw6ID8B6Ukmhsojy2h3c4=;
        b=EkcTxpfCwAPQkEEZjCgy8r3/6SmkLVv5687Dpg4/sCdlRMtFtitlQep9mupcc2Q7Oz
         YK18nsBRs49mrDFOTedbCCLLEaqNG9anQciVHPmwZhRPIhFBqVPQc8hA04kn7TWNnIcP
         T+NoFU1voHcV1wEoawul0oUXw6rfTzH5olDfNyug+M+hF9wvG9u2ErJA37Qf5TGlI/uY
         4loVOYTqaDjz4zHWKx6CqnOj8IEWNMNUhCNXNY3+FyREEKB7rChkqs1RBNcWfZfWlPIK
         3+C7uXjRBftmm65GimnxhmQU/32dUFN0twEhdzbaFt1Bb/sizdHzlzxU7a1Gk4M+EMra
         /wCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuT9r1YcopovkCsbBE7OGfahzSwvXmBDwtoxiAkvDYcadflaJJs5NSGsbCCGlHM55bkZR8VV3AbSsH8oXJXIMaRSOsHPypGpcDt+5I
X-Gm-Message-State: AOJu0YzZ56Tb2lfHkq2dfw6S/SOtjyuEAoHr3vhA39nf9BY3DedykU8A
	Yx5JAlm0fdUMgADCUGva1VN3frDKdztAi79sPGpc/HfrOnd/ZVyK6T7cyHH9ng==
X-Google-Smtp-Source: AGHT+IHtNnKRvWzISz04plZ/Sn4VuSsQpitQzokIytXUOscKGTQn7JeB5Fu2kWiz62axSJe5xomkrg==
X-Received: by 2002:a05:6a00:3908:b0:6e5:a96:6286 with SMTP id fh8-20020a056a00390800b006e50a966286mr9606526pfb.31.1709578175764;
        Mon, 04 Mar 2024 10:49:35 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x7-20020a626307000000b006e624f5c866sm2059172pfb.145.2024.03.04.10.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 10:49:34 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <keescook@chromium.org>,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/4] slab: Introduce dedicated bucket allocator
Date: Mon,  4 Mar 2024 10:49:28 -0800
Message-Id: <20240304184252.work.496-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3623; i=keescook@chromium.org;
 h=from:subject:message-id; bh=Z625OVS2xp7R5VmVOq8oa1wppYlZ30y7U3WLqYCRayc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl5he70IwCoMgSCvBAjUKwWeJz01b3BvWIw+IZn
 NkFBnkbdrmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZeYXuwAKCRCJcvTf3G3A
 JvLUEACOIeAvgkaKb4LbQPberShJfvihoE78bYC2zvaEx0MTsRGFBHPurFQpeBPK1mKDI5nhzYL
 r1/7AZ5cVLPbrhQI/v4kyrlZ4fuDf5jzh3KsaRLSf/7bl2hdg1+ZGkcT8WX1cKfv3l5jKXeXUPv
 0J2ay6PQbYAOCSoW3lY1o55Gkjn+2F3u9SRtVywyD1pC4KJxpy/Ef40p7xaDWjtcB0Y2ytY+Uxd
 EiJoN6mPUxdwnZ4LcTWbKRm7XoCaI/Dh+fIE5S+ZPclsmabZFHsGIY2Dw1SCkggBXss6ypNQfL6
 rexlpzBZj7tc5iLwhXroRl+jJvJfpU0L7/gJt/KrpffdUpj3Y62pVHt07cebOdCKuz+WLLIvzu0
 CEwIkm7gf2oiwzJdzm9fzJpojjG+p7mTqb7Wf/Jv26soM5Q/EQsZf2S8jPq970mOrVSEQ1WOSFj
 kTyk5At7MJUTo5ZdUG3bzYcnFOeg9kpynAxCUT3SPlvqoMl1cEGzsRoBjq3RM1Y71+QKwerivQU
 NNfvBqiNdaE0X/o7wOd5AxOGTbeBwXXx+SJVeMzvl+ysx3uT7mSN394vPEiCa655EmUxLxzDWaR
 J7y2dnav0uSekT2i9vyMZCWBhU/fczOZAbzJbydLA3zwJEFT4eFTUOkGgV+fSVTQx5tvoo6mOue
 j/ujTw8 SiQNFfrw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

Repeating the commit logs for patch 1 here:

    Dedicated caches are available For fixed size allocations via
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
    defense for dynamically sized allocations.

    In order to isolate user-controllable sized allocations from system
    allocations, introduce kmem_buckets_create() and kmem_buckets_alloc(),
    which behave like kmem_cache_create() and like kmem_cache_alloc() for
    confining allocations to a dedicated set of sized caches (which have
    the same layout as the kmalloc caches).

    This can also be used in the future once codetag allocation annotations
    exist to implement per-caller allocation cache isolation[0] even for
    dynamic allocations.

    Link: https://lore.kernel.org/lkml/202402211449.401382D2AF@keescook [0]

After the implemetation are 3 example patch of how this could be used
for some repeat "offenders" that get used in exploits. There are more to
be isolated beyond just these. Repeating the commit log for patch 2 here:

    The msg subsystem is a common target for exploiting[1][2][3][4][5][6]
    use-after-free type confusion flaws in the kernel for both read and
    write primitives. Avoid having a user-controlled size cache share the
    global kmalloc allocator by using a separate set of kmalloc buckets.

    After a fresh boot under Ubuntu 23.10, we can see the caches are already
    in use:

     # grep ^msg_msg /proc/slabinfo
     msg_msg-8k             0      0   8192    4    8 : ...
     msg_msg-4k            96    128   4096    8    8 : ...
     msg_msg-2k            64     64   2048   16    8 : ...
     msg_msg-1k            64     64   1024   16    4 : ...
     msg_msg-16          1024   1024     16  256    1 : ...
     msg_msg-8              0      0      8  512    1 : ...

    Link: https://blog.hacktivesecurity.com/index.php/2022/06/13/linux-kernel-exploit-development-1day-case-study/ [1]
    Link: https://hardenedvault.net/blog/2022-11-13-msg_msg-recon-mitigation-ved/ [2]
    Link: https://www.willsroot.io/2021/08/corctf-2021-fire-of-salvation-writeup.html [3]
    Link: https://a13xp0p0v.github.io/2021/02/09/CVE-2021-26708.html [4]
    Link: https://google.github.io/security-research/pocs/linux/cve-2021-22555/writeup.html [5]
    Link: https://zplin.me/papers/ELOISE.pdf [6]

-Kees

Kees Cook (4):
  slab: Introduce dedicated bucket allocator
  ipc, msg: Use dedicated slab buckets for alloc_msg()
  xattr: Use dedicated slab buckets for setxattr()
  mm/util: Use dedicated slab buckets for memdup_user()

 fs/xattr.c           | 12 ++++++++-
 include/linux/slab.h | 26 ++++++++++++++++++
 ipc/msgutil.c        | 11 +++++++-
 mm/slab_common.c     | 64 ++++++++++++++++++++++++++++++++++++++++++++
 mm/util.c            | 12 ++++++++-
 5 files changed, 122 insertions(+), 3 deletions(-)

-- 
2.34.1


