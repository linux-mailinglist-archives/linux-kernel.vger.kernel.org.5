Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072CB77F576
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350392AbjHQLmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350389AbjHQLlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:41:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B4510C0;
        Thu, 17 Aug 2023 04:41:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09F066395C;
        Thu, 17 Aug 2023 11:41:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2ABC433C7;
        Thu, 17 Aug 2023 11:41:39 +0000 (UTC)
Message-ID: <5f4a78e7-91dc-4d82-c46f-866f3492b674@xs4all.nl>
Date:   Thu, 17 Aug 2023 13:41:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] media: vb2: frame_vector.c: replace WARN_ONCE with a
 comment
Content-Language: en-US, nl
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <d5e1ee76-75b3-26cb-23ae-cf6ab40597b7@xs4all.nl>
In-Reply-To: <d5e1ee76-75b3-26cb-23ae-cf6ab40597b7@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2023 12:41, Hans Verkuil wrote:
> The WARN_ONCE was issued also in cases that had nothing to do with VM_IO
> (e.g. if the start address was just a random value and uaccess fails with
> -EFAULT).
> 
> There are no reports of WARN_ONCE being issued for actual VM_IO cases, so
> just drop it and instead add a note to the comment before the function.
> 
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

I forgot to add:

Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>


> ---
> diff --git a/drivers/media/common/videobuf2/frame_vector.c b/drivers/media/common/videobuf2/frame_vector.c
> index 0f430ddc1f67..fd87747be9b1 100644
> --- a/drivers/media/common/videobuf2/frame_vector.c
> +++ b/drivers/media/common/videobuf2/frame_vector.c
> @@ -31,6 +31,10 @@
>   * different type underlying the specified range of virtual addresses.
>   * When the function isn't able to map a single page, it returns error.
>   *
> + * Note that get_vaddr_frames() cannot follow VM_IO mappings. It used
> + * to be able to do that, but that could (racily) return non-refcounted
> + * pfns.
> + *
>   * This function takes care of grabbing mmap_lock as necessary.
>   */
>  int get_vaddr_frames(unsigned long start, unsigned int nr_frames, bool write,
> @@ -59,8 +63,6 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames, bool write,
>  	if (likely(ret > 0))
>  		return ret;
> 
> -	/* This used to (racily) return non-refcounted pfns. Let people know */
> -	WARN_ONCE(1, "get_vaddr_frames() cannot follow VM_IO mapping");
>  	vec->nr_frames = 0;
>  	return ret ? ret : -EFAULT;
>  }
> 

