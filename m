Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DB97860A3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 21:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbjHWTaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 15:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238242AbjHWTaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 15:30:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9663E6F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 12:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692819003; x=1724355003;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=O/K6buJTsts4lyk8qgqJ5lDMguNQN8GgLUMZdbG6uSI=;
  b=XJOLrrxPNrvutGWyQpbaWZejc5zQkKMX2nvk3O70fT3qEldKZ+1vKIDS
   9etJv0ocl5JdTVz9VWQG8qWLX6bSv2HXCYPEY7C9BkwPpWAaYe7FopVfI
   0sba/dmHmV2hZr/KCUe5wwuC+yq3QZjN0W1ZPaknA7GFeNdMIi5tMWtW3
   flHWQcb39JNm4vjiw53AldidJqUOkEbdt0qLJhMK8QtDFZxQ8+WK5Tp7A
   PvUrk2wn7ATGrVpZXxRVbPh9xXB4ZsggM6Vq7KrCuxzZs7jedh+aPoXmW
   GbjeGAggRr+s4MQJOCoAr7eJw7SSWJ3XkmzUubXr3bZuLkONHQjTYDQNY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="373138246"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="373138246"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 12:30:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="713697765"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="713697765"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 12:29:59 -0700
Date:   Wed, 23 Aug 2023 22:30:13 +0300
From:   Imre Deak <imre.deak@intel.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [REGRESSION] HDMI connector detection broken in 6.3 on Intel(R)
 Celeron(R) N3060 integrated graphics
Message-ID: <ZOZeRX2xZiZb61hH@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
References: <87v8dmr6ty.fsf@gmail.com>
 <f32b4636-969c-3b9e-6802-5991f511739e@leemhuis.info>
 <87il9l2ymf.fsf@gmail.com>
 <3df95e6d-8237-1c43-e220-a9bdb5d6e044@leemhuis.info>
 <ZNo7oXeH0JK+4GPG@ideak-desk.fi.intel.com>
 <87edk4d8qp.fsf@intel.com>
 <2xlfp5bz77tyoffqvr7orvmo45wcb7uz6nbpl7jbv6zhnqvlx3@2hxa4ltb3s3y>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2xlfp5bz77tyoffqvr7orvmo45wcb7uz6nbpl7jbv6zhnqvlx3@2hxa4ltb3s3y>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 11:27:29AM +0200, Maxime Ripard wrote:
> On Tue, Aug 15, 2023 at 11:12:46AM +0300, Jani Nikula wrote:
> > On Mon, 14 Aug 2023, Imre Deak <imre.deak@intel.com> wrote:
> > > On Sun, Aug 13, 2023 at 03:41:30PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> > > Hi,
> > >
> > >> On 11.08.23 20:10, Mikhail Rudenko wrote:
> > >> > On 2023-08-11 at 08:45 +02, Thorsten Leemhuis <regressions@leemhuis.info> wrote:
> > >> >> On 10.08.23 21:33, Mikhail Rudenko wrote:
> > >> >>> The following is a copy an issue I posted to drm/i915 gitlab [1] two
> > >> >>> months ago. I repost it to the mailing lists in hope that it will help
> > >> >>> the right people pay attention to it.
> > >> >>
> > >> >> Thx for your report. Wonder why Dmitry (who authored a4e771729a51) or
> > >> >> Thomas (who committed it) it didn't look into this, but maybe the i915
> > >> >> devs didn't forward the report to them.
> > >> 
> > >> For the record: they did, and Jani mentioned already. Sorry, should have
> > >> phrased this differently.
> > >> 
> > >> >> Let's see if these mails help. Just wondering: does reverting
> > >> >> a4e771729a51 from 6.5-rc5 or drm-tip help as well?
> > >> > 
> > >> > I've redone my tests with 6.5-rc5, and here are the results:
> > >> > (1) 6.5-rc5 -> still affected
> > >> > (2) 6.5-rc5 + revert a4e771729a51 -> not affected
> > >> > (3) 6.5-rc5 + two patches [1][2] suggested on i915 gitlab by @ideak -> not affected (!)
> > >> > 
> > >> > Should we somehow tell regzbot about (3)?
> > >> 
> > >> That's good to know, thx. But the more important things are:
> > >> 
> > >> * When will those be merged? They are not yet in next yet afaics, so it
> > >> might take some time to mainline them, especially at this point of the
> > >> devel cycle. Imre, could you try to prod the right people so that these
> > >> are ideally upstreamed rather sooner than later, as they fix a regression?
> > >
> > > I think the patches ([1] and [2]) could be merged via the drm-intel-next
> > > (drm-intel-fixes) tree Cc'ing also stable. Jani, is this ok?
> > 
> > It's fine by me, but need drm-misc maintainer ack to merge [1] via
> > drm-intel.
> 
> That's fine for me

Thanks, I pushed the patches to drm-intel-next.

> Maxime


