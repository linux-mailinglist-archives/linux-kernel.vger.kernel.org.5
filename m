Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A986C7ADD88
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 19:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjIYRDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 13:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYRDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 13:03:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412CAA2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695661397; x=1727197397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=2YGqQ59W49DKDa7rl7BncAHczo5t6r7R4sqaWjrN8wE=;
  b=FkG+WUn+CqghVewzmrwInWms3Bpmyh6esBucddLktHagyhGJTw/CH88Z
   a9kbu+HJlKvNkl30PIPvYNp7+025az8pXyPz7KN3QIJcNbfgJnzlXxpyi
   WKYTB6rTF9IcNujRuBiObpYgZfsgaqlTkYeHkZFPOdPd6kU8DWkNMb/pr
   /bRJWaQKevbIA2O4d3Rex6fA7XfoBVazYSn0/mXvFYRR72r3RoaFo5Ejd
   fqEvwFNLbxruRJ9q9aOi7KSssk1kOGnzdaP/PiqeX4IXwlmQ9LHMOYJKJ
   lbx8Wbd9Jo0c3XyFTo5YGPYn+i1NHBeMY+3o9y5AXxvI71a0JsK0EhgEF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="384069694"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="384069694"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 10:02:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="698056544"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="698056544"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 10:02:31 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     tglx@linutronix.de
Cc:     arjan@linux.intel.com, bp@alien8.de, chang.seok.bae@intel.com,
        linux-kernel@vger.kernel.org, nik.borisov@suse.com, x86@kernel.org,
        qiuxu.zhuo@intel.com
Subject: Re: [patch V3 00/30] x86/microcode: Cleanup and late loading enhancements
Date:   Tue, 26 Sep 2023 01:02:24 +0800
Message-Id: <20230925170224.57670-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230912065249.695681286@linutronix.de>
References: <20230912065249.695681286@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

> ...
> 
> The series is also available from git:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git ucode-v3
> ...

I tested the 'ucode-v3' code above, and it worked well on my tested machine.
For more details, please refer to the test below:

Tested Machine
--------------
  Intel Sapphire Rapids server with 2 sockets, each containing 48 cores,
  resulting in a total of 192 threads.


Microcodes
----------
  a) Microcode revisison of CPU                        : 0xab000130
  b) Microcode revision in the initramfs               : 0xab000140 // for early load
  c) Microcode revision in /lib/firmware/intel-ucode/* : 0xab000160 // for late load

     [ Microcode b) & c) headers both contain minirev 0x2b0000a1. ]

Test Results
------------
  The following test results showed that this 'ucode-v3' worked well for both
  early microcode loading and late microcode loading on this tested machine.
  Based on the test results:

  Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>


Dmesg log
---------
  // Early load OK.
  [    0.000000] microcode: updated early: 0xab000130 -> 0xab000140, date = 2022-11-04

  ...
  [   20.216675] microcode: Microcode Update Driver: v2.2.
  ...

  // Late load OK.
  [  199.343654] microcode: Updated to revision 0xab000160, date = 2022-11-16
  [  199.352434] microcode: Microcode load: updated on 96 primary CPUs with 96 siblings
  [  199.361069] microcode: Microcode revision: 0xab000140 -> 0xab000160
  ...

Thanks!
-Qiuxu
