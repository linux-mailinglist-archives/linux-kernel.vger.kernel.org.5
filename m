Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5257A2ED9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 10:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjIPI3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 04:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjIPI2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 04:28:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9A719AE;
        Sat, 16 Sep 2023 01:28:43 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38G8A51S021215;
        Sat, 16 Sep 2023 08:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3/VLjhkwt0QqhWw5T9+rjmKa67Xi2aWkcGRIUM8bQCI=;
 b=JBn22dwywyqt1fNtPpfhZm+WqfD990JLD3nJhP4429ZgyVC30lZbqr+zVt/4NskQaUY/
 NNF1IvxwLqGcrpxR9Gl8juN4kk2wdwbkcFvDxehXQ2OLz/OgW/QnNu5O4tiD/Qz9Uboc
 Y3Jx1IfS9XI27/rgywyiGUt/pVjkg3FSPLGPbM4x+zTsay1glRJQz/pUUxBYbrQbiNOw
 37lvKKWCu9hwZBMrJENPc3G//JdCe30c9p8zzi8lI4AgDd7g5ekMaFJ2nMKSHgEsqood
 hKJTzN9aJ3agF6ESev9+gBi21jzB2/ZrJ1zNiQqFX4xycubqGe9EAp9H2G4Gh6EKnfrd rA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t55neg6xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Sep 2023 08:28:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38G8SbjE032669
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Sep 2023 08:28:37 GMT
Received: from [10.216.28.42] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sat, 16 Sep
 2023 01:28:35 -0700
Message-ID: <d0c27255-fcd2-39ed-f7af-b3b79d965ddf@quicinc.com>
Date:   Sat, 16 Sep 2023 13:58:30 +0530
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
 <21d247d3-83be-ba53-c982-2ab0e2e4ffb3@quicinc.com>
 <ZQROzNqr7fbmJC87@kuha.fi.intel.com>
 <4e876097-aed1-2b0d-ecb4-6434add4ef26@quicinc.com>
 <ZQRi20nC0j5c4LGI@kuha.fi.intel.com>
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <ZQRi20nC0j5c4LGI@kuha.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OSxz2XB6x66nQ7hWg2xl-IcZbkHMNS8R
X-Proofpoint-ORIG-GUID: OSxz2XB6x66nQ7hWg2xl-IcZbkHMNS8R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_20,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309160072
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15-09-23 07:27 pm, Heikki Krogerus wrote:
> Hi Prashanth,
> 
> On Fri, Sep 15, 2023 at 07:10:25PM +0530, Prashanth K wrote:
>> On 15-09-23 06:02 pm, Heikki Krogerus wrote:
>>> On Tue, Sep 12, 2023 at 04:37:47PM +0530, Prashanth K wrote:
>>>>
>>>>
>>>> On 11-09-23 06:19 pm, Heikki Krogerus wrote:
>>>>> On Mon, Sep 11, 2023 at 02:34:15PM +0530, Prashanth K wrote:
>>>>>> Currently if ucsi_send_command() fails, then we bail out without
>>>>>> clearing EVENT_PENDING flag. So when the next connector change
>>>>>> event comes, ucsi_connector_change() won't queue the con->work,
>>>>>> because of which none of the new events will be processed.
>>>>>>
>>>>>> Fix this by clearing EVENT_PENDING flag if ucsi_send_command()
>>>>>> fails.
>>>>>>
>>>>>> Cc: <stable@vger.kernel.org> # 5.16
>>>>>> Fixes: 512df95b9432 ("usb: typec: ucsi: Better fix for missing unplug events issue")
>>>>>> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
>>>>>> ---
>>>>>>     drivers/usb/typec/ucsi/ucsi.c | 1 +
>>>>>>     1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
>>>>>> index c6dfe3d..509c67c 100644
>>>>>> --- a/drivers/usb/typec/ucsi/ucsi.c
>>>>>> +++ b/drivers/usb/typec/ucsi/ucsi.c
>>>>>> @@ -884,6 +884,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
>>>>>>     	if (ret < 0) {
>>>>>>     		dev_err(ucsi->dev, "%s: GET_CONNECTOR_STATUS failed (%d)\n",
>>>>>>     			__func__, ret);
>>>>>> +		clear_bit(EVENT_PENDING, &con->ucsi->flags);
>>>>>>     		goto out_unlock;
>>>>>>     	}
>>>>>
>>>>> I think it would be better to just move that label (out_unlock) above
>>>>> the point where clear_bit() is already called instead of separately
>>>>> calling it like that. That way the Connector Change Event will
>>>>> also get acknowledged.
>>>> Do we really need to ACK in this case since we didn't process the current
>>>> connector change event
>>>
>>> You won't get the next event before the first one was ACK'd, right?
>>>
>>
>> The spec says that we need to ACK if we received AND processed a CCI
>>
>> "4.5.4 Acknowledge Command Completion and/or Change Indication (R)
>> This command is used to acknowledge to the PPM that the OPM received and
>> processed a Command Completion and/or a Connector Change Indication."
>>
>> And here in this case, we have received, but not processed the event.
>> So I'm not really sure what to do here in this case. If we don't send an
>> ACK, then would the PPM think that OPM is not responding and reset it?
>> OR would it resend the previous event again since we didn't ACK?
> 
> Every PPM behaves differently.
> 
> Did you actually see that happening - GET_CONNECTOR_STATUS failed? Can
> you reproduce it?
> 

Yea we actually hit the issue once where GET_CONNECTOR_STATUS failed and 
subsequent events didn't get queued since EVENT_PENDING wasn't cleared. 
Its not easily reproducible (<1%) though.

[4948:kworker/0:3]UCSI: ucsi_qti_glink_write: timed out
[4948:kworker/0:3]ucsi_glink soc:qcom,pmic_glink:qcom,ucsi: 
ucsi_handle_connector_change: GET_CONNECTOR_STATUS failed (-110)

Regards,
Prashanth K
