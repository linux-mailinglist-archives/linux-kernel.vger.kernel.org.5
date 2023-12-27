Return-Path: <linux-kernel+bounces-12273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D941581F233
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 22:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 743101F23023
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 21:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF68F481BE;
	Wed, 27 Dec 2023 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="lFZ9Bdtz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D33481AD;
	Wed, 27 Dec 2023 21:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6691CC433C8;
	Wed, 27 Dec 2023 21:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703712192;
	bh=vZu8FSzIX7UcEH212Eu6LNhd6xH4C5oYya52gCy+xVs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lFZ9BdtzGo42rCUgHCykvfhdymFe2PhbaiOqqbus8bEaL5rBt6DaaGhII9vG1DEof
	 GvlX6Kgoy6wCELqUajcE3D66+d2oBX+n+iHX/qJ0eRpg2C4MaHS84KmopPgO5CKbis
	 LwxaDIHCKI0I9xrj/5/4Dm3rxwOfGQOYQnGSwYa4=
Date: Wed, 27 Dec 2023 13:23:11 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: kernel test robot <lkp@intel.com>
Cc: andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
 oe-kbuild-all@lists.linux.dev, Linux Memory Management List
 <linux-mm@kvack.org>, Andrey Konovalov <andreyknvl@gmail.com>, Alexander
 Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Andrey
 Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm] kasan: stop leaking stack trace handles
Message-Id: <20231227132311.557c302e92bdc9ffb88b42d5@linux-foundation.org>
In-Reply-To: <202312280213.6j147JJb-lkp@intel.com>
References: <20231226225121.235865-1-andrey.konovalov@linux.dev>
	<202312280213.6j147JJb-lkp@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Dec 2023 02:19:51 +0800 kernel test robot <lkp@intel.com> wrote:

> Hi,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on akpm-mm/mm-everything]
> [cannot apply to linus/master v6.7-rc7 next-20231222]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/andrey-konovalov-linux-dev/kasan-stop-leaking-stack-trace-handles/20231227-065314
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20231226225121.235865-1-andrey.konovalov%40linux.dev
> patch subject: [PATCH mm] kasan: stop leaking stack trace handles
> config: x86_64-randconfig-123-20231227 (https://download.01.org/0day-ci/archive/20231228/202312280213.6j147JJb-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231228/202312280213.6j147JJb-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312280213.6j147JJb-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> mm/kasan/generic.c:506:6: warning: no previous prototype for 'release_alloc_meta' [-Wmissing-prototypes]
>      506 | void release_alloc_meta(struct kasan_alloc_meta *meta)
>          |      ^~~~~~~~~~~~~~~~~~
> >> mm/kasan/generic.c:517:6: warning: no previous prototype for 'release_free_meta' [-Wmissing-prototypes]
>      517 | void release_free_meta(const void *object, struct kasan_free_meta *meta)
>          |      ^~~~~~~~~~~~~~~~~

Thanks, I added this fix:

--- a/mm/kasan/generic.c~kasan-stop-leaking-stack-trace-handles-fix
+++ a/mm/kasan/generic.c
@@ -503,7 +503,7 @@ void kasan_init_object_meta(struct kmem_
 	 */
 }
 
-void release_alloc_meta(struct kasan_alloc_meta *meta)
+static void release_alloc_meta(struct kasan_alloc_meta *meta)
 {
 	/* Evict the stack traces from stack depot. */
 	stack_depot_put(meta->alloc_track.stack);
@@ -514,7 +514,7 @@ void release_alloc_meta(struct kasan_all
 	__memset(meta, 0, sizeof(*meta));
 }
 
-void release_free_meta(const void *object, struct kasan_free_meta *meta)
+static void release_free_meta(const void *object, struct kasan_free_meta *meta)
 {
 	/* Check if free meta is valid. */
 	if (*(u8 *)kasan_mem_to_shadow(object) != KASAN_SLAB_FREE_META)
_


