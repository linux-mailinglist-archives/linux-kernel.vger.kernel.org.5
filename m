Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6710B7B8CDF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245508AbjJDTLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245382AbjJDTLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:11:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091AC1FFA;
        Wed,  4 Oct 2023 12:10:09 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394IaBL3008139;
        Wed, 4 Oct 2023 19:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=I56p0VYzN7IWNopjI2fcWoO2idpM2RTO92wRBOIXaDA=;
 b=h3AqwleRCwZligPx/m+vZr3DUi+ahENv46k6jE2Oz++ffrv09aassLpPnbjbBzq3xkGF
 6oDJ2fCADotzQOd1gVwAeoaARE50clK822yS0JiAu14TOvJlYqsBNUNClcEHWXdoI2pL
 MwzlR11gFLS4cYNSBqUNjifDURdJ5+WXx8LIQ3s88wSvCxKArSiaSan0ya198+tZfO7Z
 BOHv4Wq7vBcVBGPvz2shhtfigz/N4OCnE4DLY6ePLIBDfkBexNwF6aN6ugHjJow2WdFY
 w/rRsBh6Ljn0h0yZsJaf7YfRQaqMNxeTDnbR2OngrKyS/Zmquh7oDGUBg3O/dpYmyQ9M sg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3th8ck114y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 19:09:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 394J9590012308
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Oct 2023 19:09:05 GMT
Received: from [10.111.179.185] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 4 Oct
 2023 12:09:04 -0700
Message-ID: <f08778aa-0e50-40aa-a1be-9cc894b2e219@quicinc.com>
Date:   Wed, 4 Oct 2023 12:09:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] tee: amdtee: use page_alloc_exact() for memory
 allocations
Content-Language: en-US
To:     Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        SivaSangeetha SK <SivaSangeetha.SK@amd.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Yuntao Wang <ytcoode@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <op-tee@lists.trustedfirmware.org>
CC:     Mythri PK <Mythri.Pandeshwarakrishna@amd.com>,
        Nimesh Easow <Nimesh.Easow@amd.com>
References: <fe6fd7781d77ea32064e5b861f33150b28768278.1693340098.git.Devaraj.Rangasamy@amd.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <fe6fd7781d77ea32064e5b861f33150b28768278.1693340098.git.Devaraj.Rangasamy@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RCdCaBI3qUQfLKdPrsNEANnaxeQopRjk
X-Proofpoint-ORIG-GUID: RCdCaBI3qUQfLKdPrsNEANnaxeQopRjk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_10,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 mlxscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=690 adultscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310040140
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/2023 1:19 PM, Devaraj Rangasamy wrote:> Use page_alloc_exact() 
to get buffers, instead of
> get_free_pages(), so as to avoid wastage of memory.
> Currently get_free_pages() is allocating at next order,
> while page_alloc_exact() will free the unused pages.

s/page_alloc_exact()/alloc_pages_exact()/ everywhere including subject 
to match the actual code change?

