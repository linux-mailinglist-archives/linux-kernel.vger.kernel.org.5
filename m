Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BA97DBABC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 14:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjJ3NaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 09:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbjJ3N37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 09:29:59 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728DAC6;
        Mon, 30 Oct 2023 06:29:57 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AF9C26732A; Mon, 30 Oct 2023 14:29:54 +0100 (CET)
Date:   Mon, 30 Oct 2023 14:29:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-tcp: Fix a memory leak
Message-ID: <20231030132954.GD21741@lst.de>
References: <f9420cde9afdc5af40bf8a8d5aa9184a9b5da729.1698614556.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9420cde9afdc5af40bf8a8d5aa9184a9b5da729.1698614556.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2023 at 10:22:57PM +0100, Christophe JAILLET wrote:
>  		if (ctype != TLS_RECORD_TYPE_DATA) {
>  			pr_err("queue %d: unhandled TLS record %d\n",
>  			       nvme_tcp_queue_id(queue), ctype);
> -			return -ENOTCONN;
> +			ret = -ENOTCONN;
> +			goto free_icresp;
>  		}
>  	}
>  	ret = -EINVAL;

I'd slightly prefer the code to be consistent how it assigns to err,
and use the style where it is assigned in the main path as with the
-EINVAL for the next checks.

Except for that this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
