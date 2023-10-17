Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6A37CBA8E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 08:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbjJQGJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 02:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJQGJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 02:09:13 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76D3B0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 23:09:12 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 74C5868BFE; Tue, 17 Oct 2023 08:09:08 +0200 (CEST)
Date:   Tue, 17 Oct 2023 08:09:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mark O'Donovan <shiftee@posteo.net>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, kbusch@kernel.org,
        hare@suse.de, Akash Appaiah <Akash.Appaiah@dell.com>
Subject: Re: [PATCH v3 1/3] nvme-auth: alloc nvme_dhchap_key as single
 buffer
Message-ID: <20231017060908.GA8454@lst.de>
References: <20231016225857.3085234-1-shiftee@posteo.net> <20231016225857.3085234-2-shiftee@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016225857.3085234-2-shiftee@posteo.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +struct nvme_dhchap_key *nvme_auth_alloc_key(u32 len, u8 hash)
> +{
> +	struct nvme_dhchap_key *key = kzalloc(len + sizeof(*key), GFP_KERNEL);

This should use the struct_size() helper:

	key = kzalloc(struct_size(key, key, len), GFP_KERNEL);

Otherwise the change looks good.
