Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6DB7DAE43
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 21:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjJ2UnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 16:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJ2UnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 16:43:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D17AB6;
        Sun, 29 Oct 2023 13:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7IIpjoWOpsvtx4X/Q+GqaCU4Rq449hxXA8ErAipodcg=; b=eV0FtAq/bYAwmv32+sCx0b0Qiu
        Ay6BIxPf1z5E6idphu0sY1nuio8giUHa3H/opfGCvsLGJOsj/gvJ+nA0kqZRgNHcZDi92icJd3GsY
        cClHrXRHbCZ7+DIhdWp3b7yoqkhZBCe+TylofpysGKeSrvd4WK0P9b5L9al9cqCcJqX17XKjUqNKV
        52FT5IBxDzd04eCedUpFV52D/7H16J3ygHTQ+y1hCiQgEIRUwvz1KvLVAdd6nwvE3aadKpIp9l8B8
        9gHZIoBlcOAkWyj+Je+d85H9WRmgJMGCShEOXnV+inmRLdLQOcy8MGO1m633fBIMEnzxr9seyButt
        XwBEDBFA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qxCcr-00Hb5n-SL; Sun, 29 Oct 2023 20:43:13 +0000
Date:   Sun, 29 Oct 2023 20:43:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Daniel Gomez <da.gomez@samsung.com>
Cc:     "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [RFC PATCH 00/11] shmem: high order folios support in write path
Message-ID: <ZT7D4bOTBWnaqAkN@casper.infradead.org>
References: <20230919135536.2165715-1-da.gomez@samsung.com>
 <CGME20231028211535eucas1p250e19444b8c973221b7cb9e8ab957da7@eucas1p2.samsung.com>
 <20231028211518.3424020-1-da.gomez@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028211518.3424020-1-da.gomez@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2023 at 09:15:34PM +0000, Daniel Gomez wrote:
> This series try to add support for high order folios in shmem write and
> fallocate paths when swap is disabled (noswap option). This is part of the
> Large Block Size (LBS) effort [1][2] and a continuation of the shmem work from
> Luis here [3] following Matthew Wilcox's suggestion [4] regarding the path to
> take for the folio allocation order calculation.

I don't see how this is part of the LBS effort.  shmem doesn't use a
block device.  swap might, but that's a separate problem, as you've
pointed out.
