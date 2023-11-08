Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1389C7E4EA4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 02:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjKHBmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 20:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjKHBmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 20:42:36 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA65BAF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 17:42:33 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc9784dbc1so39540265ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 17:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699407753; x=1700012553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uRaBsOVzYONI9pogErmQ9X03ygbaDdU6U4Qoxn4y618=;
        b=kidAwMyTVazSg+VUFr99Bprtz/I7aJ7dNixfjiVXuvjvWp1Nh/5HfZ6sDGdGUendNK
         II3Q1xKIqRPzBFMbGclHe5zLNWLAq1vC2MXDpmWL9lxiVAjN/H3WoS4xhThYDBSvt+dw
         g513OONJ5aJlhdexqmWQ9hOeP4L1AKBHrQE7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699407753; x=1700012553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRaBsOVzYONI9pogErmQ9X03ygbaDdU6U4Qoxn4y618=;
        b=Q2E3L/bkMX7IHJwFOB9TMXJ2XaZ5ewG/XwoRwxc4TttcMvO4HFw4Bk/ukp/pJat10Q
         /dWqhRe5SvNqsdAKLh8cV8DbypuomBBEsS/ltghS2kkN6002zLvfPcOIVf/ntoqeY4X6
         5hhgWYo7SNxA104UYgKocp5KRNumQ+peqbtKo9YrwnrKfOivm8+1e1lTBS3hx02niOo1
         OIElh1lBuQ7xxdI3kaixGdkVKtpSj2W4AmYJklVIgjJ3muptd2lGmMlJoqksjOTfp4fS
         ub+hC+FOCJmLUpCXO3+02ijMFDJ+H1fyPKFqzLrJCNS8RsO726iFOyjz+eXlvzkcIJJL
         3WiQ==
X-Gm-Message-State: AOJu0YwdkO3Itah/z0KBwGRwB/w9+I3MbuyfZKR6GPKZ2W62MKlZtbLm
        K75VZxIPDU2RbhpUaoX2AyFulw==
X-Google-Smtp-Source: AGHT+IEiX3OQXe/Bpr16powrllKhPlWEmq4Fndw9pepmzaQ/R+ZOIvuD5AuOqCc8KrphNFU1/9C7Aw==
X-Received: by 2002:a17:902:7407:b0:1c5:d8a3:8789 with SMTP id g7-20020a170902740700b001c5d8a38789mr747226pll.4.1699407753200;
        Tue, 07 Nov 2023 17:42:33 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:2fe:d436:c346:6fcf])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c14c00b001cc79f3c60csm457816plj.31.2023.11.07.17.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 17:42:32 -0800 (PST)
Date:   Wed, 8 Nov 2023 10:42:29 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Vasily Averin <vasily.averin@linux.dev>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: unsafe zram_get_element call in zram_read_page()
Message-ID: <20231108014229.GE11577@google.com>
References: <d10cdf1d-4a67-48df-b389-3a51f60e9431@linux.dev>
 <20231107073911.GB11577@google.com>
 <20231107104041.GC11577@google.com>
 <c57eb649-c573-4e41-85f4-870d08cf88b9@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c57eb649-c573-4e41-85f4-870d08cf88b9@linux.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/11/07 21:19), Vasily Averin wrote:
> On 11/7/23 13:40, Sergey Senozhatsky wrote:
> > On (23/11/07 16:39), Sergey Senozhatsky wrote:
> >> Hmmm,
> >> We may want to do more here. Basically, we probably need to re-confirm
> >> after read_from_bdev() that the entry at index still has ZRAM_WB set
> >> and, if so, that it points to the same blk_idx. IOW, check that it has
> >> not been free-ed and re-used under us.
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -1364,14 +1364,21 @@ static int zram_read_page(struct zram *zram, struct page *page, u32 index,
> >  		ret = zram_read_from_zspool(zram, page, index);
> >  		zram_slot_unlock(zram, index);
> >  	} else {
> > +		unsigned long idx = zram_get_element(zram, index);
> >  		/*
> >  		 * The slot should be unlocked before reading from the backing
> >  		 * device.
> >  		 */
> >  		zram_slot_unlock(zram, index);
> >  
> > -		ret = read_from_bdev(zram, page, zram_get_element(zram, index),
> > -				     parent);
> > +		ret = read_from_bdev(zram, page, idx, parent);
> > +		if (ret == 0) {
> > +			zram_slot_lock(zram, index);
> > +			if (!zram_test_flag(zram, index, ZRAM_WB) ||
> > +			    idx != zram_get_element(zram, index))
> > +				ret = -EINVAL;
> > +			zram_slot_unlock(zram, index);
> > +		}
> 
> Why overwritten page can not be pushed to WB to the same blk_idx? 

Yeah, so I thought about it too but didn't want to go too deep into it.
We probably can only address it if we synchronize free_page (?), read_page()
and writeback(), so that we never have concurrent bitmap modifications when
one of the operations is in progress.
