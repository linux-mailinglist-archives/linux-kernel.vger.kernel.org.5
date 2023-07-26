Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2EC763D07
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjGZQ4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjGZQ4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:56:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F239F211F;
        Wed, 26 Jul 2023 09:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690390580; x=1721926580;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=JzePxdujMch5SdQ4iwj3VbDUHOAXybVBdROP+jWCD5c=;
  b=cQCxTsfelWtoh2gi5Wsnju8hIJJs4zVRN8x5g0JNpVlgy/yuJai1L7G7
   6h4ioWNoa1MuYOrG2UZMLgxNWCf4L/yk7Wc6ibrD986prP+zdCcMX5W+H
   CPu+OKClgsKD2j3q/5oWoXpHaWgOj95hatV4ba6G6+aIcuHYjFVevnYF7
   3rDCW8BEc4GmUrXUlEo+EOAFmvPvpSeDUAIT/JoYTUlQsJakJOVC/GfNc
   SmMU7q/bqqe97zqnnjfQorcnky/pl18Cq2G0sWJsAvkZVFlZ5rZh/fXeQ
   NH4eD7vH2EH/KeJVbanyhSSJp/eZbDFJ3y4kEVa5ShZWC7T0+jfQxRdeS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="348355030"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="348355030"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 09:56:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="676777774"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="676777774"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.48.113])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 26 Jul 2023 09:56:17 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Huang, Kai" <kai.huang@intel.com>
Cc:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>
Subject: Re: [PATCH] x86/sgx: fix a NULL pointer
References: <CU4OBQ8MQ2LK.2GRBPLQGVTZ3@seitikki>
 <20230717202938.94989-1-haitao.huang@linux.intel.com>
 <dfb1f233-aebd-50cf-8704-e83b91ee110a@intel.com>
 <op.18ah5mn3wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <b5779418-e2a4-ca7a-866f-97e49cd272cb@intel.com>
 <op.18aontlmwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <eb1aea6f-3688-f871-2335-ff911a51ef52@intel.com>
 <op.18aqz7sbwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <ad2d9610-61c0-4719-9df1-0116ef317d8a@intel.com>
 <op.18asliuzwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <520111c9ccdd7356f9eaf20013e3e3c75b06398e.camel@intel.com>
 <d718cdda-2d5b-9b4b-d90d-55449ec1ac75@intel.com>
 <op.18b0u6evwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <e42435bd3949de94840fa3fae88be5f3bcc6373e.camel@intel.com>
 <df3ee23c71e9c653db43a38e1b3fddf31e0bce37.camel@intel.com>
Date:   Wed, 26 Jul 2023 11:56:16 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.18o7z2biwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <df3ee23c71e9c653db43a38e1b3fddf31e0bce37.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023 19:52:22 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Fri, 2023-07-21 at 00:32 +0000, Huang, Kai wrote:
>> On Wed, 2023-07-19 at 08:53 -0500, Haitao Huang wrote:
>> > Hi Dave and Kai
>> > On Tue, 18 Jul 2023 19:21:54 -0500, Dave Hansen  
>> <dave.hansen@intel.com>
>> > wrote:
>> >
>> > > On 7/18/23 17:14, Huang, Kai wrote:
>> > > > Also perhaps the patch title is too vague.  Adding more  
>> information
>> > > > doesn't hurt
>> > > > I think, e.g., mentioning it is a fix for NULL pointer  
>> dereference in
>> > > > the EAUG
>> > > > flow.
>> > >
>> > > Yeah, let's say something like:
>> > >
>> > > 	x86/sgx: Resolve SECS reclaim vs. page fault race
>> > >
>> > The patch is not to resolve SECS vs #PF race though the race is a
>> > necessary condition to cause the NULL pointer. The same condition  
>> does not
>> > cause NULL pointer in the ELDU path of #PF, only in EAUG path of #PF.
>> >
>> > And the issue really is the NULL pointer not checked and fix was to  
>> reuse
>> > the same code to reload SECS in ELDU code path for EAUG code path
>> >
>> >
>> > How about this:
>> >
>> > x86/sgx:  Reload reclaimed SECS for EAUG on #PF
>> >
>> > or
>> >
>> > x86/sgx: Fix a NULL pointer to SECS used for EAUG on #PF
>> >
>>
>> Perhaps you can add "EAUG" part to what Dave suggested?
>>
>> 	x86/sgx: Resolves SECS reclaim vs. page fault race on EAUG
>>
>> (assuming Dave is fine with this :-))
Sure, I can use this too.

> Btw, do you have a real call trace?  If you have, I think you can add  
> that to
> the changelog too because that catches people's eye immediately.

Previously I was not able to reproduce without SGX cgroup patches. Now I  
managed to get a trace with a QEMU setup with small EPC (8M), large RAM  
(128G) and 128 vCPUs:

[ 1682.914263] BUG: kernel NULL pointer dereference, address:  
0000000000000000
[ 1682.922966] #PF: supervisor read access in kernel mode
[ 1682.929115] #PF: error_code(0x0000) - not-present page
[ 1682.935264] PGD 0 P4D 0
[ 1682.938383] Oops: 0000 [#1] PREEMPT SMP NOPTI
[ 1682.943620] CPU: 43 PID: 2681 Comm: test_sgx Not tainted  
6.3.0-rc4sgxcet #12
[ 1682.951989] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS  
rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
[ 1682.965504] RIP: 0010:sgx_encl_eaug_page+0xc7/0x210
[ 1682.971359] Code: 25 49 8b 96 98 04 00 00 48 8d 40 48 48 89 42 08 48 89  
56 48 49 8d 96 98 04 00 00 48 89 56 50 49 89 86 98 04 00 00 49 8b 46 60  
<8b> 10 48 c1 e2 05 488
[ 1682.993330] RSP: 0000:ffffb2e64725bc00 EFLAGS: 00010246
[ 1682.999585] RAX: 0000000000000000 RBX: ffff987e5abac428 RCX:  
0000000000000000
[ 1683.008059] RDX: 0000000000000001 RSI: 0000000000000000 RDI:  
ffff987e61aee000
[ 1683.016533] RBP: ffffb2e64725bcf0 R08: 0000000000000000 R09:  
ffffb2e64725bb58
[ 1683.025008] R10: 0000000000000000 R11: 00007f3f5c418fff R12:  
ffff987e61aee020
[ 1683.033479] R13: ffff987e505bc080 R14: ffff987e61aee000 R15:  
ffffb2e6420fcb20
[ 1683.041949] FS:  00007f3f5cb48740(0000) GS:ffff989cfe8c0000(0000)  
knlGS:0000000000000000
[ 1683.051540] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1683.058478] CR2: 0000000000000000 CR3: 0000000115896002 CR4:  
0000000000770ee0
[ 1683.067018] DR0: 0000000000000000 DR1: 0000000000000000 DR2:  
0000000000000000
[ 1683.075539] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:  
0000000000000400
[ 1683.084085] PKRU: 55555554
[ 1683.087465] Call Trace:
[ 1683.090547]  <TASK>
[ 1683.093220]  ? __kmem_cache_alloc_node+0x16a/0x440
[ 1683.099034]  ? xa_load+0x6e/0xa0
[ 1683.103038]  sgx_vma_fault+0x119/0x230
[ 1683.107630]  __do_fault+0x36/0x140
[ 1683.111828]  do_fault+0x12f/0x400
[ 1683.115928]  __handle_mm_fault+0x728/0x1110
[ 1683.121050]  handle_mm_fault+0x105/0x310
[ 1683.125850]  do_user_addr_fault+0x1ee/0x750
[ 1683.130957]  ? __this_cpu_preempt_check+0x13/0x20
[ 1683.136667]  exc_page_fault+0x76/0x180
[ 1683.141265]  asm_exc_page_fault+0x27/0x30
[ 1683.146160] RIP: 0033:0x7ffc6496beea
[ 1683.150563] Code: 43 48 8b 4d 10 48 c7 c3 28 00 00 00 48 83 3c 19 00 75  
31 48 83 c3 08 48 81 fb 00 01 00 00 75 ec 48 8b 19 48 8d 0d 00 00 00 00  
<0f> 01 d7 48 8b 5d 101
[ 1683.172773] RSP: 002b:00007ffc64935b68 EFLAGS: 00000202
[ 1683.179138] RAX: 0000000000000003 RBX: 00007f3800000000 RCX:  
00007ffc6496beea
[ 1683.187675] RDX: 0000000000000000 RSI: 0000000000000000 RDI:  
0000000000000000
[ 1683.196200] RBP: 00007ffc64935b70 R08: 0000000000000000 R09:  
0000000000000000
[ 1683.204724] R10: 0000000000000000 R11: 0000000000000000 R12:  
0000000000000000
[ 1683.213310] R13: 0000000000000000 R14: 0000000000000000 R15:  
0000000000000000
[ 1683.221850]  </TASK>
[ 1683.224636] Modules linked in: isofs intel_rapl_msr intel_rapl_common  
binfmt_misc kvm_intel nls_iso8859_1 kvm ppdev irqbypass input_leds  
parport_pc joydev parport rapi
[ 1683.291173] CR2: 0000000000000000
[ 1683.295271] ---[ end trace 0000000000000000 ]---



I'll add this to the commit as well.

Thanks
Haitao
