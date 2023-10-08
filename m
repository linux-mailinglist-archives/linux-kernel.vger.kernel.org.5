Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975EE7BCD63
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 10:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344543AbjJHIzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 04:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344509AbjJHIzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 04:55:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63F1C5
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 01:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696755306; x=1728291306;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=fg15z7C0Ds/CR/5uFP/gDGO+WpHuVd96XbJUma4TjEo=;
  b=UiAAdDGFeFTNkNx4M4R1ycQ1k4037lpNULKWDrO/b9i70wgNZJdIjZ6p
   CUajA4V45TD3WRW0sw9zzG/6nm6XBhC6CD2AvGTy31ZVDDIWzQdTEnWRR
   /QWEBJf7fuI0mXYvRQplMY+eZIkbnLC8a+9A81EqppEcKS4kQON/iHKtO
   z00wUYDkKKHjY3aQk7pSchd3WrofE5030SJhAnAQkOw4a/whkKeXg4eng
   cIQq51wNy4ER5GYMtU45KfqlWhIspqc5+dizXIwoeT4bZ5S4ctZkz/2fR
   089CnMnPbaP3lzVdpt7Zb9mu7vEsXAEamxfN6FnmaL5y75c0qfg1W9qif
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="448178189"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="448178189"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 01:55:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="843379542"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="843379542"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 01:55:03 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     tglx@linutronix.de
Cc:     arjan@linux.intel.com, bp@alien8.de, chang.seok.bae@intel.com,
        linux-kernel@vger.kernel.org, nik.borisov@suse.com, x86@kernel.org,
        qiuxu.zhuo@intel.com
Subject: Re: [patch V4 00/30] x86/microcode: Cleanup and late loading enhancements
Date:   Sun,  8 Oct 2023 16:54:56 +0800
Message-Id: <20231008085456.71646-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231002115506.217091296@linutronix.de>
References: <20231002115506.217091296@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
>    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git ucode-v4
> ...

Test Result (same as ucode-v3)
------------------------------
Tested 'ucode-v4' on an Intel Sapphire Rapids server that both early load
and late load worked well. For more details, please refer to the test below:


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


Dmesg log
---------
// Early load OK.
[    0.000000] microcode: updated early: 0xab000130 -> 0xab000140, date = 2022-11-04

...
[   20.215653] microcode: Microcode Update Driver: v2.2.
...

// Late load OK.
[   27.596822] microcode: Updated to revision 0xab000160, date = 2022-11-16
[   27.606848] microcode: load: updated on 96 primary CPUs with 96 siblings
[   27.614789] microcode: revision: 0xab000140 -> 0xab000160

Thanks!
-Qiuxu
