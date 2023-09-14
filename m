Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CBF7A0DE3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 21:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240880AbjINTNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 15:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237398AbjINTNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 15:13:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBEA1FFB;
        Thu, 14 Sep 2023 12:13:49 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EIvmHV014148;
        Thu, 14 Sep 2023 19:13:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=NVv6krl4SbdZrODHbuc8MmkHsQdPdgar/ZHLqzTOwnQ=;
 b=FFFEn1OCJaridW5qy84BRfxEYATL9+nngpEJiDXyyUIr3TN0CletoJJiMnOttz+Ib4fC
 xCs4aL/gze1joj++KzkS7BOKrCinzOXuHYmxlDtTrIGUJRPmUXZ72e1LHCbUM7dSSexj
 HIrtjYPv49f9GwBd8INRfvw08+qF4fEpyMpOe9LUXc02PzHQSihMC6abwIHCKYCtE1so
 mk1SrU6SuS4AjWV/KzmxLhIpy1G+lg5E/2BCltZzRqFEqZeHzAzK+5TxNcz8J3X6GOjZ
 Abf5udqSaHcDAXZEH0GfsJ1kypvcTtJSgSiId8GtEDEIePDmhVYZ9LdNv3bCf6G+FRzU UQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3re32ktv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 19:13:31 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38EJDUEM017429
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 19:13:30 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 14 Sep 2023 12:13:29 -0700
Date:   Thu, 14 Sep 2023 12:13:28 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     John Ogness <john.ogness@linutronix.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        <linux-serial@vger.kernel.org>, Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH tty v1 41/74] serial: msm: Use port lock wrappers
Message-ID: <20230914191328.GA1487598@hu-bjorande-lv.qualcomm.com>
References: <20230914183831.587273-1-john.ogness@linutronix.de>
 <20230914183831.587273-42-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230914183831.587273-42-john.ogness@linutronix.de>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: K81qciQUJPAJoPKqEj7m5ZqHF-6DCpH6
X-Proofpoint-ORIG-GUID: K81qciQUJPAJoPKqEj7m5ZqHF-6DCpH6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 clxscore=1011 suspectscore=0
 impostorscore=0 adultscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309140166
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 08:43:58PM +0206, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> When a serial port is used for kernel console output, then all
> modifications to the UART registers which are done from other contexts,
> e.g. getty, termios, are interference points for the kernel console.
> 
> So far this has been ignored and the printk output is based on the
> principle of hope. The rework of the console infrastructure which aims to
> support threaded and atomic consoles, requires to mark sections which
> modify the UART registers as unsafe. This allows the atomic write function
> to make informed decisions and eventually to restore operational state. It
> also allows to prevent the regular UART code from modifying UART registers
> while printk output is in progress.
> 
> All modifications of UART registers are guarded by the UART port lock,
> which provides an obvious synchronization point with the console
> infrastructure.
> 
> To avoid adding this functionality to all UART drivers, wrap the
> spin_[un]lock*() invocations for uart_port::lock into helper functions
> which just contain the spin_[un]lock*() invocations for now. In a
> subsequent step these helpers will gain the console synchronization
> mechanisms.
> 
> Converted with coccinelle. No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Regards,
Bjorn
