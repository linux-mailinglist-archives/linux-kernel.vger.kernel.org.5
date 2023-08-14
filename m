Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C937677C098
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjHNTSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjHNTRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:17:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E285910F9;
        Mon, 14 Aug 2023 12:17:51 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EHRpxH020748;
        Mon, 14 Aug 2023 19:17:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=t4LAvEORAET3vXYoz3zaW3Pk7QUfM3xT7l5Xgr8SSm4=;
 b=h2c+MlHaaSEG1ME779hAUviMuN4AmAeHlgvBUeDD+BiDvA2iDF8lFBJKg8XTJVxfF9NP
 Ve3plK20lsXtdLomwQvT9u2rB5bwhpbbeUlKmOX3EnSeCGP2SxVx0bkklTIQT7v6yaAV
 /v5F6c4IABdrVonycvNFS+/w66hBpSR+yuAgAqUH4UokalVIK96X62rEDj+JX7SR+8p8
 m4izjD/LK72PUcQwXqiX1LzgudBHA8pFDRilDr7ugJ08/pNRzqgz6t70QmM+/pLzE9cY
 h0W2xhXlKdbVI75tY1loG/HpRcm6Kkz7p2yd7/T1MgK1H1uoB12S8YFDL1wYWXRO8YWx OQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3se3srvm70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 19:17:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37EJHkWA009218
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 19:17:46 GMT
Received: from [10.50.35.106] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 14 Aug
 2023 12:17:42 -0700
Message-ID: <0d77682a-74ff-cdf6-bd96-dbe10f2b5e71@quicinc.com>
Date:   Tue, 15 Aug 2023 00:47:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 14/33] iris: vidc: add helpers for state management
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <mchehab@kernel.org>,
        <hans.verkuil@cisco.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-15-git-send-email-quic_vgarodia@quicinc.com>
 <60271d41-7807-0808-34d0-684ab9e81a90@linaro.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <60271d41-7807-0808-34d0-684ab9e81a90@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 09EwDmlMcVX5Pv0v6Mh8RxaUlRT1dOdh
X-Proofpoint-ORIG-GUID: 09EwDmlMcVX5Pv0v6Mh8RxaUlRT1dOdh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_16,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0
 mlxlogscore=732 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140179
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/2023 11:22 PM, Konrad Dybcio wrote:
> On 28.07.2023 15:23, Vikash Garodia wrote:
>> This implements the functions to handle different core
>> and instance state transitions.
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>> ---
> [...]
> 
>> +enum msm_vidc_core_sub_state {
>> +	CORE_SUBSTATE_NONE                   = 0x0,
>> +	CORE_SUBSTATE_POWER_ENABLE           = BIT(0),
>> +	CORE_SUBSTATE_GDSC_HANDOFF           = BIT(1),
>> +	CORE_SUBSTATE_PM_SUSPEND             = BIT(2),
>> +	CORE_SUBSTATE_FW_PWR_CTRL            = BIT(3),
>> +	CORE_SUBSTATE_PAGE_FAULT             = BIT(4),
>> +	CORE_SUBSTATE_CPU_WATCHDOG           = BIT(5),
>> +	CORE_SUBSTATE_VIDEO_UNRESPONSIVE     = BIT(6),
>> +	CORE_SUBSTATE_MAX                    = BIT(7),
> Why store it in an enum if they're not consecutive? You can make them
> preprocessor #defines.
> 
I understand that these are not consecutive but a enum for these makes them
under one roof which is easy to read and maintain, we will loose this if
replaced with macro.
>> +};
>> +
>> +enum msm_vidc_core_event_type {
>> +	CORE_EVENT_NONE                      = BIT(0),
>> +	CORE_EVENT_UPDATE_SUB_STATE          = BIT(1),
>> +};
> Ditto (even though techinically they're consecutive)
> 
>> +
>> +enum msm_vidc_state {
>> +	MSM_VIDC_OPEN,
>> +	MSM_VIDC_INPUT_STREAMING,
>> +	MSM_VIDC_OUTPUT_STREAMING,
>> +	MSM_VIDC_STREAMING,
>> +	MSM_VIDC_CLOSE,
>> +	MSM_VIDC_ERROR,
>> +};
>> +
>> +#define MSM_VIDC_SUB_STATE_NONE          0
>> +#define MSM_VIDC_MAX_SUB_STATES          6
>> +/*
>> + * max value of inst->sub_state if all
>> + * the 6 valid bits are set i.e 111111==>63
>> + */
>> +#define MSM_VIDC_MAX_SUB_STATE_VALUE     ((1 << MSM_VIDC_MAX_SUB_STATES) - 1)
>> +
>> +enum msm_vidc_sub_state {
>> +	MSM_VIDC_DRAIN                     = BIT(0),
>> +	MSM_VIDC_DRC                       = BIT(1),
>> +	MSM_VIDC_DRAIN_LAST_BUFFER         = BIT(2),
>> +	MSM_VIDC_DRC_LAST_BUFFER           = BIT(3),
>> +	MSM_VIDC_INPUT_PAUSE               = BIT(4),
>> +	MSM_VIDC_OUTPUT_PAUSE              = BIT(5),
> Ditto
> 
these are bit wise and are being used in state machine. At a time, two or
more bits can be set to define the state of and instance, hence needed.

> [...]
> 
>> +static int msm_vidc_core_init_wait_state(struct msm_vidc_core *core,
>> +					 enum msm_vidc_core_event_type type,
>> +					 struct msm_vidc_event_data *data)
>> +{
>> +	int rc = 0;
> rc seems never assigned again, good to drop
> 
> [...]
> 
Sure, will remove in next version
>> +
>> +static int msm_vidc_core_init_state(struct msm_vidc_core *core,
>> +				    enum msm_vidc_core_event_type type,
>> +				    struct msm_vidc_event_data *data)
>> +{
>> +	int rc = 0;
> Ditto
> 
> [...]
> 
>> +static int msm_vidc_core_error_state(struct msm_vidc_core *core,
>> +				     enum msm_vidc_core_event_type type,
>> +				     struct msm_vidc_event_data *data)
>> +{
>> +	int rc = 0;
> Ditto
> 
> [...]
> 
>> +int msm_vidc_update_core_state(struct msm_vidc_core *core,
>> +			       enum msm_vidc_core_state request_state, const char *func)
>> +{
>> +	struct msm_vidc_core_state_handle *state_handle = NULL;
>> +	int rc = 0;
> Ditto
> 
> [...]
> 
>> +int msm_vidc_change_core_state(struct msm_vidc_core *core,
>> +			       enum msm_vidc_core_state request_state, const char *func)
>> +{
>> +	enum msm_vidc_allow allow;
>> +	int rc = 0;
> Ditto
> 
will remove all such instances of unused rc in next version
> [...]
> 
>> +bool is_state(struct msm_vidc_inst *inst, enum msm_vidc_state state)
>> +{
>> +	return inst->state == state;
>> +}
>> +
>> +bool is_sub_state(struct msm_vidc_inst *inst, enum msm_vidc_sub_state sub_state)
>> +{
>> +	return (inst->sub_state & sub_state);
>> +}
> Why are there 2 separate funcs for core and inst? Don't we have
> a pointer within one to the other?
> 
> 
core and instance sub states are maintained differently for ex in SSR, we
need to check the core sub state, if we combine instance and core state
checks, we won't know against which sub state we should check.
> [...]
> 

>> +
>> +int msm_vidc_update_state(struct msm_vidc_inst *inst,
>> +			  enum msm_vidc_state request_state, const char *func)
>> +{
>> +	struct msm_vidc_state_handle *state_handle = NULL;
>> +	int rc = 0;
> rc is unused
> 
> [...]
> 
>> +static int msm_vidc_set_sub_state(struct msm_vidc_inst *inst,
>> +				  enum msm_vidc_sub_state sub_state, const char *func)
>> +{
>> +	char sub_state_name[MAX_NAME_LENGTH];
>> +	int cnt, rc = 0;
> ditto
> 
Thanks for pointing these out, will remove all unused rc.

Thanks,
Dikshita
> Konrad
