Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E25C7E6D85
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbjKIPgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbjKIPgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:36:11 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8235E1BD;
        Thu,  9 Nov 2023 07:36:08 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4BBF667373; Thu,  9 Nov 2023 16:36:04 +0100 (CET)
Date:   Thu, 9 Nov 2023 16:36:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     John Garry <john.g.garry@oracle.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org, Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH 21/21] nvme: Support atomic writes
Message-ID: <20231109153603.GA2188@lst.de>
References: <20230929102726.2985188-1-john.g.garry@oracle.com> <20230929102726.2985188-22-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929102726.2985188-22-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +			if (le16_to_cpu(id->nabspf))
> +				boundary = (le16_to_cpu(id->nabspf) + 1) * bs;
> +
> +			if (is_power_of_2(boundary) || !boundary) {
> +				blk_queue_atomic_write_max_bytes(disk->queue, atomic_bs);
> +				blk_queue_atomic_write_unit_min_sectors(disk->queue, 1);
> +				blk_queue_atomic_write_unit_max_sectors(disk->queue,
> +									atomic_bs / bs);
> +				blk_queue_atomic_write_boundary_bytes(disk->queue, boundary);
> +			} else {
> +				dev_err(ns->ctrl->device, "Unsupported atomic boundary=0x%x\n",
> +					boundary);
> +			}

Please figure out a way to split the atomic configuration into a
helper and avoid all those crazy long lines,  preferable also avoid
the double calls to the block helpers as well while you're at it.

Also I really want a check in the NVMe I/O path that any request
with the atomic flag set actually adhers to the limits to at least
partially paper over the annoying lack of a separate write atomic
command in nvme.
