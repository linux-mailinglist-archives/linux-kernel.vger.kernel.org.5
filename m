Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E9D7CC5A4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343966AbjJQOMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343948AbjJQOMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:12:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D17F9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697551912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qVbWHcpUgZBtR5NN7bJYHsaY9xVjfK+9siYhOyfKsEI=;
        b=QjCyhxnM8WiUTaDQpGU5KOJPXhIPrCpKAoQr3kglbdLEFkC2Cjpt6Rc6DthWMFQtUhzUNE
        yxzhpxhrnffSR4h/rXev4CGX35vkcr4OzdijmRKr+mYZ0t+AM8IDBYJTUj0VgpM1MQTmCy
        hzGAtn0YLsUtOt09NNBdS3492hz5dM4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-Rns46lFmO3yABdab5YgUEg-1; Tue, 17 Oct 2023 10:11:50 -0400
X-MC-Unique: Rns46lFmO3yABdab5YgUEg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-65b08994e15so89855136d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697551910; x=1698156710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVbWHcpUgZBtR5NN7bJYHsaY9xVjfK+9siYhOyfKsEI=;
        b=CJvNNpAp/7xWEdiItVZdiOtHxHRbFeO8IPWWwHKAC69f21CEewRuBPYgqdZipmdJ4K
         0YdV0OnzirXiTXk4O6C5f8SUt7Q78yrwNYqtbR5UtL4mAwN95N+eipdimlWVlhE5qYaZ
         DPLvr2StiTWH8vfw3a49He+vglA0tyzhnqhIxB/E7QrJZlhx0QmJrw3Zo6sRE8MLzI88
         X8+2FPZWlObYQI4/lheNKp8qqNKmU/m2/2gQBK/7TaeS3cmIpG1VlGtbME4oO0w4Hr7/
         ar8KJaOAi+23j08QjqzadRwLH6NhAOETv8FZvERULNhEXAjNIEIxLDBoXDGH+379IAwx
         GNBw==
X-Gm-Message-State: AOJu0Yw7bnvTFTouipTiRcFSQ7q7iwPebn9Kg9nknm+o8pctiRzBXEQa
        bb9e7KJgALxVCCYAvfyIrU7oYDEuMe3mnr+PUMpAiLDLKIBuQSPHvrRCvlUO422lU8VlKqIv8y3
        sL0kCZUE3a1Z1a/apDmzDRWWr
X-Received: by 2002:a05:6214:4389:b0:66d:6a92:16c2 with SMTP id oh9-20020a056214438900b0066d6a9216c2mr2774701qvb.8.1697551910455;
        Tue, 17 Oct 2023 07:11:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDUBVS13QvNQ9+bYuK6AltBNKVl+z+6NJPCUZzJSg6QJW2bjJdmi4MH3ixnmwR1DTWlzVidw==
X-Received: by 2002:a05:6214:4389:b0:66d:6a92:16c2 with SMTP id oh9-20020a056214438900b0066d6a9216c2mr2774679qvb.8.1697551910205;
        Tue, 17 Oct 2023 07:11:50 -0700 (PDT)
Received: from bfoster (c-24-60-61-41.hsd1.ma.comcast.net. [24.60.61.41])
        by smtp.gmail.com with ESMTPSA id du19-20020a05620a47d300b007757eddae8bsm680500qkb.62.2023.10.17.07.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 07:11:49 -0700 (PDT)
Date:   Tue, 17 Oct 2023 10:12:16 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-bcachefs@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] bcachefs: Refactor bkey_i to use a flexible array
Message-ID: <ZS6WQHvjMQQd42jO@bfoster>
References: <20231016212735.it.314-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016212735.it.314-kees@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 02:27:39PM -0700, Kees Cook wrote:
> The memcpy() in bch2_bkey_append_ptr() is operating on an embedded
> fake flexible array. Instead, make it explicit, and convert the memcpy
> to target the flexible array instead. Fixes the W=1 warning seen for
> -Wstringop-overflow:
> 
>    In file included from include/linux/string.h:254,
>                     from include/linux/bitmap.h:11,
>                     from include/linux/cpumask.h:12,
>                     from include/linux/smp.h:13,
>                     from include/linux/lockdep.h:14,
>                     from include/linux/radix-tree.h:14,
>                     from include/linux/backing-dev-defs.h:6,
>                     from fs/bcachefs/bcachefs.h:182:
>    fs/bcachefs/extents.c: In function 'bch2_bkey_append_ptr':
>    include/linux/fortify-string.h:57:33: warning: writing 8 bytes into a region of size 0 [-Wstringop-overflow=]
>       57 | #define __underlying_memcpy     __builtin_memcpy
>          |                                 ^
>    include/linux/fortify-string.h:648:9: note: in expansion of macro '__underlying_memcpy'
>      648 |         __underlying_##op(p, q, __fortify_size);                        \
>          |         ^~~~~~~~~~~~~
>    include/linux/fortify-string.h:693:26: note: in expansion of macro '__fortify_memcpy_chk'
>      693 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>          |                          ^~~~~~~~~~~~~~~~~~~~
>    fs/bcachefs/extents.c:235:17: note: in expansion of macro 'memcpy'
>      235 |                 memcpy((void *) &k->v + bkey_val_bytes(&k->k),
>          |                 ^~~~~~
>    fs/bcachefs/bcachefs_format.h:287:33: note: destination object 'v' of size 0
>      287 |                 struct bch_val  v;
>          |                                 ^
> 
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Brian Foster <bfoster@redhat.com>
> Cc: linux-bcachefs@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309192314.VBsjiIm5-lkp@intel.com/
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2 - Change flex array name to "v_bytes" (bfoster)
> v1 - https://lore.kernel.org/r/20231010235609.work.594-kees@kernel.org
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/bcachefs/bcachefs_format.h | 5 ++++-
>  fs/bcachefs/extents.h         | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/bcachefs/bcachefs_format.h b/fs/bcachefs/bcachefs_format.h
> index f0d130440baa..cb1af3799b59 100644
> --- a/fs/bcachefs/bcachefs_format.h
> +++ b/fs/bcachefs/bcachefs_format.h
> @@ -300,7 +300,10 @@ struct bkey_i {
>  	__u64			_data[0];
>  
>  	struct bkey	k;
> -	struct bch_val	v;
> +	union {
> +		struct bch_val	v;
> +		DECLARE_FLEX_ARRAY(__u8, v_bytes);
> +	};
>  };
>  
>  #define KEY(_inode, _offset, _size)					\
> diff --git a/fs/bcachefs/extents.h b/fs/bcachefs/extents.h
> index 7ee8d031bb6c..896fcfca4f21 100644
> --- a/fs/bcachefs/extents.h
> +++ b/fs/bcachefs/extents.h
> @@ -642,7 +642,7 @@ static inline void bch2_bkey_append_ptr(struct bkey_i *k, struct bch_extent_ptr
>  
>  		ptr.type = 1 << BCH_EXTENT_ENTRY_ptr;
>  
> -		memcpy((void *) &k->v + bkey_val_bytes(&k->k),
> +		memcpy(&k->v_bytes[bkey_val_bytes(&k->k)],
>  		       &ptr,
>  		       sizeof(ptr));
>  		k->k.u64s++;
> -- 
> 2.34.1
> 

