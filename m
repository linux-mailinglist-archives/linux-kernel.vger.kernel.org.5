Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19DC7788C9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 10:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbjHKIMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 04:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjHKIMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 04:12:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CE5110;
        Fri, 11 Aug 2023 01:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EB04r0U/QOmdPdeA69z+u0e9s4yi58XP6YzRO4akQCo=; b=PGKp/ttpJ0pZ+eqqer+Ecb5IUC
        Z+n8VqpiX/Vri8Kde3QcTZ5BIMjCMu7gt7rTQ+Mw06uU9dLCPeEYkEsSvPrq2h1aqlfYR/zUYyGPe
        f9oCN/Av6JIltFyS/xVT6Bx05MU+GGKO+2g4Hg8rN/xxKLZ1jf7lXghpSJaaJX3RWIddvYzFFhHXy
        NQWam5Ord/sA2l1ru5vrrQPpBpetCOVlFVpbmutHCQAn/9+kpd3pAlJTybY7fEDReGYuxOkf8t8/u
        2f1INfljKC0F7bXdWu4lJTIuma1K1Z4mbPho884BFl8N8NjS0ValUJ2N3DxWHQp77PqDLcMy4lhyK
        Doe11v7g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qUNGA-009pPe-39;
        Fri, 11 Aug 2023 08:12:38 +0000
Date:   Fri, 11 Aug 2023 01:12:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Stephan Wurm <stephan.wurm@a-eberle.de>,
        stable <stable@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Oliver Neukum <oliver@neukum.org>,
        Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        James Bottomley <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 1/7] ubi: block: Refactor sg list processing for highmem
Message-ID: <ZNXtdpUbhj7mVu11@infradead.org>
References: <20230810160019.16977-1-richard@nod.at>
 <20230810160019.16977-2-richard@nod.at>
 <ZNUK8nWnUYB6B4Kg@infradead.org>
 <298860961.5257332.1691684136772.JavaMail.zimbra@nod.at>
 <ZNUOjQVivR/5pFKE@infradead.org>
 <164102534.5258032.1691697286622.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164102534.5258032.1691697286622.JavaMail.zimbra@nod.at>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 09:54:46PM +0200, Richard Weinberger wrote:
> > But why add the bounce buffering first if you can avoid it from the
> > very beginning by just using kmap_local instead of adding a new
> > caller for the deprecate kmap_atomic?
> 
> Because I want this fix also in all stable trees. kmap_local() is rather
> new. When back porting patch 1/7, bounce buffers and kmap_atomic()
> are needed anyway.
> By doing this in patch 1/7 I avoid backport troubles and keep the
> delta between upstream and stable trees minimal.

Just use plain kmap for the historic backports.

