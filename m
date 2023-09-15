Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEB27A13F1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 04:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjIOCqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 22:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjIOCqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 22:46:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE47A26AB;
        Thu, 14 Sep 2023 19:46:28 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38F2gwoL026800;
        Fri, 15 Sep 2023 02:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=duSaNeGznZDxsqL4XxZuAmTpqYrhyn5db4vVj8CzfzU=;
 b=I/d+rOhFQJiBBx8iOxxV68ZtXGUFb6gb6IwPgg38VqVAnQE8ABm1I6+m9sdwONk+Ee4c
 HTAaL6+scPImXMJpyDoAW5DQ5JGDsrl5v675ectPv4qTQxqLPayRpbloeS1NnvZuS0gI
 v5RL0QoZoqcTpJiQO9Lf8ne7CVgJVHy/OBtl7/mX+YijkstfZr3vWvvF9B26GSOAFoSE
 sYqZqc+9ocPCIiUaP64yBPJdNzLle4kOBNgi2xoJlyCHOA+JivM6hY9jZs5UNfzA564x
 m5C5oQVFKRwTJRPxtuav0POBgTIZRgIswK4f9RXSRlzEN1XaBwq2PYCl4Vj8HMPy9GlG CQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4eq9r0b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 02:46:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38F2kPJC027298
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 02:46:25 GMT
Received: from [10.216.15.200] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 14 Sep
 2023 19:46:22 -0700
Message-ID: <691dc45e-8c06-71b6-c7bd-6e077d5fcea2@quicinc.com>
Date:   Fri, 15 Sep 2023 08:16:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [RFC] usb: gadget: ncm: Handle decoding of multiple NTB's in
 unwrap call
To:     =?UTF-8?Q?Maciej_=c5=bbenczykowski?= <maze@google.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>
References: <20230914182922.27157-1-quic_kriskura@quicinc.com>
 <CANP3RGeMFnBdQ3yS3i_QqWCuQB34Ma8ToEnfH-WjZQBeNgqoFw@mail.gmail.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <CANP3RGeMFnBdQ3yS3i_QqWCuQB34Ma8ToEnfH-WjZQBeNgqoFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BnVTgxnGLqneL7y32P4H8rTHelEm2Ix0
X-Proofpoint-GUID: BnVTgxnGLqneL7y32P4H8rTHelEm2Ix0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_02,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=412
 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150023
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/2023 6:54 AM, Maciej Żenczykowski wrote:
> Reviewed-by: Maciej Żenczykowski <maze@google.com>
> 
> The casts should probably use the actual correct ptr type instead of void*
> 

Hi Maciej Żenczykowski,

Thanks for the review.

I initially tried to typecast it to char* since the skb->data is of that 
type. But nothing was working. So I kept it void* since the initial 
variable tmp too was kept to void*

Will add the stable and review tag as well and send v2 to be merged.

Regards,
Krishna,
