Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F9B765DAB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjG0VCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjG0VCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:02:20 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC12D273E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:02:17 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so193039966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wowsignal-io.20221208.gappssmtp.com; s=20221208; t=1690491736; x=1691096536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0i5f8bEsulFnX7IN+7eY76DeBFKRYQvyC8lxoFn/mXg=;
        b=qOHwj1v4otqFX1t8GSyeXCcw1BGUyAR5dtsRYbES+RXZuW9VC465KWTlZr46w5SoUE
         0SbAoGaT1qBItUdGZXmt/hVpNmDLnTio373QVdCd7kFp1GhL+53a8hcMeesFJdt5xWw0
         r/iRAfp53+V/kNXzHupNCw8u7dPkFJwxYyjicA9keGByfeVXIbLSwnu5Uvxu9Jf+H47E
         +s0iXti+bUc1MIfnqr/eBbw8O3LyBZXG2Iaabx8G+z03aXHVDe/q20yuCaWuMEJ29DHQ
         mu8cTw8MJRO9K4GvY9uoikwmWLQxcQrTorBPgKFiv5Oj+oiurzrX1iL6MW3Z6j50rdUX
         hFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690491736; x=1691096536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0i5f8bEsulFnX7IN+7eY76DeBFKRYQvyC8lxoFn/mXg=;
        b=lCC9uqAuu9RkjfkBSfUPYTrrwkHYLPc5joGplwv/Jff2WyshmXZpJU8DSLPNNLcTLm
         L6/kAznDa6MoZKXrXp8IpysPMiIbhKxxnkZC3NuF1Cy+qerlIUERRihS7u2U8NXwYl/k
         NIBrTdbuq9pPS33ZHhOrhYkzHBX4xZIso1LL2ALlI25Dxsar+gzTu2r74BLWqWKNg3uY
         kQs1Gf0ttawi+fukPSNqDyiFFtCtVhQRtE4u1XRuCEVRTViOro/r/3j9DB2SdOx+bX1f
         9cKhgW6i/Vy5gq+6ueaa73QNHJM7nIPED/S6Tjv7gtoT9EoaiFh0vi1wR5v/K+XnEQDb
         x6VA==
X-Gm-Message-State: ABy/qLYjPNCw5ERwEgO/UBUW9RomZg5Gf/y1mb8DsaTRdWK6eWpPdrjx
        cOoaHhf7RZMZ0TIQup8tllhLgg==
X-Google-Smtp-Source: APBJJlFc+d60clhOSrpU+AFUQ5JtHP+MUM0e0EtqS8Pk29/3B/SZKIUIffwXraPM6jVbhhPSHex/cA==
X-Received: by 2002:a17:906:3187:b0:993:e2ba:a7b0 with SMTP id 7-20020a170906318700b00993e2baa7b0mr299751ejy.24.1690491736275;
        Thu, 27 Jul 2023 14:02:16 -0700 (PDT)
Received: from localhost ([31.40.215.10])
        by smtp.gmail.com with ESMTPSA id f19-20020a170906495300b00992c4103cb5sm1187666ejt.129.2023.07.27.14.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 14:02:15 -0700 (PDT)
Date:   Thu, 27 Jul 2023 23:02:14 +0200
From:   Adam Sindelar <adam@wowsignal.io>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, Adam Sindelar <ats@fb.com>,
        David Vernet <void@manifault.com>,
        Brendan Jackman <jackmanb@google.com>,
        KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH bpf-next v4] libbpf: Expose API to consume one ring at a
 time
Message-ID: <ZMLbVvUO6YMDKh8k@Momo.local>
References: <20230727083436.293201-1-adam@wowsignal.io>
 <64c2bebadbbba_831d208b3@john.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64c2bebadbbba_831d208b3@john.notmuch>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 12:00:10PM -0700, John Fastabend wrote:
> Adam Sindelar wrote:
> > We already provide ring_buffer__epoll_fd to enable use of external
> > polling systems. However, the only API available to consume the ring
> > buffer is ring_buffer__consume, which always checks all rings. When
> > polling for many events, this can be wasteful.
> > 
> > Signed-off-by: Adam Sindelar <adam@wowsignal.io>
> > ---
> > v1->v2: Added entry to libbpf.map
> > v2->v3: Correctly set errno and handle overflow
> > v3->v4: Fixed an embarrasing typo from zealous autocomplete
> > 
> >  tools/lib/bpf/libbpf.h   |  1 +
> >  tools/lib/bpf/libbpf.map |  1 +
> >  tools/lib/bpf/ringbuf.c  | 22 ++++++++++++++++++++++
> >  3 files changed, 24 insertions(+)
> > 
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index 55b97b2087540..20ccc65eb3f9d 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -1195,6 +1195,7 @@ LIBBPF_API int ring_buffer__add(struct ring_buffer *rb, int map_fd,
> >  				ring_buffer_sample_fn sample_cb, void *ctx);
> >  LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms);
> >  LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
> > +LIBBPF_API int ring_buffer__consume_ring(struct ring_buffer *rb, uint32_t ring_id);
> >  LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
> >  
> >  struct user_ring_buffer_opts {
> > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > index 9c7538dd5835e..42dc418b4672f 100644
> > --- a/tools/lib/bpf/libbpf.map
> > +++ b/tools/lib/bpf/libbpf.map
> > @@ -398,4 +398,5 @@ LIBBPF_1.3.0 {
> >  		bpf_prog_detach_opts;
> >  		bpf_program__attach_netfilter;
> >  		bpf_program__attach_tcx;
> > +		ring_buffer__consume_ring;
> >  } LIBBPF_1.2.0;
> > diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> > index 02199364db136..457469fc7d71e 100644
> > --- a/tools/lib/bpf/ringbuf.c
> > +++ b/tools/lib/bpf/ringbuf.c
> > @@ -290,6 +290,28 @@ int ring_buffer__consume(struct ring_buffer *rb)
> >  	return res;
> >  }
> >  
> > +/* Consume available data from a single RINGBUF map identified by its ID.
> > + * The ring ID is returned in epoll_data by epoll_wait when called with
> > + * ring_buffer__epoll_fd.
> > + */
> > +int ring_buffer__consume_ring(struct ring_buffer *rb, uint32_t ring_id)
> > +{
> > +	struct ring *ring;
> > +	int64_t res;
> > +
> > +	if (ring_id >= rb->ring_cnt)
> > +		return libbpf_err(-EINVAL);
> > +
> > +	ring = &rb->rings[ring_id];
> > +	res = ringbuf_process_ring(ring);
> > +	if (res < 0)
> > +		return libbpf_err(res);
> > +
> > +	if (res > INT_MAX)
> > +		return INT_MAX;
> > +	return res;
> 
> Why not just return int64_t here? Then skip the INT_MAX check? I would
> just assume get the actual value if I was calling this.
> 

Mainly for consistency with the existing API. So far, the comparable
LIBBPF_API functions use int. It's hard to imagine that the number of
records would exceed ~2 billion in a single call - I think the
abberation is that ringbuf_process_ring using a 64-bit counter. If you
do exceed INT_MAX records, something is probably wrong and maybe the function
should return error instead. (But that would be outside the scope of
this patch.)

> > +}
> > +
> >  /* Poll for available data and consume records, if any are available.
> >   * Returns number of records consumed (or INT_MAX, whichever is less), or
> >   * negative number, if any of the registered callbacks returned error.
> > -- 
> > 2.39.2
> > 
> > 
> 
> 
