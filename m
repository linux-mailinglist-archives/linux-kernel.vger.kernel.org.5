Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4557C78DD96
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245430AbjH3SwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244233AbjH3MsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:48:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED8C132;
        Wed, 30 Aug 2023 05:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IOWE/0M8BlcymUq1i49NiJ36nIsTbEwhbzVvvXqFMks=; b=QymoGGmpy5KxS8E9NT36ocDUFW
        FnQpoW3j5rcesOV+zTgj13HGQTw5I5dMHi1Qh4AjEp5RNalo/sjDh8q61y5O1SNvKMaNG3z5tOK05
        hXLu7s/J+VbEf+Ng2ivX+cNRVlCY+c1PIEZcwEgimLsbcZr/TBI5pV74seszbeQ4Ht/3tNFuqwx/j
        LukHJRG6ZJ8PhqCn89AtKH5QqGWV1gt72LUedCHf68SnTaGhvg5h1slQWuY+HF7+1xmEjwSMAqO2L
        3KLO8gtaeQAnMLQ88GYi57SC4EJVZT+QWuFfHxKrv2MTQm7psgOH4P80HNUq2KTAlHuWvV1MGvghD
        0QDvhsfw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qbKcE-00DVAO-1k;
        Wed, 30 Aug 2023 12:48:10 +0000
Date:   Wed, 30 Aug 2023 05:48:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Zqiang <qiang.zhang1211@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm/vmalloc: Add a safer version of find_vm_area()
 for debug
Message-ID: <ZO86ik6QWamW2u/j@infradead.org>
References: <20230830110402.386898-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830110402.386898-1-joel@joelfernandes.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 11:03:59AM +0000, Joel Fernandes (Google) wrote:
> It is unsafe to dump vmalloc area information when trying to do so from
> some contexts. Add a safer trylock version of the same function to do a
> best-effort VMA finding and use it from vmalloc_dump_obj().

Seems like 2/2 to actually use this is missing?

