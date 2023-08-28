Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092EE78B6A1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbjH1RhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjH1Rgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:36:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F178412A;
        Mon, 28 Aug 2023 10:36:32 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SETOqP006229;
        Mon, 28 Aug 2023 17:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Z3ILWNbS/AWDogs2zlrJzoPxQpLy3yybXmUEi7UduNQ=;
 b=EyyDwXbxF6oWOpRBaaiw2AasvFKkUKE2VmJmW4V8N6G9TIxaNl16PUxcOhLTDroCKDF8
 oVZvZVBw+OgLcPFU/grq8fnHS5RfpK05BdDQUzefRUTIv9cOroBNM/z08bffyX6xvVN+
 euLTmv0lds4573CVI/CrXgqbX1Ez8KjerlXoEbvC0+W+747vFsersaS6NitlQz9aLb6l
 Z0E9Bcyj5gPz16UBckCyJeB6Be9dvhjJSOr0s5XfMlfqoeTC/4CIg+LqtkAyy5JD4aQZ
 N4dXqiln1sK1DTCYzu56w2k+6jHlLj/K21EnRWaSd/bwxiTbX07jXDTriD9AEuNqYVAn /A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3srt8s0vvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 17:36:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37SHaI94008576
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 17:36:18 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 28 Aug
 2023 10:36:15 -0700
Message-ID: <2886b5c3-2d88-b920-d078-7beae20e8567@quicinc.com>
Date:   Mon, 28 Aug 2023 11:36:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] freezer,sched: Use saved_state to reduce some spurious
 wakeups
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>
CC:     Thomas Gleixner <tglx@linutronix.de>, <kernel@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Prakash Viswalingam <quic_prakashv@quicinc.com>
References: <20230828-avoid-spurious-freezer-wakeups-v1-1-8be8cf761472@quicinc.com>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20230828-avoid-spurious-freezer-wakeups-v1-1-8be8cf761472@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0rUY4r3kGhPZtK-ietWAJGgfgUCab_tI
X-Proofpoint-GUID: 0rUY4r3kGhPZtK-ietWAJGgfgUCab_tI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_15,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=805 adultscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280154
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/2023 11:33 AM, Elliot Berman wrote:
> After commit f5d39b020809 ("freezer,sched: Rewrite core freezer logic"),
> tasks that are in TASK_FREEZABLE state and end up getting frozen are
> always woken up. Prior to that commit, tasks could ask freezer to
> consider them "frozen enough" via freezer_do_not_conut(). As described

freezer_do_not_count()
