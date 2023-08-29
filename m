Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF9B78CC45
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238192AbjH2Shy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238191AbjH2Sh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:37:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDBD1BE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=A0/MJXP1OnWmTMBb5k+hfze8PHPxSXpimewIOMnBllI=; b=UsUba5JYR97HMZyAIQFbkj9HK6
        GPrchLEU2ydiMjesPkTwHluqA6VPM2tgGG379ew0JGOizACls4k7vvvF2PFQ/ZIQ/YuksG4NuYO+6
        k/b5tktzkjZ/goRh80XF9zWb3DNKgDeVUIcJB3Z+qukO/oXoDqt0Ty2Vhd98m77QeM0mjYmWB/p0k
        N4yecpU1VY+bqoJ0KappXWrlUtnG5qBgUZu31aGz2itU3MIJLdrXTjXD9/jr9GsbZKXtrxmC9BpFL
        XebH2YN8kM7xTyIVr0RUI4luxFfWzRDkyZB5yecHb3J3e8WiimKi23k56Jamn4x7uRLgQJlOqaOxX
        WrNbGYiw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qb3aW-008861-3P; Tue, 29 Aug 2023 18:37:16 +0000
Date:   Tue, 29 Aug 2023 19:37:16 +0100
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
Message-ID: <ZO463CUKB3QIHDAu@casper.infradead.org>
References: <20230724211428.3831636-1-michal.winiarski@intel.com>
 <20230724211428.3831636-2-michal.winiarski@intel.com>
 <10bb9689-9226-d47c-4cf1-7bf9d599456c@amd.com>
 <6qcxpntlr36itieyoyebsncwdv4vadr5ac7imgl4rdemoyedvp@a3m7l32pkcnf>
 <bcbfe6d5-da87-fa2b-c05a-8bea6e0004fb@amd.com>
 <ZO459g+fCBxbwTAF@casper.infradead.org>
 <f18bb070-9767-3b5c-8a40-3c95d5740e1d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f18bb070-9767-3b5c-8a40-3c95d5740e1d@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 02:35:34PM -0400, James Zhu wrote:
> 
> On 2023-08-29 14:33, Matthew Wilcox wrote:
> > On Tue, Aug 29, 2023 at 01:34:22PM -0400, James Zhu wrote:
> > > > > > @@ -1067,7 +1055,7 @@ static void drm_core_exit(void)
> > > > > >     	unregister_chrdev(DRM_MAJOR, "drm");
> > > > > >     	debugfs_remove(drm_debugfs_root);
> > > > > >     	drm_sysfs_destroy();
> > > > > > -	idr_destroy(&drm_minors_idr);
> > > > > [JZ] Should we call xa_destroy instead here?
> > > > We could, if we expect the xarray to potentially not be empty.
> > > >   From what I understand - all minors should be released at this point.
> > > [JZ] In practice,  adding destroy here will be better.
> > Why do you say that?
> [JZ] In case, the future, INIT adds something, need DESTROY to free
> completely.

That isn't going to happen.
