Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0797E8FAD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 12:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjKLLwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 06:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjKLLwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 06:52:19 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C5C2702;
        Sun, 12 Nov 2023 03:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699789936; x=1731325936;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=c6ExBF+wBoWPFPJvEml6ZUBLXMjGD5qgTHfmERRwIHY=;
  b=FQAth22M6foNOthx24LdbApc5jFEvT+AJZL59lZL3VaRHwL9szF0w/p+
   h91LzBJEYZ04PPJ/gz3LRuAzhxAXZfJem2MPVhjZX4o7hnAA1kgN/iZ04
   /FE7esCfccvTgMf10tMufNXft59ZiYLlQSeSH+qkia733WKSF3r4m3NKX
   p7P9YKNe0Ubw54P2iHOrM6/XitzZ9FJRu1LQufklWoKRlusA4qGoIffHv
   gGQ9USpfTbCl8j/a1WnYmgGJUNqP2eceIJ9eQsGPC6KNBYeuMMCiaEU3S
   X8C8yotfTwYQKPKQVG2IGaiJ5cbYnlusCcLH2GeLGmcrGHnlvFi+GMtlH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="454624780"
X-IronPort-AV: E=Sophos;i="6.03,297,1694761200"; 
   d="scan'208";a="454624780"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 03:52:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="834496288"
X-IronPort-AV: E=Sophos;i="6.03,297,1694761200"; 
   d="scan'208";a="834496288"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 03:52:15 -0800
Received: from abityuts-desk1.ger.corp.intel.com (abityuts-desk1.fi.intel.com [10.237.68.150])
        by linux.intel.com (Postfix) with ESMTP id 77869580DAB;
        Sun, 12 Nov 2023 03:52:13 -0800 (PST)
Message-ID: <e0869b55706915821a6aa1ba0140a784d263b01e.camel@linux.intel.com>
Subject: Re: [PATCH] intel_idle: add CPUIDLE_FLAG_IRQ_ENABLE to SPR C1 and
 C1E
From:   Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To:     Jon Kohler <jon@nutanix.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 12 Nov 2023 13:52:12 +0200
In-Reply-To: <22D82855-259A-425A-B401-2F51EEC3C746@nutanix.com>
References: <20220630194309.40465-1-jon@nutanix.com>
         <b35cf10b03b441a95704648e816ff1acc150f38b.camel@linux.intel.com>
         <20B0D65B-CB72-4F56-BF8F-7B212D04A7EA@nutanix.com>
         <22D82855-259A-425A-B401-2F51EEC3C746@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-11-10 at 20:00 +0000, Jon Kohler wrote:
> CPUIDLE_FLAG_IRQ_ENABLE

Hi, yes, I did run several experiments, and found that this change would ma=
ke
some micro benchmarks give worse score. I did a lot of repetitions assuming=
 I
was mixing noise with signal, but every time confirmed that enabling interr=
upts
in C1 made the score worse (like 1%).

I do not have explanation for this phenomena, but decided to not pursue thi=
s
idea.

Artem.=20
