Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853DF7C751E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441849AbjJLRwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379624AbjJLRwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:52:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF3ACA;
        Thu, 12 Oct 2023 10:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697133137; x=1728669137;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=6t7X2w/3C7D9w+nEdJJDSIhuapkwmqEAdLFRUJInO9I=;
  b=UQyVwMclxPMrcuywmSWSkuaI4Zg2bMqnG/U4NmmWKXKXEqj5k7fTPb+O
   FfU9k/U8ULrgS0Q0CCdQsyJGoxe9mI89uSeWO6MWeuMZ6L5OGl7Mwkt6k
   8hEyPQFTxCDI8T8dP1rirer0V12UDPAhaJuyjPSfJ9n9x5Lo0MJObFIbK
   M8/ZyKuJHvTGoaCooZV4Tb2tPzdHZmiUZRg3v7PKqRtd3WYPR+P+dsOEz
   Zu0NYlSnOUSYQjOdBiEd33IwrZzskccMq3h1L/DlXIbs0w21xCLJ0a1fL
   hkvN7tYOfq25IprFTFFUyhxlHaPbkXjhzG91qtZj/VDC0CLBpMR0Fn7jA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="451487320"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="451487320"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 10:52:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="928092841"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="928092841"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 10:52:17 -0700
Received: from [10.54.75.156] (debox1-desk1.jf.intel.com [10.54.75.156])
        by linux.intel.com (Postfix) with ESMTP id D1D635807A3;
        Thu, 12 Oct 2023 10:52:16 -0700 (PDT)
Message-ID: <7f2fd7a054912960c6599e4a62e2095d1567aab8.camel@linux.intel.com>
Subject: Re: [PATCH V3 09/16] platform/x86/intel/pmc: Allow
 pmc_core_ssram_init to fail
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Date:   Thu, 12 Oct 2023 10:52:16 -0700
In-Reply-To: <ac7be397-bc9-a135-9498-72dfa1fe456d@linux.intel.com>
References: <20231012023840.3845703-1-david.e.box@linux.intel.com>
         <20231012023840.3845703-10-david.e.box@linux.intel.com>
         <ac7be397-bc9-a135-9498-72dfa1fe456d@linux.intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-10-12 at 18:01 +0300, Ilpo J=C3=A4rvinen wrote:
> On Wed, 11 Oct 2023, David E. Box wrote:
>=20
> > Currently, if the PMC SSRAM initialization fails, no error is returned =
and
> > the only indication is that a PMC device has not been created.=C2=A0 In=
stead,
> > allow an error to be returned and handled directly by the caller.
>=20
> You might have a good reason for it but why isn't the call into=20
> pmc_core_pmc_add() changed in this patch to take the error value into=20
> account?

Good catch. The return value of pmc_core_pmc_add() is first used in the nex=
t
patch but should be used here.

David

>=20
> (I vaguely remember this was probably discussed in the context of some=
=20
> earlier patch touching this area that it was about the other code dealing=
=20
> with NULLs or something like that).

