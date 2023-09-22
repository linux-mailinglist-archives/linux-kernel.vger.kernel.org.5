Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55A87AB7EE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjIVRmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjIVRme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:42:34 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0E9AC
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:42:27 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-658226cf208so12939656d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1695404546; x=1696009346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aQa3pRp/TxyEpxN+Z9CHPWpvvaFg6Q8xxs5ZCg46zy8=;
        b=H489bG98Hy/ca38DMzcBUK8V8AlpC6Ii9Z2zQ3Jy/eI57bYN7bPI+F8alVnpjIpBZo
         ltIivwvKxB6gDrKDNNJq93GTBkgtsnqUycPfAV/qwpmixdQuUtP0y+Sxl75AvDnIdhTI
         SUIlo//j72PH1A31Mal6jcKQd7qtDP0eRQ+6eAKdazzS6gQWv3szLFO2ftWZLtoUrpMw
         Q25fsUYH8xDlXB2wNLD3nRVNcEq6l/OPXwAcHYkVjPgzWHQ6ncfqlJxECAI01FQV6iqN
         bPrbeUdF3+trDIOc120hfgQOZKZqJLtM6ePclfz5J39mi9O+ObhVz9Da/yDaiZZiZCwg
         +sfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695404546; x=1696009346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQa3pRp/TxyEpxN+Z9CHPWpvvaFg6Q8xxs5ZCg46zy8=;
        b=FMsp3DKCZZX1Ncr9+gyrBAKQS26UTGf+aW1e0SJgKxR79/Pph3dhrUv8v9gk1hFhmz
         Z7+2w+BHMqHvbH4C/cRxwvfGv8x6INdR/ihyD9lhKkC/0t19c0KQa/unSlEXWor6MnYN
         NQ3uBQrslWdxuB0abX/FPNbr+F33asmTl9SXy0qzJfmCc1oCns7h0qqDlLulf0zLCZpl
         TmKYwLPx8uNfiScLdV1hHOGa0wkmqYBVFQ9nuA3AZP2RjnAI012SC9FpvLa+DWtxhsBy
         tiJN7nZJ1tNLlOYKlfB27j/l8x24gtN7j0joqsSxNcQmmyRMw4ZE0ruqng3y0ya0N0O4
         38oQ==
X-Gm-Message-State: AOJu0Yy3u5VXdmFOJwWTHkgKDR36SQdsQ0eK6Fd99W1D+q066lYB/nU6
        8+Yp+oGxSKZee1cP962McFzDPg==
X-Google-Smtp-Source: AGHT+IFZcHBDUXE8br71jwRtkuR0aGa7+rh/7j9LTF7C5c0v7LVwR+KxlQZbhHg80+DaFOFn/zf+tQ==
X-Received: by 2002:a0c:a801:0:b0:64f:91de:3aab with SMTP id w1-20020a0ca801000000b0064f91de3aabmr8139129qva.29.1695404546179;
        Fri, 22 Sep 2023 10:42:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ba06])
        by smtp.gmail.com with ESMTPSA id x20-20020a0ce0d4000000b0064f732aa463sm1583210qvk.105.2023.09.22.10.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:42:25 -0700 (PDT)
Date:   Fri, 22 Sep 2023 13:42:25 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        akpm@linux-foundation.org, nphamcs@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm: zswap: fix potential memory corruption on duplicate
 store
Message-ID: <20230922174225.GF124289@cmpxchg.org>
References: <20230922172211.1704917-1-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922172211.1704917-1-cerasuolodomenico@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 07:22:11PM +0200, Domenico Cerasuolo wrote:
> While stress-testing zswap a memory corruption was happening when writing
> back pages. __frontswap_store used to check for duplicate entries before
> attempting to store a page in zswap, this was because if the store fails
> the old entry isn't removed from the tree. This change removes duplicate
> entries in zswap_store before the actual attempt.
> 
> Based on commit ce9ecca0238b ("Linux 6.6-rc2")
> 
> Fixes: 42c06a0e8ebe ("mm: kill frontswap")
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

> @@ -1218,6 +1218,19 @@ bool zswap_store(struct folio *folio)
>  	if (!zswap_enabled || !tree)
>  		return false;
>  
> +	/*
> +	 * If this is a duplicate, it must be removed before attempting to store
> +	 * it, otherwise, if the store fails the old page won't be removed from
> +	 * the tree, and it might be written back overriding the new data.
> +	 */
> +	spin_lock(&tree->lock);
> +	dupentry = zswap_rb_search(&tree->rbroot, offset);
> +	if (dupentry) {
> +		zswap_duplicate_entry++;
> +		zswap_invalidate_entry(tree, dupentry);
> +	}
> +	spin_unlock(&tree->lock);

Do we still need the dupe handling at the end of the function then?

The dupe store happens because a page that's already in swapcache has
changed and we're trying to swap_writepage() it again with new data.

But the page is locked at this point, pinning the swap entry. So even
after the tree lock is dropped I don't see how *another* store to the
tree at this offset could occur while we're compressing.
