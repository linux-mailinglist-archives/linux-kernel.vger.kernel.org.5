Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E31E773FB6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbjHHQvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjHHQuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:50:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7381417AAF;
        Tue,  8 Aug 2023 08:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691510261; x=1723046261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cnBdJaBsrsJ0gjx/7Mw5KRxcPDcdCrlyG2bBt+cQ1Sk=;
  b=St9rDyL80sKjqoFBuwFkVufDSkX+0j/w7MN2Ja2DuwYiAKJ3MFxO4/KG
   A3CxMqg/nAkyzzIRPa8lSMgPZRkoX8oPgRsK4lGi4VhKtKOhllndWUKVw
   u/7wYij0GZIpxBqdpbdiqpfjDGBs1e5fv7GrQvueZRgaRDPJEY2oA2z8k
   I+UC66BEwsHjdksV6vMqAPT0PkN25R40o8h8Hy9ElX/hnGJAek2iYpGTD
   acV3O3RVWRB2aUiNXsckg2OA/rNFts6jHYfcdBp7dw71pWmcEzyNCGD73
   y9Xa6OcMXFJrRe37L8fMMjeOiGBqNuuGtXJovFLLWiKb17isN6Y2Reo8b
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="369716041"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="369716041"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 06:07:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="845471839"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="845471839"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 08 Aug 2023 06:07:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qTMQm-00934S-0T;
        Tue, 08 Aug 2023 16:07:24 +0300
Date:   Tue, 8 Aug 2023 16:07:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Justin Tee <justin.tee@broadcom.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH v1 1/1] scsi: lpfc: Do not abuse UUID APIs
Message-ID: <ZNI+C2iMG8AbSpQF@smile.fi.intel.com>
References: <20230807095823.33902-1-andriy.shevchenko@linux.intel.com>
 <ZNERiABjPliMWu8f@smile.fi.intel.com>
 <CAAmqgVNCHhU2o-6CRT62X+as_AVs=FH3iCvQC9Eyp_vx5L9Mkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAmqgVNCHhU2o-6CRT62X+as_AVs=FH3iCvQC9Eyp_vx5L9Mkw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 10:45:03AM -0700, Justin Tee wrote:

> -- 
> This electronic communication and the information and any files transmitted 
> with it, or attached to it, are confidential and are intended solely for 
> the use of the individual or entity to whom it is addressed and may contain 
> information that is confidential, legally privileged, protected by privacy 
> laws, or otherwise restricted from disclosure to anyone else. If you are 
> not the intended recipient or the person responsible for delivering the 
> e-mail to the intended recipient, you are hereby notified that any use, 
> copying, distributing, dissemination, forwarding, printing, or copying of 
> this e-mail is strictly prohibited. If you received this e-mail in error, 
> please return the e-mail to the sender, delete it from your computer, and 
> destroy any printed copy of it.

Removed from mailbox.

-- 
With Best Regards,
Andy Shevchenko


