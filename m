Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27257A9CA7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjIUTX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjIUTX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:23:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E846EBFDA
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6MZo+bKI+dkoYi+eqghinL9pk/+RSKBqGz2KYE0utpQ=; b=vOUlNLA6gi6a77sf2a0EMWckIP
        U9SHkHm+2Ygh0/Ah0iOCqkXL+Q9MJnpMzwujpsaaKzddIpbufoI1ZZjuhzYy8CTSQHV0JtHP+QHE2
        Mjc1JreF0no05YKJsaedmmM2QTiWRz8NhUT15qBdDM+pC1obKAsgedMG/pqOfSXy8T82YpIRjLMqH
        dJWgKiuOLGD+C/CDbuwhanZu+MQV5DrIjRkc4DMVn3eno1+INzdcABA6w1JXHckVzOt+eg0xbmIaX
        dg/sSNwrRLkURkrtHhhUdt0FDUWmbZfCBBvT9ayCs6GGdCKJLV55RVSuO2tTIptgusgWxCajx3tgl
        +UPxL0Kw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qjPGZ-00DgWf-2C; Thu, 21 Sep 2023 19:23:11 +0000
Date:   Thu, 21 Sep 2023 20:23:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pedro.falcato@gmail.com,
        stable <stable@kernel.org>
Subject: Re: [PATCH 0/2] maple_tree: Fix mas_prev() state regression.
Message-ID: <ZQyYH+5pnDc1KYj0@casper.infradead.org>
References: <20230921181236.509072-1-Liam.Howlett@oracle.com>
 <20230921112521.fc07c658804f4e188179da77@linux-foundation.org>
 <20230921185330.j5jw3oms4tc6crkf@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921185330.j5jw3oms4tc6crkf@revolver>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 02:53:30PM -0400, Liam R. Howlett wrote:
> * Andrew Morton <akpm@linux-foundation.org> [230921 14:25]:
> > On Thu, 21 Sep 2023 14:12:34 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
> > 
> > > Pedro Falcato contacted me on IRC with an mprotect regression which was
> > > bisected back to the iterator changes for maple tree.  Root cause
> > > analysis showed the mas_prev() running off the end of the VMA space
> > > (previous from 0) followed by mas_find(), would skip the first value.
> > > 
> > > This patch set introduces maple state underflow/overflow so the sequence
> > > of calls on the maple state will return what the user expects.
> > 
> > It isn't clear what are the user-visible effects of this flaw?  Please
> > send this along and I'll paste it in.
> 
> 
> User may notice that mas_prev() or mas_next() calls that result in going
> outside of the limit passed to the call will cause incorrect returns on
> subsequent calls using that maple state, such as mas_find() skipping an
> entry.

When Andrew says "User visible" he means "userspace visible".  Not
"in kernel user visible".  What are the _consequences_.

I'd say that if the user maps something at address 0, mprotect() can
then fail to ... or something.

