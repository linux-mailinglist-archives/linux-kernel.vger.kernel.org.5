Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408D878C482
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbjH2MwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbjH2Mvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:51:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF4AC0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xJytkBQVWBpPepRTYkUBwDFiwgSzWjNhhkWa67DhtRs=; b=eK3dhvdkefEzP6EX7ooAdHhsdW
        nH9CLMYYoSUBo0iuHW5G53OIJZ91kbVbFzI3tupEtzKwMjJfiwrwJTpRZPTe+eX79xc+cFy+GMxVa
        QKdCKB11ncuib/xgdrkz1gyKCh8xWcb6xKHz9rniljyKdoMueKjh3mZqBBiFF8v5Uu5xOyqjTc1OA
        btta8eiER8cjhGYOlrNp1bmPZn9Gi2JUZhJMWMCxM7+b0GKBzX6ylKJ9iLGLwx0fSSXVpJ8eJKyNk
        x3TUY9LIzrsXDAOBD2WxDTlCxwQCJ7KymsC4oaZGvpIkLKMRBeJPXAsQy7rLQrW46bZGyTQgSrLdh
        IAyiz6mg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qayBr-006d0T-IK; Tue, 29 Aug 2023 12:51:27 +0000
Date:   Tue, 29 Aug 2023 13:51:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap: Tighten up cmdline_parse_stack_guard_gap()
Message-ID: <ZO3pz+3fAihhrtMU@casper.infradead.org>
References: <20230828052212.748872-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828052212.748872-1-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 10:52:12AM +0530, Anshuman Khandual wrote:
> -static int __init cmdline_parse_stack_guard_gap(char *p)
> +static int __init cmdline_parse_stack_guard_gap(char *str)
>  {
>  	unsigned long val;
> -	char *endptr;
>  
> -	val = simple_strtoul(p, &endptr, 10);
> -	if (!*endptr)
> -		stack_guard_gap = val << PAGE_SHIFT;
> +	if (!str)
> +		return 0;

Please explain how this function can be called with a NULL pointer.

> -	return 1;
> +	val = simple_strtoul(str, &str, 10);
> +	if (!*str && val) {
> +		stack_guard_gap = val << PAGE_SHIFT;
> +		return 1;
> +	}
> +	return 0;
>  }

Now you've removed the abillity for someone to say stack_guard_gap=0,
which seems potentially useful.
