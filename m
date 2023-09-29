Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B397B2FC9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 12:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbjI2KNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 06:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjI2KNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:13:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457F0199
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 03:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695982414; x=1727518414;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yMUdUXBMxkbONlcFbJ0cpOiSHGH/6S4pUNSsyx3HTtc=;
  b=cLShLRXVf8oB52jbjff6lqav9HpS36L0zQIJhRohlQV0/6AsojYOXOOL
   aXXiiewJ8D3YM/oX3fWWDbSSvoW8NCXxjiazvxBBfgfEfZFLbL0F6Xlro
   qr2UXeiTrFT02OvZGYEF8XjOTB/XcYDihfcgwtT1zhPdS8oL82ej6Qfwo
   EDUibYUqrstLW6kLHGG5jhCZRRao+auwbXHrJxaG9aQMoSgHRhvEWO8/c
   hFPBtV86kKKoX1crC2CtU+gZAhFWKmqmiTO7wos7yB02o+0PRQKf1NJQg
   0/xp1vUGoaiC8kYAgf0Zmd+YwAxwjhOY6nWGzKtaDid7cEjT8vCeSy3d7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="872802"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="872802"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 03:13:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="749914451"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="749914451"
Received: from mziotti-mobl4.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.34.13])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 03:13:27 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id B9E791095FB; Fri, 29 Sep 2023 13:13:24 +0300 (+03)
Date:   Fri, 29 Sep 2023 13:13:24 +0300
From:   "Shutemov, Kirill" <kirill.shutemov@intel.com>
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, Baoquan He <bhe@redhat.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        stanislav.kinsburskii@gmail.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-mm@kvack.org, kys@microsoft.com, jgowans@amazon.com,
        wei.liu@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        graf@amazon.de, pbonzini@redhat.com
Subject: Re: [RFC PATCH v2 0/7] Introduce persistent memory pool
Message-ID: <20230929101324.jgixt4jmqialchno@box.shutemov.name>
References: <ZRPBRkXrYvbw8+Lt@MiWiFi-R3L-srv>
 <20230927161319.GA19976@skinsburskii.>
 <ee1907a1-2f04-cfa3-9f09-75b94994e88b@intel.com>
 <20230927232548.GA20221@skinsburskii.>
 <b684d339-991d-be85-692c-75f21679ca69@intel.com>
 <20230928000230.GA20259@skinsburskii.>
 <760bbb08-83b4-7bb1-822f-2ceba26278a6@intel.com>
 <20230928003831.GA20366@skinsburskii.>
 <340596c9-d55d-5f8a-fa27-d95b0e10b20a@intel.com>
 <20230928024636.GA20423@skinsburskii.>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928024636.GA20423@skinsburskii.>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 07:46:36PM -0700, Stanislav Kinsburskii wrote:
> I'd answer yes, "System MAP" must be persisted across kexec.
> Could you elaborate on why there should be a mechanism to tell the
> kernel anything special about the existent "System map" in this context?
> Say, one can reserve a CMA region (or a crash kernel region, etc), store
> there some data, and then pass it across kexec. Reserved CMA region will
> still be a part of the "System MAP", won't it?

Em. When crash kernel starts all System RAM of the the first kernel
becomes E820_TYPE_RESERVED and only memory pre-allocated for crash
scenario becomes E820_TYPE_RAM. See crash_setup_memmap_entries().

Can't you go the same path? Report all deposited memory as
E820_TYPE_RESERVED.

Or do you have too many deposited memory ranges, so we would run out of
e820 entries?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
