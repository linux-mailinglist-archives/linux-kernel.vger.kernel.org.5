Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3C47E81D4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjKJSh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345062AbjKJSey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:34:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26EA76AF;
        Thu,  9 Nov 2023 22:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6dqdlP6AxTKMdU01n11JFGLaHz+ZMH6iLEES/JhpcoI=; b=g8BgUbS8v3nwxx7xg+ggb+VBMM
        Ssr7GN17YWFa7BYF2o8RsuocbEVVPSGrluBypv/KAgOaGHba6nwG7d/r/uHoV52lOvtM9PX0g9ptN
        EJkP7arbniWJ8ZWUzRqciozisg/jdXTJgUS5mvXmw60HRvjqgEcdJoJ/eGOFoPFGr0Z9suV33wQhj
        k3EYVpeWFsKKNARTn8G95q1ttJiEdR4FGaxgy9uqe5WFdVzdInzmO05bkYQ9736/K428MxJNZZqOb
        Te+xbgbmOox63eDUx3Sc31DZiYNrU3bc4QAZr92yIPqp3HP5o2+nIZU+X1jhrDjV4Y+AJcgsPSbYL
        1sf59gng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r1L8J-007yZG-1y;
        Fri, 10 Nov 2023 06:36:47 +0000
Date:   Thu, 9 Nov 2023 22:36:47 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     ed.tsai@mediatek.com
Cc:     ming.lei@redhat.com, hch@lst.de, Jens Axboe <axboe@kernel.dk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        wsd_upstream@mediatek.com, chun-hung.wu@mediatek.com,
        casper.li@mediatek.com, will.shiu@mediatek.com,
        light.hsieh@mediatek.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] block: limit the extract size to align queue limit
Message-ID: <ZU3Pf0o2RCZ+dGNa@infradead.org>
References: <20231110051950.21972-1-ed.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110051950.21972-1-ed.tsai@mediatek.com>
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

On Fri, Nov 10, 2023 at 01:19:49PM +0800, ed.tsai@mediatek.com wrote:
> +	if (bdev && blk_queue_pci_p2pdma(bdev->bd_disk->queue))
>  		extraction_flags |= ITER_ALLOW_P2PDMA;

As pointed out in reply to Ming, you really need to first figure out
if we can assume we have a valid bdev or not, and if not pass all the
relevant information separately.

> +	if (bdev && bio_op(bio) != REQ_OP_ZONE_APPEND) {
> +		unsigned int max = queue_max_bytes(bdev_get_queue(bdev));

The higher level code must not look at queue_max_bytes, that is only
used for splitting and might not even be initialized.
