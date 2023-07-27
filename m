Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C571765823
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbjG0P6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjG0P6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:58:35 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E64EBC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690473514; x=1722009514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FdpnzmpbpDtQgpHo2zN0d9vbabH9VR2p8NO1uqeU8Ac=;
  b=Btv1Js/PXtMfLPdezycCpOM5oJZtpl4iBazJCGXP5RNyaU8Hv9P6pyfl
   rJ70eXG/m9PpQdU327PdxVUi1HqAk+8hOWZMBvUtEXy8M6vfF+kMIuLec
   9E3RmXHBK5UW81wLM2mwzNen/MPyFpemu6HsUPiHnlpvsoutHDdAVEpLs
   I06vaxO6Ul7Du3X1DZ4pssa6MOUdg0MWnxZuQ9xSn1YojZcV6rODSW8sC
   QOAY3St9m1Pym8gxRXh82cy/IDt0P2ddlPgqWSqzvGg1b8Yd5BGF0g8T8
   CaDHzuxX2yJu7rhyiNC/h3xwOokkOI5Jo7Cda7h1TaxWmDfSdxrzow9si
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="432165598"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="432165598"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 08:58:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="762206230"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="762206230"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 27 Jul 2023 08:58:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qP3Nl-00AzYB-1n;
        Thu, 27 Jul 2023 18:58:29 +0300
Date:   Thu, 27 Jul 2023 18:58:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Subject: Re: [PATCH] mtd: fix use-after-free in mtd release
Message-ID: <ZMKUJbl7kFOfgKGg@smile.fi.intel.com>
References: <20230727145758.3880967-1-alexander.usyskin@intel.com>
 <ZMKJRNDoQV8p0DH4@smile.fi.intel.com>
 <20230727172013.7c85c05d@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727172013.7c85c05d@xps-13>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 05:20:13PM +0200, Miquel Raynal wrote:
> andriy.shevchenko@linux.intel.com wrote on Thu, 27 Jul 2023 18:12:04
> +0300:
> > On Thu, Jul 27, 2023 at 05:57:58PM +0300, Alexander Usyskin wrote:

...

> > > Fixes: 19bfa9ebebb5 ("mtd: use refcount to prevent corruption")
> > 
> > Closes: ?
> 
> Did I miss a recent update on the use of Fixes?

They are orthogonal to each other. Actually Closes goes closer with
Reported-by.

I believe both of them needs to be added (by I might miss something).

> I thought Closes was
> supposed to point at a bug report while Fixes would point to the faulty
> commit.

Correct.

> Right now I feel like Fixes is the right tag,

Nobody objects that (see above).

> but if you have a source explaining why we should not longer do it like
> I am used to, I would appreciate a link.

Since you know about Closes already, I think there is nothing to add.

-- 
With Best Regards,
Andy Shevchenko


