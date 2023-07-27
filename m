Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13384765F2E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 00:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjG0WTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 18:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjG0WTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:19:17 -0400
X-Greylist: delayed 488 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Jul 2023 15:19:16 PDT
Received: from out-105.mta1.migadu.com (out-105.mta1.migadu.com [IPv6:2001:41d0:203:375::69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C345C2D5E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:19:16 -0700 (PDT)
Message-ID: <38a585f1-fcbe-01ec-cc4c-63058b824f2f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690495866; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mDfxM8VujKA0wIuHAnqnppoIHUE5olFbUxZ3AXNPMug=;
        b=eezK/geLM39yIb2IZSaBX9LIa4JXiVFxgBkMOWQctySN+3cJ3G9hhPzSeh83R112J0Mfm9
        l6F7mVff9HVndFqSb269Tq53SvTHvSlsvKD+zeYqR4fq8/cCzC8aKgq+gRtYA5UV6s3iPY
        vuyx64MHaqy/AFSQeavD7E9cs+fvsVc=
Date:   Thu, 27 Jul 2023 15:11:00 -0700
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v4] libbpf: Expose API to consume one ring at a
 time
Content-Language: en-US
To:     Adam Sindelar <adam@wowsignal.io>, bpf@vger.kernel.org
Cc:     Adam Sindelar <ats@fb.com>, David Vernet <void@manifault.com>,
        Brendan Jackman <jackmanb@google.com>,
        KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Florent Revest <revest@chromium.org>
References: <20230727083436.293201-1-adam@wowsignal.io>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230727083436.293201-1-adam@wowsignal.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/23 1:34 AM, Adam Sindelar wrote:
> We already provide ring_buffer__epoll_fd to enable use of external
> polling systems. However, the only API available to consume the ring
> buffer is ring_buffer__consume, which always checks all rings. When
> polling for many events, this can be wasteful.
> 
> Signed-off-by: Adam Sindelar <adam@wowsignal.io>
> ---
> v1->v2: Added entry to libbpf.map
> v2->v3: Correctly set errno and handle overflow
> v3->v4: Fixed an embarrasing typo from zealous autocomplete
> 
>   tools/lib/bpf/libbpf.h   |  1 +
>   tools/lib/bpf/libbpf.map |  1 +
>   tools/lib/bpf/ringbuf.c  | 22 ++++++++++++++++++++++
>   3 files changed, 24 insertions(+)

Could you add a selftest to exercise ring_buffer__consume_ring()?
This way, people can better understand how this API could be used.

> 
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 55b97b2087540..20ccc65eb3f9d 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1195,6 +1195,7 @@ LIBBPF_API int ring_buffer__add(struct ring_buffer *rb, int map_fd,
>   				ring_buffer_sample_fn sample_cb, void *ctx);
>   LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms);
>   LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
> +LIBBPF_API int ring_buffer__consume_ring(struct ring_buffer *rb, uint32_t ring_id);
>   LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
>   
[...]
