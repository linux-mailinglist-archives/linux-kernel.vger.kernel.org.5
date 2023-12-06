Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B932E806F92
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378219AbjLFMUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377846AbjLFMUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:20:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0EA12F;
        Wed,  6 Dec 2023 04:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8KBSzwF5RnKTnZtNcdzBmJ+YoZoo95O1SbBkNFpKBcE=; b=m2rNX3S8s7ipaac/SEEHNQedcs
        AAYrNlMNmjF7zS9jCHUhtvFq1ZdWNW8yCMeTlXJWys4kJ645H/BxKVB8KXiFg3zF3gtjJTBr/NNEi
        mUC+FkbXTrGmrp+ETd3MnrZDpG/G+sWFHjwC2od8Oh11ObEQGbld+RrC3f4t7tBjbNqE8kRTjBTIS
        K6DrWwkiiYFqEcHl4lw8x2+wxFCVE07geZ6V67jqQlNN7gw4pvRuNfrwnuv47iNtfYKiCFw0DNh8W
        shx+kw06kdGZ1iGNF1c127OgtxHC+muEEBAzL2bC5g5udzVLu1zr6w8VFiAwR+wyS4iOErS8c/w/d
        i6MCK1uw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rAqsp-00AEvl-0n;
        Wed, 06 Dec 2023 12:20:07 +0000
Date:   Wed, 6 Dec 2023 04:20:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Baokun Li <libaokun1@huawei.com>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, willy@infradead.org,
        akpm@linux-foundation.org, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH -RFC 0/2] mm/ext4: avoid data corruption when extending
 DIO write race with buffered read
Message-ID: <ZXBm95si+j7lmalf@infradead.org>
References: <20231202091432.8349-1-libaokun1@huawei.com>
 <20231204121120.mpxntey47rluhcfi@quack3>
 <b524ccf7-e5a0-4a55-db6e-b67989055a05@huawei.com>
 <ZXAyV/rlfvBBuDL1@dread.disaster.area>
 <ZXA4swgzsHbkm/uB@infradead.org>
 <ZXBOSRhm11DtGO+K@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXBOSRhm11DtGO+K@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 09:34:49PM +1100, Dave Chinner wrote:
> Largely they were performance problems - unpredictable IO latency
> and CPU overhead for IO meant applications would randomly miss SLAs.
> The application would see IO suddenly lose all concurrency, go real
> slow and/or burn lots more CPU when the inode switched to buffered
> mode.
> 
> I'm not sure that's a particularly viable model given the raw IO
> throughput even cheap modern SSDs largely exceeds the capability of
> buffered IO through the page cache. The differences in concurrency,
> latency and throughput between buffered and DIO modes will be even
> more stark itoday than they were 20 years ago....

The question is what's worse:  random performance drops or random
corruption.  I suspect the former is less bad, especially if we have
good tracepoints to pin it down.

