Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E653F7C8B1F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjJMQdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMQdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:33:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F36DC;
        Fri, 13 Oct 2023 09:33:06 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DEuLHS023685;
        Fri, 13 Oct 2023 16:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=XQ3aeOmPzgrQrmVazfq5ZwF1RIShqKIieMaVMu6i7lY=;
 b=bw6jflWHJEmnXkh/4KjMP3ZjEpk73vyQ+CEaZ+Sq+kzhVi2g1NjjTXq4p32B/kv+9ENI
 SofSdbSula2hzKRrFWZSop48mTXDO770FluBcTMSI2YmMwJlWq5zXBBi7TOPSdskxKhV
 p5Lw9J84C8pa3zQDm9/KEHz5b/ia8QooPcR4Z08zBCEN6LJHIpdKCOyx47/AlQVc8zSn
 fwQW1RzhwwlInNPA8yvvmw0ityGBEujhu1DcItgykus+sviwWzzOH5Gjdv4x0uqYwlrw
 IF22PX0+MpiF9ZoqoUHxVYHLuYpqTBTveJoqtZ9U2XxuhIThyQJs2c9bu6h/rbv+dzxC 0g== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tpt0x2a1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 16:32:40 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39DGWeKr012683
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 16:32:40 GMT
Received: from quicinc.com (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 13 Oct
 2023 09:32:36 -0700
Date:   Fri, 13 Oct 2023 09:32:35 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        "Maximilian Luz" <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        "Srini Kandagatla" <srinivas.kandagatla@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 06/15] firmware: qcom: scm: smc: switch to using the
 SCM allocator
Message-ID: <ZSlxI8mibrMtNzqU@quicinc.com>
Mail-Followup-To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20231013114843.63205-1-brgl@bgdev.pl>
 <20231013114843.63205-7-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231013114843.63205-7-brgl@bgdev.pl>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VcMdlBiGm54gxOOiTDHvqPoxZYYKcC4I
X-Proofpoint-ORIG-GUID: VcMdlBiGm54gxOOiTDHvqPoxZYYKcC4I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_07,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=598 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 13 2023 13:48, Bartosz Golaszewski wrote:

[...]

> @@ -192,25 +193,12 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
>  						      SCM_SMC_FIRST_EXT_IDX]);
>  		}
>  
> -		args_phys = dma_map_single(dev, args_virt, alloc_len,
> -					   DMA_TO_DEVICE);
> -
> -		if (dma_mapping_error(dev, args_phys)) {
> -			kfree(args_virt);
> -			return -ENOMEM;
> -		}
> -
> -		smc.args[SCM_SMC_LAST_REG_IDX] = args_phys;
> +		smc.args[SCM_SMC_LAST_REG_IDX] = qcom_tzmem_to_phys(args_virt);
>  	}
>  
>  	/* ret error check follows after args_virt cleanup*/

Since args_virt cleanup is being removed, please remove this comment also.

>  	ret = __scm_smc_do(dev, &smc, &smc_res, atomic);
>  
> -	if (args_virt) {
> -		dma_unmap_single(dev, args_phys, alloc_len, DMA_TO_DEVICE);
> -		kfree(args_virt);
> -	}
> -
>  	if (ret)
>  		return ret;

Guru Das.
