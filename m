Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C6677890B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 10:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjHKIgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 04:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHKIg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 04:36:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626142737;
        Fri, 11 Aug 2023 01:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=cJocosMaFpZJVLW25SbAxt5T2sdLdDBAbE/g/2G0uCE=; b=e3PI9VlwzTl5znPWffVTncxIuc
        zxr/n6yEjgQC9DwP0iff+gDBqpHgpDYwRIVbmjQT4a+rTUD2hSdrBo+q60rGhqEhU5hAMnynrtb6X
        c27nSbBss1GPcfuWS0hA0ez2Ots+WbnKpfi2Sl6PFPJDBF1DscqMQJf8oiWbD9q7pbnDeykbMzXpJ
        6Hx7KHz0lpC+QIN2NCyiZAsYVU42h4OX8I7O5W4Yn/XincK95Crs9eQV6FS9REIzBoc0uERxbv7C4
        MZVyTw7AOq/OTMzZqDpgJOEjsVdV8XZqY9juKbz5sYP1xJZtlvqIQdA+7QLyLN2BcIqNhSlif5Tok
        vQT3j9ug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qUNd8-009rjw-26;
        Fri, 11 Aug 2023 08:36:22 +0000
Date:   Fri, 11 Aug 2023 01:36:22 -0700
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
Message-ID: <ZNXzBnDLQzT7FT5s@infradead.org>
References: <20230810160019.16977-1-richard@nod.at>
 <20230810160019.16977-2-richard@nod.at>
 <ZNUK8nWnUYB6B4Kg@infradead.org>
 <298860961.5257332.1691684136772.JavaMail.zimbra@nod.at>
 <ZNUOjQVivR/5pFKE@infradead.org>
 <164102534.5258032.1691697286622.JavaMail.zimbra@nod.at>
 <ZNXtdpUbhj7mVu11@infradead.org>
 <156807159.5281174.1691742892935.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <156807159.5281174.1691742892935.JavaMail.zimbra@nod.at>
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

On Fri, Aug 11, 2023 at 10:34:52AM +0200, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
> > Von: "Christoph Hellwig" <hch@infradead.org>
> > On Thu, Aug 10, 2023 at 09:54:46PM +0200, Richard Weinberger wrote:
> >> > But why add the bounce buffering first if you can avoid it from the
> >> > very beginning by just using kmap_local instead of adding a new
> >> > caller for the deprecate kmap_atomic?
> >> 
> >> Because I want this fix also in all stable trees. kmap_local() is rather
> >> new. When back porting patch 1/7, bounce buffers and kmap_atomic()
> >> are needed anyway.
> >> By doing this in patch 1/7 I avoid backport troubles and keep the
> >> delta between upstream and stable trees minimal.
> > 
> > Just use plain kmap for the historic backports.
> 
> Hm, yes. For UBIblock kmap should be too expensive.

?  kmap is a no-op for !highmem.  And it will always be way cheaper
than bounce buffering for the case where you are actually fed highmem
pages.
