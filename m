Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AC17AF96C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 06:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjI0Eca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 00:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjI0Ebk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 00:31:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50F24C37;
        Tue, 26 Sep 2023 17:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695773784; x=1727309784;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=t9Af1Zi6usLZRsDxAutl6VclVJK9TAWeZLdJbGkOdSY=;
  b=ddI1+awat/W5A+673tyAzsi/r9qGsGRkwxR+RmDrNK9oSYqBcTouz8G7
   x5GfEDqmVH8gvtR2A5eEn7QVA8gjjJyWwlW3yQJkmeHotorof3oOypJU7
   lGOa+YmOUTNQfyeGud48kWs3E39tceJAzCFPUIBxv4t0dN5YA5JVp/BYA
   4ECMd1h3wIbG7ce55Ll49fNagBi75X187r47fAZ5rtG5lInCP6pPIpnib
   CiZqrF6P4J5YC7Uezb8DXiit+0jMoykOWpdjPXmBXyuDrJ+03LbVr+QEb
   pHUrOhPgwqXtB4CcmAAKEmDXUnJEuyfyB1Xerwc/owc+LtJZDM/z7RS59
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="361077295"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="361077295"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 17:16:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="748993259"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="748993259"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 17:16:14 -0700
Received: from rabakare-mobl3.amr.corp.intel.com (unknown [10.212.145.15])
        by linux.intel.com (Postfix) with ESMTP id BF699580BBE;
        Tue, 26 Sep 2023 17:16:14 -0700 (PDT)
Message-ID: <850d1c1b6ef41cd039cec2fe0e67437d80856f14.camel@linux.intel.com>
Subject: Re: [PATCH 05/11] platform/x86:intel/pmc: Move get_low_power_modes
 function
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Date:   Tue, 26 Sep 2023 17:16:14 -0700
In-Reply-To: <a790e9e7-2748-5d2f-a035-20ef42ca87a2@linux.intel.com>
References: <20230922213032.1770590-1-david.e.box@linux.intel.com>
         <20230922213032.1770590-6-david.e.box@linux.intel.com>
         <a790e9e7-2748-5d2f-a035-20ef42ca87a2@linux.intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-26 at 18:56 +0300, Ilpo J=C3=A4rvinen wrote:
> On Fri, 22 Sep 2023, David E. Box wrote:
>=20
> > From: Xi Pardee <xi.pardee@intel.com>
> >=20
> > Some platforms will have a need to retrieve the low power modes as part=
 of
> > their driver initialization. As such, make the function global and call=
 it
> > from the platform specific init code.
>=20
> What is the real justification for this change, I don't think it's clearl=
y=20
> stated above?

It needs to be moved from core code to platform init code so that (in patch=
 9)
we can get the entry requirement list for the enabled modes, which won't be
known before this function is ran. I'll update the changelog.
