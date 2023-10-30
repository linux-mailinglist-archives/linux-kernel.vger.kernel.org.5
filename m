Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EB17DBE3B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbjJ3QrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjJ3QrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:47:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5DA98;
        Mon, 30 Oct 2023 09:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bIhF2shbU9yQ1xXu88DNW/2t71hPJ3iaMiPIW4OxDQA=; b=RIoSIG7WggABdOi0WX4MY6rASx
        WEinxOItdKlCxZt2IY5dzNeQIrQl3kumM4SkUssTiyTgpyXbZe2fjl8Obs29AVsEn+nkh9hGAVYBr
        OyALFWPiJZa2I1sjJcW6ciJlfTTD3xRqlVe1CSeL6/EJ7kbyvEUMdpvwHdB4/p+QZ6Wtsrse4CtfU
        4Mik9G6cO0xGU1ndKSieed3xTVVvWrJggwrbK2//5SbANhLriTGgCyENp1XFAyzuf8XANqgxiS2As
        JmvZpN+OIMpOccqV4T9OBzH15eZiWFqQiaHB5w7Wcp8SiXQ+806Y0o77G8n6JSwY8VCNffQk+g9d+
        K3K+gLzw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qxVPu-005A7k-4n; Mon, 30 Oct 2023 16:47:06 +0000
Date:   Mon, 30 Oct 2023 16:47:06 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Youling Tang <youling.tang@outlook.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, tangyouling@kylinos.cn
Subject: Re: [PATCH] readahead: Update the file_ra_state.ra_pages with each
 readahead operation
Message-ID: <ZT/eCvQ/Iug8GB1l@casper.infradead.org>
References: <MW4PR84MB3145AFD512F2C777635765B381A1A@MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR84MB3145AFD512F2C777635765B381A1A@MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 03:41:30PM +0800, Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
> 
> Changing the read_ahead_kb value midway through a sequential read of a
> large file found that the ra->ra_pages value remained unchanged (new
> ra_pages can only be detected the next time the file is opened). Because
> file_ra_state_init() is only called once in do_dentry_open() in most
> cases.
> 
> In ondemand_readahead(), update bdi->ra_pages to ra->ra_pages to ensure
> that the maximum pages that can be allocated by the readahead algorithm
> are the same as (read_ahead_kb * 1024) / PAGE_SIZE after read_ahead_kb
> is modified.

Explain to me why this is the correct behaviour.

Many things are only initialised at open() time and are not updated until
the next open().  This is longstanding behaviour that some apps expect.
Why should we change it?

