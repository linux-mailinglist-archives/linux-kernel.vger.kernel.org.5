Return-Path: <linux-kernel+bounces-89936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16EE86F782
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 23:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 561152815F2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 22:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84BB7AE6E;
	Sun,  3 Mar 2024 22:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mH3VMfKm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC7F6CDB6;
	Sun,  3 Mar 2024 22:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709506586; cv=none; b=YkENaieFEAwxfQRfmUhHx0Ba4HEpwEOyMRNrlOMDVcRKe0WCqTvSjcEpCmGfYtK4GQeZA2VzdcgyLAXh3KYNEyMnyM9aKPz9udzUIN1GcHK+hQPg0r/9swozvjZFUA4vYCQ0TzdzgR6/TH5Ip0XR49XlhThVCP/tsgcfMFTZ3e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709506586; c=relaxed/simple;
	bh=kSLt4h/GbkmQHjLADq6EU92fkgOQTutJY4Qu6S1Krpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O962piJRbjGjlRpNZkhnze73ppNeT7RlkCrmznDAdjEkm9OqfmQ54gzLFHz3Cc5pc1xqJzHHlP2TPVvbHfDs+jROlbuqMKv/LzxwLJjJET0KliLy8IeZ0PvVJjnMRTHiHn5Z5T5k+s0vV/sVGQvjF4CaC8R+UZcIR+56+IbXqg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mH3VMfKm; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709506585; x=1741042585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kSLt4h/GbkmQHjLADq6EU92fkgOQTutJY4Qu6S1Krpg=;
  b=mH3VMfKmzwRSLHF0RowqQfY7nQT2vgHokX1B5fL1TB6IASkGy9PBujTK
   gJj+KJZ/ENHovvc8UuHgH/B8gz+nkptj7bjb1e2j4LxIPBzNQHZ5f/bHP
   AMkUoCajZpGThunB4K8V23KsbudTChj2JTY1oA5FfvbHPIu7Qr/vcnT8X
   3ap5ZwF6DgN5YHmKQqT6JEkL+bWj8d8kh1wxu+esPCxLM8EZzy/xN/QRL
   QNWgPFFwfekIKqiZbouNUjm+5JhPj59f9caXuBD4SIQVZDSUmEqGYe5PB
   tCA+3XzBL4v8MbTCBuhocO5Yq6n9ITKudtGRd1iSNWTiOTle+9XhwOk5r
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="7756390"
X-IronPort-AV: E=Sophos;i="6.06,201,1705392000"; 
   d="scan'208";a="7756390"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 14:56:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,201,1705392000"; 
   d="scan'208";a="31958628"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 03 Mar 2024 14:56:19 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rgukj-0002A0-23;
	Sun, 03 Mar 2024 22:56:17 +0000
Date: Mon, 4 Mar 2024 06:55:22 +0800
From: kernel test robot <lkp@intel.com>
To: Canfeng Zhuang <quic_czhuang@quicinc.com>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Canfeng Zhuang <quic_czhuang@quicinc.com>
Subject: Re: [PATCH 1/2] misc: qualcomm: QRC driver for Robotic SDK MCU
Message-ID: <202403040603.Dtb2fV1b-lkp@intel.com>
References: <20240304-qcom_qrc-v1-1-2a709f95fd61@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-qcom_qrc-v1-1-2a709f95fd61@quicinc.com>

Hi Canfeng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 805d849d7c3cc1f38efefd48b2480d62b7b5dcb7]

url:    https://github.com/intel-lab-lkp/linux/commits/Canfeng-Zhuang/misc-qualcomm-QRC-driver-for-Robotic-SDK-MCU/20240304-005601
base:   805d849d7c3cc1f38efefd48b2480d62b7b5dcb7
patch link:    https://lore.kernel.org/r/20240304-qcom_qrc-v1-1-2a709f95fd61%40quicinc.com
patch subject: [PATCH 1/2] misc: qualcomm: QRC driver for Robotic SDK MCU
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20240304/202403040603.Dtb2fV1b-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 325f51237252e6dab8e4e1ea1fa7acbb4faee1cd)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240304/202403040603.Dtb2fV1b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403040603.Dtb2fV1b-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/misc/qrc/qrc_uart.c:10:
   In file included from include/linux/serdev.h:10:
   In file included from include/linux/iopoll.h:14:
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
   In file included from drivers/misc/qrc/qrc_uart.c:10:
   In file included from include/linux/serdev.h:10:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/misc/qrc/qrc_uart.c:10:
   In file included from include/linux/serdev.h:10:
   In file included from include/linux/iopoll.h:14:
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
   In file included from drivers/misc/qrc/qrc_uart.c:13:
   In file included from drivers/misc/qrc/qrc_core.h:14:
   In file included from include/linux/kfifo.h:42:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2188:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/misc/qrc/qrc_uart.c:203:61: warning: format specifies type 'long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
     203 |                 dev_err(dev->dev, "qrcuart transmit date overflow %ld\n", data_length);
         |                                                                   ~~~     ^~~~~~~~~~~
         |                                                                   %zu
   include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ~~~    ^~~~~~~~~~~
   8 warnings generated.


vim +203 drivers/misc/qrc/qrc_uart.c

  > 13	#include "qrc_core.h"
    14	
    15	#define QRC_RX_FIFO_SIZE 0x400
    16	#define QRC_TX_BUFF_SIZE 0x400
    17	#define QRCUART_DRV_NAME "qrcuart"
    18	#define QRC_DRV_VERSION "0.1.0"
    19	
    20	static int qrcuart_setup(struct qrc_dev *dev);
    21	
    22	static int
    23	qrc_uart_receive(struct serdev_device *serdev, const unsigned char *data,
    24			 size_t count)
    25	{
    26		struct qrcuart *qrc = serdev_device_get_drvdata(serdev);
    27		struct qrc_dev *qrc_dev = qrc->qrc_dev;
    28		int ret;
    29	
    30		/* check count */
    31		ret = kfifo_avail(&qrc->qrc_rx_fifo);
    32		if (!ret)
    33			return 0;
    34	
    35		if (count > ret)
    36			count = ret;
    37	
    38		ret = kfifo_in(&qrc->qrc_rx_fifo, data, count);
    39		if (!ret)
    40			return 0;
    41	
    42		wake_up_interruptible(&qrc_dev->r_wait);
    43	
    44		return count;
    45	}
    46	
    47	/* Write out any remaining transmit buffer. Scheduled when tty is writable */
    48	static void qrcuart_transmit(struct work_struct *work)
    49	{
    50		struct qrcuart *qrc = container_of(work, struct qrcuart, tx_work);
    51		int written;
    52	
    53		spin_lock_bh(&qrc->lock);
    54	
    55		if (qrc->tx_left <= 0) {
    56			/* Now serial buffer is almost free & we can start
    57			 * transmission of another packet
    58			 */
    59			spin_unlock_bh(&qrc->lock);
    60			return;
    61		}
    62	
    63		written = serdev_device_write_buf(qrc->serdev, qrc->tx_head,
    64						  qrc->tx_left);
    65		if (written > 0) {
    66			qrc->tx_left -= written;
    67			qrc->tx_head += written;
    68		}
    69		spin_unlock_bh(&qrc->lock);
    70	}
    71	
    72	/* Called by the driver when there's room for more data.
    73	 * Schedule the transmit.
    74	 */
    75	static void qrc_uart_wakeup(struct serdev_device *serdev)
    76	{
    77		struct qrcuart *qrc = serdev_device_get_drvdata(serdev);
    78	
    79		schedule_work(&qrc->tx_work);
    80	}
    81	
    82	static struct serdev_device_ops qrc_serdev_ops = {
    83		.receive_buf = qrc_uart_receive,
    84		.write_wakeup = qrc_uart_wakeup,
    85	};
    86	
    87	/*----------------Interface to QRC core -----------------------------*/
    88	
    89	static int qrcuart_open(struct qrc_dev *dev)
    90	{
    91		struct qrcuart *qrc = qrc_get_data(dev);
    92		struct serdev_device *serdev = qrc->serdev;
    93		int ret;
    94	
    95		if (!qrc->is_open) {
    96			ret = serdev_device_open(serdev);
    97			if (ret) {
    98				dev_err(dev->dev, "qrcuart :Unable to open device\n");
    99				return ret;
   100			}
   101			serdev_device_set_baudrate(serdev, 115200);
   102			serdev_device_set_flow_control(serdev, false);
   103			qrc->is_open = true;
   104		}
   105	
   106		return 0;
   107	}
   108	
   109	static int qrcuart_close(struct qrc_dev *dev)
   110	{
   111		struct qrcuart *qrc = qrc_get_data(dev);
   112		struct serdev_device *serdev = qrc->serdev;
   113	
   114		flush_work(&qrc->tx_work);
   115		spin_lock_bh(&qrc->lock);
   116		qrc->tx_left = 0;
   117		spin_unlock_bh(&qrc->lock);
   118	
   119		if (qrc->is_open) {
   120			serdev_device_close(serdev);
   121			qrc->is_open = false;
   122		}
   123	
   124		return 0;
   125	}
   126	
   127	static int qrcuart_init(struct qrc_dev *dev)
   128	{
   129		struct qrcuart *qrc = qrc_get_data(dev);
   130		size_t len;
   131		int ret;
   132	
   133		/* Finish setting up the device info. */
   134		len = QRC_TX_BUFF_SIZE;
   135		qrc->tx_buffer = devm_kmalloc(&qrc->serdev->dev, len, GFP_KERNEL);
   136	
   137		if (!qrc->tx_buffer)
   138			return -ENOMEM;
   139	
   140		qrc->tx_head = qrc->tx_buffer;
   141		qrc->tx_left = 0;
   142	
   143		ret = kfifo_alloc(&qrc->qrc_rx_fifo, QRC_RX_FIFO_SIZE,
   144				  GFP_KERNEL);
   145		if (ret)
   146			return -ENOMEM;
   147	
   148		return 0;
   149	}
   150	
   151	static void qrcuart_uninit(struct qrc_dev *dev)
   152	{
   153		struct qrcuart *qrc = qrc_get_data(dev);
   154	
   155		kfifo_free(&qrc->qrc_rx_fifo);
   156	}
   157	
   158	/*put data from kfifo to qrc fifo */
   159	static int qrcuart_receive(struct qrc_dev *dev, char __user *buf,
   160				   size_t count)
   161	{
   162		struct qrcuart *qrc = qrc_get_data(dev);
   163		u32 fifo_len, trans_len;
   164	
   165		if (!kfifo_is_empty(&qrc->qrc_rx_fifo)) {
   166			fifo_len = kfifo_len(&qrc->qrc_rx_fifo);
   167			if (count > fifo_len)
   168				count = fifo_len;
   169			if (kfifo_to_user(&qrc->qrc_rx_fifo,
   170					  (void *)buf, count, &trans_len))
   171				return -EFAULT;
   172			return trans_len;
   173		}
   174		return 0;
   175	}
   176	
   177	static int qrcuart_data_status(struct qrc_dev *dev)
   178	{
   179		struct qrcuart *qrc = qrc_get_data(dev);
   180	
   181		return kfifo_len(&qrc->qrc_rx_fifo);
   182	}
   183	
   184	static void qrcuart_data_clean(struct qrc_dev *dev)
   185	{
   186		struct qrcuart *qrc = qrc_get_data(dev);
   187	
   188		kfifo_reset(&qrc->qrc_rx_fifo);
   189	}
   190	
   191	static enum qrcdev_tx qrcuart_xmit(const char __user  *buf,
   192					   size_t data_length, struct qrc_dev *dev)
   193	{
   194		struct qrcuart *qrc = qrc_get_data(dev);
   195		struct qrc_device_stats *n_stats = &dev->stats;
   196		size_t written;
   197		u8 *pos;
   198	
   199		WARN_ON(qrc->tx_left);
   200	
   201		pos = qrc->tx_buffer + qrc->tx_left;
   202		if ((data_length + qrc->tx_left) > QRC_TX_BUFF_SIZE) {
 > 203			dev_err(dev->dev, "qrcuart transmit date overflow %ld\n", data_length);
   204			return __QRCDEV_TX_MIN;
   205		}
   206	
   207		if (copy_from_user(pos, buf, data_length))
   208			return __QRCDEV_TX_MIN;
   209	
   210		pos += data_length;
   211	
   212		spin_lock(&qrc->lock);
   213	
   214		written = serdev_device_write_buf(qrc->serdev, qrc->tx_buffer,
   215						  pos - qrc->tx_buffer);
   216		if (written > 0) {
   217			qrc->tx_left = (pos - qrc->tx_buffer) - written;
   218			qrc->tx_head = qrc->tx_buffer + written;
   219			n_stats->tx_bytes += written;
   220		}
   221	
   222		spin_unlock(&qrc->lock);
   223	
   224		return QRCDEV_TX_OK;
   225	}
   226	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

