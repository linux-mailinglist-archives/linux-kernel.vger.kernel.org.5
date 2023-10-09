Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D97F7BD58F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345500AbjJIIqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbjJIIqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:46:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6BCC6;
        Mon,  9 Oct 2023 01:46:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE388C433C8;
        Mon,  9 Oct 2023 08:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696841167;
        bh=4JrSlnFr9jjlqFcYvnhKELkzAZe3psc0YA2wC2PKOoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I3dYy1KomBSg0N9OvWTjDui2Y1tQMe7OST9cx1fomAEBxV+T20YbIhUfr00Ltj/Fv
         z6O6wbeW7l/Kz/OOjV767mm4YCH+CWEIvnYxhaMP8d6gYPNkvR+ljrdHTeuNYpJA+W
         bS590m9NLNyocu3hYh+nm45GHLd2maO6Y2J4rWrvG3dIJDZ1bgssCVeCx6Mt4M2kER
         uMINcw/qr1FRSysxG0LSAt9s2J3DMMJbmqpTQmzuUVL1p3+sBFkfTnevlYdH1ENUzg
         gyf+JnKauI/45Q6IXB3bEvHYs7oKuB9wwqXXnha836ZxFxbemRHLTf/rBLIiH0Qa5R
         h8jN+Dkhfhh+g==
Date:   Mon, 9 Oct 2023 11:45:14 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alejandro Colomar <alx@kernel.org>, Peter Xu <peterx@redhat.com>,
        linux-man@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] ioctl_userfaultfd.2: describe missing UFFDIO_API
 feature flags
Message-ID: <20231009084514.GJ3303@kernel.org>
References: <20230919190206.388896-1-axelrasmussen@google.com>
 <20230919190206.388896-7-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919190206.388896-7-axelrasmussen@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 12:02:02PM -0700, Axel Rasmussen wrote:
> Several new features have been added to the kernel recently, and the man
> page wasn't updated to describe these new features. So, add in
> descriptions of any missing features.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

with a small nit below

> ---
>  man2/ioctl_userfaultfd.2 | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> index e91a1dfc8..53b1f473f 100644
> --- a/man2/ioctl_userfaultfd.2
> +++ b/man2/ioctl_userfaultfd.2
> @@ -204,6 +204,13 @@ If this feature bit is set,
>  .I uffd_msg.pagefault.feat.ptid
>  will be set to the faulted thread ID for each page-fault message.
>  .TP
> +.BR UFFD_FEATURE_PAGEFAULT_FLAG_WP " (since Linux 5.10)"
> +If this feature bit is set,
> +userfaultfd supports write-protect faults
> +for anonymous memory.
> +(Note that shmem / hugetlbfs support
> +is indicated by a separate feature.)
> +.TP
>  .BR UFFD_FEATURE_MINOR_HUGETLBFS " (since Linux 5.13)"
>  If this feature bit is set,
>  the kernel supports registering userfaultfd ranges
> @@ -221,6 +228,22 @@ will be set to the exact page-fault address that was reported by the hardware,
>  and will not mask the offset within the page.
>  Note that old Linux versions might indicate the exact address as well,
>  even though the feature bit is not set.
> +.TP
> +.BR UFFD_FEATURE_WP_HUGETLBFS_SHMEM " (since Linux 5.19)"
> +If this feature bit is set,
> +userfaultfd supports write-protect faults
> +for hugetlbfs and shmem / tmpfs memory.
> +.TP
> +.BR UFFD_FEATURE_WP_UNPOPULATED " (since Linux 6.4)"
> +If this feature bit is set,
> +the kernel will handle anonymous memory the same way as file memory,
> +by allowing the user to write-protect unpopulated ptes.

Nit: s/ptes/page table entries/

> +.TP
> +.BR UFFD_FEATURE_POISON " (since Linux 6.6)"
> +If this feature bit is set,
> +the kernel supports resolving faults with the
> +.B UFFDIO_POISON
> +ioctl.
>  .PP
>  The returned
>  .I ioctls
> -- 
> 2.42.0.459.ge4e396fd5e-goog
> 
> 

-- 
Sincerely yours,
Mike.
