Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91B57B296A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 02:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjI2ALW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 20:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjI2ALV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 20:11:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC0F92;
        Thu, 28 Sep 2023 17:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695946279; x=1727482279;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gjkSVOUjK8t1WLURW1YR+vElGQY+naItEdlppoHYujM=;
  b=Q4qCXFgV4Fa6QLjLwMj8GiSms2OFihc7O0WiLRcSzb7RlEcb0O+XbuBZ
   IZQgsic/2hdibxe3Rz5wKI8PL7dZ1FQZbMU4svknDb+A6g/c4vx0SHC6q
   ObFXVQfXEZEYivcZN9EUVuw+Q73TeaU9NtRxVuGWCGkx2iO8oNv4D0Wfu
   xQApaNrZcZ/ar8QmZE0aXp9PXGu8mm23f4QS9jqL1FuoVCaQZ337xOOCz
   KhdOZt4WcPLXuGGON4xg3gtEpi+MvcTq4toHFRPVBQ/xOvMGU8dRv3N2R
   3Eczk2Aud+6wLUB9+ogZ9hUvLhQOi/ekQwqTbBW2u6bFF1TZZ7vHuedk3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="379475787"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="379475787"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 17:11:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="873486737"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="873486737"
Received: from jveerasa-mobl.amr.corp.intel.com (HELO [10.255.231.134]) ([10.255.231.134])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 17:11:11 -0700
Message-ID: <e24da7cd-fcfd-e4d3-16dd-9bb102adcab4@intel.com>
Date:   Thu, 28 Sep 2023 17:11:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6] x86/sgx: Resolves SECS reclaim vs. page fault for EAUG
 race
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        dave.hansen@linux.intel.com, kai.huang@intel.com,
        jarkko@kernel.org, linux-kernel@vger.kernel.org,
        linux-sgx@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     kristen@linux.intel.com, seanjc@google.com, stable@vger.kernel.org,
        sohil.mehta@intel.com
References: <20230728051024.33063-1-haitao.huang@linux.intel.com>
 <f2b00069-e837-ff1e-2d03-b446df49bff0@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <f2b00069-e837-ff1e-2d03-b446df49bff0@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/23 16:08, Reinette Chatre wrote:
> I'd like to check in on the status of this patch. This two month old
> patch looks to be a needed fix and has Jarkko and Kai's review tags,
> but I am not able to find it queued or merged in tip or upstream.
> Apologies if I did not look in the right spot, I just want to make
> sure it did not fall through the cracks if deemed needed.

It fell through the cracks.  Sorry about that.  It's in x86/urgent now.
