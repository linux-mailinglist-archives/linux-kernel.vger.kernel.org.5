Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE2B79E0B4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 09:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238558AbjIMHSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 03:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238567AbjIMHSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 03:18:11 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EB0198D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 00:18:07 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-403004a96a4so44501095e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 00:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694589486; x=1695194286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HobCr1YvW+uQSy9dj9a5595BmgRYMkqX7jfk+9Xr840=;
        b=pv86DxqXVjRmePVX3ksX770l1p8ltZd1AezGQ9R4OywTx+2vqZ9xmaNIuTi3NQ3HXl
         5S5vfRxnWA0TxIoU2CNpsh3nSoTjf8Ic20p7eUKRaiUOLznpAUNd/z2IMpS4xXzYXcGA
         4g9geWb7sTFWaIIstUFT1bhb7qwhqFsIcN4P0ZUbMH13vvcbicE/Vd3dC23Mt5RUHjOB
         BPm3YVh4Sch8MeLoP20xXRUPd8oHx5pM1Cx/1LfqHFP56mBuQTYAiiZWi8urS0g87/us
         uTHQCyBU0L2ogDkdR/Pkx1pyObCEgrCfGwQEXD90urQewog05+KqUjWuMcWFFe13pj1t
         iEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694589486; x=1695194286;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HobCr1YvW+uQSy9dj9a5595BmgRYMkqX7jfk+9Xr840=;
        b=oQwJ+HNZaMs+Gffy4rftHeSD1dF6+h/R4r/NNXo9BWg+Jxhn8jIoZ0t9tjXFqTRP+t
         RZl4dDWuJJ0w7lERN3OfLq7FKh8/K0u5dK/ks8PLzL9sUFx+pJyT0pEm2RxgYTLVFyEH
         qBa0WJ+hS9uALA8ui/rRrVuus6QVo2gfCbqtL5OAuNgrCNHlM03ZUmL0hGP+F+DCudji
         emRZhTAQoGWOGe8eUCILz013eJSBtABOIRW95RhJNM0JHaEyE0ZacLaLZyMrygCFMjjH
         2HHJXIcbJWXtFjigBZN1RYY6V8zqeYEXiJRZf7fJRh3Y2Jp0RIcSk54lj7gg46Pyq1Mz
         yNuQ==
X-Gm-Message-State: AOJu0Yz1CHqUjszmfNvaaw/m6AE5YMX/WCGE+ZNEezdAuOhFMuo1Gr8A
        PNRr9BYDOHlG80WP2+U4lShfcXQwkMC/JGR8Glw=
X-Google-Smtp-Source: AGHT+IEbQBgayXNJblrUIThLYaVXgYZABLp2tLpnLNnjRe3Kktx0V+OpYipBJgeEvAqEhtLs6hwJUg==
X-Received: by 2002:a7b:cd9a:0:b0:3fe:1cac:37d7 with SMTP id y26-20020a7bcd9a000000b003fe1cac37d7mr1158816wmj.10.1694589485899;
        Wed, 13 Sep 2023 00:18:05 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c19-20020a7bc013000000b003fed70fb09dsm1136763wmb.26.2023.09.13.00.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 00:18:05 -0700 (PDT)
Date:   Wed, 13 Sep 2023 10:18:03 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Qiang Yu <quic_qianyu@quicinc.com>,
        mani@kernel.org, quic_jhugo@quicinc.com
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, quic_mrana@quicinc.com,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        Qiang Yu <quic_qianyu@quicinc.com>
Subject: Re: [PATCH 1/2] bus: mhi: host: Add spinlock to protect WP access
 when queueing TREs
Message-ID: <6fd73c41-852d-4d4a-9a48-b0c6dffe2515@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1694426069-74140-2-git-send-email-quic_qianyu@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qiang,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qiang-Yu/bus-mhi-host-Add-spinlock-to-protect-WP-access-when-queueing-TREs/20230912-072349
base:   linus/master
patch link:    https://lore.kernel.org/r/1694426069-74140-2-git-send-email-quic_qianyu%40quicinc.com
patch subject: [PATCH 1/2] bus: mhi: host: Add spinlock to protect WP access when queueing TREs
config: i386-randconfig-141-20230913 (https://download.01.org/0day-ci/archive/20230913/202309131155.OQbvsWhZ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230913/202309131155.OQbvsWhZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202309131155.OQbvsWhZ-lkp@intel.com/

smatch warnings:
drivers/bus/mhi/host/main.c:1249 mhi_gen_tre() warn: inconsistent returns '&mhi_chan->lock'.

vim +1249 drivers/bus/mhi/host/main.c

189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1200  int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1201  			struct mhi_buf_info *info, enum mhi_flags flags)
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1202  {
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1203  	struct mhi_ring *buf_ring, *tre_ring;
84f5f31f110e5e drivers/bus/mhi/host/main.c Manivannan Sadhasivam 2022-03-01  1204  	struct mhi_ring_element *mhi_tre;
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1205  	struct mhi_buf_info *buf_info;
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1206  	int eot, eob, chain, bei;
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1207  	int ret;
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1208  
c8a037317010d5 drivers/bus/mhi/host/main.c Bhaumik Bhatt         2023-09-11  1209  	/* Protect accesses for reading and incrementing WP */
c8a037317010d5 drivers/bus/mhi/host/main.c Bhaumik Bhatt         2023-09-11  1210  	write_lock_bh(&mhi_chan->lock);
c8a037317010d5 drivers/bus/mhi/host/main.c Bhaumik Bhatt         2023-09-11  1211  
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1212  	buf_ring = &mhi_chan->buf_ring;
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1213  	tre_ring = &mhi_chan->tre_ring;
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1214  
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1215  	buf_info = buf_ring->wp;
cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1216  	WARN_ON(buf_info->used);
cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1217  	buf_info->pre_mapped = info->pre_mapped;
cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1218  	if (info->pre_mapped)
cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1219  		buf_info->p_addr = info->p_addr;
cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1220  	else
cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1221  		buf_info->v_addr = info->v_addr;
cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1222  	buf_info->cb_buf = info->cb_buf;
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1223  	buf_info->wp = tre_ring->wp;
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1224  	buf_info->dir = mhi_chan->dir;
cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1225  	buf_info->len = info->len;
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1226  
cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1227  	if (!info->pre_mapped) {
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1228  		ret = mhi_cntrl->map_single(mhi_cntrl, buf_info);
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1229  		if (ret)
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1230  			return ret;

write_unlock_bh(&mhi_chan->lock);

cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1231  	}
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1232  
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1233  	eob = !!(flags & MHI_EOB);
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1234  	eot = !!(flags & MHI_EOT);
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1235  	chain = !!(flags & MHI_CHAIN);
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1236  	bei = !!(mhi_chan->intmod);
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1237  
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1238  	mhi_tre = tre_ring->wp;
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1239  	mhi_tre->ptr = MHI_TRE_DATA_PTR(buf_info->p_addr);
cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1240  	mhi_tre->dword[0] = MHI_TRE_DATA_DWORD0(info->len);
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1241  	mhi_tre->dword[1] = MHI_TRE_DATA_DWORD1(bei, eot, eob, chain);
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1242  
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1243  	/* increment WP */
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1244  	mhi_add_ring_element(mhi_cntrl, tre_ring);
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1245  	mhi_add_ring_element(mhi_cntrl, buf_ring);
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1246  
c8a037317010d5 drivers/bus/mhi/host/main.c Bhaumik Bhatt         2023-09-11  1247  	write_unlock_bh(&mhi_chan->lock);
c8a037317010d5 drivers/bus/mhi/host/main.c Bhaumik Bhatt         2023-09-11  1248  
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20 @1249  	return 0;
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1250  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

