Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E03E79B298
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240643AbjIKVGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237452AbjIKMvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:51:51 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F9ACEB;
        Mon, 11 Sep 2023 05:51:44 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RkmjD48PWzMlH2;
        Mon, 11 Sep 2023 20:48:16 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 11 Sep 2023 20:51:41 +0800
Subject: Re: [RFC PATCH net-next 2/6] net: ethernet: add mac-phy interrupt
 support with reset complete handling
To:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <steen.hegelund@microchip.com>,
        <rdunlap@infradead.org>, <horms@kernel.org>,
        <casper.casan@gmail.com>, <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <horatiu.vultur@microchip.com>, <Woojung.Huh@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <Thorsten.Kummermehr@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-3-Parthiban.Veerasooran@microchip.com>
From:   "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Message-ID: <5f434392-0e87-ecbc-9c9a-ad08a809206a@huawei.com>
Date:   Mon, 11 Sep 2023 20:51:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20230908142919.14849-3-Parthiban.Veerasooran@microchip.com>
Content-Type: text/plain; charset="gbk"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.200]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Register MAC-PHY interrupt and handle reset complete interrupt. Reset
> complete bit is set when the MAC-PHY reset complete and ready for
> configuration. When it is set, it will generate a non-maskable interrupt
> to alert the SPI host. Additionally reset complete bit in the STS0
> register has to be written by one upon reset complete to clear the
> interrupt.
> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
> ---
>  drivers/net/ethernet/oa_tc6.c | 141 ++++++++++++++++++++++++++++++++--
>  include/linux/oa_tc6.h        |  16 +++-
>  2 files changed, 150 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
> index 613cf034430a..0019f70345b6 100644
> --- a/drivers/net/ethernet/oa_tc6.c
> +++ b/drivers/net/ethernet/oa_tc6.c
> @@ -6,6 +6,7 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/interrupt.h>
>  #include <linux/oa_tc6.h>
>  
>  static int oa_tc6_spi_transfer(struct spi_device *spi, u8 *ptx, u8 *prx,
> @@ -160,10 +161,16 @@ int oa_tc6_perform_ctrl(struct oa_tc6 *tc6, u32 addr, u32 val[], u8 len,
>  	if (ret)
>  		goto err_ctrl;
>  
> -	/* Check echoed/received control reply */
> -	ret = oa_tc6_check_control(tc6, tx_buf, rx_buf, len, wnr, ctrl_prot);
> -	if (ret)
> -		goto err_ctrl;
> +	/* In case of reset write, the echoed control command doesn't have any
> +	 * valid data. So no need to check for error.
> +	 */
> +	if (addr != OA_TC6_RESET) {
> +		/* Check echoed/received control reply */
> +		ret = oa_tc6_check_control(tc6, tx_buf, rx_buf, len, wnr,
> +					   ctrl_prot);
> +		if (ret)
> +			goto err_ctrl;
> +	}
>  
>  	if (!wnr) {
>  		/* Copy read data from the rx data in case of ctrl read */
> @@ -186,6 +193,88 @@ int oa_tc6_perform_ctrl(struct oa_tc6 *tc6, u32 addr, u32 val[], u8 len,
>  	return ret;
>  }
>  
> +static int oa_tc6_handler(void *data)
> +{
> +	struct oa_tc6 *tc6 = data;
> +	u32 regval;
> +	int ret;
> +
> +	while (likely(!kthread_should_stop())) {
> +		wait_event_interruptible(tc6->tc6_wq, tc6->int_flag ||
> +					 kthread_should_stop());
> +		if (tc6->int_flag) {
> +			tc6->int_flag = false;
> +			ret = oa_tc6_perform_ctrl(tc6, OA_TC6_STS0, &regval, 1,
> +						  false, false);
> +			if (ret) {
> +				dev_err(&tc6->spi->dev, "Failed to read STS0\n");
> +				continue;
> +			}
> +			/* Check for reset complete interrupt status */
> +			if (regval & RESETC) {
> +				regval = RESETC;
> +				/* SPI host should write RESETC bit with one to
> +				 * clear the reset interrupt status.
> +				 */
> +				ret = oa_tc6_perform_ctrl(tc6, OA_TC6_STS0,
> +							  &regval, 1, true,
> +							  false);
> +				if (ret) {
> +					dev_err(&tc6->spi->dev,
> +						"Failed to write STS0\n");
> +					continue;
> +				}
> +				complete(&tc6->rst_complete);
> +			}
> +		}
> +	}
> +	return 0;
> +}
> +
> +static irqreturn_t macphy_irq(int irq, void *dev_id)
> +{
> +	struct oa_tc6 *tc6 = dev_id;
> +
> +	/* Wake tc6 task to perform interrupt action */
> +	tc6->int_flag = true;
> +	wake_up_interruptible(&tc6->tc6_wq);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int oa_tc6_sw_reset(struct oa_tc6 *tc6)
> +{
> +	long timeleft;
> +	u32 regval;
> +	int ret;
> +
> +	/* Perform software reset with both protected and unprotected control
> +	 * commands because the driver doesn't know the current status of the
> +	 * MAC-PHY.
> +	 */
> +	regval = SW_RESET;
> +	reinit_completion(&tc6->rst_complete);
> +	ret = oa_tc6_perform_ctrl(tc6, OA_TC6_RESET, &regval, 1, true, false);
> +	if (ret) {
> +		dev_err(&tc6->spi->dev, "RESET register write failed\n");
> +		return ret;
> +	}
> +
> +	ret = oa_tc6_perform_ctrl(tc6, OA_TC6_RESET, &regval, 1, true, true);
> +	if (ret) {
> +		dev_err(&tc6->spi->dev, "RESET register write failed\n");
> +		return ret;
> +	}
> +	timeleft = wait_for_completion_interruptible_timeout(&tc6->rst_complete,
> +							     msecs_to_jiffies(1));
> +	if (timeleft <= 0) {
> +		dev_err(&tc6->spi->dev, "MAC-PHY reset failed\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
>  int oa_tc6_write_register(struct oa_tc6 *tc6, u32 addr, u32 val[], u8 len)
>  {
>  	return oa_tc6_perform_ctrl(tc6, addr, val, len, true, tc6->ctrl_prot);
> @@ -201,6 +290,7 @@ EXPORT_SYMBOL_GPL(oa_tc6_read_register);
>  struct oa_tc6 *oa_tc6_init(struct spi_device *spi)
>  {
>  	struct oa_tc6 *tc6;
> +	int ret;
>  
>  	if (!spi)
>  		return NULL;
> @@ -211,12 +301,51 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi)
>  
>  	tc6->spi = spi;
>  
> +	/* Used for triggering the OA TC6 task */
> +	init_waitqueue_head(&tc6->tc6_wq);
> +
> +	init_completion(&tc6->rst_complete);
> +
> +	/* This task performs the SPI transfer */
> +	tc6->tc6_task = kthread_run(oa_tc6_handler, tc6, "OA TC6 Task");
> +	if (IS_ERR(tc6->tc6_task))
> +		goto err_tc6_task;
> +
> +	/* Set the highest priority to the tc6 task as it is time critical */
> +	sched_set_fifo(tc6->tc6_task);
> +
> +	/* Register MAC-PHY interrupt service routine */
> +	ret = devm_request_irq(&spi->dev, spi->irq, macphy_irq, 0, "macphy int",
> +			       tc6);
> +	if ((ret != -ENOTCONN) && ret < 0) {
> +		dev_err(&spi->dev, "Error attaching macphy irq %d\n", ret);
> +		goto err_macphy_irq;
> +	}
> +
> +	/* Perform MAC-PHY software reset */
> +	if (oa_tc6_sw_reset(tc6))
> +		goto err_macphy_reset;
> +
>  	return tc6;
> +
> +err_macphy_reset:
> +	devm_free_irq(&tc6->spi->dev, tc6->spi->irq, tc6);
> +err_macphy_irq:
> +	kthread_stop(tc6->tc6_task);
> +err_tc6_task:
> +	kfree(tc6);
> +	return NULL;
>  }
>  EXPORT_SYMBOL_GPL(oa_tc6_init);
>  
> -void oa_tc6_deinit(struct oa_tc6 *tc6)
> +int oa_tc6_deinit(struct oa_tc6 *tc6)
>  {
> -	kfree(tc6);
> +	int ret;
> +
> +	devm_free_irq(&tc6->spi->dev, tc6->spi->irq, tc6);
> +	ret = kthread_stop(tc6->tc6_task);

kthread_stop() will the result of threadfn(). Here mean that if threadfn()
return non-zero, deinit() will fail. But the KTHREAD_SHOULD_STOP already be set.
And oa_tc6_handler() will end. Please check it is what you want.

> +	if (!ret)
> +		kfree(tc6);
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(oa_tc6_deinit);
> diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
> index 5e0a58ab1dcd..315f061c2dfe 100644
> --- a/include/linux/oa_tc6.h
> +++ b/include/linux/oa_tc6.h
> @@ -17,15 +17,29 @@
>  #define CTRL_HDR_LEN	GENMASK(7, 1)	/* Length */
>  #define CTRL_HDR_P	BIT(0)		/* Parity Bit */
>  
> +/* Open Alliance TC6 Standard Control and Status Registers */
> +#define OA_TC6_RESET	0x0003		/* Reset Control and Status Register */
> +#define OA_TC6_STS0	0x0008		/* Status Register #0 */
> +
> +/* RESET register field */
> +#define SW_RESET	BIT(0)		/* Software Reset */
> +
> +/* STATUS0 register field */
> +#define RESETC		BIT(6)		/* Reset Complete */
> +
>  #define TC6_HDR_SIZE	4		/* Ctrl command header size as per OA */
>  #define TC6_FTR_SIZE	4		/* Ctrl command footer size ss per OA */
>  
>  struct oa_tc6 {
>  	struct spi_device *spi;
>  	bool ctrl_prot;
> +	struct task_struct *tc6_task;
> +	wait_queue_head_t tc6_wq;
> +	bool int_flag;
> +	struct completion rst_complete;
>  };
>  
>  struct oa_tc6 *oa_tc6_init(struct spi_device *spi);
> -void oa_tc6_deinit(struct oa_tc6 *tc6);
> +int oa_tc6_deinit(struct oa_tc6 *tc6);
>  int oa_tc6_write_register(struct oa_tc6 *tc6, u32 addr, u32 value[], u8 len);
>  int oa_tc6_read_register(struct oa_tc6 *tc6, u32 addr, u32 value[], u8 len);
> 
