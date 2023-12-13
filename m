Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C350810CCE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 09:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjLMIxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 03:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjLMIxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 03:53:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A97AC;
        Wed, 13 Dec 2023 00:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qz0UdSoKEx8DKiO3JaKHyhacTW1PxqeO0PZEU64Vnco=; b=0N7VFaF+09920+5bY2hyGOj5cw
        6z9ZbQDHBaGCrSSS07b9CV20jXslGu76PsFQzZDLbWIWrsecXY61B82L02FQbq376aKZjGrZFAavS
        RpLIHp3FQELsUxkQqlSt7AW6PrC0LQR5Di0w9uPe4wbVEt4iLnk6IOZFztHHctA/1zi+sFJcB9x9C
        Q/KwtgwzGLn7muXC2BqSjcXCz+YkHh3kc/3fTpMeRP9cKb4dtKSVaU3/4HhVDzVD2SpzGYOo3xky+
        Phr+9nhlzDvYG2oJn48gG9oQaRZ4ANLPklhj7LcA0+gKyrH9u6b3YusJIOmPt3WsbbzVvdPFAt182
        FOa1pqIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rDKzJ-00E5YK-2i;
        Wed, 13 Dec 2023 08:53:05 +0000
Date:   Wed, 13 Dec 2023 00:53:05 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] btrfs: factor out block mapping for RAID5/6
Message-ID: <ZXlw8Ux/HJBSKl1M@infradead.org>
References: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
 <20231212-btrfs_map_block-cleanup-v1-8-b2d954d9a55b@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-btrfs_map_block-cleanup-v1-8-b2d954d9a55b@wdc.com>
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

> +static void map_blocks_for_raid56(struct btrfs_chunk_map *map,
> +				  enum btrfs_map_op op,
> +				  struct btrfs_io_geometry *io_geom,
> +				  u64 logical, u64 *length)
> +{
> +	int data_stripes = nr_data_stripes(map);
> +
> +	if (op != BTRFS_MAP_READ || io_geom->mirror_num > 1) {

Any reason to not have separate read/write helpers here given that
they don't really share anything?

