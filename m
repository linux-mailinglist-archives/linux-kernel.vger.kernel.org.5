Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1E57A0DFC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 21:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241804AbjINTRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 15:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240636AbjINTRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 15:17:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B4D1FFA;
        Thu, 14 Sep 2023 12:17:17 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EI1kOr014778;
        Thu, 14 Sep 2023 19:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=xnl2VfNwTErVfgz6gCLlzUTBCpYIqCi5Mv5VqUzO5wA=;
 b=i8izwu14bJjAPzJJOaTrB+hTSVlrEBUgtnm49peZm2B4BaSda1+2mX/pnrDxiJsDkQlB
 vD3SjVIY5AMuMtzTJPw6xUviDDtegBHBW0SDH87MLoj5xUdmtREEuJGuX+2rkb1irFQc
 IakMAT24yMskz66Kcqohvq2AznsopE+YPmUIjbbjCFAeanKew6+qkVU+a6TxnADlo9mN
 sm6HKUaJKNZp3r59XeWQNM9DEkJC6i0EIGTWot/2lTDZ6QdSFif30OKdtN2I+2kSSS5t
 BUFzOJFJKMWNDom9SFHImhcugAJuXJuWCAniDbCon2DTmL6CLx2lLrs/IgrdR79HL2tz TA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3qqaau1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 19:16:55 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38EJGseH009679
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 19:16:54 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 14 Sep 2023 12:16:53 -0700
Date:   Thu, 14 Sep 2023 12:16:52 -0700
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
Subject: Re: [PATCH tty v1 49/74] serial: qcom-geni: Use port lock wrappers
Message-ID: <20230914191652.GB1487598@hu-bjorande-lv.qualcomm.com>
References: <20230914183831.587273-1-john.ogness@linutronix.de>
 <20230914183831.587273-50-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230914183831.587273-50-john.ogness@linutronix.de>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: V4CzjHi2qkUHi8jCFoqa9fxwl2VGA7Zb
X-Proofpoint-GUID: V4CzjHi2qkUHi8jCFoqa9fxwl2VGA7Zb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_11,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 phishscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140168
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 08:44:06PM +0206, John Ogness wrote:
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

> ---
>  drivers/tty/serial/qcom_geni_serial.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index b8aa4c1293ba..7e78f97e8f43 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -482,9 +482,9 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
>  
>  	uport = &port->uport;
>  	if (oops_in_progress)
> -		locked = spin_trylock_irqsave(&uport->lock, flags);
> +		locked = uart_port_trylock_irqsave(uport, &flags);
>  	else
> -		spin_lock_irqsave(&uport->lock, flags);
> +		uart_port_lock_irqsave(uport, &flags);
>  
>  	geni_status = readl(uport->membase + SE_GENI_STATUS);
>  
> @@ -520,7 +520,7 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
>  		qcom_geni_serial_setup_tx(uport, port->tx_remaining);
>  
>  	if (locked)
> -		spin_unlock_irqrestore(&uport->lock, flags);
> +		uart_port_unlock_irqrestore(uport, flags);
>  }
>  
>  static void handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
> @@ -970,7 +970,7 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
>  	if (uport->suspended)
>  		return IRQ_NONE;
>  
> -	spin_lock(&uport->lock);
> +	uart_port_lock(uport);
>  

Nice, now this no longer look unbalanced with the unlock in
uart_port_unlock_irqrestore().

Regards,
Bjorn

>  	m_irq_status = readl(uport->membase + SE_GENI_M_IRQ_STATUS);
>  	s_irq_status = readl(uport->membase + SE_GENI_S_IRQ_STATUS);
> -- 
> 2.39.2
> 
