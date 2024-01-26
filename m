Return-Path: <linux-kernel+bounces-39597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F24D083D35E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 05:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D221C22986
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 04:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B37C2C6;
	Fri, 26 Jan 2024 04:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O2M0gT4J"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0378CC139
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 04:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706242417; cv=none; b=IrCZfxn1JAmxKzEcOmF5Xe5GSWOhQjTFQW7t3qkiQ9pbH98mMfXsu1FQfNPqEr7IxhhOj9Hg78ICppkqozLnnihB8/QGqOJWqwQhhKoqxhQtO9tIiJKk3fuvHQede2fmEzzRq1fnR+//6iXNBLaRJLJK2IoHOlwoEgis3akpxzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706242417; c=relaxed/simple;
	bh=72aQfR45fYmxRG0c4MzxIIhX6YN236McT6hETaon2QI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Pjn4hKV+XWkT7ozZi0G5jMe+ZLH6B0o8TEMlYTfTyPrepr+mWZqTgaQDUBIJQ0g3qEf+7Cx8ctS+E7FCi2NLzqSfcRiuABjLb2qw95ca0BYbsEVaxeYMi8Zv3LiWEWdACszazsWO7SVBp6t+3OpPE09nwuk2n9pUupTHj8UcWE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O2M0gT4J; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706242415; x=1737778415;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=72aQfR45fYmxRG0c4MzxIIhX6YN236McT6hETaon2QI=;
  b=O2M0gT4Jjwmmt3TpvoHbHSsUD54pP7ORs9Uh33T6wA/+zsT/n7aHzgJ9
   oN4EdaChymDbTP82yXl1DoAVCe/ZJiGcs2ZFSwgRNriHomerfMuibFCWm
   nvZCm+ypWjrr6VjoXdOgGCOEPaKuUNqxGyzTu4fr5ldmpZs7QZ3dWpPWc
   N3urCI9pLlshWGbrmehRdrbKEOdviu6xd1Vwk1McNeqQF0/z0+amrnr3/
   9KIGOnncLDY5HbHOzoLPgrrIcDw0YHta0c0ZgZBBahuE7bNfvxNzj/ErN
   93lrOXQP7jkWj78yHJppbw5HV77J1VhQ915VoSqNVSFtXjHc388b6tEBm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="402038612"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="402038612"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 20:13:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="960097654"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="960097654"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 Jan 2024 20:13:31 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTDar-0000fy-1Y;
	Fri, 26 Jan 2024 04:13:29 +0000
Date: Fri, 26 Jan 2024 12:13:22 +0800
From: kernel test robot <lkp@intel.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/misc/eeprom/idt_89hpesx.c:599:31: sparse: sparse: incorrect
 type in assignment (different base types)
Message-ID: <202401261250.b07Yt30Z-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ecb1b8288dc7ccbdcb3b9df005fa1c0e0c0388a7
commit: cfad6425382ec81acd073fdf24361e1c30b4cb36 eeprom: Add IDT 89HPESx EEPROM/CSR driver
date:   7 years ago
config: openrisc-randconfig-s041-20230115 (https://download.01.org/0day-ci/archive/20240126/202401261250.b07Yt30Z-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20240126/202401261250.b07Yt30Z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401261250.b07Yt30Z-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/misc/eeprom/idt_89hpesx.c:599:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [assigned] [usertype] memaddr @@     got restricted __le16 [usertype] @@
   drivers/misc/eeprom/idt_89hpesx.c:599:31: sparse:     expected unsigned short [addressable] [assigned] [usertype] memaddr
   drivers/misc/eeprom/idt_89hpesx.c:599:31: sparse:     got restricted __le16 [usertype]
   drivers/misc/eeprom/idt_89hpesx.c:671:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [assigned] [usertype] memaddr @@     got restricted __le16 [usertype] @@
   drivers/misc/eeprom/idt_89hpesx.c:671:31: sparse:     expected unsigned short [addressable] [assigned] [usertype] memaddr
   drivers/misc/eeprom/idt_89hpesx.c:671:31: sparse:     got restricted __le16 [usertype]
>> drivers/misc/eeprom/idt_89hpesx.c:769:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [assigned] [usertype] csraddr @@     got restricted __le16 [usertype] @@
   drivers/misc/eeprom/idt_89hpesx.c:769:24: sparse:     expected unsigned short [addressable] [assigned] [usertype] csraddr
   drivers/misc/eeprom/idt_89hpesx.c:769:24: sparse:     got restricted __le16 [usertype]
>> drivers/misc/eeprom/idt_89hpesx.c:770:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [addressable] [assigned] [usertype] data @@     got restricted __le32 [usertype] @@
   drivers/misc/eeprom/idt_89hpesx.c:770:21: sparse:     expected unsigned int [addressable] [assigned] [usertype] data
   drivers/misc/eeprom/idt_89hpesx.c:770:21: sparse:     got restricted __le32 [usertype]
   drivers/misc/eeprom/idt_89hpesx.c:834:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [assigned] [usertype] csraddr @@     got restricted __le16 [usertype] @@
   drivers/misc/eeprom/idt_89hpesx.c:834:24: sparse:     expected unsigned short [addressable] [assigned] [usertype] csraddr
   drivers/misc/eeprom/idt_89hpesx.c:834:24: sparse:     got restricted __le16 [usertype]
>> drivers/misc/eeprom/idt_89hpesx.c:859:17: sparse: sparse: cast to restricted __le32
>> drivers/misc/eeprom/idt_89hpesx.c:859:17: sparse: sparse: cast to restricted __le32
>> drivers/misc/eeprom/idt_89hpesx.c:859:17: sparse: sparse: cast to restricted __le32
>> drivers/misc/eeprom/idt_89hpesx.c:859:17: sparse: sparse: cast to restricted __le32
>> drivers/misc/eeprom/idt_89hpesx.c:859:17: sparse: sparse: cast to restricted __le32
>> drivers/misc/eeprom/idt_89hpesx.c:859:17: sparse: sparse: cast to restricted __le32
   In file included from include/linux/kernel.h:11,
                    from drivers/misc/eeprom/idt_89hpesx.c:70:
   include/linux/log2.h:22:1: warning: ignoring attribute 'noreturn' because it conflicts with attribute 'const' [-Wattributes]
      22 | int ____ilog2_NaN(void);
         | ^~~
   drivers/misc/eeprom/idt_89hpesx.c: In function 'idt_dbgfs_csr_write':
   drivers/misc/eeprom/idt_89hpesx.c:941:31: warning: variable 'csrval_len' set but not used [-Wunused-but-set-variable]
     941 |         int ret, csraddr_len, csrval_len;
         |                               ^~~~~~~~~~

vim +599 drivers/misc/eeprom/idt_89hpesx.c

   565	
   566	/*===========================================================================
   567	 *                          EEPROM IO-operations
   568	 *===========================================================================
   569	 */
   570	
   571	/*
   572	 * idt_eeprom_read_byte() - read just one byte from EEPROM
   573	 * @pdev:	Pointer to the driver data
   574	 * @memaddr:	Start EEPROM memory address
   575	 * @data:	Data to be written to EEPROM
   576	 */
   577	static int idt_eeprom_read_byte(struct idt_89hpesx_dev *pdev, u16 memaddr,
   578					u8 *data)
   579	{
   580		struct device *dev = &pdev->client->dev;
   581		struct idt_eeprom_seq eeseq;
   582		struct idt_smb_seq smbseq;
   583		int ret, retry;
   584	
   585		/* Initialize SMBus sequence fields */
   586		smbseq.ccode = pdev->iniccode | CCODE_EEPROM;
   587		smbseq.data = (u8 *)&eeseq;
   588	
   589		/*
   590		 * Sometimes EEPROM may respond with NACK if it's busy with previous
   591		 * operation, so we need to perform a few attempts of read cycle
   592		 */
   593		retry = RETRY_CNT;
   594		do {
   595			/* Send EEPROM memory address to read data from */
   596			smbseq.bytecnt = EEPROM_WRRD_CNT;
   597			eeseq.cmd = pdev->inieecmd | EEPROM_OP_READ;
   598			eeseq.eeaddr = pdev->eeaddr;
 > 599			eeseq.memaddr = cpu_to_le16(memaddr);
   600			ret = pdev->smb_write(pdev, &smbseq);
   601			if (ret != 0) {
   602				dev_err(dev, "Failed to init eeprom addr 0x%02hhx",
   603					memaddr);
   604				break;
   605			}
   606	
   607			/* Perform read operation */
   608			smbseq.bytecnt = EEPROM_RD_CNT;
   609			ret = pdev->smb_read(pdev, &smbseq);
   610			if (ret != 0) {
   611				dev_err(dev, "Failed to read eeprom data 0x%02hhx",
   612					memaddr);
   613				break;
   614			}
   615	
   616			/* Restart read operation if the device is busy */
   617			if (retry && (eeseq.cmd & EEPROM_NAERR)) {
   618				dev_dbg(dev, "EEPROM busy, retry reading after %d ms",
   619					EEPROM_TOUT);
   620				msleep(EEPROM_TOUT);
   621				continue;
   622			}
   623	
   624			/* Check whether IDT successfully read data from EEPROM */
   625			if (eeseq.cmd & (EEPROM_NAERR | EEPROM_LAERR | EEPROM_MSS)) {
   626				dev_err(dev,
   627					"Communication with eeprom failed, cmd 0x%hhx",
   628					eeseq.cmd);
   629				ret = -EREMOTEIO;
   630				break;
   631			}
   632	
   633			/* Save retrieved data and exit the loop */
   634			*data = eeseq.data;
   635			break;
   636		} while (retry--);
   637	
   638		/* Return the status of operation */
   639		return ret;
   640	}
   641	
   642	/*
   643	 * idt_eeprom_write() - EEPROM write operation
   644	 * @pdev:	Pointer to the driver data
   645	 * @memaddr:	Start EEPROM memory address
   646	 * @len:	Length of data to be written
   647	 * @data:	Data to be written to EEPROM
   648	 */
   649	static int idt_eeprom_write(struct idt_89hpesx_dev *pdev, u16 memaddr, u16 len,
   650				    const u8 *data)
   651	{
   652		struct device *dev = &pdev->client->dev;
   653		struct idt_eeprom_seq eeseq;
   654		struct idt_smb_seq smbseq;
   655		int ret;
   656		u16 idx;
   657	
   658		/* Initialize SMBus sequence fields */
   659		smbseq.ccode = pdev->iniccode | CCODE_EEPROM;
   660		smbseq.data = (u8 *)&eeseq;
   661	
   662		/* Send data byte-by-byte, checking if it is successfully written */
   663		for (idx = 0; idx < len; idx++, memaddr++) {
   664			/* Lock IDT SMBus device */
   665			mutex_lock(&pdev->smb_mtx);
   666	
   667			/* Perform write operation */
   668			smbseq.bytecnt = EEPROM_WR_CNT;
   669			eeseq.cmd = pdev->inieecmd | EEPROM_OP_WRITE;
   670			eeseq.eeaddr = pdev->eeaddr;
   671			eeseq.memaddr = cpu_to_le16(memaddr);
   672			eeseq.data = data[idx];
   673			ret = pdev->smb_write(pdev, &smbseq);
   674			if (ret != 0) {
   675				dev_err(dev,
   676					"Failed to write 0x%04hx:0x%02hhx to eeprom",
   677					memaddr, data[idx]);
   678				goto err_mutex_unlock;
   679			}
   680	
   681			/*
   682			 * Check whether the data is successfully written by reading
   683			 * from the same EEPROM memory address.
   684			 */
   685			eeseq.data = ~data[idx];
   686			ret = idt_eeprom_read_byte(pdev, memaddr, &eeseq.data);
   687			if (ret != 0)
   688				goto err_mutex_unlock;
   689	
   690			/* Check whether the read byte is the same as written one */
   691			if (eeseq.data != data[idx]) {
   692				dev_err(dev, "Values don't match 0x%02hhx != 0x%02hhx",
   693					eeseq.data, data[idx]);
   694				ret = -EREMOTEIO;
   695				goto err_mutex_unlock;
   696			}
   697	
   698			/* Unlock IDT SMBus device */
   699	err_mutex_unlock:
   700			mutex_unlock(&pdev->smb_mtx);
   701			if (ret != 0)
   702				return ret;
   703		}
   704	
   705		return 0;
   706	}
   707	
   708	/*
   709	 * idt_eeprom_read() - EEPROM read operation
   710	 * @pdev:	Pointer to the driver data
   711	 * @memaddr:	Start EEPROM memory address
   712	 * @len:	Length of data to read
   713	 * @buf:	Buffer to read data to
   714	 */
   715	static int idt_eeprom_read(struct idt_89hpesx_dev *pdev, u16 memaddr, u16 len,
   716				   u8 *buf)
   717	{
   718		int ret;
   719		u16 idx;
   720	
   721		/* Read data byte-by-byte, retrying if it wasn't successful */
   722		for (idx = 0; idx < len; idx++, memaddr++) {
   723			/* Lock IDT SMBus device */
   724			mutex_lock(&pdev->smb_mtx);
   725	
   726			/* Just read the byte to the buffer */
   727			ret = idt_eeprom_read_byte(pdev, memaddr, &buf[idx]);
   728	
   729			/* Unlock IDT SMBus device */
   730			mutex_unlock(&pdev->smb_mtx);
   731	
   732			/* Return error if read operation failed */
   733			if (ret != 0)
   734				return ret;
   735		}
   736	
   737		return 0;
   738	}
   739	
   740	/*===========================================================================
   741	 *                          CSR IO-operations
   742	 *===========================================================================
   743	 */
   744	
   745	/*
   746	 * idt_csr_write() - CSR write operation
   747	 * @pdev:	Pointer to the driver data
   748	 * @csraddr:	CSR address (with no two LS bits)
   749	 * @data:	Data to be written to CSR
   750	 */
   751	static int idt_csr_write(struct idt_89hpesx_dev *pdev, u16 csraddr,
   752				 const u32 data)
   753	{
   754		struct device *dev = &pdev->client->dev;
   755		struct idt_csr_seq csrseq;
   756		struct idt_smb_seq smbseq;
   757		int ret;
   758	
   759		/* Initialize SMBus sequence fields */
   760		smbseq.ccode = pdev->iniccode | CCODE_CSR;
   761		smbseq.data = (u8 *)&csrseq;
   762	
   763		/* Lock IDT SMBus device */
   764		mutex_lock(&pdev->smb_mtx);
   765	
   766		/* Perform write operation */
   767		smbseq.bytecnt = CSR_WR_CNT;
   768		csrseq.cmd = pdev->inicsrcmd | CSR_OP_WRITE;
 > 769		csrseq.csraddr = cpu_to_le16(csraddr);
 > 770		csrseq.data = cpu_to_le32(data);
   771		ret = pdev->smb_write(pdev, &smbseq);
   772		if (ret != 0) {
   773			dev_err(dev, "Failed to write 0x%04x: 0x%04x to csr",
   774				CSR_REAL_ADDR(csraddr), data);
   775			goto err_mutex_unlock;
   776		}
   777	
   778		/* Send CSR address to read data from */
   779		smbseq.bytecnt = CSR_WRRD_CNT;
   780		csrseq.cmd = pdev->inicsrcmd | CSR_OP_READ;
   781		ret = pdev->smb_write(pdev, &smbseq);
   782		if (ret != 0) {
   783			dev_err(dev, "Failed to init csr address 0x%04x",
   784				CSR_REAL_ADDR(csraddr));
   785			goto err_mutex_unlock;
   786		}
   787	
   788		/* Perform read operation */
   789		smbseq.bytecnt = CSR_RD_CNT;
   790		ret = pdev->smb_read(pdev, &smbseq);
   791		if (ret != 0) {
   792			dev_err(dev, "Failed to read csr 0x%04x",
   793				CSR_REAL_ADDR(csraddr));
   794			goto err_mutex_unlock;
   795		}
   796	
   797		/* Check whether IDT successfully retrieved CSR data */
   798		if (csrseq.cmd & (CSR_RERR | CSR_WERR)) {
   799			dev_err(dev, "IDT failed to perform CSR r/w");
   800			ret = -EREMOTEIO;
   801			goto err_mutex_unlock;
   802		}
   803	
   804		/* Unlock IDT SMBus device */
   805	err_mutex_unlock:
   806		mutex_unlock(&pdev->smb_mtx);
   807	
   808		return ret;
   809	}
   810	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

