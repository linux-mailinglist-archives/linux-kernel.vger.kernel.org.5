Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC097D2DF4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjJWJUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjJWJUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:20:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D97D97;
        Mon, 23 Oct 2023 02:20:31 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N7X2Qm012761;
        Mon, 23 Oct 2023 09:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/nL/msgWlvlfc6jVbUSC8tsOqCePVy5oKiXHjTdF3To=;
 b=i1HQeRgSWVo8pCfhBRXSV+zPRTDi4uyaBl74JiaKWc1Bqlu0XZp2n8ux3swJo2nFZ7lj
 80OrDOqLxg/wesHzB88fyV38zG1LFZY5TkfB22HY9z9l8AgnPQqSpJlsejWJXlC9WVS8
 ybTIE6LF8QJt09M1mT2yk5uMlgHoDFhRVK18wCmt0iYc6lvZVtF4Dkj+7eG0j5EK1jLz
 FhGJutuXpnHQ7DHFkks/h3KRu+XDfLlDP1YKSAxDDpONbmpNUpjJq6NcHzNpRZDqQaqW
 BYY3gblheBCIlj0e3YYMb4mUpgT6o64SBGQbi5yABqXgbkN94ASi/oQXIWvat9mpT+c4 AA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv5ndumpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 09:20:21 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39N9KKOi004084
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 09:20:20 GMT
Received: from [10.216.32.116] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 23 Oct
 2023 02:20:17 -0700
Message-ID: <5c277465-2da5-7a0b-3726-b5a88d515c92@quicinc.com>
Date:   Mon, 23 Oct 2023 14:50:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] eventfs: Fix failure path in eventfs_create_events_dir()
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
CC:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Julia Lawall <julia.lawall@inria.fr>
References: <20231019204132.6662fef0@gandalf.local.home>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20231019204132.6662fef0@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LT8x1amTZmXYepYXu3Q0hHbHjlX7v6ud
X-Proofpoint-ORIG-GUID: LT8x1amTZmXYepYXu3Q0hHbHjlX7v6ud
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_06,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=667 bulkscore=0
 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 clxscore=1011 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310230078
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/2023 6:11 AM, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The failure path of allocating ei goes to a path that dereferences ei.
> Add another label that skips over the ei dereferences to do the rest of
> the clean up.
> 
> Link: https://lore.kernel.org/all/70e7bace-561c-95f-1117-706c2c220bc@inria.fr/
> 
> Fixes: 5790b1fb3d67 ("eventfs: Remove eventfs_file and just use eventfs_inode")
> Reported-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

> ---
>   fs/tracefs/event_inode.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 9f19b6608954..1885f1f1f339 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -735,7 +735,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
>   
>   	ei = kzalloc(sizeof(*ei), GFP_KERNEL);
>   	if (!ei)
> -		goto fail;
> +		goto fail_ei;
>   
>   	inode = tracefs_get_inode(dentry->d_sb);
>   	if (unlikely(!inode))
> @@ -781,6 +781,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
>    fail:
>   	kfree(ei->d_children);
>   	kfree(ei);
> + fail_ei:
>   	tracefs_failed_creating(dentry);
>   	return ERR_PTR(-ENOMEM);
>   }
