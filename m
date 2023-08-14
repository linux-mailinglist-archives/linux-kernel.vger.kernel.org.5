Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E075477BF35
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 19:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbjHNRpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 13:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjHNRpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:45:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B3D10D0;
        Mon, 14 Aug 2023 10:45:21 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EEVu66014918;
        Mon, 14 Aug 2023 17:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Hftj3CSCQzqu2/zmdE3hTLfkYdcZT2h+JdbLoFd4VsM=;
 b=VcnC9dI/VS1AobdBTCrRB1KkWB4hyJIY/UkJTnP5sBYdpQbV8jQLEAaCaZ8jw2JvEOoQ
 G2I0Dp0Iaqwbl/4leX5GQDeGdH1Y1S2AxwFsYoHrm4jhLQyYOi1Ptjn+Y3CxWn2XPLRc
 Hsf72HAybfGS1HoK7ZqRzMsTUpQSWsVQkcvC0kJlZjXywBfx3iXMz1rYyk0WTjTEZrnI
 kVUI7uo8EZpkNZbywbu6ODssxDdRoc8wGNYaSro/Cj/ODtI93tBywjW7buHJNJkljY5T
 8tvUSSKKZmn6q9cbofPISlnGP8gVk5JxZVXq3e9mdfa6FszCQiP0gNSxlZUguVe4hCzd jg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3se3mt4eep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 17:45:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37EHj5Wf032706
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 17:45:05 GMT
Received: from [10.216.41.62] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 14 Aug
 2023 10:44:53 -0700
Message-ID: <c88fa667-c746-e9da-1ae0-e469607e366d@quicinc.com>
Date:   Mon, 14 Aug 2023 23:14:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RESEND] tty: serial: qcom-geni-serial: Poll primary
 sequencer irq status after cancel_tx
Content-Language: en-CA
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Hugo Villeneuve <hugo@hugovil.com>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <bartosz.golaszewski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_msavaliy@quicinc.com>,
        <dianders@chromium.org>, <mka@chromium.org>, <swboyd@chromium.org>,
        <quic_vtanuku@quicinc.com>
References: <1691583100-15689-1-git-send-email-quic_vnivarth@quicinc.com>
 <20230809091951.fbcc682d00deacd4d7b55b44@hugovil.com>
 <9be10770-d3df-467e-0541-8839bcd22fee@quicinc.com>
 <7mdlnuxzm7rxstl2r3kyyiuefbj3wpyqprzufdrsxe7hy5fvfo@tdwfhi6a27hj>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <7mdlnuxzm7rxstl2r3kyyiuefbj3wpyqprzufdrsxe7hy5fvfo@tdwfhi6a27hj>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2lHETf-nAv2jDYxex97pLDaNnWsgh8z5
X-Proofpoint-ORIG-GUID: 2lHETf-nAv2jDYxex97pLDaNnWsgh8z5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_14,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308140163
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much, Hugo Villeneuve and Bjorn, for the review and time.

If this one doesn't get merged, I will post another patch series incorporating suggestions (including splitting) along with few more changes.

-Vijay/



On 8/10/2023 8:06 PM, Bjorn Andersson wrote:
> On Wed, Aug 09, 2023 at 10:51:54PM +0530, Vijaya Krishna Nivarthi wrote:
>> Hi,
>>
>> Thank you very much for the review...
>>
> Thank you for the bug fix, Vijaya.
>
>> On 8/9/2023 6:49 PM, Hugo Villeneuve wrote:
>>> On Wed,  9 Aug 2023 17:41:40 +0530
>>> Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com> wrote:
>>>
>>>> TX is handled by primary sequencer. After cancelling primary command, poll
>>>> primary sequencer's irq status instead of that of secondary.
>>> Hi,
>>> it is not clear to me if this is a bug fix or an improvement?
>> This is a bug fix.
> Please describe the actual problem you're solving, to allow others
> working in and around this driver to know what issue(s) are corrected.
>
> This will save others debugging time, and it will teach others to help
> you maintain this driver.
>
> The section in the documentation on how to describe your changes is
> good, please read it:
> https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
>
>>>> While at it, also remove a couple of redundant lines that read from IRQ_EN
>>>> register and write back same.
>>> This should go into a separate patch.
>> The changes were too close by so I wasn't sure it could be split into 2
>> patches.
>>
>> I see that the earlier patch has already been signed off by Greg. (I did a
>> RESEND after realising that I had Bjorn Andersson's email address incorrect)
> Please use ./scripts/get_maintainer.pl on the upstream tree, as this
> uses up to date information about recipients.
>
>> Will post another version if original patch doesn't get merged for any
>> reason.
>>
> Please double check linux-next [1], if it's unclear if Greg picked up
> your previous patch (he's usually quite explicit about it...). I really
> would like some more details on the bug fix...
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
>
> Regards,
> Bjorn
