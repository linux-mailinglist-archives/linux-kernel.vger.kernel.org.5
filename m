Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34F17762A0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbjHIOiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjHIOiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:38:05 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD68D1FCC;
        Wed,  9 Aug 2023 07:38:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 498816732D; Wed,  9 Aug 2023 16:38:01 +0200 (CEST)
Date:   Wed, 9 Aug 2023 16:38:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Christoph Hellwig <hch@lst.de>, netdev@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC] Introduce uniptr_t as a generic "universal" pointer
Message-ID: <20230809143801.GA693@lst.de>
References: <87edkce118.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edkce118.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 04:35:47PM +0200, Takashi Iwai wrote:
> Although sockptr_t is used already in several places as a "universal"
> pointer, it's still too confusing to use it in other subsystems, since
> people see it always as if it were a network-related stuff.
> 
> This patch defines a more generic type, uniptr_t, that does exactly as
> same as sockptr_t for a wider use.  As of now, it's almost 1:1 copy
> with renames (just with comprehensive header file inclusions).

The original set_fs removal series did that as uptr_t, and Linus
hated it with passion.  I somehow doubt he's going to like it more now.

> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> 
> This is a RFC patch, or rather a material for bikeshedding.
> 
> Initially the discussion started from the use of sockptr_t for the
> sound driver in Andy's patch:
>   https://lore.kernel.org/r/20230721100146.67293-1-andriy.shevchenko@linux.intel.com
> followed by a bigger series of patches by me:
>   https://lore.kernel.org/r/20230731154718.31048-1-tiwai@suse.de
> 
> The first reaction to the patches (including my own) were
> "why sockptr_t?"  Yes, it's just confusing.  So, here it is, a
> proposal of defining the new type for the very purpose as sockptr_t.
> 
> The name of uniptr_t is nothing but my random pick up, and we can
> endlessly discuss for a better name (genptr_t or whatever).
> I'm totally open for the name.
> 
> After this introduction, sockptr_t can be alias of uniptr_t,
> e.g. simply override with "#define sockptr_t uniptr_t" or such.
> How can it be is another open question.
> 
> Also, we can clean up the macro implementation along with it;
> there seem a few (rather minor) issues as suggested by Andy:
>   https://lore.kernel.org/r/ZMlGKy7ibjkQ6ii7@smile.fi.intel.com
> 
> Honestly speaking, I don't mind to keep using sockptr_t generically
> despite of the name, if people agree.  The rename might make sense,
> though, if it's more widely used in other subsystems in future.
> 
> 
> Takashi
> 
> ===
> 
>  include/linux/uniptr.h | 121 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 include/linux/uniptr.h
> 
> diff --git a/include/linux/uniptr.h b/include/linux/uniptr.h
> new file mode 100644
> index 000000000000..f7994d3a45eb
> --- /dev/null
> +++ b/include/linux/uniptr.h
> @@ -0,0 +1,121 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Support for "universal" pointers that can point to either kernel or userspace
> + * memory.
> + *
> + * Original code from sockptr.h
> + *    Copyright (c) 2020 Christoph Hellwig
> + */
> +#ifndef _LINUX_UNIPTR_H
> +#define _LINUX_UNIPTR_H
> +
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <linux/uaccess.h>
> +
> +typedef struct {
> +	union {
> +		void		*kernel;
> +		void __user	*user;
> +	};
> +	bool		is_kernel : 1;
> +} uniptr_t;
> +
> +static inline bool uniptr_is_kernel(uniptr_t uniptr)
> +{
> +	return uniptr.is_kernel;
> +}
> +
> +static inline uniptr_t KERNEL_UNIPTR(void *p)
> +{
> +	return (uniptr_t) { .kernel = p, .is_kernel = true };
> +}
> +
> +static inline uniptr_t USER_UNIPTR(void __user *p)
> +{
> +	return (uniptr_t) { .user = p };
> +}
> +
> +static inline bool uniptr_is_null(uniptr_t uniptr)
> +{
> +	if (uniptr_is_kernel(uniptr))
> +		return !uniptr.kernel;
> +	return !uniptr.user;
> +}
> +
> +static inline int copy_from_uniptr_offset(void *dst, uniptr_t src,
> +					  size_t offset, size_t size)
> +{
> +	if (!uniptr_is_kernel(src))
> +		return copy_from_user(dst, src.user + offset, size);
> +	memcpy(dst, src.kernel + offset, size);
> +	return 0;
> +}
> +
> +static inline int copy_from_uniptr(void *dst, uniptr_t src, size_t size)
> +{
> +	return copy_from_uniptr_offset(dst, src, 0, size);
> +}
> +
> +static inline int copy_to_uniptr_offset(uniptr_t dst, size_t offset,
> +					const void *src, size_t size)
> +{
> +	if (!uniptr_is_kernel(dst))
> +		return copy_to_user(dst.user + offset, src, size);
> +	memcpy(dst.kernel + offset, src, size);
> +	return 0;
> +}
> +
> +static inline int copy_to_uniptr(uniptr_t dst, const void *src, size_t size)
> +{
> +	return copy_to_uniptr_offset(dst, 0, src, size);
> +}
> +
> +static inline void *memdup_uniptr(uniptr_t src, size_t len)
> +{
> +	void *p = kmalloc_track_caller(len, GFP_USER | __GFP_NOWARN);
> +
> +	if (!p)
> +		return ERR_PTR(-ENOMEM);
> +	if (copy_from_uniptr(p, src, len)) {
> +		kfree(p);
> +		return ERR_PTR(-EFAULT);
> +	}
> +	return p;
> +}
> +
> +static inline void *memdup_uniptr_nul(uniptr_t src, size_t len)
> +{
> +	char *p = kmalloc_track_caller(len + 1, GFP_KERNEL);
> +
> +	if (!p)
> +		return ERR_PTR(-ENOMEM);
> +	if (copy_from_uniptr(p, src, len)) {
> +		kfree(p);
> +		return ERR_PTR(-EFAULT);
> +	}
> +	p[len] = '\0';
> +	return p;
> +}
> +
> +static inline long strncpy_from_uniptr(char *dst, uniptr_t src, size_t count)
> +{
> +	if (uniptr_is_kernel(src)) {
> +		size_t len = min(strnlen(src.kernel, count - 1) + 1, count);
> +
> +		memcpy(dst, src.kernel, len);
> +		return len;
> +	}
> +	return strncpy_from_user(dst, src.user, count);
> +}
> +
> +static inline int check_zeroed_uniptr(uniptr_t src, size_t offset, size_t size)
> +{
> +	if (!uniptr_is_kernel(src))
> +		return check_zeroed_user(src.user + offset, size);
> +	return memchr_inv(src.kernel + offset, 0, size) == NULL;
> +}
> +
> +#endif /* _LINUX_UNIPTR_H */
> -- 
> 2.35.3
---end quoted text---
