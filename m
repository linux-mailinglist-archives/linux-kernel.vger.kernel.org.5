Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B827E6CE6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbjKIPKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjKIPKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:10:20 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466E52D62;
        Thu,  9 Nov 2023 07:10:18 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3068167373; Thu,  9 Nov 2023 16:10:14 +0100 (CET)
Date:   Thu, 9 Nov 2023 16:10:13 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     John Garry <john.g.garry@oracle.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH 01/21] block: Add atomic write operations to
 request_queue limits
Message-ID: <20231109151013.GA32432@lst.de>
References: <20230929102726.2985188-1-john.g.garry@oracle.com> <20230929102726.2985188-2-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230929102726.2985188-2-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 10:27:06AM +0000, John Garry wrote:
> From: Himanshu Madhani <himanshu.madhani@oracle.com>
> 
> Add the following limits:
> - atomic_write_boundary_bytes
> - atomic_write_max_bytes
> - atomic_write_unit_max_bytes
> - atomic_write_unit_min_bytes
> 
> All atomic writes limits are initialised to 0 to indicate no atomic write
> support. Stacked devices are just not supported either for now.
> 
> Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> #jpg: Heavy rewrite
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  Documentation/ABI/stable/sysfs-block | 42 +++++++++++++++++++
>  block/blk-settings.c                 | 60 ++++++++++++++++++++++++++++
>  block/blk-sysfs.c                    | 33 +++++++++++++++
>  include/linux/blkdev.h               | 33 +++++++++++++++
>  4 files changed, 168 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> index 1fe9a553c37b..05df7f74cbc1 100644
> --- a/Documentation/ABI/stable/sysfs-block
> +++ b/Documentation/ABI/stable/sysfs-block
> @@ -21,6 +21,48 @@ Description:
>  		device is offset from the internal allocation unit's
>  		natural alignment.
>  
> +What:		/sys/block/<disk>/atomic_write_max_bytes
> +Date:		May 2023
> +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> +Description:
> +		[RO] This parameter specifies the maximum atomic write
> +		size reported by the device. An atomic write operation
> +		must not exceed this number of bytes.

> +What:		/sys/block/<disk>/atomic_write_unit_max_bytes
> +Date:		January 2023
> +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> +Description:
> +		[RO] This parameter defines the largest block which can be
> +		written atomically with an atomic write operation. This
> +		value must be a multiple of atomic_write_unit_min and must
> +		be a power-of-two.

What is the difference between these two values?


> +Date:		May 2023
> +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> +Description:
> +		[RO] This parameter specifies the smallest block which can
> +		be written atomically with an atomic write operation. All
> +		atomic write operations must begin at a
> +		atomic_write_unit_min boundary and must be multiples of
> +		atomic_write_unit_min. This value must be a power-of-two.

How can the minimum unit be anythіng but one logical block?

> +extern void blk_queue_atomic_write_max_bytes(struct request_queue *q,
> +					     unsigned int bytes);

Please don't add pointless externs to prototypes in headers.

> +static inline unsigned int queue_atomic_write_unit_max_bytes(const struct request_queue *q)

.. and please avoid the overly long lines.

