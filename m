Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E017B1E7A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjI1Ndd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjI1Ndb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:33:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE63C1A1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 06:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695908009; x=1727444009;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TV50ur6EsvFD+NIQva87XnbSKRPe7K1V/2028Lb4zYE=;
  b=Zw71CayG4jsFtFQYWvPXN6KAoaQY0T2BIscmmHjwt5kYcf7iDEozUu44
   tZhugjPMbofMcR5sc758yXsCHBgPKzqw4J8W4kTCGmBwbVca0Ib/3ERNB
   tdMMYrEB6K7kCS3PCYrOpVBFSHjlL7Eet61CyEwO1ZxRHeFfTsWDYDGYg
   O1mLx/fL4B+BFJGeehT16aAevrQGxiE4gCD/Mqo1TUH1Wk3uSMO63anvM
   DRLnyLTO9wMurkwXLTNc/4ckeNwvJVvysvtkMK0EV6y4HE4qQuY1ePzqG
   zUTjhkTdIiIXvHZ2H9pnUehZ9zQpNjNUvRECT3TrbrJPdvgZtNHd19Fqx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="367123735"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="367123735"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 06:22:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="784686572"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="784686572"
Received: from jveerasa-mobl.amr.corp.intel.com (HELO [10.255.231.134]) ([10.255.231.134])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 06:22:54 -0700
Message-ID: <ee1907a1-2f04-cfa3-9f09-75b94994e88b@intel.com>
Date:   Thu, 28 Sep 2023 06:22:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 0/7] Introduce persistent memory pool
Content-Language: en-US
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
        Baoquan He <bhe@redhat.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        stanislav.kinsburskii@gmail.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-mm@kvack.org, kys@microsoft.com, jgowans@amazon.com,
        wei.liu@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        graf@amazon.de, pbonzini@redhat.com
References: <01828.123092517290700465@us-mta-156.us.mimecast.lan>
 <ZRPBRkXrYvbw8+Lt@MiWiFi-R3L-srv> <20230927161319.GA19976@skinsburskii.>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230927161319.GA19976@skinsburskii.>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/23 09:13, Stanislav Kinsburskii wrote:
> Once deposited, these pages can't be accessed by Linux anymore and thus
> must be preserved in "used" state across kexec, as hypervisor state is
> unware of kexec.

If Linux can't access them, they're not RAM any more.  I'd much rather
remove them from the memory map and move on with life rather than
implement a bunch of new ABI that's got to be handed across kernels.
