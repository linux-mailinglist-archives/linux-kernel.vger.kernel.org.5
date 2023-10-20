Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FE07D06DB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 05:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346865AbjJTD3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 23:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346916AbjJTD3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 23:29:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE711D45
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 20:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o7uVj+BWSvci11+EmzgxZowQ4BFh6afGOeAd/iYFtNE=; b=OVYJQjQN5amrALRJRDc+biqABr
        gqr5ViWVPUS/uQzT4vXazunLCY2fSGOsUP1jsSxf2TSxcfVFWEJzWOuUwdG+5P8FqpS/lMXiFJa0H
        1KWrPg9zZG1/ARnkgdD3J+UIdHqXA7ZH5vnzxMPo3acAfgQjZQnmiMBd6+MrH3eSTqKqYcS5QBQVH
        aqLJp0Tuv86iKJWGCV/mq2YmndTYlS0WA20GMoCCfsESxHGTBbpdsiZxcpFremM8vGCDiZwqWtiNZ
        BHA4AZkrq8S8OpqjJnodOO5PefhhVir5d38fOeOi7mX3rOroUAR6rDStVisuPe4C3qrDAmEMZlbww
        sa9ojvRA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qtgCA-00AofD-1b; Fri, 20 Oct 2023 03:29:06 +0000
Date:   Fri, 20 Oct 2023 04:29:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhiguo Jiang <justinjiang@vivo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v2 2/2] mm:vmscan: the ref clean dirty folio skip unmap
Message-ID: <ZTH0Aob4srLnnjCM@casper.infradead.org>
References: <20231019134211.329-1-justinjiang@vivo.com>
 <20231019134211.329-3-justinjiang@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019134211.329-3-justinjiang@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 09:42:11PM +0800, Zhiguo Jiang wrote:
> +++ b/mm/vmscan.c
> @@ -1225,7 +1225,10 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  			stat->nr_ref_keep += nr_pages;
>  			goto keep_locked;
>  		case FOLIOREF_RECLAIM:
> +			break;
>  		case FOLIOREF_RECLAIM_CLEAN:
> +			if (dirty)
> +				goto activate_locked;

Why activate_locked and not keep_locked?
