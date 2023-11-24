Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61D67F78FF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjKXQa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjKXQaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:30:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C15019A3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:31:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCD0C433C7;
        Fri, 24 Nov 2023 16:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700843460;
        bh=0m2/cMBcTydjmRWM2kg9Xg3sXuhlmH0zFa0ospNDRBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qpW2GhNg4EblHnxfauyUbT06NCJY/KQePisvrxpj3Bb0hqiZ9OQAqj2ZX10vIPnm/
         7fV725jNxjWCkDAK8WFoBG2ZCuoLURtPDbWYV97BoU1PL61sGBZ/Npasvffl+In+Bo
         53GGEWDwJjZVJFpoiPVZv99XLTZtb9VXFJATxD5/+ufBGwCkrH8PJOnUYqsXWHvwEQ
         aOjF8HzHhMyBjUAosqaZ+rK96Mif55NMadoGV/ppGVZfcd/VN/XVDEMQdulju5PSGu
         9/Mmq2SqYGQpY1LOEM4kFJaw1p6TBIUSEgQv7RpwNNv1Vkw1BzUGU5D362A/BvomHp
         7v/HdYqIjRx3Q==
Date:   Fri, 24 Nov 2023 16:30:54 +0000
From:   Simon Horman <horms@kernel.org>
To:     Kory Maincent <kory.maincent@bootlin.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 9/9] net: pse-pd: Add PD692x0 PSE controller
 driver
Message-ID: <20231124163054.GQ50352@kernel.org>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
 <20231116-feature_poe-v1-9-be48044bf249@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116-feature_poe-v1-9-be48044bf249@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 03:01:41PM +0100, Kory Maincent wrote:
> Add a new driver for the PD692x0 I2C Power Sourcing Equipment controller.
> This driver only support i2c communication for now.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Hi Kory,

some minor feedback from my side.

...

> diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c

...

> +static int
> +pd692x0_get_of_matrix(struct device *dev,
> +		      struct matrix port_matrix[PD692X0_MAX_LOGICAL_PORTS])
> +{
> +	int ret, i, ports_matrix_size;
> +	u32 val[PD692X0_MAX_LOGICAL_PORTS * 3];

nit: reverse xmas tree please.

...

> +static int pd692x0_fw_write_line(const struct i2c_client *client,
> +				 const char line[PD692X0_FW_LINE_MAX_SZ],
> +				 const bool last_line)
> +{
> +	int ret;
> +
> +	while (*line != 0) {
> +		ret = i2c_master_send(client, line, 1);
> +		if (ret < 0)
> +			return FW_UPLOAD_ERR_RW_ERROR;
> +		line++;
> +	}
> +
> +	if (last_line) {
> +		ret = pd692x0_fw_recv_resp(client, 100, "TP\r\n",
> +					   sizeof("TP\r\n") - 1);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret = pd692x0_fw_recv_resp(client, 100, "T*\r\n",
> +					   sizeof("T*\r\n") - 1);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return FW_UPLOAD_ERR_NONE;
> +}

...

> +static enum fw_upload_err pd692x0_fw_write(struct fw_upload *fwl,
> +					   const u8 *data, u32 offset,
> +					   u32 size, u32 *written)
> +{
> +	struct pd692x0_priv *priv = fwl->dd_handle;
> +	char line[PD692X0_FW_LINE_MAX_SZ];
> +	const struct i2c_client *client;
> +	int ret, i;
> +	char cmd;
> +
> +	client = priv->client;
> +	priv->fw_state = PD692X0_FW_WRITE;
> +
> +	/* Erase */
> +	cmd = 'E';
> +	ret = i2c_master_send(client, &cmd, 1);
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"Failed to boot programming mode (%pe)\n",
> +			ERR_PTR(ret));
> +		return FW_UPLOAD_ERR_RW_ERROR;
> +	}
> +
> +	ret = pd692x0_fw_recv_resp(client, 100, "TOE\r\n", sizeof("TOE\r\n") - 1);
> +	if (ret)
> +		return ret;
> +
> +	ret = pd692x0_fw_recv_resp(client, 5000, "TE\r\n", sizeof("TE\r\n") - 1);
> +	if (ret)
> +		dev_warn(&client->dev,
> +			 "Failed to erase internal memory, however still try to write Firmware\n");
> +
> +	ret = pd692x0_fw_recv_resp(client, 100, "TPE\r\n", sizeof("TPE\r\n") - 1);
> +	if (ret)
> +		dev_warn(&client->dev,
> +			 "Failed to erase internal memory, however still try to write Firmware\n");
> +
> +	if (priv->cancel_request)
> +		return FW_UPLOAD_ERR_CANCELED;
> +
> +	/* Program */
> +	cmd = 'P';
> +	ret = i2c_master_send(client, &cmd, sizeof(char));
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"Failed to boot programming mode (%pe)\n",
> +			ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	ret = pd692x0_fw_recv_resp(client, 100, "TOP\r\n", sizeof("TOP\r\n") - 1);
> +	if (ret)
> +		return ret;
> +
> +	i = 0;
> +	while (i < size) {
> +		ret = pd692x0_fw_get_next_line(data, line, size - i);
> +		if (!ret) {
> +			ret = FW_UPLOAD_ERR_FW_INVALID;
> +			goto err;
> +		}
> +
> +		i += ret;
> +		data += ret;
> +		if (line[0] == 'S' && line[1] == '0') {
> +			continue;
> +		} else if (line[0] == 'S' && line[1] == '7') {
> +			ret = pd692x0_fw_write_line(client, line, true);
> +			if (ret)
> +				goto err;
> +		} else {
> +			ret = pd692x0_fw_write_line(client, line, false);
> +			if (ret)
> +				goto err;
> +		}
> +
> +		if (priv->cancel_request) {
> +			ret = FW_UPLOAD_ERR_CANCELED;
> +			goto err;
> +		}
> +	}
> +	*written = i;
> +
> +	msleep(400);
> +
> +	return FW_UPLOAD_ERR_NONE;
> +
> +err:
> +	pd692x0_fw_write_line(client, "S7\r\n", true);

gcc-13 (W=1) seems a bit upset about this.

 drivers/net/pse-pd/pd692x0.c: In function 'pd692x0_fw_write':
 drivers/net/pse-pd/pd692x0.c:861:9: warning: 'pd692x0_fw_write_line' reading 128 bytes from a region of size 5 [-Wstringop-overread]
   861 |         pd692x0_fw_write_line(client, "S7\r\n", true);
       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 drivers/net/pse-pd/pd692x0.c:861:9: note: referencing argument 2 of type 'const char[128]'
 drivers/net/pse-pd/pd692x0.c:642:12: note: in a call to function 'pd692x0_fw_write_line'
   642 | static int pd692x0_fw_write_line(const struct i2c_client *client,
       |            ^~~~~~~~~~~~~~~~~~~~~

> +	return ret;
> +}

...
