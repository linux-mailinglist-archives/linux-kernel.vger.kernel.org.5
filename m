Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FDF785661
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbjHWLGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjHWLGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:06:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAEBCDA;
        Wed, 23 Aug 2023 04:06:29 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37N8HvIt015116;
        Wed, 23 Aug 2023 11:06:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qiMmn5wx7QNMjhgbTwUVO0uesMmqRuxiNsiUbEPC25M=;
 b=WHt6QVN+tnKPQ+lV2R1P2EAsCqHEC6y1cEJjBS7cJYd/9Nm26GqXUpsk6gifkFhL065Y
 52hpVucxN5FjxciRlDMtNv2/2uz06h70eOI/pzQBkjMSyebAPlZtNhgiD1WAkbFPzae5
 nHz4WSRIzD0CzvIE6+sk7MPXsNHsq127GN/mPoRcSgimEqwOu5NfJ4GAiR9Ekj3J+RXX
 DftG1PV8lSBv9jLlQBlXTvfCyL234S+mb0MEHA198DIyC9kx1/tmI6YUMQCecUy/g1ZD
 4Q5XG1PyY957fizftz4BWt9mEwx20hscfA/oV0r+rn+cTsT38TdTBWfCyT24HFdgPgxY rw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sn2bt9qrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 11:06:23 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37NB6Mif024894
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 11:06:22 GMT
Received: from [10.50.32.23] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 23 Aug
 2023 04:06:17 -0700
Message-ID: <08655b2e-a8c3-4355-90c3-a96f303e0640@quicinc.com>
Date:   Wed, 23 Aug 2023 16:36:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] soc: qcom: Add driver to read secondary
 bootloader (XBL) log
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <psodagud@quicinc.com>,
        <quic_ppareek@quicinc.com>, <quic_kprasan@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20230822121512.8631-1-quic_ninanaik@quicinc.com>
 <20230822121512.8631-2-quic_ninanaik@quicinc.com>
 <d0f663e7-cee4-451e-9b28-99ba7e6f674a@quicinc.com>
Content-Language: en-US
From:   Ninad Naik <quic_ninanaik@quicinc.com>
In-Reply-To: <d0f663e7-cee4-451e-9b28-99ba7e6f674a@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2gZZWG3zl8TGW6xXpUnY858jkw19n_JA
X-Proofpoint-GUID: 2gZZWG3zl8TGW6xXpUnY858jkw19n_JA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_06,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230101
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavan,

On 8/22/2023 6:09 PM, Pavan Kondeti wrote:
> On Tue, Aug 22, 2023 at 05:45:12PM +0530, Ninad Naik wrote:
>> Qualcomm secondary bootloader (XBL) boot log holds information to
>> identify various firmware configuration currently set on the SoC.
>> The XBL log is stored in a predefined reserved memory region.
>>
>> This drivers provides a way to print XBL logs on the console. To
>> do so, it provides a debugfs entry which captures the logs stored
>> in this reserved memory region. This entry can now be used to read
>> and print the XBL logs to console.
>>
>> User can use the below command to print XBL log to console:
>>          cat /sys/kernel/debug/xbl_log
>>
>> Signed-off-by: Ninad Naik <quic_ninanaik@quicinc.com>
>> ---
> 
> For a single patch, cover letter may not be needed. The under cut
> portion (this area) of the patch can be used to present the additional
> details.
> 
Ack.
>>   drivers/soc/qcom/Kconfig        |  13 +++
>>   drivers/soc/qcom/Makefile       |   1 +
>>   drivers/soc/qcom/dump_xbl_log.c | 139 ++++++++++++++++++++++++++++++++
>>   3 files changed, 153 insertions(+)
>>   create mode 100644 drivers/soc/qcom/dump_xbl_log.c
>>
> 
> [...]
> 
>> +static int map_addr_range(struct device_node **parent, const char *name,
>> +			  struct xbl_log_data *xbl_data)
>> +{
>> +	struct device_node *node;
>> +	struct resource res;
>> +	int ret;
>> +
>> +	node = of_find_node_by_name(*parent, name);
>> +	if (!node)
>> +		return -ENODEV;
>> +
>> +	ret = of_address_to_resource(node, 0, &res);
>> +	if (ret) {
>> +		dev_err(xbl_data->dev, "Failed to parse memory region\n");
>> +		return ret;
>> +	}
>> +	of_node_put(node);
>> +
>> +	if (!resource_size(&res)) {
>> +		dev_err(xbl_data->dev, "Failed to parse memory region size\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	xbl_data->buf_size = resource_size(&res) - 1;
>> +	xbl_data->xbl_buf = devm_memremap(xbl_data->dev, res.start,
>> +					  xbl_data->buf_size, MEMREMAP_WB);
>> +	if (!xbl_data->xbl_buf) {
>> +		dev_err(xbl_data->dev, "%s: memory remap failed\n", name);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int xbl_log_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct xbl_log_data *xbl_data;
>> +	struct device_node *parent;
>> +	int ret;
>> +
>> +	xbl_data = devm_kzalloc(dev, sizeof(*xbl_data), GFP_KERNEL);
>> +	if (!xbl_data)
>> +		return -ENOMEM;
>> +
>> +	xbl_data->dev = &pdev->dev;
>> +	platform_set_drvdata(pdev, xbl_data);
>> +
>> +	parent = of_find_node_by_path("/reserved-memory");
>> +	if (!parent) {
>> +		dev_err(xbl_data->dev, "reserved-memory node missing\n");
>> +		return -ENODEV;
>> +	}
>> +
> 
> You would need to present the Device Tree binding document for this. For
> ex: pls see
> Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.yaml
> 
Ack. Will add a corresponding DT binding in the next version
>> +	ret = map_addr_range(&parent, "uefi-log", xbl_data);
>> +	if (ret)
>> +		goto put_node;
>> +
>> +	xbl_data->dbg_data.data = xbl_data->xbl_buf;
>> +	xbl_data->dbg_data.size = xbl_data->buf_size;
>> +	xbl_data->dbg_file = debugfs_create_blob("xbl_log", 0400, NULL,
>> +						 &xbl_data->dbg_data);
>> +	if (IS_ERR(xbl_data->dbg_file)) {
>> +		dev_err(xbl_data->dev, "failed to create debugfs entry\n");
>> +		ret = PTR_ERR(xbl_data->dbg_file);
>> +	}
>> +
>> +put_node:
>> +	of_node_put(parent);
>> +	return ret;
>> +}
>> +
>> +static int xbl_log_remove(struct platform_device *pdev)
>> +{
>> +	struct xbl_log_data *xbl_data = platform_get_drvdata(pdev);
>> +
>> +	debugfs_remove_recursive(xbl_data->dbg_file);
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver xbl_log_driver = {
>> +	.probe = xbl_log_probe,
>> +	.remove = xbl_log_remove,
>> +	.driver = {
>> +		   .name = "xbl-log",
>> +		   },
>> +};
>> +
>> +static struct platform_device xbl_log_device = {
>> +	.name = "xbl-log",
>> +};
>> +
>> +static int __init xbl_log_init(void)
>> +{
>> +	int ret = 0;
>> +
>> +	ret = platform_driver_register(&xbl_log_driver);
>> +	if (!ret) {
>> +		ret = platform_device_register(&xbl_log_device);
>> +		if (ret)
>> +			platform_driver_unregister(&xbl_log_driver);
>> +	}
>> +	return ret;
>> +}
>> +
> 
> The platform device registration, the resource parsing can be completely
> avoided by adding your compatible entry to reserved_mem_matches
> structure defined in drivers/of/platform.c . There are some Qualcomm SoC
> devices also present in that list.
> 
Ack. So once the compatible entry is added to reserved_mem_matches 
structure here, a platform_device is created for this node to which this 
driver can bind to. Thank you for the suggestion, I'll make the 
necessary corrections in the next revision.

>> +static void __exit xbl_log_exit(void)
>> +{
>> +	platform_device_unregister(&xbl_log_device);
>> +	platform_driver_unregister(&xbl_log_driver);
>> +}
>> +
>> +module_init(xbl_log_init);
>> +module_exit(xbl_log_exit);
>> +
>> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. (QTI) XBL log driver");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.41.0
>>
Thanks,
Ninad
