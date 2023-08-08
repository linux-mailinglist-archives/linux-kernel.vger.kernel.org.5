Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFDD7743BC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbjHHSI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbjHHSIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:08:32 -0400
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C04A1974B;
        Tue,  8 Aug 2023 10:03:38 -0700 (PDT)
Received: from [134.238.52.102] (helo=[10.8.4.157])
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qTINg-00CjDa-Lk; Tue, 08 Aug 2023 09:47:56 +0100
Message-ID: <12c1e981-b664-b80c-d0df-7e7a098e32b1@codethink.co.uk>
Date:   Tue, 8 Aug 2023 09:47:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH 1/2] serial: sifive: Add suspend and resume operations
Content-Language: en-GB
To:     Nick Hu <nick.hu@sifive.com>, zong.li@sifive.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20230808072625.2109564-1-nick.hu@sifive.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20230808072625.2109564-1-nick.hu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 08:26, Nick Hu wrote:
> If the Sifive Uart is not used as the wake up source, suspend the uart
> before the system enter the suspend state to prevent it woken up by
> unexpected uart interrupt. Resume the uart once the system woken up.
> 
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

^ This should be Reviewed-by, as I did review on this earlier.

> ---
>   drivers/tty/serial/sifive.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
> index a19db49327e2..87994cb69007 100644
> --- a/drivers/tty/serial/sifive.c
> +++ b/drivers/tty/serial/sifive.c
> @@ -1022,6 +1022,31 @@ static int sifive_serial_remove(struct platform_device *dev)
>   	return 0;
>   }
>   
> +static int sifive_serial_suspend(struct device *dev)
> +{
> +	int ret = 0;
> +	struct sifive_serial_port *ssp = dev_get_drvdata(dev);

Minor annyonance is ordering of ssp and ret, I think the showrter one
last is the nicest looking.

> +	if (ssp && ssp->port.type != PORT_UNKNOWN)
> +		ret = uart_suspend_port(&sifive_serial_uart_driver, &ssp->port);

Do we really need a test for ssp being valid if the device is bound.
Not sure if the port.type is also useful?

> +	return ret;
> +}
> +
> +static int sifive_serial_resume(struct device *dev)
> +{
> +	int ret = 0;
> +	struct sifive_serial_port *ssp = dev_get_drvdata(dev);
> +
> +	if (ssp && ssp->port.type != PORT_UNKNOWN)
> +		ret = uart_resume_port(&sifive_serial_uart_driver, &ssp->port);
> +
> +	return ret;
> +}
> +
> +DEFINE_SIMPLE_DEV_PM_OPS(sifive_uart_pm_ops, sifive_serial_suspend,
> +			 sifive_serial_resume);
> +
>   static const struct of_device_id sifive_serial_of_match[] = {
>   	{ .compatible = "sifive,fu540-c000-uart0" },
>   	{ .compatible = "sifive,uart0" },
> @@ -1034,6 +1059,7 @@ static struct platform_driver sifive_serial_platform_driver = {
>   	.remove		= sifive_serial_remove,
>   	.driver		= {
>   		.name	= SIFIVE_SERIAL_NAME,
> +		.pm = pm_sleep_ptr(&sifive_uart_pm_ops),
>   		.of_match_table = of_match_ptr(sifive_serial_of_match),
>   	},
>   };

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

