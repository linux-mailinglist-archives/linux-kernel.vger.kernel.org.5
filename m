Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E2D784694
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237507AbjHVQIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbjHVQIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:08:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03841113;
        Tue, 22 Aug 2023 09:08:35 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MBOUX3020257;
        Tue, 22 Aug 2023 16:08:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kvyYZwAdpAQVDzlq8OLrapuXygrnT8Ss3tbbOi6PXAI=;
 b=BVGJxpe3ntlw/K9CgHeqfq/c15YtjUS/LFFZREgPfFx6AuiYtKFeWw/uu2Q6Tn+j8zAK
 cip+SRSTXmN5ZAR7VKlEPXh8GiYFFjeah1YsCCC45pkboX2/WcPaZHQnSXkCQLmJsrYT
 hYbA/qD1b5lzFWXKHdoQRi35yjYY7QdjBbt50TbRqXCeKNogtm3+TDkBfP9+tCy0kmnX
 K38FBLQPm8llEQw9CXZZEBFeehbIc55QTjGTQaUeeHnQwlIWK45yy0gjOnSRLFpvqvlw
 aUpaQINRO0zV0FXAweb4FDcqPsfGrcVZst/zCoY2QhAzyPtV7I7U56aw54ny06raVFT0 Fg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3smasmthn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 16:08:31 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37MG8Uk8027472
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 16:08:30 GMT
Received: from [10.110.124.126] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 22 Aug
 2023 09:08:28 -0700
Message-ID: <06cb9718-ed64-8604-0bde-fff6d56ef3dd@quicinc.com>
Date:   Tue, 22 Aug 2023 09:08:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 1/1] soc: qcom: Add driver to read secondary
 bootloader (XBL) log
To:     Ninad Naik <quic_ninanaik@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>
CC:     <psodagud@quicinc.com>, <quic_ppareek@quicinc.com>,
        <quic_kprasan@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>
References: <20230822121512.8631-1-quic_ninanaik@quicinc.com>
 <20230822121512.8631-2-quic_ninanaik@quicinc.com>
Content-Language: en-US
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <20230822121512.8631-2-quic_ninanaik@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oaXcNXBegj_FiDR3dVqHU_Y3_9ZXXBX9
X-Proofpoint-GUID: oaXcNXBegj_FiDR3dVqHU_Y3_9ZXXBX9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_13,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1015 suspectscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308220125
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/2023 5:15 AM, Ninad Naik wrote:
> Qualcomm secondary bootloader (XBL) boot log holds information to
> identify various firmware configuration currently set on the SoC.
> The XBL log is stored in a predefined reserved memory region.

What does "X" stands for here? From what you have described above it 
looks like SBL and not XBL.

> 
> This drivers provides a way to print XBL logs on the console. To
> do so, it provides a debugfs entry which captures the logs stored
> in this reserved memory region. This entry can now be used to read
> and print the XBL logs to console.
> 
> User can use the below command to print XBL log to console:
>          cat /sys/kernel/debug/xbl_log


It is not clear to me why these patches are posted as RFC. Please 
clarify. Are they not tested properly or just seeking some feedback and 
driver is not ready w/ all the features?

> 
> Signed-off-by: Ninad Naik <quic_ninanaik@quicinc.com>
> ---
>   drivers/soc/qcom/Kconfig        |  13 +++
>   drivers/soc/qcom/Makefile       |   1 +
>   drivers/soc/qcom/dump_xbl_log.c | 139 ++++++++++++++++++++++++++++++++
>   3 files changed, 153 insertions(+)
>   create mode 100644 drivers/soc/qcom/dump_xbl_log.c
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 715348869d04..4489d37e924d 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -291,4 +291,17 @@ config QCOM_INLINE_CRYPTO_ENGINE
>   	tristate
>   	select QCOM_SCM
>   
> +config QCOM_DUMP_XBL_LOG
> +	tristate "Qualcomm driver to print XBL logs on console from debugfs"

Why you want to print these logs from the debugfs? What is the format of 
the logs? Can you post an example log?

> +	help
> +	  This driver is used to capture secondary bootloader (xbl) log
> +	  from a reserved memory region and provide a debugfs entry to read
> +	  logs captured from this memory region and print them on console.
> +	  User can use below command to print the xbl log on console:
> +
> +                cat /sys/kernel/debug/xbl_log
> +
> +	  These logs help to identify firmware configuration information on
> +	  the SoC. The name of the built module will be dump_xbl_log
> +
>   endmenu
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index bbca2e1e55bb..aac088a1a0b6 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -32,3 +32,4 @@ obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
>   obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
>   qcom_ice-objs			+= ice.o
>   obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= qcom_ice.o
> +obj-$(CONFIG_QCOM_DUMP_XBL_LOG)	+= dump_xbl_log.o
> diff --git a/drivers/soc/qcom/dump_xbl_log.c b/drivers/soc/qcom/dump_xbl_log.c
> new file mode 100644
> index 000000000000..ea335a5e660b
> --- /dev/null
> +++ b/drivers/soc/qcom/dump_xbl_log.c
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/memblock.h>
> +#include <linux/of_address.h>
> +#include <linux/err.h>
> +#include <linux/debugfs.h>
> +
> +struct xbl_log_data {
> +	struct device *dev;
> +	size_t buf_size;
> +	void __iomem *xbl_buf;
> +	struct dentry *dbg_file;
> +	struct debugfs_blob_wrapper dbg_data;
> +};
> +
> +static int map_addr_range(struct device_node **parent, const char *name,
> +			  struct xbl_log_data *xbl_data)
> +{
> +	struct device_node *node;
> +	struct resource res;
> +	int ret;
> +
> +	node = of_find_node_by_name(*parent, name);
> +	if (!node)
> +		return -ENODEV;
> +
> +	ret = of_address_to_resource(node, 0, &res);
> +	if (ret) {
> +		dev_err(xbl_data->dev, "Failed to parse memory region\n");
> +		return ret;
> +	}
> +	of_node_put(node);
> +
> +	if (!resource_size(&res)) {
> +		dev_err(xbl_data->dev, "Failed to parse memory region size\n");
> +		return -ENODEV;
> +	}
> +
> +	xbl_data->buf_size = resource_size(&res) - 1;
> +	xbl_data->xbl_buf = devm_memremap(xbl_data->dev, res.start,
> +					  xbl_data->buf_size, MEMREMAP_WB);
> +	if (!xbl_data->xbl_buf) {
> +		dev_err(xbl_data->dev, "%s: memory remap failed\n", name);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static int xbl_log_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct xbl_log_data *xbl_data;
> +	struct device_node *parent;
> +	int ret;
> +
> +	xbl_data = devm_kzalloc(dev, sizeof(*xbl_data), GFP_KERNEL);
> +	if (!xbl_data)
> +		return -ENOMEM;
> +
> +	xbl_data->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, xbl_data);
> +
> +	parent = of_find_node_by_path("/reserved-memory");
> +	if (!parent) {
> +		dev_err(xbl_data->dev, "reserved-memory node missing\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = map_addr_range(&parent, "uefi-log", xbl_data);

Here you are calling it as uefi-log. Is it xbl-log or uefi-log? Please 
decide first.


> +	if (ret)
> +		goto put_node;
> +
> +	xbl_data->dbg_data.data = xbl_data->xbl_buf;
> +	xbl_data->dbg_data.size = xbl_data->buf_size;
> +	xbl_data->dbg_file = debugfs_create_blob("xbl_log", 0400, NULL,
> +						 &xbl_data->dbg_data);
> +	if (IS_ERR(xbl_data->dbg_file)) {
> +		dev_err(xbl_data->dev, "failed to create debugfs entry\n");
> +		ret = PTR_ERR(xbl_data->dbg_file);
> +	}
> +
> +put_node:
> +	of_node_put(parent);
> +	return ret;
> +}
> +
> +static int xbl_log_remove(struct platform_device *pdev)
> +{
> +	struct xbl_log_data *xbl_data = platform_get_drvdata(pdev);
> +
> +	debugfs_remove_recursive(xbl_data->dbg_file);
> +	return 0;
> +}
> +
> +static struct platform_driver xbl_log_driver = {
> +	.probe = xbl_log_probe,
> +	.remove = xbl_log_remove,
> +	.driver = {
> +		   .name = "xbl-log",
> +		   },
> +};
> +
> +static struct platform_device xbl_log_device = {
> +	.name = "xbl-log",
> +};
> +
> +static int __init xbl_log_init(void)
> +{
> +	int ret = 0;
> +
> +	ret = platform_driver_register(&xbl_log_driver);
> +	if (!ret) {
> +		ret = platform_device_register(&xbl_log_device);

I am puzzled here. Why?

> +		if (ret)
> +			platform_driver_unregister(&xbl_log_driver);
> +	}
> +	return ret;
> +}
> +
> +static void __exit xbl_log_exit(void)
> +{
> +	platform_device_unregister(&xbl_log_device);
> +	platform_driver_unregister(&xbl_log_driver);
> +}
> +
> +module_init(xbl_log_init);
> +module_exit(xbl_log_exit);
> +
> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. (QTI) XBL log driver");
> +MODULE_LICENSE("GPL");
-- 
---Trilok Soni

