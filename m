Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520E77CEC05
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjJRXaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJRXaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:30:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE448FA;
        Wed, 18 Oct 2023 16:30:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9306DC433C7;
        Wed, 18 Oct 2023 23:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697671807;
        bh=vsSM4qg1HgsRtYLsQXhJgkd01GgzpTXSKdRv/YTRBVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dGTjH2VwPd10ZCx8hGlCUzxI1kafr0HoJxgyE11uAcheNftnKpg0VfzCLH+wqFnSv
         AHObOrPU152pf6MbU44AExujn2gRRO9wVE4TZMOR5ApL1OSKL+hK8Y7h8htzWNwbeg
         d9yyLOnQZt9r8d+8aMbtU24R1StsipIKXFWvoIiRBQqC8P6i9h0P7DPGqBt6EA20+e
         1eOreH9ydaMx9fiBXwoHrsYwTG7MNDA5/Reptzt7owHYKXQpmlekQBd/A3pwVpNJQT
         ZjQHzdcjtTBCvue5uk2sz0mQTnd11uWj1JMnhS7s/l2FILampzkZOtD4aMzJmmn+X/
         ba5xGW2QhG8DA==
Date:   Wed, 18 Oct 2023 16:30:06 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     willy@infradead.org, hch@lst.de, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] iomap: fix short copy in iomap_write_iter()
Message-ID: <20231018233006.GK3195650@frogsfrogsfrogs>
References: <8762e91a210f4cc5713fce05fe5906c18513bd0a.1697617238.git.jstancek@redhat.com>
 <e1cb4f8981f8c6e7e0384e95faf1911d9937e979.1697647960.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1cb4f8981f8c6e7e0384e95faf1911d9937e979.1697647960.git.jstancek@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 08:32:32PM +0200, Jan Stancek wrote:
> Starting with commit 5d8edfb900d5 ("iomap: Copy larger chunks from
> userspace"), iomap_write_iter() can get into endless loop. This can
> be reproduced with LTP writev07 which uses partially valid iovecs:
>         struct iovec wr_iovec[] = {
>                 { buffer, 64 },
>                 { bad_addr, 64 },
>                 { buffer + 64, 64 },
>                 { buffer + 64 * 2, 64 },
>         };
> 
> commit bc1bb416bbb9 ("generic_perform_write()/iomap_write_actor():
> saner logics for short copy") previously introduced the logic, which
> made short copy retry in next iteration with amount of "bytes" it
> managed to copy:
> 
>                 if (unlikely(status == 0)) {
>                         /*
>                          * A short copy made iomap_write_end() reject the
>                          * thing entirely.  Might be memory poisoning
>                          * halfway through, might be a race with munmap,
>                          * might be severe memory pressure.
>                          */
>                         if (copied)
>                                 bytes = copied;
> 
> However, since 5d8edfb900d5 "bytes" is no longer carried into next
> iteration, because it is now always initialized at the beginning of
> the loop. And for iov_iter_count < PAGE_SIZE, "bytes" ends up with
> same value as previous iteration, making the loop retry same copy
> over and over, which leads to writev07 testcase hanging.
> 
> Make next iteration retry with amount of bytes we managed to copy.
> 
> Fixes: 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Looks fine to me, will send it out for testing...
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
> Changes in v2:
> - use goto instead of new variable (suggested by Christoph Hellwig)
> 
>  fs/iomap/buffered-io.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 5db54ca29a35..2bc0aa23fde3 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -881,8 +881,10 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  		size_t bytes;		/* Bytes to write to folio */
>  		size_t copied;		/* Bytes copied from user */
>  
> +		bytes = iov_iter_count(i);
> +retry:
>  		offset = pos & (chunk - 1);
> -		bytes = min(chunk - offset, iov_iter_count(i));
> +		bytes = min(chunk - offset, bytes);
>  		status = balance_dirty_pages_ratelimited_flags(mapping,
>  							       bdp_flags);
>  		if (unlikely(status))
> @@ -933,10 +935,12 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  			 * halfway through, might be a race with munmap,
>  			 * might be severe memory pressure.
>  			 */
> -			if (copied)
> -				bytes = copied;
>  			if (chunk > PAGE_SIZE)
>  				chunk /= 2;
> +			if (copied) {
> +				bytes = copied;
> +				goto retry;
> +			}
>  		} else {
>  			pos += status;
>  			written += status;
> -- 
> 2.31.1
> 
