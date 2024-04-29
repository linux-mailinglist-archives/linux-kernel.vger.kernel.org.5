Return-Path: <linux-kernel+bounces-161698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E72A78B4FD5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 05:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D4FF1C2100E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 03:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2809D8F68;
	Mon, 29 Apr 2024 03:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="VAY/pWr+"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8798BEC;
	Mon, 29 Apr 2024 03:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714361540; cv=none; b=Ef8D4NKcnjJhjsEqUTXt8bL6T0JsYfZ+ByV11yHeYPUsX/ClxxiB77PzNU3jy6/PKVwz3M6UAnOK5rUf92x1ZHEH71wCqf/9w08js9kn0yt/zAQ9Twcwf0+PygxeDEbxlxtwaSNNgv17jvmm+KYY75rtxIIo9aJaUst6ZUMSa8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714361540; c=relaxed/simple;
	bh=f2KQguX71x1xq7iC9KGN5UfbWpxX4Rd3/wmNbAjMcLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I58asYjtimWwi+5lSvEkYasZj4P/8ImUSKXyylclRliaedoOSvJlAtnljbE9WV8Ymr/CghcBmx/AxK046WPutY+BK04/VaeHnmIvAixhfwlX3Cu5KDIpIq6kg226JhrTI4e3DyAAzXvSQt5JuAfeKLBbLE7X4q+vUNqL0OXPDzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=VAY/pWr+; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=CHSUhxC6lM1/IFRN+7v8UnKMqdYD3kpZXA4RJ6Yr18A=;
	b=VAY/pWr+mr1srwZ7TVWSsxCFRjJ4x5BDWIcj9slomL8YMxH110QFrsI82LJzq9
	Rmhi/dsnpDpestidFNjF2DjPdfBcg/f8Sxjfh8339B5MkWOWf0OqUUtrIag9ApqW
	w5sapIsILs+O+AZ5AfAOKHBgCG+o4wU1/rlNt6OaMLEU0=
Received: from [192.168.50.76] (unknown [58.22.7.114])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wD3v7NwFC9mrac4Bg--.23843S2;
	Mon, 29 Apr 2024 11:31:00 +0800 (CST)
Message-ID: <aee69bf3-ea7b-4ff3-8fd5-01e97d3381eb@126.com>
Date: Mon, 29 Apr 2024 11:30:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: core: Convert to use __mmc_poll_for_busy()
 SD_APP_OP_COND too
Content-Language: en-GB
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>, Avri Altman
 <avri.altman@wdc.com>, Dragan Simic <dsimic@manjaro.org>,
 linux-kernel@vger.kernel.org
References: <20240425133034.79599-1-ulf.hansson@linaro.org>
From: Yao Xiao <xiaokeqinhealth@126.com>
In-Reply-To: <20240425133034.79599-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3v7NwFC9mrac4Bg--.23843S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw15JF4ktFWrtFykKF17Wrg_yoW5tF18pF
	WUXryYkF4Dtr1a9F97WanF93s3uw1SkFWUG3s7X34FvrsI9r98KFyvkayFvF18Zr9rC3yI
	vFWjgr15u3sxJrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U65lnUUUUU=
X-CM-SenderInfo: 50ld0yhhtl0xhhdo3xa6rslhhfrp/1tbiEBXP1WVLbIDYJgAAsj

Hi ulf,

On 2024/4/25 21:30, Ulf Hansson wrote:
> Similar to what has already been changed for eMMC and the MMC_SEND_OP_COND
> (CMD1), let's convert the SD_APP_OP_COND (ACMD41) for SD cards to use the
> common __mmc_poll_for_busy() too.
> 
> This change means the initial delay period, that starts as 10ms will now
> increase for every loop when being busy. The total accepted timeout for
> being busy is 1s, which is according to the SD spec.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   drivers/mmc/core/sd_ops.c | 77 +++++++++++++++++++++++++--------------
>   1 file changed, 50 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> index a59cd592f06e..3ce1ff336826 100644
> --- a/drivers/mmc/core/sd_ops.c
> +++ b/drivers/mmc/core/sd_ops.c
> @@ -19,6 +19,15 @@
>   #include "sd_ops.h"
>   #include "mmc_ops.h"
>   
> +#define SD_APP_OP_COND_PERIOD_US	(10 * 1000) /* 10ms */
> +#define SD_APP_OP_COND_TIMEOUT_MS	1000 /* 1s */
> +
> +struct sd_app_op_cond_busy_data {
> +	struct mmc_host *host;
> +	u32 ocr;
> +	struct mmc_command *cmd;
> +};
> +
>   int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
>   {
>   	int err;
> @@ -115,10 +124,44 @@ int mmc_app_set_bus_width(struct mmc_card *card, int width)
>   	return mmc_wait_for_app_cmd(card->host, card, &cmd);
>   }
>   
> +static int sd_app_op_cond_cb(void *cb_data, bool *busy)
> +{
> +	struct sd_app_op_cond_busy_data *data = cb_data;
> +	struct mmc_host *host = data->host;
> +	struct mmc_command *cmd = data->cmd;
> +	u32 ocr = data->ocr;
> +	int err;
> +	*busy = false;
> +
> +	err = mmc_wait_for_app_cmd(host, NULL, cmd);
> +	if (err)
> +		return err;
> +
> +	/* If we're just probing, do a single pass. */
> +	if (ocr == 0)
> +		return 0;
> +
> +	/* Wait until reset completes. */
> +	if (mmc_host_is_spi(host)) {
> +		if (!(cmd->resp[0] & R1_SPI_IDLE))
> +			return 0;
> +	} else if (cmd->resp[0] & MMC_CARD_BUSY) {
> +		return 0;
> +	}
> +
> +	*busy = true;
> +	return 0;
> +}
> +
>   int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
>   {
>   	struct mmc_command cmd = {};
> -	int i, err = 0;
> +	struct sd_app_op_cond_busy_data cb_data = {
> +		.host = host,
> +		.ocr = ocr,
> +		.cmd = &cmd
> +	};
> +	int err;
>   
>   	cmd.opcode = SD_APP_OP_COND;
>   	if (mmc_host_is_spi(host))
> @@ -127,36 +170,16 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
>   		cmd.arg = ocr;
>   	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
>   
> -	for (i = 100; i; i--) {
> -		err = mmc_wait_for_app_cmd(host, NULL, &cmd);
> -		if (err)
> -			break;
> -
> -		/* if we're just probing, do a single pass */
> -		if (ocr == 0)
> -			break;
> -
> -		/* otherwise wait until reset completes */
> -		if (mmc_host_is_spi(host)) {
> -			if (!(cmd.resp[0] & R1_SPI_IDLE))
> -				break;
> -		} else {
> -			if (cmd.resp[0] & MMC_CARD_BUSY)
> -				break;
> -		}
> -
> -		err = -ETIMEDOUT;
> -
> -		mmc_delay(10);
> -	}
> -
> -	if (!i)
> -		pr_err("%s: card never left busy state\n", mmc_hostname(host));
> +	err = __mmc_poll_for_busy(host, SD_APP_OP_COND_PERIOD_US,
> +				  SD_APP_OP_COND_TIMEOUT_MS, &sd_app_op_cond_cb,
> +				  &cb_data);
> +	if (err)
> +		return err;
>   
>   	if (rocr && !mmc_host_is_spi(host))
>   		*rocr = cmd.resp[0];
>   
> -	return err;
> +	return 0;
>   }
>   
>   static int __mmc_send_if_cond(struct mmc_host *host, u32 ocr, u8 pcie_bits,
The implementation looks solid and it works as expected in the scenarios 
I tested.
Acked-by: Felix Qin <xiaokeqinhealth@126.com>


