Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D03777DBD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbjHJQIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236462AbjHJQIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:08:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BECE5257;
        Thu, 10 Aug 2023 09:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hiIZJWDMNiv2gzLUMIYbryzWNVPKrIU6vS93dh6YUgA=; b=obK7Vufll0p3NiLUKIGLh71Mvz
        LoMOvVdhtCXloJ/bs2EGYTiqFibQe8Vq+XkQMIneZxhny/LNv1oyRb/2eHDmTbF8z0ZLp8ri1hZop
        7fgysE/f97NB92qJOA3kx1YpP897VNmLTvWviH0qaIc0bW5mBAnAtgt8g1Q2jKuQcbbKRt7Lqsrzb
        W7le995cvpS+NktKwNyz2LXgD4IZ1cvC2TtP6yg63uobduAJ73McZ16yzetJPKTv+Kcny2iDVuyjX
        JL/qYgw/aLo4jB5jfWvmQ4rUnUqcB47o1aCTPHoCdD3DGbWTcKgZtugHlXhg8D5is9ltl5hINdaLE
        y2iZo9pw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qU8As-0088cE-0p;
        Thu, 10 Aug 2023 16:06:10 +0000
Date:   Thu, 10 Aug 2023 09:06:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>,
        Stephan Wurm <stephan.wurm@a-eberle.de>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Oliver Neukum <oliver@neukum.org>,
        Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/7] ubi: block: Refactor sg list processing for highmem
Message-ID: <ZNUK8nWnUYB6B4Kg@infradead.org>
References: <20230810160019.16977-1-richard@nod.at>
 <20230810160019.16977-2-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810160019.16977-2-richard@nod.at>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 06:00:12PM +0200, Richard Weinberger wrote:
> Currently sg_virt() is used while filling the sg list from LEB data.
> This approach cannot work with highmem.
> 
> Refactor ubi_eba_read_leb_sg() to use kmap_atomic() for sg list
> access.
> Since kmap_atomic() disables preempt a bounce buffer is needed.
> kmap_local_page() is not used to allow easy backporting of this patch
> to older kernels.
> 
> The followup patches in this series will switch to kmap_sg()
> and we can remove our own helper and the bounce buffer.

Please just use kmap_local and avoid the bounce buffering.

