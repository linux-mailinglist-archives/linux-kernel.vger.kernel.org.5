Return-Path: <linux-kernel+bounces-105122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547CB87D95F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 10:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 625B71C20DB1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 09:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261A8175A7;
	Sat, 16 Mar 2024 09:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TfrU71st"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2302F12B79;
	Sat, 16 Mar 2024 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710579655; cv=none; b=aT+MA77GmW2QrhXKqO6FC4h3WS1QSJ3Mqezi8uNHVbcfXCB5Q+IpWSZ1Zm30S5xshxkqRaSdN+aurqlY2BVVB7aN6DULmSKcuDk2yv2hEcdUpXTvTqeVkY/CmqnE/Qr30kd4wDmgfXkHOHSEQBFyI20bY/4q3LAUcbBtq1FKuSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710579655; c=relaxed/simple;
	bh=9tpnCC2OSnn/XSLWszg6PWWM++RoYjOZSlHEqh0s26Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2o8oqNS2yb3/SBhN2arZjPr1sBLk6br2KpeDrLoC0akGgjuQTlnTASundLMH8URI2Y1uA8Wt1ULq5Il97qaypy5LMrC2QMlhVugtaX4b3oGp4HLd2DyxtSRvmrLiQVhVRPSLhkEo9jW53tm5HKZ1M3CXiUO+CPbkwLczJUuPe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TfrU71st; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710579652; x=1742115652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9tpnCC2OSnn/XSLWszg6PWWM++RoYjOZSlHEqh0s26Q=;
  b=TfrU71st517W6SDJ3q0xd64lgRzlKLqk9GBy7giWOoPZlrHovue+gL2o
   ZzgSoww/uLtl6a9JedaPE5BDKUt75l94OFMtlS1uGxL66IpeHesXNM7Nh
   p3onqIqloqWmQmyIJ60MF24LaLQtjnfOaPwKTxHjFXQzoK2ovmgvRVd23
   jrTDIthgp/P3doITQzrDBN+Z9AYb5uec6NQn0MseDTOyJkLueezpRIADi
   gx2OX+r+rVl0TXJXDf3A/4gqzwR3aMogh/WvLAsNMsMSZgYK0L9eWUJC/
   YrF+dr5J6imjOTd+vfPb9DMNGK3YepExGmRHAr6dFEUmVPi1MrSWIanYN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="5588432"
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="5588432"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2024 02:00:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="17527675"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 16 Mar 2024 02:00:40 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rlPuA-000FFx-26;
	Sat, 16 Mar 2024 09:00:38 +0000
Date: Sat, 16 Mar 2024 17:00:14 +0800
From: kernel test robot <lkp@intel.com>
To: Ayush Singh <ayushdevel1325@gmail.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ayush Singh <ayushdevel1325@gmail.com>, jkridner@beagleboard.org,
	robertcnelson@beagleboard.org,
	Vaishnav M A <vaishnav@beagleboard.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
	greybus-dev@lists.linaro.org
Subject: Re: [PATCH v3 7/8] mikrobus: Add mikrobus driver
Message-ID: <202403161645.CxE8k6qy-lkp@intel.com>
References: <20240315184908.500352-8-ayushdevel1325@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315184908.500352-8-ayushdevel1325@gmail.com>

Hi Ayush,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 61996c073c9b070922ad3a36c981ca6ddbea19a5]

url:    https://github.com/intel-lab-lkp/linux/commits/Ayush-Singh/dt-bindings-misc-Add-mikrobus-connector/20240316-025407
base:   61996c073c9b070922ad3a36c981ca6ddbea19a5
patch link:    https://lore.kernel.org/r/20240315184908.500352-8-ayushdevel1325%40gmail.com
patch subject: [PATCH v3 7/8] mikrobus: Add mikrobus driver
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240316/202403161645.CxE8k6qy-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 8f68022f8e6e54d1aeae4ed301f5a015963089b7)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240316/202403161645.CxE8k6qy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403161645.CxE8k6qy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/misc/mikrobus/mikrobus_id.c:17:
   In file included from drivers/misc/mikrobus/mikrobus_core.h:14:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/misc/mikrobus/mikrobus_id.c:17:
   In file included from drivers/misc/mikrobus/mikrobus_core.h:14:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/misc/mikrobus/mikrobus_id.c:17:
   In file included from drivers/misc/mikrobus/mikrobus_core.h:14:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   In file included from drivers/misc/mikrobus/mikrobus_id.c:17:
   In file included from drivers/misc/mikrobus/mikrobus_core.h:14:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/misc/mikrobus/mikrobus_id.c:45:60: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
      45 |         pr_info("mikrobus_id: writing manifest size = %lu bytes", count);
         |                                                       ~~~         ^~~~~
         |                                                       %zu
   include/linux/printk.h:530:34: note: expanded from macro 'pr_info'
     530 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |                                 ~~~     ^~~~~~~~~~~
   include/linux/printk.h:457:60: note: expanded from macro 'printk'
     457 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                     ~~~    ^~~~~~~~~~~
   include/linux/printk.h:429:19: note: expanded from macro 'printk_index_wrap'
     429 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ~~~~    ^~~~~~~~~~~
   8 warnings generated.


vim +45 drivers/misc/mikrobus/mikrobus_id.c

    28	
    29	static ssize_t mikrobus_manifest_store(struct device *device, struct device_attribute *attr,
    30					       const char *buf, size_t count)
    31	{
    32		u8 write_request[] = { W1_MIKROBUS_ID_WRITE_EEPROM,
    33				       W1_MIKROBUS_EEPROM_MANIFEST_START_PAGE };
    34		u8 release_command = W1_MIKROBUS_ID_RELEASE_EEPROM;
    35		struct w1_slave *sl = dev_to_w1_slave(device);
    36		u16 crc, crc_read, pos = 0;
    37		u8 status = 0;
    38		int cnt;
    39	
    40		if (count > W1_MIKROBUS_ID_EEPROM_SIZE)
    41			return -ENOMEM;
    42	
    43		mutex_lock(&sl->master->bus_mutex);
    44	
  > 45		pr_info("mikrobus_id: writing manifest size = %lu bytes", count);
    46		while (pos < count) {
    47			if (w1_reset_select_slave(sl))
    48				break;
    49	
    50			w1_write_block(sl->master, write_request, sizeof(write_request));
    51			crc = crc16(0, write_request, sizeof(write_request)) ^ 0xFFFF;
    52			w1_read_block(sl->master, (u8 *)&crc_read, sizeof(crc_read));
    53	
    54			if (crc != crc_read)
    55				break;
    56	
    57			for (cnt = 0; cnt < W1_MIKROBUS_ID_EEPROM_PAGE_SIZE; cnt++)
    58				w1_write_8(sl->master, (u8)buf[cnt]);
    59	
    60			crc = crc16(0, buf, W1_MIKROBUS_ID_EEPROM_PAGE_SIZE) ^ 0xFFFF;
    61			usleep_range(1 * USEC_PER_MSEC, 2 * USEC_PER_MSEC);
    62			w1_read_block(sl->master, (u8 *)&crc_read, sizeof(crc_read));
    63	
    64			if (crc != crc_read)
    65				break;
    66	
    67			w1_write_8(sl->master, release_command);
    68			usleep_range(10 * USEC_PER_MSEC, 15 * USEC_PER_MSEC);
    69			status = w1_read_8(sl->master);
    70			w1_read_block(sl->master, (u8 *)&crc_read, sizeof(crc_read));
    71			crc = crc16(0, (u8 *)&release_command, sizeof(release_command)) ^ 0xFFFF;
    72	
    73			if (status != W1_MIKROBUS_ID_RELEASE_EEPROM)
    74				break;
    75	
    76			if (crc != crc_read)
    77				break;
    78	
    79			buf += W1_MIKROBUS_ID_EEPROM_PAGE_SIZE;
    80			pos += W1_MIKROBUS_ID_EEPROM_PAGE_SIZE;
    81			write_request[1]++;
    82		}
    83	
    84		pr_info("mikrobus_id: manifest written bytes: %d", pos);
    85		mutex_unlock(&sl->master->bus_mutex);
    86	
    87		return count > pos ? count : pos;
    88	}
    89	static DEVICE_ATTR_WO(mikrobus_manifest);
    90	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

