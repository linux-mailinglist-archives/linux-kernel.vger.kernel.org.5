Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D558781690
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 04:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243628AbjHSCEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 22:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243614AbjHSCDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 22:03:48 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFE4421E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 19:03:46 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40fe9c38800so9902621cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 19:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692410626; x=1693015426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ge4vs6S3mMj3DmqkDgD4zHVDF/KT+E9LoxSZv9SIUzY=;
        b=VARY436CEZaIAAVHBo8vHhRNc1uI8FcKFzexcLbi/VLWfucOUnkPI0RoEatixybcD6
         h8NcJKHfYInwzQ3z+LQg4Ku8ZQ9ouOOH13XedzxzuOG85CFsvy3OVDlwNss9BX6JP0LX
         obPmD6I7SzQGLSjLj7nxOE2PgQG1Syo7SBvAL0Kxfnjtz0YxeBWngXWq6fs9Eux0S8+d
         J35VO6thB3cU22Awb77df1dKOTsXriB9dxa1mcKXHYHxw84cwYZYn1koTkSy165dwIWx
         GilVekWZrDzDMHw5RaviBQMxErwMkSJxug531iMAaPdSoFFiO6YuWppxRelWyhs8g/tp
         zj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692410626; x=1693015426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ge4vs6S3mMj3DmqkDgD4zHVDF/KT+E9LoxSZv9SIUzY=;
        b=J3ZsonEvTdnygLwuPHsE4uoiqAYi5N2bTti3XgTKXveIDeOO/9UbpJh/g8DOknV+9j
         Mgy0gXSUDgdogaRAhm/5cHAUPCCv4wFXwyfQePhvyhGJ48eb0QDu7JaxnF+mQi8MQAT+
         cHpylKAI3YAJEfW+r2AMDZ7WlRPZaMHJ6UVbZJi29BIFBKyv9fCghsSiHIvH5pLzyfmh
         1jVSYHPBooeunU3zhPgEBVKQM8tgsFm21D0xKexFhi7M3+HQehGrHe0J+8yZZfTp7ot5
         xb8YWT+AvmojKYwSQDSIfWyDk53ubaIlCjMKMQmvCEVEf1C45YRD8TxVoOvQHhOlFk7k
         LZ+g==
X-Gm-Message-State: AOJu0Yx/g1kremGsJO1a2xjzl9od/uGg2114Br8L1jZirOIrTcioe3WC
        RUP3iiWDtpk1I3t/NvvTiJ1zQzoTCrw=
X-Google-Smtp-Source: AGHT+IEGSNi02gFwnTGk1CMF4vINpSx68mSixnPS6/cWgtuMDDtLTS/Geq09Cz/GsZflrUAtxrGMZQ==
X-Received: by 2002:ac8:5f85:0:b0:401:e1e7:a291 with SMTP id j5-20020ac85f85000000b00401e1e7a291mr1274223qta.22.1692410625807;
        Fri, 18 Aug 2023 19:03:45 -0700 (PDT)
Received: from localhost ([32.218.242.113])
        by smtp.gmail.com with ESMTPSA id g8-20020ac87748000000b0040324785e4csm883422qtu.13.2023.08.18.19.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 19:03:45 -0700 (PDT)
Date:   Fri, 18 Aug 2023 19:03:44 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] bitmap: optimize bitmap_remap()
Message-ID: <ZOAi9PB6+/p4orRN@yury-ThinkPad>
References: <20230815235934.47782-1-yury.norov@gmail.com>
 <ZN3qQPeFtdZQrLE4@smile.fi.intel.com>
 <ZN3qlCd+TcYiZg+s@smile.fi.intel.com>
 <ZN4tB7jkQrX/TKnh@yury-ThinkPad>
 <ZN4+nZwBu317dVjz@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN4+nZwBu317dVjz@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 06:37:01PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 17, 2023 at 07:21:59AM -0700, Yury Norov wrote:
> > On Thu, Aug 17, 2023 at 12:38:28PM +0300, Andy Shevchenko wrote:
> > > On Thu, Aug 17, 2023 at 12:37:05PM +0300, Andy Shevchenko wrote:
> > > > On Tue, Aug 15, 2023 at 04:59:34PM -0700, Yury Norov wrote:
> 
> ...
> 
> > > > >  		int n = bitmap_pos_to_ord(old, oldbit, nbits);
> > > > >  
> > > > > +		bit = (n < 0) ? oldbit :	/* identity map */
> > > > 
> > > > Can't you also optimize this case?
> > > > 
> > > > Something like
> > > > 
> > > >   bitmap_xor(tmp, old, new) // maybe even better approach, dunno
> > > 
> > > >   bitmap_empty(tmp) // can be replaced by find first bit
> > > 
> > > Or reuse bitmap_weight()...
> > 
> > That way it wouldn't work,
> 
> Why not? AFAIU there are two cases when we may copy:
> 1) the new mapping is empty;
> 2) the old == new.
> 
> The other cases we need to remap.
> 
> The case 2) is easy with xor and weight.
> 
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 24284caadbcc..917eea5219ac 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -958,7 +958,7 @@ EXPORT_SYMBOL(bitmap_parse);
>   * gets mapped to (returns) @ord value 3 in this example, that means
>   * that bit 7 is the 3rd (starting with 0th) set bit in @buf.
>   *
> - * The bit positions 0 through @bits are valid positions in @buf.
> + * The bit positions 0 through @nbits are valid positions in @buf.
>   */
>  static int bitmap_pos_to_ord(const unsigned long *buf, unsigned int pos, unsigned int nbits)
>  {
> @@ -1008,17 +1008,30 @@ void bitmap_remap(unsigned long *dst, const unsigned long *src,
>  
>  	if (dst == src)		/* following doesn't handle inplace remaps */
>  		return;
> -	bitmap_zero(dst, nbits);
> +
> +	bitmap_xor(dst, old, new, nbits);
> +	if (bitmap_empty(dst, nbits))
> +		goto identity_map;

Now you see? The complexity of this test is 2*O(N). Assuming that people
know better than us when they can optimize their trivial cases with just
copying, this will slow those conscientious users because for them, of
course, old == new is highly unlikely.

Of course, we can do 'if (bitmap_equal(old, new, nbits))', but it's
still O(N), and the above is applicable just as well.
  
>  	w = bitmap_weight(new, nbits);
> +	if (w == 0)
> +		goto identity_map;

In contrast, this test is O(1), because we need the weight of new
bitmap anyways.

> +
> +	bitmap_zero(dst, nbits);
> +
>  	for_each_set_bit(oldbit, src, nbits) {
>  		int n = bitmap_pos_to_ord(old, oldbit, nbits);
>  
> -		if (n < 0 || w == 0)
> +		if (n < 0)
>  			set_bit(oldbit, dst);	/* identity map */
>  		else
>  			set_bit(find_nth_bit(new, nbits, n % w), dst);
>  	}
> +
> +	return;
> +
> +identity_map:
> +	bitmap_copy(dst, src, nbits);
>  }
>  EXPORT_SYMBOL(bitmap_remap);
> 
> But this gives +89 bytes on x86_64... :-(

Who cares if it gives a boost of performance for regular users?

> Inside the loop we can also break when n gets equal to w, but it seems
> a special case (we don't need bitmap_weight_from() for that, do we?).

No, we can't. Instead, we should wrap around 0, exactly what the existing
code does. See the comment:

  * Let @old and @new define a mapping of bit positions, such that
  * whatever position is held by the n-th set bit in @old is mapped
  * to the n-th set bit in @new.  In the more general case, allowing
  * for the possibility that the weight 'w' of @new is less than the
  * weight of @old, map the position of the n-th set bit in @old to
  * the position of the m-th set bit in @new, where m == n % w.

This is written 18 years ago, and it seems it needs to get illustrated.
I didn't find anything else describing bitmap_remap() for more except
my own comment in a random discussion more than a year ago:

https://lkml.org/lkml/2022/6/13/3126

Thanks,
Yury
