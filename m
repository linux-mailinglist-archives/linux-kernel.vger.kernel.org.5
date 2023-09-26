Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9967AE30D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 02:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjIZApY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 20:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjIZApV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 20:45:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C284B109;
        Mon, 25 Sep 2023 17:45:14 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38Q0d24f007282;
        Tue, 26 Sep 2023 00:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=O6GQ05kOGxAM4YVWuYvy/Z6qCm8b0cByMPYMw3YB4JM=;
 b=AwQBw2qxwifO7KpAe1UD3QIB708vj5pk0zHgX+ruoQ6zpdrU5QWiqjFTRikytqg+YftE
 7KUeMdAAgMXzWgysskXIGzId3cpvYSg5nfttzBXTJZQ+Sz3vUjkWcSFsTh2wBbO7PXI6
 iHtYwmRjEHi30t7F5Lb5bvxxmOoTicZKhpePDyuRFfsVL4zNka6xDhdJJlUDpAKrnS1f
 CkXhTa1FLj7BW/ih7suAoqFZjvECfI7LhLYjL39mJT7gW9su+L8kHghgiUKfrZ222Gm5
 jIlJmhPJaY26pIxKDj3A4rEhaK+CpP6UU8h8dIXLrPFrJ4/gqOArViYnQQwoS7gFH/3c JQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tb72shw18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 00:45:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38Q0jABd019002
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 00:45:10 GMT
Received: from [10.48.244.213] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 25 Sep
 2023 17:45:10 -0700
Message-ID: <5591d8a4-24be-4288-88df-29fd5a11ac66@quicinc.com>
Date:   Mon, 25 Sep 2023 17:45:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 2/2] ath: dfs_pattern_detector: Use flex
 array to simplify code
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Kalle Valo <kvalo@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>
References: <ad8c55b97ee4b330cb053ce2c448123c309cc91c.1695538105.git.christophe.jaillet@wanadoo.fr>
 <1920cc38db2e570633e13b37d50852f3202a7270.1695538105.git.christophe.jaillet@wanadoo.fr>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <1920cc38db2e570633e13b37d50852f3202a7270.1695538105.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PcxPwyF9f3xd-1O33kimOP-_8PQf5iQM
X-Proofpoint-ORIG-GUID: PcxPwyF9f3xd-1O33kimOP-_8PQf5iQM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_19,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 malwarescore=0 adultscore=0 mlxlogscore=850 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260003
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/2023 11:57 PM, Christophe JAILLET wrote:
> At the time of the writing, the value of 'num_radar_types' is 7 or 9. So
> on a 64 bits system, only 56 or 72 bytes are allocated for the
> 'detectors' array.
> 
> Turn it into a flex array, in order to simplify memory management and save
> an indirection when the array is used.
> 
> Doing so, cd->detectors can't be NULL, and channel_detector_exit() can be
> simplified as well.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

