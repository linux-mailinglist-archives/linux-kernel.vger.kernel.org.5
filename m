Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE6B7E4615
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbjKGQd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjKGQdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:33:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AAD2711
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 08:32:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0281EC433C8;
        Tue,  7 Nov 2023 16:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1699374745;
        bh=AePIgCWA1HUB2K2O8lYo+JWrk2IOpVUkPLhVIZjxpTY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zZ/3bmoZkPagTKjZTznZsZyM23cMbhjZaKU6rx3dRCKCIFJVdT8X7ZjbLciNJ/iXU
         vMDR5O67cBwGOUBP61sidc6o2cWgt2T8XpFER14R6qHjUCfd0dW+jgyDZHDalBHqVr
         IVNwwizIdiVvFrvlchnTU/qP3E6X9gd7UXvUw4zg=
Date:   Tue, 7 Nov 2023 08:32:24 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     zhaimingbing <zhaimingbing@cmss.chinamobile.com>
Cc:     rdunlap@infradead.org, James.Bottomley@hansenpartnership.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm:hugetlb_cgroup: Fix the wrong format specifier
Message-Id: <20231107083224.cf5ca5fd48ca222c1315b4d0@linux-foundation.org>
In-Reply-To: <20231106082723.8728-1-zhaimingbing@cmss.chinamobile.com>
References: <20231106082723.8728-1-zhaimingbing@cmss.chinamobile.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Nov 2023 16:27:23 +0800 zhaimingbing <zhaimingbing@cmss.chinamobile.com> wrote:

> The long type should use "%ld" instead of "%lu".
> 
> ...
>
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -696,7 +696,7 @@ static int __hugetlb_events_show(struct seq_file *seq, bool local)
>  	else
>  		max = atomic_long_read(&h_cg->events[idx][HUGETLB_MAX]);
>  
> -	seq_printf(seq, "max %lu\n", max);
> +	seq_printf(seq, "max %ld\n", max);
>  
>  	return 0;
>  }

Well.  We can't have a negative number of events.  If we had an
atomic_ulong_t, we'd be using that for ->events[].

Perhaps giving `max' an unsigned long type would better represent the
intent in there.
