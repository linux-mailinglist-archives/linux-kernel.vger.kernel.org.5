Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CBD7D2F7D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 12:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjJWKJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 06:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjJWKJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 06:09:04 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FC1F7;
        Mon, 23 Oct 2023 03:09:01 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N7qjV7000816;
        Mon, 23 Oct 2023 10:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BLdOF2MNcWnOdGsdKCRiPVsu2ONU9CpChtK8Cj13Kyk=;
 b=PIjw8wL2LFZ7/SbuuwsqYNH2brQcBS1j9QVD9QwHy9ZH+gfTboGWixa5FI7rBLktyou6
 3RTbYbrnFbxnRYkp9WiXa4J53vF/O0QCLzyCdDdQxivZxOA7GNFu/7gEbwJZhOSEJVpF
 avEVbZ/WRtl2p7RvHZRbZZFVQrzMCd3QfNs0AcbTkFKz4X1nYgPMrMRV0G96WuwbWgYV
 xNyXIF26yHKytuvQoquXHUrMhGB9g78i5Ag0+LzpJKhL4HormRXdmWZ2F1pCSWhXYjd1
 bojSwlcirWZzguotI5buFoWJu8SMTtAinxHdsByGJzvniSCGU4axgGOAHklYHU6kIwqM Rw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv6873pnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 10:08:57 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39NA8urh006366
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 10:08:56 GMT
Received: from [10.216.32.116] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 23 Oct
 2023 03:08:53 -0700
Message-ID: <0ed6de5e-5b47-30cb-68fa-ce6ee7c839a8@quicinc.com>
Date:   Mon, 23 Oct 2023 15:38:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tracing/histograms: Simplify last_cmd_set()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
References: <30b6fb04dadc10a03cc1ad08f5d8a93ef623a167.1697899346.git.christophe.jaillet@wanadoo.fr>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <30b6fb04dadc10a03cc1ad08f5d8a93ef623a167.1697899346.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UHy1YigTnHOKlS2qWr2zbYMPfhnsbHda
X-Proofpoint-ORIG-GUID: UHy1YigTnHOKlS2qWr2zbYMPfhnsbHda
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_08,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 spamscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230087
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/21/2023 8:12 PM, Christophe JAILLET wrote:
> Turn a kzalloc()+strcpy()+strncat() into an equivalent and less verbose
> kasprintf().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   kernel/trace/trace_events_hist.c | 11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index d06938ae0717..1abc07fba1b9 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -774,23 +774,16 @@ static void last_cmd_set(struct trace_event_file *file, char *str)
>   {
>   	const char *system = NULL, *name = NULL;
>   	struct trace_event_call *call;
> -	int len;
>   
>   	if (!str)
>   		return;
>   
> -	/* sizeof() contains the nul byte */
> -	len = sizeof(HIST_PREFIX) + strlen(str);
>   	kfree(last_cmd);
> -	last_cmd = kzalloc(len, GFP_KERNEL);
> +
> +	last_cmd = kasprintf(GFP_KERNEL, HIST_PREFIX "%s", str);
>   	if (!last_cmd)
>   		return;
>   
> -	strcpy(last_cmd, HIST_PREFIX);
> -	/* Again, sizeof() contains the nul byte */
> -	len -= sizeof(HIST_PREFIX);
> -	strncat(last_cmd, str, len);

LGTM, careful optimization., Thanks.
Reviewed-by: Mukesh ojha <quic_mojha@quicinc.com>


-Mukesh

> -
>   	if (file) {
>   		call = file->event_call;
>   		system = call->class->system;
