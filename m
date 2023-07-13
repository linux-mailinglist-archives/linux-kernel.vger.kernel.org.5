Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4D6752905
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbjGMQsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235322AbjGMQsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:48:17 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A7D2D4E;
        Thu, 13 Jul 2023 09:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689266896; x=1720802896;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tj4bWOVtIkY6Zc/uDzLYtWIJ1eesZDcBpkM6O9U8etY=;
  b=biA66LTs5/XrNqkyB5cR/ip4+dV+yb0Mb86dWAp2Ke+Psw0mvhZJgsCE
   Z0J9cxmLTxNAI/932V9+4fBGPzKwWKLvzoAKwsuoWdKDVWO4Tztexf2ux
   hqBZjoTXViG3Z9BeOm5D0ksl2hfysupxYLA21xs/a9vFQpIXdv7NtWvgc
   3tGj05sLTQ/vDv1mnGhQB/P4eEqkna8YCPJjWDk0Osj7aKeSVoe6R+/3L
   YNhVM9nU3Jbwi+YpLmK0d5LSjOC0NtTpIeTkUkUtTb0XFwXd4W6gHPZvP
   5s1k9+/yBUW5vFXpqB3KXrNEtr7aFUMqe6K8TIkVX/XazXAT/EVm+M+cz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="365285932"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="365285932"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 09:48:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="751707087"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="751707087"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 13 Jul 2023 09:48:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJzUB-002ROg-2m;
        Thu, 13 Jul 2023 19:48:11 +0300
Date:   Thu, 13 Jul 2023 19:48:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] platform/x86/intel/tpmi: Add debugfs interface
Message-ID: <ZLAqyzaFaF1BUIdZ@smile.fi.intel.com>
References: <20230712225950.171326-1-srinivas.pandruvada@linux.intel.com>
 <20230712225950.171326-3-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712225950.171326-3-srinivas.pandruvada@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 03:59:49PM -0700, Srinivas Pandruvada wrote:
> Add debugfs interface for debugging TPMI configuration and register
> contents. This shows PFS (PM Feature structure) for each TPMI device.
> 
> For each feature, show full register contents and allow to modify
> register at an offset.
> 
> This debugfs interface is not present on locked down kernel with no
> DEVMEM access and without CAP_SYS_RAWIO permission.

...

> +	for (i = 0; i < tpmi_info->feature_count; ++i) {

As I explained in the discussion in previous version the preincrement is rising
unneeded attention when there is nothing special about it.

> +		pfs = &tpmi_info->tpmi_features[i];
> +		ret = tpmi_read_feature_status(tpmi_info, pfs->pfs_header.tpmi_id, &locked,
> +					       &disabled);
> +		if (ret) {
> +			locked = 'U';
> +			disabled = 'U';
> +		} else {
> +			disabled = disabled ? 'Y' : 'N';
> +			locked = locked ? 'Y' : 'N';
> +		}
> +		seq_printf(s, "0x%02x\t\t0x%02x\t\t0x%04x\t\t0x%04x\t\t0x%02x\t\t0x%08x\t%c\t%c\n",
> +			   pfs->pfs_header.tpmi_id, pfs->pfs_header.num_entries,
> +			   pfs->pfs_header.entry_size, pfs->pfs_header.cap_offset,
> +			   pfs->pfs_header.attribute, pfs->vsec_offset, locked, disabled);
> +	}

...

> +	for (count = 0; count < pfs->pfs_header.num_entries; ++count) {

Ditto.

> +		seq_printf(s, "TPMI Instance:%d offset:0x%x\n", count, off);
> +
> +		mem = ioremap(off, size);
> +		if (!mem) {
> +			ret = -ENOMEM;
> +			break;
> +		}
> +
> +		memcpy_fromio(buffer, mem, size);
> +
> +		seq_hex_dump(s, " ", DUMP_PREFIX_OFFSET, row_size, sizeof(u32), buffer, size,
> +			     false);
> +
> +		iounmap(mem);
> +
> +		off += size;
> +	}

...

> +	for (i = 0; i < tpmi_info->feature_count; ++i) {

Ditto.

> +		struct intel_tpmi_pm_feature *pfs;
> +		struct dentry *dir;
> +
> +		pfs = &tpmi_info->tpmi_features[i];
> +		snprintf(name, sizeof(name), "tpmi-id-%02x", pfs->pfs_header.tpmi_id);
> +		dir = debugfs_create_dir(name, tpmi_info->dbgfs_dir);
> +
> +		debugfs_create_file("mem_dump", 0444, dir, pfs, &tpmi_mem_dump_fops);
> +		debugfs_create_file("mem_write", 0644, dir, pfs, &mem_write_ops);
> +	}
> +}

-- 
With Best Regards,
Andy Shevchenko


