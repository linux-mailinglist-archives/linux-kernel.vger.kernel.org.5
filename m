Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07458811A2B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjLMQzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbjLMQza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:55:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6AAAC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6C+G+He17NccpRYXyvfr/RRpub5+8DDVn1CdeNstsjM=; b=eMShkFmEwwZe5F929p52bl4FOD
        CvbkWqFICiRnUUQ1L//RWI2/P+5TDUv56GmEj4i+95Nj9pWhwp/2RoOLS0MxofbBB4waUmwKHwaHN
        LwsuQ5EtxnSmzd04hX7iyhhjz252+MtHuP1bq512XRDW+lIkoqFAwRZi+v1H+hgV5ldaKBzUxpDuz
        KEXf2wwntJZbJtQhnH85vu/dp4kfYJqSvdPYD0jN/DShb1Nr8aEzy5/ITthEmGObyXHmJjR6RlMi2
        GSZyllH0Swb0VsZ/MWVlpCb+puMSougMmcBgJyQb7yqH3NA5tL6iYP6RHmFQ9Tt0H64UUxeHpNEfz
        GCJfbewQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rDSWB-00FWGw-0R;
        Wed, 13 Dec 2023 16:55:31 +0000
Date:   Wed, 13 Dec 2023 08:55:31 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Saeed Mahameed <saeed@kernel.org>
Cc:     Aron Silverton <aron.silverton@oracle.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <ZXniAwBwtF5hmOuq@infradead.org>
References: <20231128175224.GR436702@nvidia.com>
 <20231128103304.25c2c642@kernel.org>
 <ZWZJGF7moDM_k6TU@x130>
 <2023112922-lyricist-unclip-8e78@gregkh>
 <oxtcvxwbj2hzv4lxnxubo3hoxn7diyzhm2oj3tsw2toxbc3og4@ddglhm6r3oa5>
 <20231204185210.030a72ca@kernel.org>
 <fgalnohzpiox7rvsf3wsurkf2x3rdtyhwqq5tk43gesvjlw6yl@i7colkh2sx5h>
 <20231205204855.52fa5cc1@kernel.org>
 <kakenvblxlgrkjvcrwfflnkm6n5fpxgr4qifwkdttjascth3te@57us7mblobjz>
 <ZXIUysBgNWWZHe0z@x130>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXIUysBgNWWZHe0z@x130>
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

On Thu, Dec 07, 2023 at 10:54:02AM -0800, Saeed Mahameed wrote:
> Also I would like to repeat, this is not touching netdev, netdev's policies
> do not apply to the greater kernel or RDMA, and we have use cases with
> pure-infiniband/DPU/FPGA cards that have no netdev at all, or other cases
> with pur virtio instances, and much more.

Yes.  I mean just about every complex block driver has some kind of
vendor spcific tooling for debugging, statistics, etc.  Trying to deny
it just because one function expose by a device is a network device is
even more silly than disallowing it for pure net devices (which already
tend to be complex beasts).
