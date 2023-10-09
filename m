Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B357BD63F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345911AbjJIJFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345728AbjJIJE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:04:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DA1112;
        Mon,  9 Oct 2023 02:04:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DC7C433C8;
        Mon,  9 Oct 2023 09:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696842285;
        bh=ExSTeG0S5N1PTLbbaSlmaXZRGf5NsQQSh7p1UChNEJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DtkLS4x3TILpdQvSob4UvXg4FKFvgI3Ua6vfjQQIT553zp+yfukNKLXMd9qy7IcI4
         kuF2Snnnf15yim0DE1N2tgN0Uri40cVnUmXvwQZWMRXNinUBevse07GvMqTrqNSbsv
         /eR3k8K2wLO/aRg+ril9lzuCtqOVleFIbIN9KXDHHniqFvSLlcvdclp2G3qh/LT62T
         j1DZZQ4aQ7jdSqJ1IKmMReKfWz8d3LGtebFumsgRHB4Guxa8H5Z8VGmtphAie3bPdy
         J7l8Npqv61QJjB4YYI6/P0KWHHYslVPmw06z4FGIAZAi263xRVdd9x6ZrhKPj5drr8
         wJR0mHsmopnpg==
Date:   Mon, 9 Oct 2023 12:03:51 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alejandro Colomar <alx@kernel.org>, Peter Xu <peterx@redhat.com>,
        linux-man@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] ioctl_userfaultfd.2: clarify the state of the
 uffdio_api structure on error
Message-ID: <20231009090351.GL3303@kernel.org>
References: <20230919190206.388896-1-axelrasmussen@google.com>
 <20230919190206.388896-9-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919190206.388896-9-axelrasmussen@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 12:02:04PM -0700, Axel Rasmussen wrote:
> The old FIXME noted that the zeroing was done to differentiate the two
> EINVAL cases. It's possible something like this was true historically,
> but in current Linux we zero it in *both* EINVAL cases, so this is at
> least no longer true.
> 
> After reading the code, I can't determine any clear reason why we zero
> it in some cases but not in others. So, some simple advice we can give
> userspace is: if an error occurs, treat the contents of the structure as
> unspecified. Just re-initialize it before retrying UFFDIO_API again.

In old kernels (e.g. 4.20 and I didn't go to check when this changed) we
had two -EINVALS: one when UFFDIO_API was called when

	state != UFFD_STATE_WAIT_API

and another for API version or features mismatch and we
zeroed uffd_api struct only in the second case.

In the current code the first case does not exits anymore.

> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  man2/ioctl_userfaultfd.2 | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> index 1aa9654be..29dca1f6b 100644
> --- a/man2/ioctl_userfaultfd.2
> +++ b/man2/ioctl_userfaultfd.2
> @@ -272,6 +272,14 @@ operation returns 0 on success.
>  On error, \-1 is returned and
>  .I errno
>  is set to indicate the error.
> +If an error occurs,
> +the kernel may zero the provided
> +.I uffdio_api
> +structure.
> +The caller should treat its contents as unspecified,
> +and reinitialize it before re-attempting another
> +.B UFFDIO_API
> +call.
>  Possible errors include:
>  .TP
>  .B EFAULT
> @@ -305,14 +313,6 @@ twice,
>  the first time with no features set,
>  is explicitly allowed
>  as per the two-step feature detection handshake.
> -.\" FIXME In the above error case, the returned 'uffdio_api' structure is
> -.\" zeroed out. Why is this done? This should be explained in the manual page.
> -.\"
> -.\" Mike Rapoport:
> -.\"     In my understanding the uffdio_api
> -.\"     structure is zeroed to allow the caller
> -.\"     to distinguish the reasons for -EINVAL.
> -.\"
>  .SS UFFDIO_REGISTER
>  (Since Linux 4.3.)
>  Register a memory address range with the userfaultfd object.
> -- 
> 2.42.0.459.ge4e396fd5e-goog
> 
> 

-- 
Sincerely yours,
Mike.
