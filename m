Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAFD7588D9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 01:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjGRXFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 19:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjGRXFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 19:05:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D12A1;
        Tue, 18 Jul 2023 16:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689721528; x=1721257528;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VhODeFD5Y7nvrP5kQrGvm1ObDGUld/Q0gKN5ouYFzwo=;
  b=EYf09KGQ1i2tr65SM3tQBrNtiTralvGQP7oeoarWNABXVcTXwv36eZyq
   +aQ1tdkaSRZT3lxwqA2y/3ZeimajPxePWPojDF322lKhHLFZngHxpTvdj
   sS93Pa5RSYoqoleMMharzewUYriW1sMaVQqHmIr/EczyghmMXdJYLyvvb
   0PFrruiInCEC+WXwtBPYkJx/RqYXCCEc8Nx/d+JfGihWtExTjJNm7tcJ6
   lXTwOCQlcwjii/bB4AzqH41D1CJ0IaF2tap6sEllRRB5g0T9fCo+cpJNh
   91wc3NTcve3gs/s+wuix9/y06SSx6TThsQ5nbOfAC+tqLeAX8crv1BlJB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="363790161"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="363790161"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 16:05:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="897711266"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="897711266"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 16:05:27 -0700
Date:   Tue, 18 Jul 2023 16:05:26 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v3 5/8] x86/resctrl: Add package scoped resource
Message-ID: <ZLcatuA9nndt075/@agluck-desk3>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230713163207.219710-6-tony.luck@intel.com>
 <ef5b5a4b-d8b1-b82f-243f-170213883f05@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef5b5a4b-d8b1-b82f-243f-170213883f05@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 01:43:45PM -0700, Reinette Chatre wrote:
> Hi Tony,
> 
> On 7/13/2023 9:32 AM, Tony Luck wrote:
> > Some Intel features require setting a package scoped model specific
> > register.
> > 
> > Add a new resource that builds domains for each package.
> 
> If I understand correctly the only purpose of this new resource
> is to know when the first CPU associated with a package
> comes online. Am I not reading this right? Using a resctrl resource
> for this purpose seems inappropriate and unnecessary while also
> making the code very hard to follow.

Reinette,

Yes. You understand.

I agree that this is blatant abuse of the resource structures.  I can find
another way to perform an action on the first CPU of a package online,
and the last CPU of a package offline.

-Tony
