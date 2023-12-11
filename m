Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF33980D314
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344190AbjLKRAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjLKRAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:00:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4BFB3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XQL4KLYK46FBcvS2Q/hWsRZjCkcrPdKFGKmtrMsbgdc=; b=h/IzyEDXFu6U8tWkhAzL4uzmOt
        PM9PoWDLlm+5uSEnp9Ch6iGufZCzFHD7XntJ87pW50FC9PQ4B3ltyjcZMfevYhIKk7H6cHnbnscpI
        aQDHqgFgsPQWLm8aLLRwDdo3fM7NhVeuXBL/lBaHoPNYssz2RzDlKUUKjBD8RF/pRX6TTjlKJM+Ri
        CLcpGOWp3Qcs5dBM6LS1lh33zSokbjzTfXX0CaeyTi/wFKQZwv5WSrURfN7Zwm51gH6eG38Qb2LZU
        xIENm+1OIbEIHtkXBz7Cg8WD3stbmlhwFpOvAuIil6Ta9qevjE1wZ16eXlZnBlPXX+hhgar7nefby
        B2/s9q+A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1rCje6-00924L-VK; Mon, 11 Dec 2023 17:00:43 +0000
Date:   Mon, 11 Dec 2023 17:00:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        souravpanda@google.com
Subject: Re: [PATCH] vmstat: don't auto expand the sysfs files
Message-ID: <ZXdAOroKNce1r+TZ@casper.infradead.org>
References: <20231211154644.4103495-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211154644.4103495-1-pasha.tatashin@soleen.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 03:46:44PM +0000, Pasha Tatashin wrote:
> +++ b/drivers/base/node.c
> @@ -520,26 +520,34 @@ static ssize_t node_read_vmstat(struct device *dev,
>  	int i;
>  	int len = 0;
>  
> -	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
> -		len += sysfs_emit_at(buf, len, "%s %lu\n",
> -				     zone_stat_name(i),
> -				     sum_zone_node_page_state(nid, i));
> +	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
> +		if (vmstat_text[ZONE_STAT_NAME_IDX(i)].flags & VMSTAT_SHOW_SYSFS) {
> +			len += sysfs_emit_at(buf, len, "%s %lu\n",
> +					     zone_stat_name(i),
> +					     sum_zone_node_page_state(nid, i));
> +		}
> +	}

This seems overly complicated.  Why not do:

	for (i = 0; i < NR_VM_ZONE_STAT_SYSFS_ITEMS; i++)

and have assertions that this number doesn't change (and require people
to add to the list after that point)?
