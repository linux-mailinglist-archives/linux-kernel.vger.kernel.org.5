Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B04B7F3470
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbjKURDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjKURDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:03:34 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0EF12C;
        Tue, 21 Nov 2023 09:03:30 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9D72267373; Tue, 21 Nov 2023 18:03:27 +0100 (CET)
Date:   Tue, 21 Nov 2023 18:03:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 2/5] btrfs: zoned: don't clear dirty flag of extent
 buffer
Message-ID: <20231121170327.GB19695@lst.de>
References: <20231121-josef-generic-163-v1-0-049e37185841@wdc.com> <20231121-josef-generic-163-v1-2-049e37185841@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121-josef-generic-163-v1-2-049e37185841@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  	if (test_bit(EXTENT_BUFFER_CANCELLED, &eb->bflags)) {
> -		WARN_ON_ONCE(found_start != 0);
> +		memzero_extent_buffer(eb, 0, eb->len);
>  		return BLK_STS_OK;

> +	if (btrfs_is_zoned(fs_info)) {
> +		set_bit(EXTENT_BUFFER_CANCELLED, &eb->bflags);
> +		return;
> +	}

Maybe these two places would benefit from comments on why the buffer
is just marked as cancelled and zeroed out (that is to keep the
write order because block numbers are already assigned)?

Otherwise this looks great:

Reviewed-by: Christoph Hellwig <hch@lst.de>
