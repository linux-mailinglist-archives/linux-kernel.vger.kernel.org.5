Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2BE7A64AC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 15:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjISNTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 09:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjISNTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E9513E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 06:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695129499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BjorSHNoei3MCn6r/RhuSoFNc+wMBxeBjY3SnV9le7g=;
        b=GQ7xJejGDyO6cWMc/LGnJOfMTicbPyj4rGgA2tpGcL+nuxIXvp61+nhO/6TXd1wJlEaP9F
        8QTtukiD4EmSxGmD7FCYxqz+JJbrzsi2+e5+IFQ340NPDuAnQEK4+uEkmrWZS+Qgzl9r1P
        jHLmX/No/5OWMWFl/gxMwXKukP14TPQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-tSRslDVmOReqav7kcBykaQ-1; Tue, 19 Sep 2023 09:18:17 -0400
X-MC-Unique: tSRslDVmOReqav7kcBykaQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-76dcf1d8905so741412685a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 06:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695129497; x=1695734297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjorSHNoei3MCn6r/RhuSoFNc+wMBxeBjY3SnV9le7g=;
        b=CiK3ORZtgXoAHV2syBinKeWWBE2DRS81QlSCJ+F3kCDeqYpLGXonW0v06Xq2t0quni
         5O73A3rD+oxSiIzntrh2OjiYj2YPVP9jIOaXxVT0T0v1vQJ8TDOmIko47y6IzPT1eQfT
         Zq6xQGp0YklRGQxUgkLFY+WaoHlqKljrGsTP5Qsq9AQm4GsHp97I2gp3VbuLEccCfrKE
         hCg2Jqjll7vA7LxGRIaNo09RqpT4lEy1TXf7QZwzQ5Sg4ytj45zByc+vR88hENvh5CRr
         pr/SB8+0TEfy6ivLjoDwh+nDGMZW59RAvudUGTkhgy0iORTB+5JIYQ/3SWKNKhjfHDlA
         J3QA==
X-Gm-Message-State: AOJu0Yy3XKAqMtXGWQKKahFvuJ1gqYjUtXNp7+mvtlkMvUA36we8qUwo
        svjUk+0wWoKTqMmK+hhRaPThmfrbndl2lotbj8kiCdqrvO6NOT20QHnQkfdfsnPmNOqa1PIC7Xo
        32D+rw6VUZ6zWoKwwdN8k+vgF
X-Received: by 2002:a05:620a:f15:b0:770:f346:e9e8 with SMTP id v21-20020a05620a0f1500b00770f346e9e8mr13271561qkl.10.1695129497083;
        Tue, 19 Sep 2023 06:18:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDQenUL8nVYXBKc2kaywrW+7QsIuTBhMV8LPjj3O/QpZfTWjObXhPmQyrl/R+ZAlk9EvgDgQ==
X-Received: by 2002:a05:620a:f15:b0:770:f346:e9e8 with SMTP id v21-20020a05620a0f1500b00770f346e9e8mr13271536qkl.10.1695129496821;
        Tue, 19 Sep 2023 06:18:16 -0700 (PDT)
Received: from bfoster (c-24-60-61-41.hsd1.ma.comcast.net. [24.60.61.41])
        by smtp.gmail.com with ESMTPSA id ou36-20020a05620a622400b007659935ce64sm3947722qkn.71.2023.09.19.06.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 06:18:16 -0700 (PDT)
Date:   Tue, 19 Sep 2023 09:18:31 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH] bcachefs: Avoid a potential memory over-allocation in
 bch2_printbuf_make_room()
Message-ID: <ZQmfpzxX+qjLtJjm@bfoster>
References: <2e6a82a83d0ddd9ce7f36ea889dd7ffc30f5fbc9.1694853900.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e6a82a83d0ddd9ce7f36ea889dd7ffc30f5fbc9.1694853900.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2023 at 10:45:23AM +0200, Christophe JAILLET wrote:
> kmalloc() and co. don't always allocate a power of 2 number of bytes.
> There are some special handling for 64<n<=96 and 128<n<=192 cases.
> 

It's not immediately clear to me what you mean by "special handling."
Taking a quick look at slabinfo, it looks like what you mean is that
slab rounding is a bit more granular than power of two, particularly in
these ranges. Is that right? If so, JFYI it would be helpful to describe
that more explicitly in the commit log.

> So trust kmalloc() algorithm instead of forcing a power of 2 allocation.
> This can saves a few bytes of memory and still make use of all the
> memory allocated.
> 
> On the other side, it may require an additional realloc() in some cases.
> 

Well, I feel like this isn't the only place I've seen the power of two
buffer size realloc algorithm thing, but in thinking about it this seems
fairly harmless and reasonable for printbufs. FWIW:

Reviewed-by: Brian Foster <bfoster@redhat.com>

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  fs/bcachefs/printbuf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/bcachefs/printbuf.c b/fs/bcachefs/printbuf.c
> index 77bee9060bfe..34527407e950 100644
> --- a/fs/bcachefs/printbuf.c
> +++ b/fs/bcachefs/printbuf.c
> @@ -28,7 +28,7 @@ int bch2_printbuf_make_room(struct printbuf *out, unsigned extra)
>  	if (out->pos + extra < out->size)
>  		return 0;
>  
> -	new_size = roundup_pow_of_two(out->size + extra);
> +	new_size = kmalloc_size_roundup(out->size + extra);
>  
>  	/*
>  	 * Note: output buffer must be freeable with kfree(), it's not required
> -- 
> 2.34.1
> 

