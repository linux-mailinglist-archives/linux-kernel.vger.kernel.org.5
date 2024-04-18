Return-Path: <linux-kernel+bounces-149524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D27C78A9259
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DACE61C21662
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365DE54F95;
	Thu, 18 Apr 2024 05:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vih8eJP7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E09937162;
	Thu, 18 Apr 2024 05:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713418216; cv=none; b=aQjdj6s25LqS7lzmCG42yfrz4yS9xfTzz5FQWqGlzBVki8DTmaoBgw85Y/5GeMZBFBLqoUpwCwCJNi5VNjQgAHh3xQ2SlnU5OBNXeXU7CXU4mAihbNvNfsDarSaIxIaGjtZj49y8nilqNWUkeQCIMv9X9v7PBDubY+qKBXHVTQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713418216; c=relaxed/simple;
	bh=NYgj7ZhMx+/Gt3JSoGDcMbiG0lfzlaFzj6mHj8V0D1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bA0sJd6qA3Fs69FJe6qrincoVwQUGH1vSDkEHUZG4hsMuMGN5JQdvp0PazTAnzURU1ekUBiFo1mgpjivImwgPMam57xmbvUATS2tdHyXMtNNjTApaFkRQbY3qFyaoW/54goT2zNPt47sJFotFkevBdow2t9gMHP0ZdN1kcF0GSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vih8eJP7; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713418215; x=1744954215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NYgj7ZhMx+/Gt3JSoGDcMbiG0lfzlaFzj6mHj8V0D1g=;
  b=Vih8eJP7QCIMoF8x0oXcwFXr5Gt+lgbjgddM5ts0kio8P9+6sYMI91JS
   VHeVyIx/GC8gnPV9nDIDS2VKii3PrFTsOQP35XWPERJ64cxcIsOMz/jNp
   As8+FVwfYQe7UNsgy9RkxX9Lw6vYKs+CccSKm/2nEL3kx2Hu0t3rVMNnC
   v/vNtLw/TrcbvldBaB5gVycfuWyvucrb9NRbJ0Je08SPDE5uk/QMiZbi+
   A9ikkCDxVeJjze3hZZ+dTdmrU+92GBu39lKlaPWaT1/p7VitWeNXS4E//
   JN2CeOEvECKQU3Fz8vdh2m2fprbvYT7JZ/EV8aT6kxow+/x+852PNIY1D
   w==;
X-CSE-ConnectionGUID: 3wP2Da3qRN6d8ZwuGkrVEQ==
X-CSE-MsgGUID: Vuv+DBV3TXSZMHA8Ukad/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="20366898"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="20366898"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 22:30:14 -0700
X-CSE-ConnectionGUID: yroBPzUYRFSOj2URPkR5yA==
X-CSE-MsgGUID: JoBGsokrR2qTlTP89CuKvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="46141496"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 17 Apr 2024 22:30:11 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxKLZ-0007LU-0x;
	Thu, 18 Apr 2024 05:30:09 +0000
Date: Thu, 18 Apr 2024 13:29:14 +0800
From: kernel test robot <lkp@intel.com>
To: Parker Newman <parker@finest.io>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v4 6/7] serial: exar: add CTI specific setup code
Message-ID: <202404181353.1VIC4cz9-lkp@intel.com>
References: <ae4a66e7342b686cb8d4b15317585dfb37222cf4.1713382717.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae4a66e7342b686cb8d4b15317585dfb37222cf4.1713382717.git.pnewman@connecttech.com>

Hi Parker,

kernel test robot noticed the following build warnings:

[auto build test WARNING on b86ae40ffcf5a16b9569b1016da4a08c4f352ca2]

url:    https://github.com/intel-lab-lkp/linux/commits/Parker-Newman/serial-exar-remove-old-Connect-Tech-setup/20240418-043457
base:   b86ae40ffcf5a16b9569b1016da4a08c4f352ca2
patch link:    https://lore.kernel.org/r/ae4a66e7342b686cb8d4b15317585dfb37222cf4.1713382717.git.pnewman%40connecttech.com
patch subject: [PATCH v4 6/7] serial: exar: add CTI specific setup code
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20240418/202404181353.1VIC4cz9-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240418/202404181353.1VIC4cz9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404181353.1VIC4cz9-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/8250/8250_exar.c:727: warning: Function parameter or struct member 'pcidev' not described in 'cti_get_port_type_xr17c15x_xr17v25x'
>> drivers/tty/serial/8250/8250_exar.c:819: warning: Function parameter or struct member 'pcidev' not described in 'cti_get_port_type_fpga'
>> drivers/tty/serial/8250/8250_exar.c:849: warning: Function parameter or struct member 'pcidev' not described in 'cti_get_port_type_xr17v35x'


vim +727 drivers/tty/serial/8250/8250_exar.c

   714	
   715	/**
   716	 * cti_get_port_type_xr17c15x_xr17v25x() - Get port type of xr17c15x/xr17v25x
   717	 * @priv: Device's private structure
   718	 * @port_num: Port to get type of
   719	 *
   720	 * CTI xr17c15x and xr17v25x based cards port types are based on PCI IDs.
   721	 *
   722	 * Return: port type on success, CTI_PORT_TYPE_NONE on failure
   723	 */
   724	static enum cti_port_type cti_get_port_type_xr17c15x_xr17v25x(struct exar8250 *priv,
   725								struct pci_dev *pcidev,
   726								unsigned int port_num)
 > 727	{
   728		enum cti_port_type port_type;
   729	
   730		switch (pcidev->subsystem_device) {
   731		// RS232 only cards
   732		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_232:
   733		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_232:
   734		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_232:
   735		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_232:
   736		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_232_NS:
   737		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_232:
   738		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_232_NS:
   739			port_type = CTI_PORT_TYPE_RS232;
   740			break;
   741		// 1x RS232, 1x RS422/RS485
   742		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_1_1:
   743			port_type = (port_num == 0) ?
   744				CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
   745			break;
   746		// 2x RS232, 2x RS422/RS485
   747		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_2:
   748			port_type = (port_num < 2) ?
   749				CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
   750			break;
   751		// 4x RS232, 4x RS422/RS485
   752		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4:
   753		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_SP:
   754			port_type = (port_num < 4) ?
   755				CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
   756			break;
   757		// RS232/RS422/RS485 HW (jumper) selectable
   758		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2:
   759		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4:
   760		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8:
   761		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_SP_OPTO:
   762		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_SP_OPTO_A:
   763		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_SP_OPTO_B:
   764		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS:
   765		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_A:
   766		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_B:
   767		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS:
   768		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_A:
   769		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_B:
   770		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS_OPTO:
   771		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_A:
   772		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_B:
   773		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP:
   774		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_LEFT:
   775		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_RIGHT:
   776		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XP_OPTO:
   777		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_XPRS_OPTO:
   778		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP:
   779			port_type = CTI_PORT_TYPE_RS232_422_485_HW;
   780			break;
   781		// RS422/RS485 HW (jumper) selectable
   782		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_485:
   783		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_485:
   784		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_485:
   785		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_485:
   786		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_485:
   787			port_type = CTI_PORT_TYPE_RS422_485;
   788			break;
   789		// 6x RS232, 2x RS422/RS485
   790		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_6_2_SP:
   791			port_type = (port_num < 6) ?
   792				CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
   793			break;
   794		// 2x RS232, 6x RS422/RS485
   795		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_6_SP:
   796			port_type = (port_num < 2) ?
   797				CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
   798			break;
   799		default:
   800			dev_err(&pcidev->dev, "unknown/unsupported device\n");
   801			port_type = CTI_PORT_TYPE_NONE;
   802		}
   803	
   804		return port_type;
   805	}
   806	
   807	/**
   808	 * cti_get_port_type_fpga() - Get the port type of a CTI FPGA card
   809	 * @priv: Device's private structure
   810	 * @port_num: Port to get type of
   811	 *
   812	 * FPGA based cards port types are based on PCI IDs.
   813	 *
   814	 * Return: port type on success, CTI_PORT_TYPE_NONE on failure
   815	 */
   816	static enum cti_port_type cti_get_port_type_fpga(struct exar8250 *priv,
   817							struct pci_dev *pcidev,
   818							unsigned int port_num)
 > 819	{
   820		enum cti_port_type port_type;
   821	
   822		switch (pcidev->device) {
   823		case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG00X:
   824		case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG01X:
   825		case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_16:
   826			port_type = CTI_PORT_TYPE_RS232_422_485_HW;
   827			break;
   828		default:
   829			dev_err(&pcidev->dev, "unknown/unsupported device\n");
   830			return CTI_PORT_TYPE_NONE;
   831		}
   832	
   833		return port_type;
   834	}
   835	
   836	/**
   837	 * cti_get_port_type_xr17v35x() - Read port type from the EEPROM
   838	 * @priv: Device's private structure
   839	 * @port_num: port offset
   840	 *
   841	 * CTI XR17V35X based cards have the port types stored in the EEPROM.
   842	 * This function reads the port type for a single port.
   843	 *
   844	 * Return: port type on success, CTI_PORT_TYPE_NONE on failure
   845	 */
   846	static enum cti_port_type cti_get_port_type_xr17v35x(struct exar8250 *priv,
   847							struct pci_dev *pcidev,
   848							unsigned int port_num)
 > 849	{
   850		enum cti_port_type port_type;
   851		u16 port_flags;
   852		u8 offset;
   853	
   854		offset = CTI_EE_OFF_XR17V35X_PORT_FLAGS + port_num;
   855		port_flags = exar_ee_read(priv, offset);
   856	
   857		port_type = FIELD_GET(CTI_EE_MASK_PORT_FLAGS_TYPE, port_flags);
   858		if (!CTI_PORT_TYPE_VALID(port_type)) {
   859			/*
   860			 * If the port type is missing the card assume it is a
   861			 * RS232/RS422/RS485 card to be safe.
   862			 *
   863			 * There is one known board (BEG013) that only has
   864			 * 3 of 4 port types written to the EEPROM so this
   865			 * acts as a work around.
   866			 */
   867			dev_warn(&pcidev->dev,
   868				"failed to get port %d type from EEPROM\n", port_num);
   869			port_type = CTI_PORT_TYPE_RS232_422_485_HW;
   870		}
   871	
   872		return port_type;
   873	}
   874	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

