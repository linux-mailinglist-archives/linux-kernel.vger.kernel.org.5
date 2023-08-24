Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8734F786FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239239AbjHXMxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241384AbjHXMxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:53:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE5319B7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 05:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692881557; x=1724417557;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dunuAZtbGWWJ6igJeK6u0DuFMGwv+wZZMA8ZHJSj/wc=;
  b=K66UdxDPh8TXYXn5yi7jKBsrNbF6IeeD/dTMvq7tUWcq4sFgSM+5/I97
   wJ1bnfNkko5xvy1FFEXhnJGRBdVqmKnJlLb5wDc54U5b0TncqWJw+rYO5
   cZ/2z5+fCrVKuyyPiwWlV34EazqF064SG6XiapOfNOIVXB6U6gg8loIBt
   jsWAAPyMKeLbT3rKtSTsXeEjDJacAbDjg8RDCGoQN4ogNHjG5KBR4+AWc
   6yJN99As35OsXqIDgcT6P+uYTexJqune3fLIt1lSgNE2hOXKomjRizfK3
   dfrwusodNw6aH2miCYI0+G+Wl9oFKSM1PfnT6m/Tma1aLAbpk0+uwSFj5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="353965555"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="353965555"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 05:52:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="686853099"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="686853099"
Received: from abedekar-mobl1.ger.corp.intel.com ([10.251.213.29])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 05:52:08 -0700
Date:   Thu, 24 Aug 2023 15:52:05 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        fenghua.yu@intel.com
Subject: Re: [PATCH 1/3] selftests/resctrl: Fix schemata write error check
In-Reply-To: <e7ea177261ded70f0c781841b0fb67fb1eb8909d.1692880423.git.maciej.wieczor-retman@intel.com>
Message-ID: <5c6a2065-6771-ed87-c5ed-843f4e184ff8@linux.intel.com>
References: <cover.1692880423.git.maciej.wieczor-retman@intel.com> <e7ea177261ded70f0c781841b0fb67fb1eb8909d.1692880423.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ki,

You're lacking a few people from the To/Cc list. Please see KERNEL 
SELFTEST FRAMEWORK entry in MAINTAINERS.

On Thu, 24 Aug 2023, Wieczor-Retman, Maciej wrote:

> Writing bitmasks to the schemata can fail when the bitmask doesn't
> adhere to some constraints defined by what a particular CPU supports.
> Some example of constraints are max length or being having contiguous

"being having" is not good English.

> bits. The driver should properly return errors when any rule concerning
> bitmask format is broken.
> 
> Resctrl FS returns error codes from fprintf() only when fclose() is
> called.

I wonder if this is actually related to libc doing buffering between 
fprintf() and the actual write() syscall.

> Current error checking scheme allows invalid bitmasks to be
> written into schemata file and the selftest doesn't notice because the
> fclose() error code isn't checked.
> 
> Add error check to the fclose() call.
> 
> Add perror() just after fprintf so a proper error message can be seen.
> 
> Signed-off-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>
> ---
>  tools/testing/selftests/resctrl/resctrlfs.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index bd36ee206602..a6d0b632cbc6 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -532,13 +532,17 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>  	}
>  
>  	if (fprintf(fp, "%s\n", schema) < 0) {
> -		sprintf(reason, "Failed to write schemata in control group");
> +		sprintf(reason, "fprintf() failed with error : %s",
> +			strerror(errno));

These should use snprintf() to make sure the buffer does not overflow. 

>  		fclose(fp);
>  		ret = -1;
>  
>  		goto out;
>  	}
> -	fclose(fp);
> +	ret = fclose(fp);
> +	if (ret)
> +		sprintf(reason, "Failed to write schemata in control group : %s",
> +			strerror(errno));
>  
>  out:
>  	ksft_print_msg("Write schema \"%s\" to resctrl FS%s%s\n",
> 

-- 
 i.

