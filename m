Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAF075141A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjGLXGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjGLXG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:06:26 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BB730FA;
        Wed, 12 Jul 2023 16:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689203143; x=1720739143;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e7LYvcVy+v9S3RlgAaVngEjeffDD+Hja50r5usVYpTk=;
  b=MXejf7MCf3VWQMtPaexmqz66LTUTqsQ15F3pxIFkINSe88+squDsDWzL
   uS4Yx3jYZkmIDDMzpd2YN0HsRquqCBxwvoARNVu5neCClsicMJ3cf3zDi
   3e15mRGz2o3fw4K5pwzxJ05Bn3VNcvNVz3+l7s5VEdYueQaOO2toTAf+/
   Jlyf7ec/XOAhCADjcr2xVE7/uv+v+Knj3NCPJ2Pwr4q3qwliq2J1nEfs7
   Nldm6QCFzPS9+LN4toPPlm7bsbM0G71msoMIdz/aD6cBlYBlPxeRXk5hd
   oo3aEbRrxQeQLcRrd/n+4e7Uh7LUxNzEKQF1iZMfb6B+abPvPUTp2YPyC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="428774641"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="428774641"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 16:03:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="835338901"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="835338901"
Received: from nlsegerl-mobl1.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.182.248])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 16:03:58 -0700
Message-ID: <9e6873e53112ea9568fd0d1c8ef50e652ca05d84.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/3] platform/x86/intel/tpmi: Read feature control
 status
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 12 Jul 2023 16:03:57 -0700
In-Reply-To: <ZK7BL0GIPgr3alVr@smile.fi.intel.com>
References: <20230711220949.71881-1-srinivas.pandruvada@linux.intel.com>
         <20230711220949.71881-2-srinivas.pandruvada@linux.intel.com>
         <ZK7BL0GIPgr3alVr@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-07-12 at 18:05 +0300, Andy Shevchenko wrote:
> On Tue, Jul 11, 2023 at 03:09:47PM -0700, Srinivas Pandruvada wrote:
> > Some of the PM features can be locked or disabled. In that case,
> > write
> > interface can be locked.
> > 
> > This status is read via a mailbox. There is one TPMI ID which
> > provides
> > base address for interface and data register for mail box
> > operation.
> > The mailbox operations is defined in the TPMI specification. Refer
> > to
> > https://github.com/intel/tpmi_power_management/ for TPMI
> > specifications.
> > 
> > An API is exposed to feature drivers to read feature control
> > status.
> 
> ...
> 
> > +/*
> > + * TPMI PFS and per feature memory size can't exceed 4K.
> > + * Also PFS start and feature memory is 4K aligned.
> > + */
> > +#define TPMI_MAX_BUFFER_SIZE    (4 * 1024)
> 
> SZ_4K from sizes.h?
> 
> ...
I added a macro for size and uses sizes.h define.

> 
> > +#define TPMI_CONTROL_TIMEOUT_MAX_US    USEC_PER_SEC
> 
> > +#define TPMI_RB_TIMEOUT_MAX_US         USEC_PER_SEC
> 
> I think it's easier to get in a form (1 * ..._SEC)
> 
OK

> ...
> 
> > +static int tpmi_wait_for_owner(struct intel_tpmi_info *tpmi_info,
> > u8 owner)
> > +{
> > +       u64 control;
> > +
> > +       return read_poll_timeout(readq, control,
> > +                                owner ==
> > FIELD_GET(TPMI_CONTROL_STATUS_OWNER, control),
> > +                                TPMI_CONTROL_TIMEOUT_US,
> > TPMI_CONTROL_TIMEOUT_MAX_US, false,
> > +                                tpmi_info->tpmi_control_mem +
> > TPMI_CONTROL_STATUS_OFFSET);
> 
> Since you have "false" why not use readq_poll_timeout()?
> 
Changed in new version

> > +}
> 
> ...
> 
> > +       /* Wait for Run Busy clear */
> > +       ret = read_poll_timeout(readq, control, !(control &
> > TPMI_CONTROL_STATUS_RB),
> > +                               TPMI_RB_TIMEOUT_US,
> > TPMI_RB_TIMEOUT_MAX_US, false,
> > +                               tpmi_info->tpmi_control_mem +
> > TPMI_CONTROL_STATUS_OFFSET);
> 
> Ditto.
Done.

> 
> > +       if (ret)
> > +               goto done_proc;
> 
> ...
> 
> > +       size = pfs->pfs_header.num_entries * pfs-
> > >pfs_header.entry_size * sizeof(u32);
> > +       /* This size is coming from trusted hardware, but verify
> > anyway */
> 
> I would move this comment before size assignment that we already know
> that it's
> from the trusted hw.
Created a macro.

Thanks,
Srinivas

> 
> > +       if (size > TPMI_MAX_BUFFER_SIZE)
> > +               return;
> 

