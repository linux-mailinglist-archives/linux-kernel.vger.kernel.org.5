Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA65880ECC5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376515AbjLLNG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjLLNG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:06:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522C999;
        Tue, 12 Dec 2023 05:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=67rvxc8KF4Am0jhrdB27CpUPgtiBS4+Z+YV3L6uI8NY=; b=boRv2crSvsM4V861vsFYqPudVo
        oG6u3FHR4FHHElcP1zSEgNE+5kwcrLl8Uz1eXzDuU+QSB05HYIyBVVwkOtXpg6sFkZYx9mqFKQjJM
        CXisjMmelC2DPUsL58SML8bx6tCM58JvtFZQEwgmQOs8rP7cRr4IW8hQuQzWegRit+rlMtWPUetU0
        KpVjNA38PW2wXGCw2uTGgg9BxSr2A9zNj44dE7KI91wfU5RQzskEfu8I4zBHr9uonz3WBXwvKc/s5
        KmNCYBg+ld1Sb/eG3XxK7KRizFgVP0sSFjlESHL+pIF2sj7jbF+BxiL0+eJ/kF74k423hjI106Lm6
        x5CzPzPg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rD2Sy-00Bko8-0I;
        Tue, 12 Dec 2023 13:06:28 +0000
Date:   Tue, 12 Dec 2023 05:06:28 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Eric Curtin <ecurtin@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        Daan De Meyer <daan.j.demeyer@gmail.com>,
        Stephen Smoogen <ssmoogen@redhat.com>,
        Yariv Rachmani <yrachman@redhat.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Douglas Landgraf <dlandgra@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Colin Walters <walters@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        Eric Chanudet <echanude@redhat.com>,
        Pavol Brilla <pbrilla@redhat.com>,
        Lokesh Mandvekar <lmandvek@redhat.com>,
        Petr =?utf-8?Q?=C5=A0abata?= <psabata@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>, Neal Gompa <neal@gompa.dev>,
        nvdimm@lists.linux.dev
Subject: Re: [RFC KERNEL] initoverlayfs - a scalable initial filesystem
Message-ID: <ZXha1IxzRfhsRNOu@infradead.org>
References: <CAOgh=Fwb+JCTQ-iqzjq8st9qbvauxc4gqqafjWG2Xc08MeBabQ@mail.gmail.com>
 <941aff31-6aa4-4c37-bb94-547c46250304@linux.alibaba.com>
 <ZXgNQ85PdUKrQU1j@infradead.org>
 <58d175f8-a06e-4b00-95fe-1bd5a79106df@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58d175f8-a06e-4b00-95fe-1bd5a79106df@linux.alibaba.com>
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

On Tue, Dec 12, 2023 at 03:50:25PM +0800, Gao Xiang wrote:
> I have no idea how it's faster than the current initramfs or initrd.
> So if it's really useful, maybe some numbers can be posted first
> with the current `memmap` hack and see it's worth going further with
> some new infrastructure like initdax.

Agreed.
