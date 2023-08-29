Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D5678CC30
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237336AbjH2SeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjH2Sdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:33:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9221F19A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=cFaAbUJjl2UXtlahY+fCqV8++1uLiZUrQMG64DLh/k8=; b=Cv4sMiBtHPqhcvYzMcH9hdAWnx
        Q9OMnGzle6A0Gq2+3jpLjbG4PDAwEiqttJUNJ4wUs/N7xwqmORzj1ejuujmrSTPiaYYHlWgHo8Po3
        B+Y6zZ9XM5Grju4Ix49bxDj1xVGinBvTocE7RhIhZKYspCLdZiYMVaEncUMO0gwDZ3kt4goYO9pDL
        QqKjhBdI8nalakhFQ7nr7J6XWO959b4pV4nTTCVZ7SL6ud0RVTpFX/zAH5KAX/A5kNu5gaIeNS5DJ
        iDgFU04JUnx9wqoGys2nTQjPB/zBvXXMxFEsOSSVX00aevP7bdg8C5FPYVYnGgWrkt9y/PuswYK5z
        XpQg/jqg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qb3Wo-0087wD-Ey; Tue, 29 Aug 2023 18:33:26 +0000
Date:   Tue, 29 Aug 2023 19:33:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     James Zhu <jamesz@amd.com>
Cc:     =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Simon Ser <contact@emersion.fr>,
        Oded Gabbay <ogabbay@kernel.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        James Zhu <James.Zhu@amd.com>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH v6 1/4] drm: Use XArray instead of IDR for minors
Message-ID: <ZO459g+fCBxbwTAF@casper.infradead.org>
References: <20230724211428.3831636-1-michal.winiarski@intel.com>
 <20230724211428.3831636-2-michal.winiarski@intel.com>
 <10bb9689-9226-d47c-4cf1-7bf9d599456c@amd.com>
 <6qcxpntlr36itieyoyebsncwdv4vadr5ac7imgl4rdemoyedvp@a3m7l32pkcnf>
 <bcbfe6d5-da87-fa2b-c05a-8bea6e0004fb@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bcbfe6d5-da87-fa2b-c05a-8bea6e0004fb@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 01:34:22PM -0400, James Zhu wrote:
> > > > @@ -1067,7 +1055,7 @@ static void drm_core_exit(void)
> > > >    	unregister_chrdev(DRM_MAJOR, "drm");
> > > >    	debugfs_remove(drm_debugfs_root);
> > > >    	drm_sysfs_destroy();
> > > > -	idr_destroy(&drm_minors_idr);
> > > [JZ] Should we call xa_destroy instead here?
> > We could, if we expect the xarray to potentially not be empty.
> >  From what I understand - all minors should be released at this point.
> [JZ] In practice,  adding destroy here will be better.

Why do you say that?
