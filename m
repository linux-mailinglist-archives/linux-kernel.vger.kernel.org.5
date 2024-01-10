Return-Path: <linux-kernel+bounces-21995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4358297A1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948511C21D45
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0040847F67;
	Wed, 10 Jan 2024 10:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMM4k/SM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1C946BA6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA0BC433C7;
	Wed, 10 Jan 2024 10:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704882414;
	bh=u0i2FaVQlYbTLnWyHEIAv2lNsR9XhIwGw/u5AT2iYxI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=EMM4k/SMS/MJdNAJ/5RgLZiJOmTiYQxja4QuNj2EQ/gmtXKJyX+iDkJLek81nZURv
	 LqRL8dmmie0ZSNDOAaqlhlyBzqXEpoETaUFlUpMIk0tM6z5HF4kJ0qOqobNh3HIGPP
	 iB+wJ1hiyufll73xHdcLdCAMFjt2sFFED5Ch5YTsBuMdSWbjes3xC+ySZMQ1HUWDPc
	 XGGeirJBMv/FCNHQfk5Otp+IKsy91rYUN6yq4VfqXqo3E9mdvilyYvxPKmTkpXX0ve
	 nmviqBfe9YOxv+QhRqoJGcqqYaY4pqfaIjp/zFd5MjUD5UCu3Mm9wF+7PazAlF3nV6
	 oI5jhaAnHPk1Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 52479CE0AB0; Wed, 10 Jan 2024 02:26:54 -0800 (PST)
Date: Wed, 10 Jan 2024 02:26:54 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org
Subject: Re: [BUG] allmodconfig build error in next-20240108
Message-ID: <3a10ef2b-acbe-4d80-805a-e947e15e5db3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <45ad1d0f-a10f-483e-848a-76a30252edbe@paulmck-laptop>
 <20240109095757.1313b2d9@canb.auug.org.au>
 <341a4955-0cdd-48d0-bfbd-cc6f6f09df37@paulmck-laptop>
 <atbx7mspjbymkzgstk4l64qz3uky3wpmx4isrfg3ixgtvebdd2@cktpe4ejfk7k>
 <20240110081155.48bb0cbd@oak>
 <d61dfe52-9567-4f62-98f5-5c1e00cb4708@paulmck-laptop>
 <20240110095822.3ba3d979@canb.auug.org.au>
 <3d14049c-d44c-4b33-9933-0f96055b8a70@paulmck-laptop>
 <20240110160335.2bad7d54@oak>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240110160335.2bad7d54@oak>

On Wed, Jan 10, 2024 at 04:03:51PM +1100, Stephen Rothwell wrote:
> Hi Paul,
> 
> On Tue, 9 Jan 2024 19:46:27 -0800 "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >
> > On Wed, Jan 10, 2024 at 09:58:22AM +1100, Stephen Rothwell wrote:
> > >
> > > Maybe that line "subdir-ccflags-y += $(call cc-option, -Wstringop-overflow)"
> > > should just be removed as the setting of that option has been moved to the
> > > normal C flags in the top level Makefile (out of Makefile.extrawarn).  
> > 
> > If you meant like this, no joy.  :-(
> 
> Actually I meant the one in drivers/gpu/drm/xe/Makefile

Like this?  That does work as shown below, thank you!

							Thanx, Paul

------------------------------------------------------------------------

drm/xe: Fix build bug for GCC 11

Building drivers/gpu/drm/xe/xe_gt_pagefault.c with GCC 11 results
in the following build errors:

/include/linux/fortify-string.h:57:33: error: writing 16 bytes into a region of size 0 [-Werror=stringop-overflow=]
   57 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
/include/linux/fortify-string.h:644:9: note: in expansion of macro ‘__underlying_memcpy’
  644 |         __underlying_##op(p, q, __fortify_size);                        \
      |         ^~~~~~~~~~~~~
/include/linux/fortify-string.h:689:26: note: in expansion of macro ‘__fortify_memcpy_chk’
  689 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
      |                          ^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/xe/xe_gt_pagefault.c:340:17: note: in expansion of macro ‘memcpy’
  340 |                 memcpy(pf_queue->data + pf_queue->tail, msg, len * sizeof(u32));
      |                 ^~~~~~
In file included from drivers/gpu/drm/xe/xe_device_types.h:17,
                 from drivers/gpu/drm/xe/xe_vm_types.h:16,
                 from drivers/gpu/drm/xe/xe_bo.h:13,
                 from drivers/gpu/drm/xe/xe_gt_pagefault.c:16:
drivers/gpu/drm/xe/xe_gt_types.h:102:25: note: at offset [1144, 265324] into destination object ‘tile’ of size 8
  102 |         struct xe_tile *tile;
      |                         ^~~~

Fix these by removing -Wstringop-overflow from drm/xe builds.

Suggested-by: Stephen Rothwell <sfr@rothwell.id.au>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
index 53bd2a8ba1ae..efcf0ab7a1a6 100644
--- a/drivers/gpu/drm/xe/Makefile
+++ b/drivers/gpu/drm/xe/Makefile
@@ -17,7 +17,6 @@ subdir-ccflags-y += $(call cc-option, -Wunused-const-variable)
 subdir-ccflags-y += $(call cc-option, -Wpacked-not-aligned)
 subdir-ccflags-y += $(call cc-option, -Wformat-overflow)
 subdir-ccflags-y += $(call cc-option, -Wformat-truncation)
-subdir-ccflags-y += $(call cc-option, -Wstringop-overflow)
 subdir-ccflags-y += $(call cc-option, -Wstringop-truncation)
 # The following turn off the warnings enabled by -Wextra
 ifeq ($(findstring 2, $(KBUILD_EXTRA_WARN)),)

