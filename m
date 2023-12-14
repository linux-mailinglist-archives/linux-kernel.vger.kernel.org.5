Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAA2812CA0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443591AbjLNKO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443576AbjLNKO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:14:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B0EE0;
        Thu, 14 Dec 2023 02:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702548902; x=1734084902;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=j/tIEo/VvMKL1LFNLxLpU6GIsg5Zh2L0h8q3lAMEyg8=;
  b=JeBPofI7wJWI/DZVbkri/qEZcOPxcXhpfetQ7YXsrZbPvW3goAweDYf8
   yJYvhcpVufovHIJ5xcmxbvD54JtdFLvaNL1uINSVvypFgYfmqh4a71+kP
   iTY4D0wq7Rhp9rZqXi7LXGm+rlYVTlo37Ql9y1jiRObo1m0ypAIv4oVRd
   oONJIRg8ZRpZbMjugP2PKw9cIAjG06dCbalwstDYyelmNzPT3J2cK2c/P
   VwWCz4dvdQD6EsF2tNAH+2TKhSevrsGdT7L27d8M87AIh0zvGGRyF9yyV
   rslMu9zon6fQnu7pzYwjwaxCwOl6uK71hik9xglWgimbqaLDq9N+v2za4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="394845751"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="394845751"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 02:15:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="777845815"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="777845815"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.mshome.net) ([10.237.66.38])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 02:14:59 -0800
Date:   Thu, 14 Dec 2023 12:14:56 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 07/29] selftests/resctrl: Refactor get_cbm_mask() and
 rename to get_full_cbm()
In-Reply-To: <150fbd26-cb36-48f8-bd23-fc2eb83f03f2@intel.com>
Message-ID: <77e1b59b-1b7d-9ed0-41a5-fe252daec38@linux.intel.com>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com> <20231211121826.14392-8-ilpo.jarvinen@linux.intel.com> <150fbd26-cb36-48f8-bd23-fc2eb83f03f2@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1036506092-1702548902=:5690"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1036506092-1702548902=:5690
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 13 Dec 2023, Reinette Chatre wrote:

> Hi Ilpo,
> 
> On 12/11/2023 4:18 AM, Ilpo Järvinen wrote:
> 
> > -int get_cbm_mask(char *cache_type, char *cbm_mask)
> > +static int get_bit_mask(const char *filename, unsigned long *mask)
> >  {
> > -	char cbm_mask_path[1024];
> >  	FILE *fp;
> >  
> > -	if (!cbm_mask)
> > +	if (!filename || !mask)
> >  		return -1;
> >  
> > -	sprintf(cbm_mask_path, "%s/%s/cbm_mask", INFO_PATH, cache_type);
> > -
> > -	fp = fopen(cbm_mask_path, "r");
> > +	fp = fopen(filename, "r");
> >  	if (!fp) {
> > -		ksft_perror("Failed to open cache level");
> > -
> > +		fprintf(stderr, "Failed to open bit mask file '%s': %s\n",
> > +			filename, strerror(errno));
> >  		return -1;
> >  	}
> > -	if (fscanf(fp, "%s", cbm_mask) <= 0) {
> > -		ksft_perror("Could not get max cbm_mask");
> > +
> > +	if (fscanf(fp, "%lx", mask) <= 0) {
> > +		fprintf(stderr, "Could not read bit mask file '%s': %s\n",
> > +			filename, strerror(errno));
> >  		fclose(fp);
> >  
> >  		return -1;
> 
> After seeing the new effort to correct the perror() messages it is
> not obvious to me why this patch changes these particular messages to
> use fprintf(stderr, ...).

Yeah, good point, thanks. Somehow I dismissed the opportunity and thought 
there's no need to do anything even if this came up during series conflict 
resolution phase.


-- 
 i.

--8323329-1036506092-1702548902=:5690--
