Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44400810CC5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 09:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjLMIux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 03:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjLMIuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 03:50:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3650B7;
        Wed, 13 Dec 2023 00:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VsEFfbXYkoEiyCW2AjPqmE6JGQ/NnRAbJd6BX+OhLPk=; b=z+/71fcKw5r2E+N+ihmNs5HSEc
        04Pl7NkpysRUp4baIDPUaVi46NzGq8+EUuO4jQ5xsBtRzwgQ5+wN1kIMOG/8BBA46Q28I4azn8oou
        RoftrV8TAlcJ7kb9aGOOFjVaZnUKo0n0lp2ib4acoa4gXXXEdWBj56EKW/rlLjnCiSMAHPoX0qtM2
        HlaErUGqF6MvNpFr9+m5JA3INKoIwPc7vWzeLrIhLe6kWQdWw6LSM9T3HYszgevThamw2oZTSjThu
        EoxIE0gZeY9Z6pCLzx+h7HnJr9jSGfNK7WNvvNfkiXKz/YttEfUQ5GRJIgHGIBGqxG2nYhxeOuw0v
        O9ohzDvA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rDKxC-00E5Ke-1f;
        Wed, 13 Dec 2023 08:50:54 +0000
Date:   Wed, 13 Dec 2023 00:50:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] btrfs: factor out block-mapping for RAID0
Message-ID: <ZXlwbjflk9EwEE7A@infradead.org>
References: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
 <20231212-btrfs_map_block-cleanup-v1-3-b2d954d9a55b@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-btrfs_map_block-cleanup-v1-3-b2d954d9a55b@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static void map_blocks_for_raid0(struct btrfs_chunk_map *map,

I'd skip the _for here as it is a bit redundant.

> +				 enum btrfs_map_op op,

Looking at all the patches: shouldn't the op also go into the
btrfs_io_geometry structure?

