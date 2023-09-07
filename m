Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F2579701B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 07:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjIGF3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 01:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjIGF3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 01:29:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404E51BC1;
        Wed,  6 Sep 2023 22:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694064545; x=1725600545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+GKVNJ5i63FwLD00A6L49LahYAqMl5s1qC9HtyRI4M8=;
  b=bo6nV2ECWSCaTky1xU5C8OCLr03LtcboHSE+tWQJEE6/5lZCfuzq9n3g
   X72/A5HnyyEBwix8VA+9QgIz258Q5Ru7xuSPGvsUba0Wo/iPnzzocO6Bx
   mN/kgfvdokRrlkiY3xNBIALaYegQOe2jpOJq8Au46qAQ0g/L8hlOhQClP
   TB8GAIk55H2Lpv/w4hmcbVgBGleMCrHVJTrWJLkftg8jOW680y1azTk3S
   /qZjwkPC5NODUXA/WiCyLz/5dOxI6ahaOyHu44xHc1pWScX/+4x6hUaOF
   xFgDzTWW/AYMPJLy8uDEbSn6IZiBUNFOFCCKjcUYEVOROUYwsz4iMVtzT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="376166870"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="376166870"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 22:29:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="718547175"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="718547175"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 06 Sep 2023 22:29:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id C5ED9177; Thu,  7 Sep 2023 08:29:00 +0300 (EEST)
Date:   Thu, 7 Sep 2023 08:29:00 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH v2 3/3] platform/x86: intel_scu_ipc: Fail IPC send if
 still busy
Message-ID: <20230907052900.GG1599918@black.fi.intel.com>
References: <20230906180944.2197111-1-swboyd@chromium.org>
 <20230906180944.2197111-4-swboyd@chromium.org>
 <ZPjdZ3xNmBEBvNiS@smile.fi.intel.com>
 <CAE-0n53iGCL3q=CsDKZr28eMjx40miLNG6+-jf12JKMxuAKkKg@mail.gmail.com>
 <ZPjlIhDykHd44YTz@smile.fi.intel.com>
 <CAE-0n500OCS0nh_7v_FL1rtTccAJxKhoD8vuBE7AER1fwWihsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE-0n500OCS0nh_7v_FL1rtTccAJxKhoD8vuBE7AER1fwWihsQ@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 03:59:33PM -0500, Stephen Boyd wrote:
> Quoting Andy Shevchenko (2023-09-06 13:46:26)
> > On Wed, Sep 06, 2023 at 03:22:43PM -0500, Stephen Boyd wrote:
> > > Quoting Andy Shevchenko (2023-09-06 13:13:27)
> > > > On Wed, Sep 06, 2023 at 11:09:43AM -0700, Stephen Boyd wrote:
> >
> > ...
> >
> > > > > @@ -450,6 +468,12 @@ int intel_scu_ipc_dev_simple_command(struct intel_scu_ipc_dev *scu, int cmd,
> > > > >               return -ENODEV;
> > > > >       }
> > > >
> > > > >       scu = ipcdev;
> > > >
> > > > Side observation: Isn't this a bug? We should not override the supplied parameter.
> > >
> > > If it is a bug that would be great to know. I wanted to make an API that
> > > got the scu if it wasn't busy but then I ran across this code that
> > > replaced the scu with ipcdev.
> >
> > To me this seems like a bug, because in other similar code we don't do that.
> > And even reading this one, why do we have a parameter if it's always being
> > rewritten?
> 
> Yes. From what I can tell looking at commit f57fa18583f5 ("platform/x86:
> intel_scu_ipc: Introduce new SCU IPC API") it was an unintentional bug
> to leave that line there.

Indeed it is. Good catch Andy!
