Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25117E50D7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 08:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbjKHHRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 02:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbjKHHRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 02:17:02 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31441711;
        Tue,  7 Nov 2023 23:17:00 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7588167373; Wed,  8 Nov 2023 08:16:56 +0100 (CET)
Date:   Wed, 8 Nov 2023 08:16:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] blk-core: use pr_warn_ratelimited() in bio_check_ro()
Message-ID: <20231108071655.GA4875@lst.de>
References: <20231107111247.2157820-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107111247.2157820-1-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 07:12:47PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> If one of the underlying disks of raid or dm is set to read-only, then
> each io will generate new log, which will cause message storm. This
> environment is indeed problematic, however we can't make sure our
> naive custormer won't do this, hence use pr_warn_ratelimited() to
> prevent message storm in this case.

Reducing the log spam sounds good, and I guess the single warning
would be even better.

That being said, why/how is the underlying device set to read-only?
If there is a good reason we should probably add a holder op to tell
the user about it so that it stop sending writes.

