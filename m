Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06272797DF5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240249AbjIGVcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjIGVcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:32:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134031BE6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 14:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694122333; x=1725658333;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uOFHji2mp0FYCt27UDl4aADtHaHkYEgXUonNnF8B460=;
  b=PyVKVmhfPZy9UhFIjQI1z0kpdmv6QO/oiCWB6KLNGwfnEN04TUJkifBv
   T0tMmvIrcBX/ksgKil/eNP/cte9b+q3bc4MJkqubKwcCzaXbBHIBAO0KA
   yCByHrhKqSHGy5+Jb3d1/Ssv4z/06osx+bsiACBPdT1gLAKuI+T4ChdV4
   mFzzzluk2dGqdy8a+Fz9/y90EjxYt2ciUlNB8nyjkV9FFKUmHlcsRdGoj
   +T9RHYWXUDENDuElh6tawncLZP2fMG30Nps3YAoBtmimKFMon/qKObnej
   g18IxyEgBV52Uko2nd1W5pKccgz1XYIjuzm89XyKK2Q0IU/Krb/ocEr3Y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="408474038"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="408474038"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 14:32:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="771451547"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="771451547"
Received: from ningle-mobl2.amr.corp.intel.com (HELO [10.209.13.77]) ([10.209.13.77])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 14:32:11 -0700
Message-ID: <81ee91fa-5546-4ca8-e8bc-765174938fc5@intel.com>
Date:   Thu, 7 Sep 2023 14:32:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] x86/platform/uv: Use alternate source for socket to node
 data
Content-Language: en-US
To:     Steve Wahl <steve.wahl@hpe.com>
Cc:     Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20230807141730.1117278-1-steve.wahl@hpe.com>
 <ad1ff365-4160-87b9-4199-ace5ff1250e1@intel.com>
 <ZPI1IP38l/X7K/k9@swahl-home.5wahls.com>
 <ZPdC2OxhPznQuYk8@swahl-home.5wahls.com>
 <29cd0ee1-c638-9d8e-8a1c-8c2aa2e167e7@intel.com>
 <ZPo/z0TaWahjgglT@swahl-home.5wahls.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ZPo/z0TaWahjgglT@swahl-home.5wahls.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/23 14:25, Steve Wahl wrote:
>> Does this need a stable@ tag when it gets applied?
> I hadn't thought about that.  I think it meets the requirements in
> stable-kernel-rules.rst.  And it looks like it should apply without
> conflicts or prerequisites.  So it probably should.  Is there a way to
> add a cc:stable tag at this point?

I can do it when I apply it.  I just wanted to make sure there wasn't a
good reason you left off the cc:stable.
