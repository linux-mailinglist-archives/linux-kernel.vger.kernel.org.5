Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31477CDE9E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344929AbjJROMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbjJROMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:12:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7D613D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=41esCbpGOiNvuMpXdu5kkIly6/BMtC7WI0rjINadEXI=; b=Bvthg0jTiYmJA89rusISVNCnk6
        FkTOdcN2gYyU3pDzIHF8P8VpC/HpVYFqx3DuGjYDIawfW317jAjZhhLR35rNhrh6LD1oUGlmP3cFQ
        DJRLa+U0VQHaU+Sty0TFWGsfy76Rsrb6Kh7AWHba3q7iT51H8vK+0JHaCMLM7DzHUUcalGO+NTeQJ
        yGvSh7lB9E3OY7/QZ5tDvXUq2jV5DQy/xowRGaaTEVcJETyj/W+GSlCBrwJFz9yN0ikPzExYl8SDg
        pmPbV/6T+Xk7hTF0wWKgzSvhqOGv2k6nQKXm0sfzKXDrBzqV984frPnrdbA3losZDx650PwaGK3tf
        VfJx7Trw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qt7HH-001Key-B3; Wed, 18 Oct 2023 14:12:03 +0000
Date:   Wed, 18 Oct 2023 15:12:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhiguo Jiang <justinjiang@vivo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH] mm: vmscan: the dirty folio unmap redundantly
Message-ID: <ZS/nszOJM0Qzspip@casper.infradead.org>
References: <20231018013004.1569-1-justinjiang@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018013004.1569-1-justinjiang@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 09:30:03AM +0800, Zhiguo Jiang wrote:
> If the dirty folio is not reclaimed in the shrink process, it do
> not need to unmap, which can save shrinking time during traversaling
> the dirty folio.

Don't we have to unmap it first in order to make sure that all the
dirty bits from the PTEs have been transferred to the folio dirty bit?

