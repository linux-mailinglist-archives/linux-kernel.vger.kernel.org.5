Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200E179E2A0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239117AbjIMIvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238900AbjIMIvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:51:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60244196;
        Wed, 13 Sep 2023 01:51:40 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38D8bvrE011988;
        Wed, 13 Sep 2023 08:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RgQpJCOK3bDFZ1dpUq09zxE57TA/jA/GRxmPNuz9zJs=;
 b=f4rVatg+hNgC2qG5YOCyKxoA7wmXGn/NTM/JdkOaPQNbRKlZ3WEd21RGsX4GMYnl6/6I
 acOWj58sZT70rsjRc/IR4TKiQp7LPPjbC/GTXA81B+SpKh957VAK505exFrvP+RXmjbn
 oDRWATHGx7yUTuKGeE3TrhDoylWmqdSZGafEu9G9fZuz/9A8isVkvTYyWetiN4Dv6QmV
 E0TRI7jF/3zQt060XjiGFku39PiZf98pqrhU2SM4b68gSK1gfzVm5l3zlI5rN3VMfOYh
 IPbUH93iuwyVPVhlrVNobaETnCECmAiVg2qZVjnZ3B9qX7wtIZPrMiX3N1QOpPtpNQri Tg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t2y8e14tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 08:50:44 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38D8oh8p004975
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 08:50:43 GMT
Received: from [10.253.13.18] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 13 Sep
 2023 01:50:39 -0700
Message-ID: <8096b5cc-cc25-d24d-f5af-e86220e25c09@quicinc.com>
Date:   Wed, 13 Sep 2023 16:50:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] bus: mhi: host: Add spinlock to protect WP access
 when queueing TREs
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        <oe-kbuild@lists.linux.dev>, <mani@kernel.org>,
        <quic_jhugo@quicinc.com>
CC:     <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
        <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <quic_mrana@quicinc.com>, Bhaumik Bhatt <bbhatt@codeaurora.org>
References: <6fd73c41-852d-4d4a-9a48-b0c6dffe2515@kadam.mountain>
Content-Language: en-US
From:   Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <6fd73c41-852d-4d4a-9a48-b0c6dffe2515@kadam.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Nx-laNVULctxCzORmYBsMCdYylJX0T44
X-Proofpoint-GUID: Nx-laNVULctxCzORmYBsMCdYylJX0T44
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_02,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 clxscore=1011 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309130070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/13/2023 3:18 PM, Dan Carpenter wrote:
> Hi Qiang,
>
> kernel test robot noticed the following build warnings:
>
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Qiang-Yu/bus-mhi-host-Add-spinlock-to-protect-WP-access-when-queueing-TREs/20230912-072349
> base:   linus/master
> patch link:    https://lore.kernel.org/r/1694426069-74140-2-git-send-email-quic_qianyu%40quicinc.com
> patch subject: [PATCH 1/2] bus: mhi: host: Add spinlock to protect WP access when queueing TREs
> config: i386-randconfig-141-20230913 (https://download.01.org/0day-ci/archive/20230913/202309131155.OQbvsWhZ-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20230913/202309131155.OQbvsWhZ-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202309131155.OQbvsWhZ-lkp@intel.com/
>
> smatch warnings:
> drivers/bus/mhi/host/main.c:1249 mhi_gen_tre() warn: inconsistent returns '&mhi_chan->lock'.
>
> vim +1249 drivers/bus/mhi/host/main.c
Thanks for reporting this error. Added write_unlock_bh(&mhi_chan->lock) 
before return because of error process in v2 patch.
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1200  int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
> cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1201  			struct mhi_buf_info *info, enum mhi_flags flags)
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1202  {
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1203  	struct mhi_ring *buf_ring, *tre_ring;
> 84f5f31f110e5e drivers/bus/mhi/host/main.c Manivannan Sadhasivam 2022-03-01  1204  	struct mhi_ring_element *mhi_tre;
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1205  	struct mhi_buf_info *buf_info;
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1206  	int eot, eob, chain, bei;
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1207  	int ret;
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1208
> c8a037317010d5 drivers/bus/mhi/host/main.c Bhaumik Bhatt         2023-09-11  1209  	/* Protect accesses for reading and incrementing WP */
> c8a037317010d5 drivers/bus/mhi/host/main.c Bhaumik Bhatt         2023-09-11  1210  	write_lock_bh(&mhi_chan->lock);
> c8a037317010d5 drivers/bus/mhi/host/main.c Bhaumik Bhatt         2023-09-11  1211
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1212  	buf_ring = &mhi_chan->buf_ring;
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1213  	tre_ring = &mhi_chan->tre_ring;
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1214
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1215  	buf_info = buf_ring->wp;
> cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1216  	WARN_ON(buf_info->used);
> cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1217  	buf_info->pre_mapped = info->pre_mapped;
> cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1218  	if (info->pre_mapped)
> cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1219  		buf_info->p_addr = info->p_addr;
> cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1220  	else
> cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1221  		buf_info->v_addr = info->v_addr;
> cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1222  	buf_info->cb_buf = info->cb_buf;
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1223  	buf_info->wp = tre_ring->wp;
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1224  	buf_info->dir = mhi_chan->dir;
> cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1225  	buf_info->len = info->len;
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1226
> cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1227  	if (!info->pre_mapped) {
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1228  		ret = mhi_cntrl->map_single(mhi_cntrl, buf_info);
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1229  		if (ret)
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1230  			return ret;
>
> write_unlock_bh(&mhi_chan->lock);
>
> cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1231  	}
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1232
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1233  	eob = !!(flags & MHI_EOB);
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1234  	eot = !!(flags & MHI_EOT);
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1235  	chain = !!(flags & MHI_CHAIN);
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1236  	bei = !!(mhi_chan->intmod);
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1237
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1238  	mhi_tre = tre_ring->wp;
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1239  	mhi_tre->ptr = MHI_TRE_DATA_PTR(buf_info->p_addr);
> cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1240  	mhi_tre->dword[0] = MHI_TRE_DATA_DWORD0(info->len);
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1241  	mhi_tre->dword[1] = MHI_TRE_DATA_DWORD1(bei, eot, eob, chain);
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1242
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1243  	/* increment WP */
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1244  	mhi_add_ring_element(mhi_cntrl, tre_ring);
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1245  	mhi_add_ring_element(mhi_cntrl, buf_ring);
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1246
> c8a037317010d5 drivers/bus/mhi/host/main.c Bhaumik Bhatt         2023-09-11  1247  	write_unlock_bh(&mhi_chan->lock);
> c8a037317010d5 drivers/bus/mhi/host/main.c Bhaumik Bhatt         2023-09-11  1248
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20 @1249  	return 0;
> 189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1250  }
>
