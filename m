Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339DC751426
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjGLXI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbjGLXHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:07:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECDA271B;
        Wed, 12 Jul 2023 16:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689203249; x=1720739249;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X0ev2njybRILWDnx6CfYSNeQvyx6ndrvO3cLSpr75KU=;
  b=JHFZkDK6oCZnAHiLJSFZETKMQtLpQfQbI1dd/dnlBOxpYxgNAQ7PaPkA
   32j0kvrcZVMv+7CFEOs4tgIlH/O/vPEXh9+oo0B3OeBoF2NpV/011mudp
   gEwwJpuAdhbBfLJfUHvA6zRLh5Uojsda9sQV6HWZyLIMOkE1mYcONYofK
   oNpalI3HjoZeEqltdctphTV1dr5Y8m1CAfZMVfeuH2WnSpiARNPyV/0D6
   WpKwpZJtOkzmqKdGrLDPOIggL/3YcgD+DbIbmnzBPjLRAzAGwPn1X8xob
   6UJSUVoy1oEF5wRDfix2iiaErUd4ckuQh5G4Ubpm1UM9NOT9if3u6Bxc1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="451388355"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="451388355"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 16:06:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="751351815"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="751351815"
Received: from nlsegerl-mobl1.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.182.248])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 16:06:51 -0700
Message-ID: <befd890f0252f0cec193d3bea379c2e23e62e824.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/3] platform/x86/intel/tpmi: Add debugfs interface
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 12 Jul 2023 16:06:50 -0700
In-Reply-To: <ZK7DNdlUvUZ5deho@smile.fi.intel.com>
References: <20230711220949.71881-1-srinivas.pandruvada@linux.intel.com>
         <20230711220949.71881-3-srinivas.pandruvada@linux.intel.com>
         <ZK7DNdlUvUZ5deho@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-07-12 at 18:13 +0300, Andy Shevchenko wrote:
> On Tue, Jul 11, 2023 at 03:09:48PM -0700, Srinivas Pandruvada wrote:
> > Add debugfs interface for debugging TPMI configuration and register
> > contents. This shows PFS (PM Feature structure) for each TPMI
> > device.
> > 
> > For each feature, show full register contents and allow to modify
> > register at an offset.
> > 
> > This debugfs interface is not present on locked down kernel with no
> > DEVMEM access and without CAP_SYS_RAWIO permission.
> 
> ...
> 
> >  struct intel_tpmi_pm_feature {
> >         struct intel_tpmi_pfs_entry pfs_header;
> >         unsigned int vsec_offset;
> > +       struct intel_vsec_device *vsec_dev;
> 
> Hmm... I don't know the layout of pfs_header, but this may be 4 bytes
> less
> if you move it upper.
The pfs_header is packed with size of 64 bit. So size will not change.
 
> 
> >  };
> 
> ...
> 
> > +       for (count = 0; count < pfs->pfs_header.num_entries;
> > ++count) {
> 
> > +               size = pfs->pfs_header.entry_size * sizeof(u32);
> 
> You already used this once, perhaps a macro helper?
> Also you can add there a comment that this comes from the trusted hw.
> 
Added.

> > +               /* The size is from a trusted hardware, but verify
> > anyway */
> > +               if (size > TPMI_MAX_BUFFER_SIZE) {
> > +                       /*
> > +                        * The next offset depends on the current
> > size. So, can't skip to the
> > +                        * display of the next entry. Simply return
> > from this function with error.
> > +                        */
> > +                       ret = -EIO;
> > +                       goto done_mem_show;
> > +               }
> > +
> > +               buffer = kmalloc(size, GFP_KERNEL);
> > +               if (!buffer) {
> > +                       ret = -ENOMEM;
> > +                       goto done_mem_show;
> > +               }
> > +
> > +               seq_printf(s, "TPMI Instance:%d offset:0x%x\n",
> > count, off);
> > +
> > +               mem = ioremap(off, size);
> > +               if (!mem) {
> > +                       ret = -ENOMEM;
> > +                       kfree(buffer);
> > +                       goto done_mem_show;
> > +               }
> > +
> > +               memcpy_fromio(buffer, mem, size);
> > +
> > +               seq_hex_dump(s, " ", DUMP_PREFIX_OFFSET, row_size,
> > sizeof(u32), buffer, size,
> > +                            false);
> > +
> > +               iounmap(mem);
> > +               kfree(buffer);
> > +
> > +               off += size;
> > +       }
> > +
> > +done_mem_show:
> > +       mutex_unlock(&tpmi_dev_lock);
> > +
> > +       return ret;
> > +}
> 
> ...
> 
> > +       size = pfs->pfs_header.entry_size * sizeof(u32);
> > +       if (size > TPMI_MAX_BUFFER_SIZE)
> > +               return -EIO;
> 
> Again a dup even with a check.
> 
> ...
> 
> > +       top_dir = debugfs_create_dir(name, NULL);
> > +       if (IS_ERR_OR_NULL(top_dir))
> 
> I dunno if I told you, but after a discussion (elsewhere), I realized
> two things:
> 1) this one never returns NULL;
> 2) even if error pointer is returned, the debugfs API is aware and
>    will do nothing.
> 
> Hence this conditional is redundant.
Removed that. My original version didn't check the return value.

> 
> > +               return;
> 
> ...
> 
> > +       for (i = 0; i < tpmi_info->feature_count; ++i) {
> 
> Why preincrement?
Does it matter for a "for" loop increment?

Thanks,
Srinivas
> 
> > +               struct intel_tpmi_pm_feature *pfs;
> > +               struct dentry *dir;
> > +
> > +               pfs = &tpmi_info->tpmi_features[i];
> > +               snprintf(name, sizeof(name), "tpmi-id-%02x", pfs-
> > >pfs_header.tpmi_id);
> > +               dir = debugfs_create_dir(name, top_dir);
> > +
> > +               debugfs_create_file("mem_dump", 0444, dir, pfs,
> > &tpmi_mem_dump_fops);
> > +               debugfs_create_file("mem_write", 0644, dir, pfs,
> > &mem_write_ops);
> > +       }
> 

