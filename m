Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A47F796F82
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 06:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbjIGELO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 00:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjIGELC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 00:11:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E556199F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 21:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=9UzaIJHInJlgwQfLKiyRFrgprSJsNB4MmXDA+n+Rqa8=; b=NxbZcGmtObKKKMrOvJ4xI4xAVD
        BtXfbfHyyWOqXFD8wSsX7y+5BcvzIuBPwKYz5OB5RsNrOgQb7l3Jb+NEbK0SY0rKOasI/0alHzm7J
        6e2l78Dbr0lyi4IRrFdu9H0eYlrKK5vzstp4QJ44jY1ss5V8M8yhBmY4z1P7Hr8wbo4+2Pd3AMCAb
        lrdoMuTHYMFncAofbakz8JPzNYQ7/MDSf584PYJ/PCwMr2pNF5ogkBAL9bX5F3mpYGD64EkST+t+T
        0HTlJleUKJJRmVknlB6nSlHsqtdyhLviKK2levIK/tNF4w+h8vCkPuZK8QxO4Uk+qwonCTTdBerEt
        0S9cwQ/g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qe6Lk-0084Ax-QE; Thu, 07 Sep 2023 04:10:36 +0000
Date:   Thu, 7 Sep 2023 05:10:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     =?utf-8?B?7Ius7J6s7ISg?= <jason.sim@samsung.com>,
        "liam.howlett@oracle.com" <liam.howlett@oracle.com>,
        "surenb@google.com" <surenb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
Subject: Re: [PATCH] maple_tree: use GFP_KERNEL on mas_node_count
Message-ID: <ZPlNPGpAPy+7oQay@casper.infradead.org>
References: <CGME20230907033914epcms1p61c5eed4d34d5c4212436c201f33292b3@epcms1p6>
 <20230907033914epcms1p61c5eed4d34d5c4212436c201f33292b3@epcms1p6>
 <ZPlIShWJWt+Kxt8x@casper.infradead.org>
 <06a8624e-00bb-a332-4271-860847faf4a3@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06a8624e-00bb-a332-4271-860847faf4a3@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 12:02:02PM +0800, Peng Zhang wrote:
> 
> 
> 在 2023/9/7 11:49, Matthew Wilcox 写道:
> > On Thu, Sep 07, 2023 at 12:39:14PM +0900, 심재선 wrote:
> > > Use GFP_KERNEL on mas_node_count instead of GFP_NOWAIT | __GFP_NOWARN
> > > in order to allow memory reclaim.
> There are many paths that call maple tree's mas_node_count(). Some paths
> cannot reclaim memory.

Right ... but we should be handling the ENOMEM inside the maple tree and
allocating some nodes with GFP_KERNEL instead of failing fork().

> > What testing did you do of this patch?  In particular, did you try it
> > with lockdep enabled?

