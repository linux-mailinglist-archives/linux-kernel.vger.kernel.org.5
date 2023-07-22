Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3780F75DE3F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 21:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjGVTSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 15:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGVTSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 15:18:38 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F415E7A;
        Sat, 22 Jul 2023 12:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690053517; x=1721589517;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/sWeK70vMwPIPRUy8fstWEekCfivAD4oofyJy80Hpdo=;
  b=ImxTSAaiWzDK8MkBP7vWHG7R9eBuc1AJx2oyBtFyh15xhY5SR/rqLrIV
   06jxerl8awdhfT0L+lgYCTYpj3r1RWfzo0kIPXNQzqMHY/b5ll+Oah5+b
   x1ZZK/5vLcKSyK3ZslmT+H9PiZ3nPXrIc9E9JJSmsUgSNG4AomljlVDgg
   F62HOTkJn6mh9GomJ1miTux7N+b7NRwtYuXS9XBHJtS59B+q1lcwqaXPg
   E9S/PGKMRO60/2u1bBTwzjK9IGlTpci9Mqpb9cVYaAz/7T7QYmecwNu4D
   xXdKP07n6h5bgkdVnQU+NC95lTher5Vl10BVmu1hBZBEbhDrUH3aN88Ui
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="357218110"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="357218110"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 12:18:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="868599686"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 12:18:37 -0700
Date:   Sat, 22 Jul 2023 12:18:35 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>
Cc:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v3 3/8] x86/resctrl: Add a new node-scoped resource to
 rdt_resources_all[]
Message-ID: <ZLwrizekJ0qO2ppy@agluck-desk3>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230713163207.219710-4-tony.luck@intel.com>
 <769521ee-6907-1613-442f-e2915a8ea554@intel.com>
 <ZLcY1MQr5/Ibnv7N@agluck-desk3>
 <076a76c9-ab57-cae2-e6e4-99d26921b578@intel.com>
 <ZLh9y8LQNkR/VhOq@agluck-desk3>
 <95c56b28-414d-b148-055f-b41e7da9401a@intel.com>
 <SJ1PR11MB6083E1B292969DA2AE1FC67DFC3EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083E1B292969DA2AE1FC67DFC3EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 09:56:50PM +0000, Luck, Tony wrote:
> This does seem a worthy target.
> 
> I started on a patch to so this ... but I'm not sure I have the stamina or the time
> to see it through. 

I was being a wuss. I came back at this on Friday from a slightly
different perspective, and it all came togeteher fairly easily.

New series posted here:
	https://lore.kernel.org/all/20230722190740.326190-1-tony.luck@intel.com/

-Tony
