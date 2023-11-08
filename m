Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA637E50DC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 08:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbjKHHTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 02:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbjKHHTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 02:19:31 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF3010F9;
        Tue,  7 Nov 2023 23:19:29 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6680D6732D; Wed,  8 Nov 2023 08:19:25 +0100 (CET)
Date:   Wed, 8 Nov 2023 08:19:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Li Lingfeng <lilingfeng@huaweicloud.com>
Cc:     josef@toxicpanda.com, linux-kernel@vger.kernel.org, hch@lst.de,
        linux-block@vger.kernel.org, nbd@other.debian.org, axboe@kernel.dk,
        chaitanya.kulkarni@wdc.com, yukuai1@huaweicloud.com,
        houtao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        lilingfeng3@huawei.com
Subject: Re: [PATCH v2] nbd: fix uaf in nbd_open
Message-ID: <20231108071925.GB4875@lst.de>
References: <20231107103435.2074904-1-lilingfeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107103435.2074904-1-lilingfeng@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think this is actually enough on it's own.  You'll also
need to move al the teardown logic that is currently in
nbd_dev_remove.  And with this you should be able to remove the
NULL check in nbd_open, and propably the nbd_index_mutex critical
section.  Although that'll need a very careful audit.
