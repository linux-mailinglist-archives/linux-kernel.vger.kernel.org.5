Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FEE80534C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347018AbjLELqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345333AbjLELqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:46:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1744785
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:46:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BC6C433C8;
        Tue,  5 Dec 2023 11:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701776816;
        bh=/pO6pOloy1pC9HuVjzn7MuPfwdbOmMGzkM3HpUEuFbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dwluM7bJoMJJMnJsHnMR88lmHEgvdB2NbOq2vUw6NMqvUWA7ki1dUcA9cb7DXTDzD
         C3ewA26Z6bLKMhfdAsJY0v4Mnr335G2bAhBAgw2e3FehNq+4kMRyaLanBm7cplYdDR
         /buDjuJYD0pD4dwD1gmkPTuVih/5GMup2FkKv5SYGNAm03nXxbQa9S3W9CGM8Klmka
         fCUlFGa7Yff8rnpoGbmmcvT5U+yXG5jZgkJZvrmAFXxXVD6sBkegBNGEbsu3kO3W+6
         8DbNkldBeYlN0Hwst1pYOgi5/AMa4Gan4BlgRxbDdpZYMuy3eq9m7oahV952C6HOlr
         VxRtLLSzcL3Tg==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rATts-00005m-29;
        Tue, 05 Dec 2023 12:47:40 +0100
Date:   Tue, 5 Dec 2023 12:47:40 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/2] Bluetooth: qca: run the power-on/off sequence for
 QCA6390 too
Message-ID: <ZW8N3BHQTUGtIx_W@hovoldconsulting.com>
References: <20231205110903.68898-1-brgl@bgdev.pl>
 <20231205110903.68898-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205110903.68898-2-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 12:09:03PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The Bluetooth module on QCA6390 needs to be powered-on by enabling the
> relevant regulators and driving the enable GPIO high. We can reuse the
> power sequence for the WNC models.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/bluetooth/hci_qca.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 7f25931a946e..351ba904c8c2 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1788,6 +1788,7 @@ static int qca_power_on(struct hci_dev *hdev)
>  	case QCA_WCN6750:
>  	case QCA_WCN6855:
>  	case QCA_WCN7850:
> +	case QCA_QCA6390:
>  		ret = qca_regulator_init(hu);
>  		break;
>  
> @@ -2137,6 +2138,7 @@ static void qca_power_shutdown(struct hci_uart *hu)
>  
>  	case QCA_WCN6750:
>  	case QCA_WCN6855:
> +	case QCA_QCA6390:
>  		gpiod_set_value_cansleep(qcadev->bt_en, 0);
>  		msleep(100);
>  		qca_regulator_disable(qcadev);
> @@ -2284,6 +2286,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  	case QCA_WCN6750:
>  	case QCA_WCN6855:
>  	case QCA_WCN7850:
> +	case QCA_QCA6390:
>  		qcadev->bt_power = devm_kzalloc(&serdev->dev,
>  						sizeof(struct qca_power),
>  						GFP_KERNEL);
> @@ -2394,6 +2397,7 @@ static void qca_serdev_remove(struct serdev_device *serdev)
>  	case QCA_WCN6750:
>  	case QCA_WCN6855:
>  	case QCA_WCN7850:
> +	case QCA_QCA6390:
>  		if (power->vregs_on) {
>  			qca_power_shutdown(&qcadev->serdev_hu);
>  			break;

These two patches should also be squashed into one. Makes no sense to
separate them.

Johan
