Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A6E7A64A1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 15:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjISNRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 09:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjISNRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:17:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E52F0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 06:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695129422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xj9oJdLVZXXfe2DsJm6AxoI6S1Ht1Kg/C17bLb/ATuI=;
        b=be5/ym38fAJ8+Jtk0dTC37g1SFLObA8bMt2dbCucAGxrQOHNfOcS1vD8Pg/l7TKlznDPjr
        7L5GgIeE8S4yCegSUL4xM46G1WLETP9SaEItpB3WduZumvX6IVPsql4jeywkgCrrJT1ZMz
        wYFR0x1vnIHQeVA0TEWFVxhmFo2JNFg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-lyWB58sMNdCihZGiDt2Ksg-1; Tue, 19 Sep 2023 09:17:00 -0400
X-MC-Unique: lyWB58sMNdCihZGiDt2Ksg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-65634fb3c63so47375746d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 06:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695129420; x=1695734220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xj9oJdLVZXXfe2DsJm6AxoI6S1Ht1Kg/C17bLb/ATuI=;
        b=K2Gqirweg06516BBUxLmE7QEUI0ESQ0zMqcV8E6pSELarnTC7yVc7IFbkYRnbZebcs
         DaOqpIxMr1vfGm1urDnCYI0fklPu0xv9+yo+kbuepQDSX1blKqaEiQxBfZVHFl4GF95G
         agHwXeO2RN8fiQlEH76K+E3USIUScud16f8FrT1mzF+yEFCw45RMpYn/xAiI9zTu/oq0
         UdL5fmQb+IOzurfu27/y2cwNqqBx6iGRzJ/3vS4bIgPTxfg8eHC0y9LI6/PrKd01+6Ca
         hov6CInz2boufTGh7SajAsz3MyCfjhes24G7fCalWqJW2R+mysuzDtGV0l0BnhY3Oi+g
         Dgtw==
X-Gm-Message-State: AOJu0YzdEmyHuILUlCSerFFRqeHF2RWP4H2t1L+wxmfD2UkHwUZrgK+3
        tR4cJ5WbpoHqkc+WxnV082m8QbEUjgvbtPDQGAnGYThDNibYGqX1Zba35IKgwxCm6qfwGRRrmBQ
        lbcW1IKxvUF/U2sFGIHmWLelr
X-Received: by 2002:a0c:e20d:0:b0:656:4712:af9f with SMTP id q13-20020a0ce20d000000b006564712af9fmr9055936qvl.13.1695129420088;
        Tue, 19 Sep 2023 06:17:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWm0sJ6bQfCTcqIXcWFuNz102xB7zzDEs9BOGZf+iPByp+jbF8VQ4mQLLnIFV1uf1wfB3zJg==
X-Received: by 2002:a0c:e20d:0:b0:656:4712:af9f with SMTP id q13-20020a0ce20d000000b006564712af9fmr9055919qvl.13.1695129419781;
        Tue, 19 Sep 2023 06:16:59 -0700 (PDT)
Received: from bfoster (c-24-60-61-41.hsd1.ma.comcast.net. [24.60.61.41])
        by smtp.gmail.com with ESMTPSA id m19-20020a0cf193000000b0064f364f3584sm4314734qvl.97.2023.09.19.06.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 06:16:58 -0700 (PDT)
Date:   Tue, 19 Sep 2023 09:17:13 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH] bcachefs: Avoid a potential useless over memory
 allocation in bch2_prt_vprintf()
Message-ID: <ZQmfWbIgPM0Oo8Jg@bfoster>
References: <0f40108bed3e084057223bdbe32c4b37f8500ff3.1694845203.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f40108bed3e084057223bdbe32c4b37f8500ff3.1694845203.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2023 at 08:20:24AM +0200, Christophe JAILLET wrote:
> printbuf_remaining() returns the number of characters we can print to the
> output buffer - i.e. excluding the terminating null.
> 
> vsnprintf() takes the size of the buffer, including the trailing null
> space.
> It is truncated if the returned value is greater than or equal to the size
> of the buffer.
> 
> Knowing all that, buffer sizes and overflow checks can be fixed in order
> to potentially avoid a useless memory over-allocation.
> 

For whatever reason I had a hard time parsing this last sentence.  Do
you mean to say there's an off by one here that leads to an unnecessary
overallocation?

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Un-tested
> ---
>  fs/bcachefs/printbuf.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/bcachefs/printbuf.c b/fs/bcachefs/printbuf.c
> index de41f9a14492..77bee9060bfe 100644
> --- a/fs/bcachefs/printbuf.c
> +++ b/fs/bcachefs/printbuf.c
> @@ -54,8 +54,9 @@ void bch2_prt_vprintf(struct printbuf *out, const char *fmt, va_list args)
>  		va_list args2;
>  
>  		va_copy(args2, args);
> -		len = vsnprintf(out->buf + out->pos, printbuf_remaining(out), fmt, args2);
> -	} while (len + 1 >= printbuf_remaining(out) &&
> +		len = vsnprintf(out->buf + out->pos, printbuf_remaining(out) + 1,
> +				fmt, args2);
> +	} while (len >= printbuf_remaining(out) + 1 &&
>  		 !bch2_printbuf_make_room(out, len + 1));

It's amazing how simple arithmetic can make my eyes cross at times. :) I
think I follow the fix after reading the commit log a couple times, but
could we use printbuf_remaining_size() appropriately in these places
that want to check actual buffer size (i.e. including terminating null)
instead of doing the manual size fixup?

Brian

>  
>  	len = min_t(size_t, len,
> @@ -70,9 +71,10 @@ void bch2_prt_printf(struct printbuf *out, const char *fmt, ...)
>  
>  	do {
>  		va_start(args, fmt);
> -		len = vsnprintf(out->buf + out->pos, printbuf_remaining(out), fmt, args);
> +		len = vsnprintf(out->buf + out->pos, printbuf_remaining(out) + 1,
> +				fmt, args);
>  		va_end(args);
> -	} while (len + 1 >= printbuf_remaining(out) &&
> +	} while (len >= printbuf_remaining(out) + 1 &&
>  		 !bch2_printbuf_make_room(out, len + 1));
>  
>  	len = min_t(size_t, len,
> -- 
> 2.34.1
> 

