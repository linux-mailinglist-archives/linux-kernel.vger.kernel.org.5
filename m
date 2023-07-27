Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29174764E21
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 10:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbjG0Iu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 04:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbjG0Iuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:50:32 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56613C5B2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:32:05 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbc77e76abso6972975e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wowsignal-io.20221208.gappssmtp.com; s=20221208; t=1690446676; x=1691051476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fZFtCpovnp82kT+FkbHY0+/cBruEvbU7wiC862ePSTI=;
        b=K7tLlDmQGygN+P8AUY4HaZJeNFLMebfjrBrw3ETxkwRaLv/xIdJAA1w9GC8syEyqVp
         YSxwyQQzu/JvlLv1w8c6solAxDm4LrjxLnGrOE7h7p3ANh9zWoR/H3pmAvglG0Hd9ZvS
         ABVCCCfnNDdUpRuPJcxtRbQQ24hDZFUT+TJMqpH2D8cKO+U8DXzWRY1QO7+68aJdwSE9
         82InR3Ani9UxDB2MT4zANVCpz3wuoZQbYNsWUDOmEDpGL81y3Nk25umjDBrLrpQdleFE
         0T7eDtIlroh5/m3mWTnzBhkb7TZx8e4f0lRoAQMaEvzDSqtkWsNP7cbT+s39KPeIKMor
         5wUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690446676; x=1691051476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZFtCpovnp82kT+FkbHY0+/cBruEvbU7wiC862ePSTI=;
        b=fK9getDWdkJujZ0m+Zuj+LaztANG4M3ldMLCwSSK38tLgU0ApmWszkBv0wvUc7CH8T
         g6PRjlSXnqobZ3CWuAKtYMOwfy7PhUNJ07bb8vNwgmyPP6Ns6YoM+Gx9T8ogIrJ2g9qj
         vQ70j1ZfdCkBTk0AndOs1cNJChQLQ5GWal/Wg5avzp/5N04/az0pJ/xOGXNdwT+GKlHH
         ZoR08LLjwmmsohQJ2/jifz1zQnEXQar+1It6kfSupa07p5Xm8sOXSl3EF3+8KiGnxoi5
         PLrGyaVV/5sX4GC3MzZo8XMS/8fx4WSHpaLwnD/dOl4q5XEDtDk0E/GGQ4DJ29oaAXAK
         nTSQ==
X-Gm-Message-State: ABy/qLY9veCJ/Yh3/HXvicCdIooFnzzeoU6fKI/oE30NbUv1TBivV7Xp
        9bMlZivNzP+sS33lL7N1oiWOCw==
X-Google-Smtp-Source: APBJJlFECgYh4ciyD3uPwT7v4rGJlK987lIDqpLvmusJiYpIMvGRPpg4IIVHsOfCIleUAJbqJQuqYQ==
X-Received: by 2002:a7b:c8cf:0:b0:3f9:b19c:aab4 with SMTP id f15-20020a7bc8cf000000b003f9b19caab4mr1163765wml.6.1690446676284;
        Thu, 27 Jul 2023 01:31:16 -0700 (PDT)
Received: from localhost (212-51-140-210.fiber7.init7.net. [212.51.140.210])
        by smtp.gmail.com with ESMTPSA id k17-20020a7bc311000000b003fc02218d6csm4024695wmj.25.2023.07.27.01.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:31:15 -0700 (PDT)
Date:   Thu, 27 Jul 2023 10:31:15 +0200
From:   Adam Sindelar <adam@wowsignal.io>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Adam Sindelar <ats@fb.com>,
        David Vernet <void@manifault.com>,
        Brendan Jackman <jackmanb@google.com>,
        KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH] libbpf: Expose API to consume one ring at a time
Message-ID: <ZMIrU0kQZElkUhAg@debian>
References: <20230725162654.912897-1-adam@wowsignal.io>
 <cb844776-9045-1b69-f1db-8ef7d75815b5@huaweicloud.com>
 <482ed32c-5650-54a5-d5bb-18b9bb03e838@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <482ed32c-5650-54a5-d5bb-18b9bb03e838@huaweicloud.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 02:17:12PM +0800, Hou Tao wrote:
> Hi,
> 
> On 7/27/2023 9:06 AM, Hou Tao wrote:
> > Hi,
> >
> > On 7/26/2023 12:26 AM, Adam Sindelar wrote:
> >> We already provide ring_buffer__epoll_fd to enable use of external
> >> polling systems. However, the only API available to consume the ring
> >> buffer is ring_buffer__consume, which always checks all rings. When
> >> polling for many events, this can be wasteful.
> >>
> >> Signed-off-by: Adam Sindelar <adam@wowsignal.io>
> >> ---
> >>  tools/lib/bpf/libbpf.h  |  1 +
> >>  tools/lib/bpf/ringbuf.c | 15 +++++++++++++++
> >>  2 files changed, 16 insertions(+)
> >>
> >> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> >> index 55b97b2087540..20ccc65eb3f9d 100644
> >> --- a/tools/lib/bpf/libbpf.h
> >> +++ b/tools/lib/bpf/libbpf.h
> >> @@ -1195,6 +1195,7 @@ LIBBPF_API int ring_buffer__add(struct ring_buffer *rb, int map_fd,
> >>  				ring_buffer_sample_fn sample_cb, void *ctx);
> >>  LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms);
> >>  LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
> >> +LIBBPF_API int ring_buffer__consume_ring(struct ring_buffer *rb, uint32_t ring_id);
> >>  LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
> >>  
> >>  struct user_ring_buffer_opts {
> >> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> >> index 02199364db136..8d087bfc7d005 100644
> >> --- a/tools/lib/bpf/ringbuf.c
> >> +++ b/tools/lib/bpf/ringbuf.c
> >> @@ -290,6 +290,21 @@ int ring_buffer__consume(struct ring_buffer *rb)
> >>  	return res;
> >>  }
> >>  
> >> +/* Consume available data from a single RINGBUF map identified by its ID.
> >> + * The ring ID is returned in epoll_data by epoll_wait when called with
> >> + * ring_buffer__epoll_fd.
> >> + */
> >> +int ring_buffer__consume_ring(struct ring_buffer *rb, uint32_t ring_id)
> >> +{
> >> +	struct ring *ring;
> >> +
> >> +	if (ring_id >= rb->ring_cnt)
> >> +		return libbpf_err(-EINVAL);
> >> +
> >> +	ring = &rb->rings[ring_id];
> >> +	return ringbuf_process_ring(ring);
> > When ringbuf_process_ring() returns an error, we need to use
> > libbpf_err() to set the errno accordingly.
> 
> It seems that even when ringbuf_process_ring() returns a positive
> result, we also need to cap it under INT_MAX, otherwise it may be cast
> into a negative error.

Ah, sorry I missed that. Fixed in v3, going out in a few moments.

> >> +}
> >> +
> >>  /* Poll for available data and consume records, if any are available.
> >>   * Returns number of records consumed (or INT_MAX, whichever is less), or
> >>   * negative number, if any of the registered callbacks returned error.
> >
> >
> > .
> 

Thanks!
