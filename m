Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A73880E35C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 05:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjLLEg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 23:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLLEg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 23:36:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1842A6;
        Mon, 11 Dec 2023 20:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UterbU1lY68chbDZ2KRFpiUZP8yEoxB+cO4YjpDyhgk=; b=YZTKS8ktQn3PVpr4ijYJlRv8d8
        Wcxi6WSeFcE8qV1rz/zSjQoCASaX94/5/JjH22enU+grOyzAE9nzAbLPkksSyIBMH3Z6b9ITOsgjl
        75H3pcfXBxFRObCMZVievtZQsN2oCPAVYZJVNUZWM8RlNiyQM2EEvJ/EqwVj4w4D4hqpME+/qtinO
        TKzfYz+Sqf9ZieUatcd/hX3xNiKk8/6Pvdvm8A6kwALWaPkpi7vg+fDpZUymcLeBlb8dZLjco6+Gr
        ZGevd+JOdMdDH9JsXAiJG4hvdkKZS/BftgjpDMEy5Z9uWeofuDkRlXi4B6IS+N/mLYpPxZ3fR1CmN
        8L1aUoGw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1rCuVi-009cuU-0H; Tue, 12 Dec 2023 04:36:46 +0000
Date:   Tue, 12 Dec 2023 04:36:45 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Baokun Li <libaokun1@huawei.com>, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, akpm@linux-foundation.org,
        ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH -RFC 0/2] mm/ext4: avoid data corruption when extending
 DIO write race with buffered read
Message-ID: <ZXfjXZWK4HlJi6pg@casper.infradead.org>
References: <20231202091432.8349-1-libaokun1@huawei.com>
 <20231204121120.mpxntey47rluhcfi@quack3>
 <b524ccf7-e5a0-4a55-db6e-b67989055a05@huawei.com>
 <20231204144106.fk4yxc422gppifsz@quack3>
 <70b274c2-c19a-103b-4cf4-b106c698ddcc@huawei.com>
 <20231206193757.k5cppxqew6zjmbx3@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206193757.k5cppxqew6zjmbx3@quack3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 08:37:57PM +0100, Jan Kara wrote:
> Within the same page buffered reads and writes should be consistent because
> they are synchronized by the page lock. However once reads and writes
> involve multiple pages, there is no serialization so you can get contents
> of some pages before write and some pages after being written. However this
> doesn't seem to be your particular case here. I just wanted to point out
> that in general even buffered reads vs writes are not fully consistent.

Buffered reads don't take the page/folio lock.  We only use the folio
lock to avoid reading stale data from the page cache while we're
fetching the data from storage.  Once the uptodate flag is set on the
folio, we never take the folio lock for reads.
