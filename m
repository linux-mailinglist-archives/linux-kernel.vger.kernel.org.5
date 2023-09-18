Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FE67A4196
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 08:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239893AbjIRG4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 02:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239854AbjIRGzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 02:55:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4544EC6;
        Sun, 17 Sep 2023 23:55:49 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="382323755"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="382323755"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2023 23:55:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="695417720"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="695417720"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2023 23:55:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andy@kernel.org>)
        id 1qi8AI-0000000DVlr-18aJ;
        Mon, 18 Sep 2023 09:55:26 +0300
Date:   Mon, 18 Sep 2023 09:55:25 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Philipp Stanner <pstanner@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        David Disseldorp <ddiss@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Siddh Raman Pant <code@siddh.me>,
        Nick Alcock <nick.alcock@oracle.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Zack Rusin <zackr@vmware.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-hardening@vger.kernel.org,
        David Airlie <airlied@redhat.com>
Subject: Re: [PATCH v2 1/5] string.h: add array-wrappers for (v)memdup_user()
Message-ID: <ZQf0XfrKiwhvkxum@smile.fi.intel.com>
References: <cover.1694202430.git.pstanner@redhat.com>
 <93001a9f3f101be0f374080090f9c32df73ca773.1694202430.git.pstanner@redhat.com>
 <b219788a-69e6-44cf-a609-91f9640967f5@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b219788a-69e6-44cf-a609-91f9640967f5@moroto.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2023 at 05:32:42PM +0300, Dan Carpenter wrote:
> On Fri, Sep 08, 2023 at 09:59:40PM +0200, Philipp Stanner wrote:

...

> > +static inline void *memdup_array_user(const void __user *src, size_t n, size_t size)
> > +{
> > +	size_t nbytes;
> > +
> > +	if (unlikely(check_mul_overflow(n, size, &nbytes)))
> > +		return ERR_PTR(-EOVERFLOW);
> 
> No need for an unlikely() because check_mul_overflow() already has one
> inside.

Makes sense.

> I feel like -ENOMEM is more traditional but I doubt anyone/userspace
> cares.

ENOMEM is good for the real allocation calls, here is not the one (the one is
below). Hence ENOMEM is not good candidate above. And whenever functions returns
an error pointer the caller must not assume that it will be only ENOMEM for
allocators.

> > +	return memdup_user(src, nbytes);
> > +}

-- 
With Best Regards,
Andy Shevchenko


