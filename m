Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC987B6CB6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239906AbjJCPN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjJCPNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:13:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CF7A1;
        Tue,  3 Oct 2023 08:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696346002; x=1727882002;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=JyQ+b2l4HyqGplvW8pMX1Xx0aY+GgEvR6svKIcK2blk=;
  b=PDOv3TVU1KmaGm7Yo5iiCkmfzkbJ+ERb2ztw163LIo/SFEh9CRV7QPog
   PO+3EOhT3ZV0qDg1s6E0LM5oTf4BhzDkaLwGEIomQeNG3bHcTY8MNC9tE
   dtPFFpLecF0iin/NQ+A1ooyEU7qrBHVujxT/q84c2WxCQerhNVL0Tkp+w
   xUJrjxloU5hrwE9VYEG/fnRXu8K4agECjaFZKsO0jGXyzp7KdxIZnV6eA
   9jwW33utrRFNkZwgVl3x0+foKXW8XUjkTWBV1PQt/IkQMZ6Lwy0i1ZNtw
   r57Xwv6OciumQ0IUfcAbjZh1XR/2OTwSJTW6NYIr+oTJdKEYgU1REf2Al
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="362267989"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="362267989"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 08:13:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="780332107"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="780332107"
Received: from spandruv-desk.jf.intel.com (HELO spandruv-desk.amr.corp.intel.com) ([10.54.75.14])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 08:13:21 -0700
Message-ID: <ab0ab04980b07e2893d9672b96311230ac981e40.camel@linux.intel.com>
Subject: Re: [UPDATE][PATCH] platform/x86/intel-uncore-freq: Conditionally
 create attribute for read frequency
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 03 Oct 2023 08:13:21 -0700
In-Reply-To: <6c59be5-1ff1-d0b1-5960-3789fe10c692@linux.intel.com>
References: <20231002131817.1590966-1-srinivas.pandruvada@linux.intel.com>
         <6c59be5-1ff1-d0b1-5960-3789fe10c692@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi llPo,

On Tue, 2023-10-03 at 16:10 +0300, Ilpo J=C3=A4rvinen wrote:
> On Mon, 2 Oct 2023, Srinivas Pandruvada wrote:
>=20
> > When the current uncore frequency can't be read, don't create
> > attribute
> > "current_freq_khz" as any read will fail later. Some user space
> > applications like turbostat fail to continue with the failure. So,
> > check
> > error during attribute creation.
> >=20
> > Fixes: 8a54e2253e4c ("platform/x86/intel-uncore-freq: Uncore
> > frequency control via TPMI")
>=20
> Hi,
>=20
> Thanks for the update but that commit id looks bogus, or where the
> value=20
> is used w/o error check?

commit 8a54e2253e4c25e5b61c9a9bee157bb52da5d432
Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date:   Thu Apr 20 15:05:14 2023 -0700

    platform/x86/intel-uncore-freq: Uncore frequency control via TPMI


This is the commit exposed the issue. This is not the commit which
changed the code in question.=20


I can add also
Fixes: dbce412a7733 ("platform/x86/intel-uncore-freq: Split common and
enumeration part")

But the change even before that as this commit just reorganized code
but because of change of folders, that will look like correct commit.


Thanks,
Srinivas



