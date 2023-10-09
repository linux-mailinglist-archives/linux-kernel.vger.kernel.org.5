Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B32F7BD661
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345547AbjJIJKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbjJIJKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:10:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC95A3;
        Mon,  9 Oct 2023 02:10:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41527C433C7;
        Mon,  9 Oct 2023 09:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696842645;
        bh=f5CUYsknjVmhnuTqhXtkJxqt3bb4YSHlTfNzYrnpBuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fz+BE5xuLV3Yh0jSKKwKBi28SNwZP6ko5HrzaOLCMXAY3v0jAslsCOFIJyBQlOWa3
         3+peKOxVHoeX+jBrhdicviDhC3uZ9e58+jIh5tCIfOXjup1W5xSe02ogt/NWiBvoB9
         tVz/7Vc6CvgLRNXOevRFKX7Tlkqzps/0zBUYC/cpIPJdMHL79vvx8zhneWLsOcdBti
         /vT5vOdZKJndel926GduNNEBI0b4yt/VyEOv+oNBZDmdZZHRAe0lWV7MoMIkJUH71Y
         YJ5YUnvafWnMJpU8TCmbEQguN6pCHXUYQRb5LGiO9E80bB5pQ4pU5/Aa9QJ3uDq09b
         ygzDjga+86edw==
Date:   Mon, 9 Oct 2023 12:09:51 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alejandro Colomar <alx@kernel.org>, Peter Xu <peterx@redhat.com>,
        linux-man@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] ioctl_userfaultfd.2: document new UFFDIO_POISON
 ioctl
Message-ID: <20231009090951.GM3303@kernel.org>
References: <20230919190206.388896-1-axelrasmussen@google.com>
 <20230919190206.388896-11-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919190206.388896-11-axelrasmussen@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 12:02:06PM -0700, Axel Rasmussen wrote:
> This is a new feature recently added to the kernel. So, document the new
> ioctl the same way we do other UFFDIO_* ioctls.
> 
> Also note the corresponding new ioctl flag we can return in reponse to a
> UFFDIO_REGISTER call.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

With a small correction 

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  man2/ioctl_userfaultfd.2 | 112 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
> 
> diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> index afe3caffc..1282f63e1 100644
> --- a/man2/ioctl_userfaultfd.2
> +++ b/man2/ioctl_userfaultfd.2
> @@ -405,6 +405,11 @@ operation is supported.
>  The
>  .B UFFDIO_CONTINUE
>  operation is supported.
> +.TP
> +.B 1 << _UFFDIO_POISON
> +The
> +.B UFFDIO_POISON
> +operation is supported.
>  .PP
>  This
>  .BR ioctl (2)
> @@ -916,6 +921,113 @@ The faulting process has exited at the time of a
>  .B UFFDIO_CONTINUE
>  operation.
>  .\"
> +.SS UFFDIO_POISON
> +(Since Linux 6.6.)
> +Mark an address range as "poisoned".
> +Future accesses to these addresses will raise a
> +.B SIGBUS
> +signal.
> +Unlike
> +.B MADV_HWPOISON
> +this works by installing page table entries,
> +rather than "really" poisoning the underlying physical pages.
> +This means it only affects this particular address space.
> +.PP
> +The
> +.I argp
> +argument is a pointer to a
> +.I uffdio_continue

Did you mean uffdio_poison? 

> +structure as shown below:
> +.PP
> +.in +4n
> +.EX
> +struct uffdio_poison {
> +	struct uffdio_range range;
> +	                /* Range to install poison PTE markers in */
> +	__u64 mode;     /* Flags controlling the behavior of poison */
> +	__s64 updated;  /* Number of bytes poisoned, or negated error */
> +};
> +.EE
> +.in
> +.PP
> +The following value may be bitwise ORed in
> +.I mode
> +to change the behavior of the
> +.B UFFDIO_POISON
> +operation:
> +.TP
> +.B UFFDIO_POISON_MODE_DONTWAKE
> +Do not wake up the thread that waits for page-fault resolution.
> +.PP
> +The
> +.I updated
> +field is used by the kernel
> +to return the number of bytes that were actually poisoned,
> +or an error in the same manner as
> +.BR UFFDIO_COPY .
> +If the value returned in the
> +.I updated
> +field doesn't match the value that was specified in
> +.IR range.len ,
> +the operation fails with the error
> +.BR EAGAIN .
> +The
> +.I updated
> +field is output-only;
> +it is not read by the
> +.B UFFDIO_POISON
> +operation.
> +.PP
> +This
> +.BR ioctl (2)
> +operation returns 0 on success.
> +In this case,
> +the entire area was poisoned.
> +On error, \-1 is returned and
> +.I errno
> +is set to indicate the error.
> +Possible errors include:
> +.TP
> +.B EAGAIN
> +The number of bytes mapped
> +(i.e., the value returned in the
> +.I updated
> +field)
> +does not equal the value that was specified in the
> +.I range.len
> +field.
> +.TP
> +.B EINVAL
> +Either
> +.I range.start
> +or
> +.I range.len
> +was not a multiple of the system page size; or
> +.I range.len
> +was zero; or the range specified was invalid.
> +.TP
> +.B EINVAL
> +An invalid bit was specified in the
> +.I mode
> +field.
> +.TP
> +.B EEXIST
> +One or more pages were already mapped in the given range.
> +.TP
> +.B ENOENT
> +The faulting process has changed its virtual memory layout simultaneously with
> +an outstanding
> +.B UFFDIO_POISON
> +operation.
> +.TP
> +.B ENOMEM
> +Allocating memory for page table entries failed.
> +.TP
> +.B ESRCH
> +The faulting process has exited at the time of a
> +.B UFFDIO_POISON
> +operation.
> +.\"
>  .SH RETURN VALUE
>  See descriptions of the individual operations, above.
>  .SH ERRORS
> -- 
> 2.42.0.459.ge4e396fd5e-goog
> 
> 

-- 
Sincerely yours,
Mike.
