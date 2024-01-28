Return-Path: <linux-kernel+bounces-41519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E991E83F39B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 04:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 616CE1F226C9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 03:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FDB3C38;
	Sun, 28 Jan 2024 03:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQHCaSd2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7E08BF2;
	Sun, 28 Jan 2024 03:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706411443; cv=none; b=YaysLGG1AmsH8Fs5VhrirDJld+bBtIbFY3MpwbDu/RdBV2S3fXs61RhZa4g24VCvc83TKS07qRZMdZB5/w2/oeuwi4kxai59ux0npqwqGxERoPXnB3IHaaDWSGSGl1zP/aR4rDb4EWUoA0e49hipCNc4tmnwMK1y80xmRoc1ZMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706411443; c=relaxed/simple;
	bh=HFfRd6LkLwTX+vbnKYAsPwyhG28/axA6Cw7j+acEa8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W43jyuu5HTLfKCoGKiL/YvcwizqNa0OFoAFb9Rf4m7WpW/po4erHPwRT9vrEC8E2qMFsjDa/6SbL5tL1e/XF2A47IfiKG2nEwauXj7A8q7n8FaP7iBVoLRveL/gMZHjxOEyrJj2h4RXpbUF9CrVJ201A2Tst+lk2udFjNEtsT3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQHCaSd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B73BC433C7;
	Sun, 28 Jan 2024 03:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706411442;
	bh=HFfRd6LkLwTX+vbnKYAsPwyhG28/axA6Cw7j+acEa8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AQHCaSd2OrA3oeY7JeiunXrGswY2e6O5yf2KQD3lmFpiwc7pL+ZoDP1p/Veb/GVpU
	 ahhM2lhfydPri04fnrdUy/hwuRGeNKBoZ5uxBVPa0XnN1OpgqGHd8bIV2LVNSx33bk
	 Bp6wi+BdVULytUnQz2r+mh2aGR/4wrXBzWX+8Gg0qrKn3HplxaYlhJnY4XLPj4+ZPi
	 P4tnYnmISLNecpaMhhncKnH1DlZpZRkziVgUPmyOC+SHcywsp/nTxffuld3RVHWstK
	 1JdWzgM2trvU30orhDTZbHkfi5jX5p3pVYZM9tK/i7P8LmbxST9aFgNzBNcXaYpjlA
	 XbjtP6NXPG6BA==
Date: Sat, 27 Jan 2024 21:10:40 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, 
	Stephen Boyd <swboyd@chromium.org>, linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: qcom-geni: Don't cancel/abort if we can't
 get the port lock
Message-ID: <fr73heymmg3rar25adkkcwybewjaridbeyhjrgi5a7xtue3c3n@i5h7i2y7hmph>
References: <20240112150307.1.I7dc0993c1e758a1efedd651e7e1670deb1b430fb@changeid>
 <20240112150307.2.Idb1553d1d22123c377f31eacb4486432f6c9ac8d@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112150307.2.Idb1553d1d22123c377f31eacb4486432f6c9ac8d@changeid>

On Fri, Jan 12, 2024 at 03:03:08PM -0800, Douglas Anderson wrote:
> As of commit d7402513c935 ("arm64: smp: IPI_CPU_STOP and
> IPI_CPU_CRASH_STOP should try for NMI"), if we've got pseudo-NMI
> enabled then we'll use it to stop CPUs at panic time. This is nice,
> but it does mean that there's a pretty good chance that we'll end up
> stopping a CPU while it holds the port lock for the console
> UART. Specifically, I see a CPU get stopped while holding the port
> lock nearly 100% of the time on my sc7180-trogdor based Chromebook by
> enabling the "buddy" hardlockup detector and then doing:
> 
>   sysctl -w kernel.hardlockup_all_cpu_backtrace=1
>   sysctl -w kernel.hardlockup_panic=1
>   echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT
> 
> UART drivers are _supposed_ to handle this case OK and this is why
> UART drivers check "oops_in_progress" and only do a "trylock" in that
> case. However, before we enabled pseudo-NMI to stop CPUs it wasn't a
> very well-tested situation.
> 
> Now that we're testing the situation a lot, it can be seen that the
> Qualcomm GENI UART driver is pretty broken. Specifically, when I run
> my test case and look at the console output I just see a bunch of
> garbled output like:
> 
>   [  201.069084] NMI backtrace[  201.069084] NM[  201.069087] CPU: 6
>   PID: 10296 Comm: dnsproxyd Not tainted 6.7.0-06265-gb13e8c0ede12
>   #1 01112b9f14923cbd0b[  201.069090] Hardware name: Google Lazor
>   ([  201.069092] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DI[
>   201.069095] pc : smp_call_function_man[  201.069099]
> 
> That's obviously not so great. This happens because each call to the
> console driver exits after the data has been written to the FIFO but
> before it's actually been flushed out of the serial port. When we have
> multiple calls into the console one after the other then (if we can't
> get the lock) each call tells the UART to throw away any data in the
> FIFO that hadn't been transferred yet.
> 
> I've posted up a patch to change the arm64 core to avoid this
> situation most of the time [1] much like x86 seems to do, but even if
> that patch lands the GENI driver should still be fixed.
> 
> From testing, it appears that we can just delete the cancel/abort in
> the case where we weren't able to get the UART lock and the output
> looks good. It makes sense that we'd be able to do this since that
> means we'll just call into __qcom_geni_serial_console_write() and
> __qcom_geni_serial_console_write() looks much like
> qcom_geni_serial_poll_put_char() but with a loop. However, it seems
> safest to poll the FIFO and make sure it's empty before our
> transfer. This should reliably make sure that we're not
> interrupting/clobbering any existing transfers.
> 
> As part of this change, we'll also avoid re-setting up a TX at the end
> of the console write function if we weren't able to get the lock,
> since accessing "port->tx_remaining" without the lock is not
> safe. This is only needed to re-start userspace initiated transfers.
> 
> [1] https://lore.kernel.org/r/20231207170251.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
> 
>  drivers/tty/serial/qcom_geni_serial.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 7e78f97e8f43..06ebe62f99bc 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -488,18 +488,16 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
>  
>  	geni_status = readl(uport->membase + SE_GENI_STATUS);
>  
> -	/* Cancel the current write to log the fault */
>  	if (!locked) {
> -		geni_se_cancel_m_cmd(&port->se);
> -		if (!qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
> -						M_CMD_CANCEL_EN, true)) {
> -			geni_se_abort_m_cmd(&port->se);
> -			qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
> -							M_CMD_ABORT_EN, true);
> -			writel(M_CMD_ABORT_EN, uport->membase +
> -							SE_GENI_M_IRQ_CLEAR);
> -		}
> -		writel(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
> +		/*
> +		 * We can only get here if an oops is in progress then we were
> +		 * unable to get the lock. This means we can't safely access
> +		 * our state variables like tx_remaining. About the best we
> +		 * can do is wait for the FIFO to be empty before we start our
> +		 * transfer, so we'll do that.
> +		 */
> +		qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
> +					  M_TX_FIFO_NOT_EMPTY_EN, false);
>  	} else if ((geni_status & M_GENI_CMD_ACTIVE) && !port->tx_remaining) {
>  		/*
>  		 * It seems we can't interrupt existing transfers if all data
> @@ -516,11 +514,12 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
>  
>  	__qcom_geni_serial_console_write(uport, s, count);
>  
> -	if (port->tx_remaining)
> -		qcom_geni_serial_setup_tx(uport, port->tx_remaining);
>  
> -	if (locked)
> +	if (locked) {
> +		if (port->tx_remaining)
> +			qcom_geni_serial_setup_tx(uport, port->tx_remaining);
>  		uart_port_unlock_irqrestore(uport, flags);
> +	}
>  }
>  
>  static void handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
> -- 
> 2.43.0.275.g3460e3d667-goog
> 

