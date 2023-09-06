Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E5F794345
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 20:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243852AbjIFSts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 14:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjIFStq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 14:49:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10533CF1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 11:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694026183; x=1725562183;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Fy5qFyHVN8tyAk/fRNKBrlqYUDb6GIiwnpOu4fUSTpg=;
  b=DplL7/QzSpoMnkgOIlQrbmDl78rBQztx8/sXDH1Vh/t3WO7/Bl9WYI2K
   eP9gK2d0Q6kET9VYxeRZdFurYdkWuvQlqrLnq2V1GTigHdfiCCk2swY8u
   Jq9qFoVX+vmDBEdJFM1PcVPqdNMYDuRkpabB4cM1lOP7AB6oT4+IC8sK8
   eAaRUmbwUMcDC+/bR2ewgQSjvpDW3S9sEQnV/d1UM76+UhackSFGlG1eR
   /mVwTZiaw5315y1nt3QDMC0pCndi56TQqE6gazFFBamsRq1cZSODAKd1M
   f/qN4MupMVN2IcEXuawB0oxzAn7gbVwP8SiJfZ49Sdx+psxjrV5ktOCfR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="379864333"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="379864333"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 11:49:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="856576698"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="856576698"
Received: from lmgabald-mobl2.amr.corp.intel.com (HELO [10.212.242.149]) ([10.212.242.149])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 11:49:41 -0700
Message-ID: <08dd36d0-08e1-cf55-355e-5c21132c44fb@intel.com>
Date:   Wed, 6 Sep 2023 11:49:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v6 1/3] x86/fpu: Measure the Latency of XSAVES and XRSTORS
Content-Language: en-US
To:     Yi Sun <yi.sun@intel.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        sohil.mehta@intel.com, ilpo.jarvinen@linux.intel.com,
        heng.su@intel.com, tony.luck@intel.com,
        dave.hansen@linux.intel.com, yi.sun@intel.intel.com
References: <20230901143414.1664368-1-yi.sun@intel.com>
 <20230901143414.1664368-2-yi.sun@intel.com> <ZPMTVNM2oBCdSYjJ@gmail.com>
 <ZPOIVmC6aY9GBtdJ@tassilo> <ZPhD7B+pXyeP2BPS@ysun46-mobl.ccr.corp.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ZPhD7B+pXyeP2BPS@ysun46-mobl.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/23 02:18, Yi Sun wrote:
> Or just use PT

I'd really like to be able to use this mechanism across a wide range of
systems over time and vendors.  For instance, if Intel's AVX512 XSAVE
implementation is much faster than AMD's, it would be nice to show some
apples-to-apples data to motivate AMD to do better.  We can't do that
with PT.
