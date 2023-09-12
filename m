Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C395879CF75
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbjILLJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbjILLIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:08:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5110211F;
        Tue, 12 Sep 2023 04:07:58 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C7hWVi022226;
        Tue, 12 Sep 2023 11:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=lImsvjSI/7UiZSfw38oBDU1ONszfOqlUayBGLOImhpQ=;
 b=F+uzK4i0fCp6YjGxybBgaLacf96jxXYobMaoMcFab2kTFWFt8N58IhOwe+4dL9i1BrbF
 LrAGvFbdH0gwCTzWYCzAqEOv4YICHbGDVkrtLY3eGvPH846IGdij1gfdRFlnqldoPyRo
 wEa9wvhkjPKj6S7jeTVsWw1szuIxguSRe+t+s8ywCZODCd0t27Rq10Mr8NDNsWpdadq3
 rHbtQgvIvuaKsjLkWVL1NSjgpRkm1r1Rp+G9v03anUbQZ9qxMep+7EnYqZoXIiW15QIy
 UGdzyUXr60aOPZsphGeialF6h0TlFqrQCJfgWpdt0J447MtYWGyf+xsAuSxnZeYt5iJL kA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t29b0hnp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 11:07:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38CB7qu9019449
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 11:07:52 GMT
Received: from [10.217.219.52] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 12 Sep
 2023 04:07:50 -0700
Message-ID: <21d247d3-83be-ba53-c982-2ab0e2e4ffb3@quicinc.com>
Date:   Tue, 12 Sep 2023 16:37:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: usb: typec: ucsi: Clear EVENT_PENDING bit if ucsi_send_command
 fails
Content-Language: en-US
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "# 5 . 16" <stable@vger.kernel.org>
References: <1694423055-8440-1-git-send-email-quic_prashk@quicinc.com>
 <ZP8M6zqgsLTK25PI@kuha.fi.intel.com>
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <ZP8M6zqgsLTK25PI@kuha.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nbCVu8xN1FrfUm2npsFAiewR58xiYWSO
X-Proofpoint-ORIG-GUID: nbCVu8xN1FrfUm2npsFAiewR58xiYWSO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_09,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309120092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11-09-23 06:19 pm, Heikki Krogerus wrote:
> On Mon, Sep 11, 2023 at 02:34:15PM +0530, Prashanth K wrote:
>> Currently if ucsi_send_command() fails, then we bail out without
>> clearing EVENT_PENDING flag. So when the next connector change
>> event comes, ucsi_connector_change() won't queue the con->work,
>> because of which none of the new events will be processed.
>>
>> Fix this by clearing EVENT_PENDING flag if ucsi_send_command()
>> fails.
>>
>> Cc: <stable@vger.kernel.org> # 5.16
>> Fixes: 512df95b9432 ("usb: typec: ucsi: Better fix for missing unplug events issue")
>> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
>> ---
>>   drivers/usb/typec/ucsi/ucsi.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
>> index c6dfe3d..509c67c 100644
>> --- a/drivers/usb/typec/ucsi/ucsi.c
>> +++ b/drivers/usb/typec/ucsi/ucsi.c
>> @@ -884,6 +884,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
>>   	if (ret < 0) {
>>   		dev_err(ucsi->dev, "%s: GET_CONNECTOR_STATUS failed (%d)\n",
>>   			__func__, ret);
>> +		clear_bit(EVENT_PENDING, &con->ucsi->flags);
>>   		goto out_unlock;
>>   	}
> 
> I think it would be better to just move that label (out_unlock) above
> the point where clear_bit() is already called instead of separately
> calling it like that. That way the Connector Change Event will
> also get acknowledged.
Do we really need to ACK in this case since we didn't process the 
current connector change event
> 
> If this really can happen, then I think it would be good to also
> schedule a task for ucsi_check_connection():
> 
>          if (ret < 0) {
>                  dev_err(ucsi->dev, "%s: GET_CONNECTOR_STATUS failed (%d)\n",
>                          __func__, ret);
> +               ucsi_partner_task(con, ucsi_check_connection, 1, HZ);
>                  goto out_unlock;
>          }
> 
> thanks,
> 
Retrying is a good idea, but ucsi_check_connection() doesn't have the 
full functionality compared to handle_connector_change. I guess 
ucsi_check_connection() will send a set_role, but won't handle the 
connector_change scenarios happening due to PR/DR swap, which will lead 
to deadlocks (due to wait_for_completion). This is just an example. So 
its better to bail out and process the next events, because the failure 
here is from the glink layer.

Thanks
Prashanth K
