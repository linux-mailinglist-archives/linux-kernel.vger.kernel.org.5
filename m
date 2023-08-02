Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46B276CB3C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjHBKsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjHBKsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:48:01 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 414C71FD6;
        Wed,  2 Aug 2023 03:47:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 612DB80AE;
        Wed,  2 Aug 2023 10:47:53 +0000 (UTC)
Date:   Wed, 2 Aug 2023 13:47:52 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v5 3/3] serial: core: Fix serial core controller port
 name to show controller id
Message-ID: <20230802104752.GD14799@atomide.com>
References: <20230725054216.45696-4-tony@atomide.com>
 <202308021529.35b3ad6c-oliver.sang@intel.com>
 <20230802092354.GC14799@atomide.com>
 <2023080236-gurgling-violet-b54e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023080236-gurgling-violet-b54e@gregkh>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> [230802 09:40]:
> On Wed, Aug 02, 2023 at 12:23:54PM +0300, Tony Lindgren wrote:
> > * kernel test robot <oliver.sang@intel.com> [230802 08:16]:
> > > from serial, we observed last print out is:
> > > 
> > > [   15.584772][  T954] EDAC MC0: Giving out device to module skx_edac controller Skylake Socket#0 IMC#0: DEV 0000:3a:0a.0 (INTERRUPT)
> > > [   15.597328][  T954] EDAC MC1: Giving out device to module skx_edac controller Skylake Socket#0 IMC#1: DEV 0000:3a:0c.0 (INTERRUPT)
> > > [   15.610326][  T954] EDAC MC2: Giving out device to module skx_edac controller Skylake Socket#1 IMC#0: DEV 0000:ae:0a.0 (INTERRUPT)
> > > [   15.623375][  T954] EDAC MC3: Giving out device to module skx_edac controller Skylake Socket#1 IMC#1: DEV 0000:ae:0c.0 (INTERRUPT)
> > > [   15.640145][   T19] intel_rapl_common: Found RAPL domain package
> > > [   15.655890][   T19] intel_rapl_common: Found RAPL domain dram
> > > [   15.661983][   T19] intel_rapl_common: package-0:package:long_term locked by BIOS
> > > [   15.678564][   T19] intel_rapl_common: package-0:package:short_term locked by BIOS
> > > [   15.695259][   T19] intel_rapl_common: package-0:dram:long_term locked by BIOS
> > > [   15.713068][  T158] intel_rapl_common: Found RAPL domain package
> > > [   15.728719][  T158] intel_rapl_common: Found RAPL domain dram
> > > [   15.734743][  T158] intel_rapl_common: package-1:package:long_term locked by BIOS
> > > [   15.745244][ T1154] raid6: avx512x4 gen() 18153 MB/s
> > > [   15.761297][  T158] intel_rapl_common: package-1:package:short_term locked by BIOS
> > > [   15.767244][ T1154] raid6: avx512x2 gen() 18130 MB/s
> > > [   15.768866][  T158] intel_rapl_common: package-1:dram:long_term locked by BIOS
> > > [   15.790243][ T1154] raid6: avx512x1 gen() 18155 MB/s
> > > [   15.812245][ T1154] raid6: avx2x4   gen() 18060 MB/s
> > > [   15.834244][ T1154] raid6: avx2x2   gen() 18076 MB/s
> > > [   15.856244][ T1154] raid6: avx2x1   gen() 13836 MB/s
> > > [   15.861474][ T1154] raid6: using algorithm avx512x1 gen() 18155 MB/s
> > > [   15.884243][ T1154] raid6: .... xor() 27974 MB/s, rmw enabled
> > > [   15.890254][ T1154] raid6: using avx512x2 recovery algorithm
> > > [   15.897891][ T1154] xor: measuring software checksum speed
> > > [   15.904013][ T1154]    prefetch64-sse  : 31308 MB/sec
> > > [   15.909878][ T1154]    generic_sse     : 22929 MB/sec
> > > [   15.915230][ T1154] xor: using function: prefetch64-sse (31308 MB/sec)
> > > [   16.042623][ T1154] Btrfs loaded, zoned=no, fsverity=no
> > > [   16.054593][  T930] BTRFS: device fsid e422031c-19be-42f5-ab4f-be5f306aa6e1 devid 1 transid 39725 /dev/sda2 scanned by systemd-udevd (930)
> > > 
> > > 
> > > then the machine is just stuck there. (whole dmesg captured from serial is
> > > attached), and the issue is 100% reproducible for this commit.
> > > 
> > > for parent, we never observed the boot failure.
> > > 
> > > it looks quite strange to us why this commit could cause this behavior on our
> > > machine. could you help check dmesg, config and kernel command line which is
> > > also captured in dmesg, etc. and guide us if anything need to be updated to be
> > > compatible with this change? Thanks!
> > 
> > Thanks for the report. With the ctrl and port prefixes dropped, I broke
> > serial_base_match() looks like. As we attempt to continue anyways, things
> > still mostly work..
> > 
> > Greg, can you please drop the related commit?
> > 
> > It's the following commit:
> > 
> > 1ef2c2df1199 ("serial: core: Fix serial core controller port name to show controller id")
> 
> Please send me a revert, I can't rewrite history in my public branches.

OK. The fix might be just to check for device_type in serial_base_match().

Regards,

Tony
