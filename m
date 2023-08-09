Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C7F776080
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjHINT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjHINTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:19:55 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CDDC1;
        Wed,  9 Aug 2023 06:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=cUN4q2uPSv0EtcrftAHSjxqJl2d7BThgJJTgUIhHnGM=; b=FRHwR2dDgMYMp4QSyuHGRGO53L
        TIDNnF6dsbVK9lq4Y2kvzcvGjx59dlPgY6RNia1aRRGL2JRjpqnE1IrCeDFHf0y5kC36v8A9qm5lk
        sYYSeM1nzW8Kpv0gweqiIiA7GnmwNh+4DW+tEq6MkvVbiPt6+jMFAR8vNChu5ytwiLyw=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:40840 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qTj6N-0001ba-Qa; Wed, 09 Aug 2023 09:19:52 -0400
Date:   Wed, 9 Aug 2023 09:19:51 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@kernel.org,
        konrad.dybcio@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, bartosz.golaszewski@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_msavaliy@quicinc.com,
        dianders@chromium.org, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com
Message-Id: <20230809091951.fbcc682d00deacd4d7b55b44@hugovil.com>
In-Reply-To: <1691583100-15689-1-git-send-email-quic_vnivarth@quicinc.com>
References: <1691583100-15689-1-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH RESEND] tty: serial: qcom-geni-serial: Poll primary
 sequencer irq status after cancel_tx
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Aug 2023 17:41:40 +0530
Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com> wrote:

> TX is handled by primary sequencer. After cancelling primary command, poll
> primary sequencer's irq status instead of that of secondary.

Hi,
it is not clear to me if this is a bug fix or an improvement?

> While at it, also remove a couple of redundant lines that read from IRQ_EN
> register and write back same.

This should go into a separate patch.

Hugo Villeneuve.


> Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for serial engine DMA")
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 3ca5db2..b8aa4c1 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -591,7 +591,6 @@ static void qcom_geni_serial_stop_tx_dma(struct uart_port *uport)
>  {
>  	struct qcom_geni_serial_port *port = to_dev_port(uport);
>  	bool done;
> -	u32 m_irq_en;
>  
>  	if (!qcom_geni_serial_main_active(uport))
>  		return;
> @@ -603,12 +602,10 @@ static void qcom_geni_serial_stop_tx_dma(struct uart_port *uport)
>  		port->tx_remaining = 0;
>  	}
>  
> -	m_irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
> -	writel(m_irq_en, uport->membase + SE_GENI_M_IRQ_EN);
>  	geni_se_cancel_m_cmd(&port->se);
>  
> -	done = qcom_geni_serial_poll_bit(uport, SE_GENI_S_IRQ_STATUS,
> -					 S_CMD_CANCEL_EN, true);
> +	done = qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
> +					 M_CMD_CANCEL_EN, true);
>  	if (!done) {
>  		geni_se_abort_m_cmd(&port->se);
>  		done = qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
> -- 
> 2.7.4
> 
