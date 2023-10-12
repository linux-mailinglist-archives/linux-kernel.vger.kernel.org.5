Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9BF7C76AD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442140AbjJLTZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442009AbjJLTZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:25:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9BBC0;
        Thu, 12 Oct 2023 12:25:36 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CHmqBa022129;
        Thu, 12 Oct 2023 19:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=U6CHnxhmbie1MniY9mLh7MjnBVn+zWwHS+KdgGitcEQ=;
 b=Lj7LFbae0VIKQW6cUfKxX9i7J40fAko4uGYwlQpiRxgf+k8seBqhW0M96rqsShc+9ZQq
 z1ObH7W9TOP1Cho2vIjxT6PNDVCwJoH3jh1uOHPFEKSxC9wmAbmnWNN3bnMlxuPzzN2L
 rGcR7afqjoHbl9rkqqjcHv+4bRhZJq+J5F5vBlDVQ68vrgkLbkyG6iW0Xq8aaDQzEFSz
 rRqL5rOrVgi8ZKwpProfvKVxyBm4KESTbfxRaG0YkhLda7Ru02loaCaN7dwVtb8Mnw70
 G3p2dYnt1wiGf9ov1EvWNjRuTdr0u56jldvbi/7RcdbHe/AER4lSpXDuEsmXvTfizchF Vw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tp9dp1tu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 19:25:32 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39CJPVkW008144
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 19:25:31 GMT
Received: from [10.71.115.198] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 12 Oct
 2023 12:25:30 -0700
Message-ID: <1e8d6d63-f5e5-3e69-ae8e-cf3cd1b90ad8@quicinc.com>
Date:   Thu, 12 Oct 2023 12:25:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC] usb: dwc3: core: Fix RAM interface getting stuck during
 enumeration
Content-Language: en-US
To:     Krishna Kurapati <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        <quic_ugoswami@quicinc.com>
References: <20231011100214.25720-1-quic_kriskura@quicinc.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <20231011100214.25720-1-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: J3G5IDxh8OqOn7biv9BCRHRxsyb8-VQh
X-Proofpoint-GUID: J3G5IDxh8OqOn7biv9BCRHRxsyb8-VQh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_11,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0 bulkscore=0
 mlxscore=0 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120161
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krishna,

On 10/11/2023 3:02 AM, Krishna Kurapati wrote:
> This implementation is to fix RAM interface getting stuck during
> enumeration and controller not responding to any command.
> 
> During plug-out test cases, it is sometimes seen that no events
> are generated by the controller and all CSR register reads give "0"
> and CSR_Timeout bit gets set indicating that CSR reads/writes are
> timing out or timed out.
> 
> The issue comes up on different instnaces of enumeration on different
> platforms. On one platform, the debug log is as follows:
> 
> Prepared a TRB on ep0out and did start transfer to get set
> address request from host:
> 
> <...>-7191    [000] D..1.    66.421006: dwc3_gadget_ep_cmd: ep0out:
> cmd 'Start Transfer' [406] params 00000000 efffa000 00000000 -->
> status: Successful
> 
> <...>-7191    [000] D..1.    66.421196: dwc3_event: event (0000c040):
> ep0out: Transfer Complete (sIL) [Setup Phase]
> 
> <...>-7191    [000] D..1.    66.421197: dwc3_ctrl_req: Set
> Address(Addr = 01)
> 
> Then XFER NRDY received on ep0in for zero length status phase and
> a Start Transfer was done on ep0in with 0-length packet in 2 Stage
> status phase:
> 
> <...>-7191    [000] D..1.    66.421249: dwc3_event: event (000020c2):
> ep0in: Transfer Not Ready [00000000] (Not Active) [Status Phase]
> 
> <...>-7191    [000] D..1.    66.421266: dwc3_prepare_trb: ep0in: trb
> ffffffc00fcfd000 (E0:D0) buf 00000000efffa000 size 0 ctrl 00000c33
> sofn 00000000 (HLcs:SC:status2)
> 
> <...>-7191    [000] D..1.    66.421387: dwc3_gadget_ep_cmd: ep0in: cmd
> 'Start Transfer' [406] params 00000000 efffa000 00000000 -->status:
> Successful
> 
> Then a bus reset was received directly after 500 msec. Software never
> got the cmd complete for the start transfer done in status phase. Here
> the RAM interface is stuck. So host issues a bus reset as link is
> idle for 500 msec:
> 
> <...>-7191    [000] D..1.    66.935603: dwc3_event: event (00000101):
> Reset [U0]
> 
> Then software sees that it is in status phase and we issue an ENDXFER
> on ep0in and it gets timedout waiting for the CMDACT to go '0':
> 
> <...>-7191    [000] D..1.    66.958249: dwc3_gadget_ep_cmd: ep0in: cmd
> 'End Transfer' [10508] params 00000000 00000000 00000000 --> status:
> Timed Out
> 
> Upon debug with Synopsys, it turns out that the root cause is as
> follows:
> 
> During any transfer, if the data is not successfully transmitted,
> then a Done (with failure) handshake is returned, so that the BMU
> can re-attempt the same data again by rewinding its data pointers.
> 
> But, if the USB IN is a 0-length payload (which is what is happening
> in this case - 2 stage status phase of set_address), then there is no
> need to rewind the pointers and the Done (with failure) handshake is
> not returned for failure case. This keeps the Request-Done interface
> busy till the next Done handshake. The MAC sends the 0-length payload
> again when the host requests. If the transmission is successful this
> time, the Done (with success) handshake is provided back. Otherwise,
> it repeats the same steps again.
> 
> If the cable is disconnected or if the Host aborts the transfer on 3
> consecutive failed attempts, the Request-Done handshake is not
> complete. This keeps the interface busy.
> 
> The subsequent RAM access cannot proceed until the above pending
> transfer is complete. This results in failure of any access to RAM
> address locations. Many of the EndPoint commands need to access the
> RAM and they would fail to complete successfully.
> 
> Furthermore when cable removal happens, this would not generate a
> disconnect event and the "connected" flag remains true always blockin
> suspend.
> 
> Synopsys confirmed that the issue is present on all USB3 devices and
> as a workaround, suggested to re-initialize device mode.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>   drivers/usb/dwc3/core.c   | 20 ++++++++++++++++++++
>   drivers/usb/dwc3/core.h   |  4 ++++
>   drivers/usb/dwc3/drd.c    |  5 +++++
>   drivers/usb/dwc3/gadget.c |  6 ++++--
>   4 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 44ee8526dc28..d18b81cccdc5 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -122,6 +122,7 @@ static void __dwc3_set_mode(struct work_struct *work)
>   	unsigned long flags;
>   	int ret;
>   	u32 reg;
> +	u8 timeout = 100;
>   	u32 desired_dr_role;
>   
>   	mutex_lock(&dwc->mutex);
> @@ -137,6 +138,25 @@ static void __dwc3_set_mode(struct work_struct *work)
>   	if (!desired_dr_role)
>   		goto out;
>   
> +	/*
> +	 * STAR 5001544 - If cable disconnect doesn't generate
> +	 * disconnect event in device mode, then re-initialize the
> +	 * controller.
> +	 */
> +	if ((dwc->cable_disconnected == true) &&
> +		(dwc->current_dr_role == DWC3_GCTL_PRTCAP_DEVICE)) {
> +		while (dwc->connected == true && timeout != 0) {
> +			mdelay(10);
> +			timeout--;
> +		}
> +
> +		if (timeout == 0) {
> +			dwc3_gadget_soft_disconnect(dwc);
> +			udelay(100);
> +			dwc3_gadget_soft_connect(dwc);
> +		}
> +	}
> +
>   	if (desired_dr_role == dwc->current_dr_role)
>   		goto out;
>   
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index c6c87acbd376..7642330cf608 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -1355,6 +1355,7 @@ struct dwc3 {
>   	int			last_fifo_depth;
>   	int			num_ep_resized;
>   	struct dentry		*debug_root;
> +	bool			cable_disconnected;
>   };
>   
>   #define INCRX_BURST_MODE 0
> @@ -1568,6 +1569,9 @@ void dwc3_event_buffers_cleanup(struct dwc3 *dwc);
>   
>   int dwc3_core_soft_reset(struct dwc3 *dwc);
>   
> +int dwc3_gadget_soft_disconnect(struct dwc3 *dwc);
> +int dwc3_gadget_soft_connect(struct dwc3 *dwc);
> +
>   #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
>   int dwc3_host_init(struct dwc3 *dwc);
>   void dwc3_host_exit(struct dwc3 *dwc);
> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
> index 039bf241769a..593c023fc39a 100644
> --- a/drivers/usb/dwc3/drd.c
> +++ b/drivers/usb/dwc3/drd.c
> @@ -446,6 +446,8 @@ static int dwc3_usb_role_switch_set(struct usb_role_switch *sw,
>   	struct dwc3 *dwc = usb_role_switch_get_drvdata(sw);
>   	u32 mode;
>   
> +	dwc->cable_disconnected = false;
> +
>   	switch (role) {
>   	case USB_ROLE_HOST:
>   		mode = DWC3_GCTL_PRTCAP_HOST;
> @@ -454,6 +456,9 @@ static int dwc3_usb_role_switch_set(struct usb_role_switch *sw,
>   		mode = DWC3_GCTL_PRTCAP_DEVICE;
>   		break;
>   	default:
> +		if (role == USB_ROLE_NONE)
> +			dwc->cable_disconnected = true;
> +

How do we handle cases where role switch isn't used? (ie extcon or maybe 
no cable connection notification at all)

Thanks
Wesley Cheng
