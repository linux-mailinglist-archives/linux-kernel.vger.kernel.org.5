Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D80802706
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 20:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbjLCTgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 14:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbjLCTgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 14:36:07 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA1C30C3;
        Sun,  3 Dec 2023 11:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=5kdk7NFvHqeMqSQj/vvyZS672r6fTVBe/SPbye4Cvow=; b=sTN0L4FRNGtyAzojEV8PIpHtNL
        62/xauG7IQTV4lDACxkdzTLk2UZTVoVpiX6+IPcGRH/AdKwLfHs7k5l+KA/E9WJD+7mJQcRLhzcJ8
        Zvk2VdzBSRxUXyEGgjGPBmke7yLJXLVlVSpuyB8U+fezvXwfgZUa7ZjSmcUjPEd4rCNc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r9sEw-001uaj-5h; Sun, 03 Dec 2023 20:34:54 +0100
Date:   Sun, 3 Dec 2023 20:34:54 +0100
From:   Andrew Lunn <andrew@lunn.ch>
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
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v2 8/8] net: pse-pd: Add PD692x0 PSE controller
 driver
Message-ID: <639c5222-043f-4e27-9efa-ce2a1d73eaba@lunn.ch>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
 <20231201-feature_poe-v2-8-56d8cac607fa@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201-feature_poe-v2-8-56d8cac607fa@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int pd692x0_try_recv_msg(const struct i2c_client *client,
> +				struct pd692x0_msg *msg,
> +				struct pd692x0_msg *buf)
> +{
> +	msleep(30);
> +
> +	memset(buf, 0, sizeof(*buf));
> +	i2c_master_recv(client, (u8 *)buf, sizeof(*buf));
> +	if (buf->key)
> +		return 1;
> +
> +	msleep(100);
> +
> +	memset(buf, 0, sizeof(*buf));
> +	i2c_master_recv(client, (u8 *)buf, sizeof(*buf));
> +	if (buf->key)
> +		return 1;
> +
> +	return 0;

Maybe make this function return a bool? Or 0 on success, -EIO on
error?

> +}
> +
> +/* Implementation of I2C communication, specifically addressing scenarios
> + * involving communication loss. Refer to the "Synchronization During
> + * Communication Loss" section in the Communication Protocol document for
> + * further details.
> + */
> +static int pd692x0_recv_msg(struct pd692x0_priv *priv,
> +			    struct pd692x0_msg *msg,
> +			    struct pd692x0_msg *buf)
> +{
> +	const struct i2c_client *client = priv->client;
> +	int ret;
> +
> +	ret = pd692x0_try_recv_msg(client, msg, buf);
> +	if (ret)
> +		goto out_success;

The danger with this returning an int, is this fragment of code is the
exact opposite to normal. Developers are used to ret being an error
code, and this goto would then be going to error handling. Without the
_success it would be easy to understand this wrongly.

> +
> +	dev_warn(&client->dev,
> +		 "Communication lost, rtnl is locked until communication is back!");

Maybe add another dev_warn() if/when communication is re-established?

> +static int pd692x0_sendrecv_msg(struct pd692x0_priv *priv,
> +				struct pd692x0_msg *msg,
> +				struct pd692x0_msg *buf)
> +{
> +	struct device *dev = &priv->client->dev;
> +	int ret;
> +
> +	ret = pd692x0_send_msg(priv, msg);
> +	if (ret)
> +		return ret;
> +
> +	ret = pd692x0_recv_msg(priv, msg, buf);
> +	if (ret)
> +		return ret;
> +
> +	if (msg->echo != buf->echo) {
> +		dev_err(dev, "Wrong match in message ID\n");

Maybe print the two values? This is not something you expect to
happen, so if it does, its probably hard to reproduce? Having the two
values probably helps you debug it, without being able to reproduce
it? Are they different by one, does it happen on wrap-around, have one
gone back to 0, etc.

> +		return -EIO;
> +	}
> +
> +	/* If the reply is a report message is it successful */
> +	if (buf->key == PD692X0_KEY_REPORT &&
> +	    (buf->sub[0] || buf->sub[1])) {
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct pd692x0_priv *to_pd692x0_priv(struct pse_controller_dev *pcdev)
> +{
> +	return container_of(pcdev, struct pd692x0_priv, pcdev);
> +}
> +
> +static int pd692x0_fw_unavailable(struct pd692x0_priv *priv)
> +{
> +	switch (priv->fw_state) {
> +	case PD692X0_FW_OK:
> +		return 0;
> +	case PD692X0_FW_PREPARE:
> +	case PD692X0_FW_WRITE:
> +	case PD692X0_FW_COMPLETE:
> +		dev_err(&priv->client->dev, "Firmware update in progress!\n");
> +		return -EBUSY;
> +	case PD692X0_FW_BROKEN:
> +	case PD692X0_FW_NEED_UPDATE:
> +	default:
> +		dev_err(&priv->client->dev,
> +			"Firmware issue. Please update it!\n");
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int pd692x0_ethtool_set_config(struct pse_controller_dev *pcdev,
> +				      unsigned long id,
> +				      struct netlink_ext_ack *extack,
> +				      const struct pse_control_config *config)
> +{
> +	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
> +	struct pd692x0_msg msg, buf = {0};
> +	int ret;
> +
> +	ret = pd692x0_fw_unavailable(priv);
> +	if (ret)
> +		return ret;
> +
> +	if (priv->admin_state[id] == config->c33_admin_control)
> +		return 0;
> +
> +	msg = pd692x0_msg_template_list[PD692X0_MSG_SET_PORT_PARAM];
> +	switch (config->c33_admin_control) {
> +	case ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED:
> +		msg.data[0] = 0x1;
> +		break;
> +	case ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED:
> +		msg.data[0] = 0x0;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	msg.sub[2] = id;
> +	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	priv->admin_state[id] = config->c33_admin_control;
> +
> +	return 0;
> +}
> +
> +static int pd692x0_ethtool_get_status(struct pse_controller_dev *pcdev,
> +				      unsigned long id,
> +				      struct netlink_ext_ack *extack,
> +				      struct pse_control_status *status)
> +{
> +	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
> +	struct pd692x0_msg msg, buf = {0};
> +	int ret;
> +
> +	ret = pd692x0_fw_unavailable(priv);
> +	if (ret)
> +		return ret;
> +
> +	msg = pd692x0_msg_template_list[PD692X0_MSG_GET_PORT_STATUS];
> +	msg.sub[2] = id;
> +	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Compare Port Status (Communication Protocol Document par. 7.1) */
> +	if ((buf.sub[0] & 0xf0) == 0x80 || (buf.sub[0] & 0xf0) == 0x90)
> +		status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_DELIVERING;
> +	else if (buf.sub[0] == 0x1b || buf.sub[0] == 0x22)
> +		status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_SEARCHING;
> +	else if (buf.sub[0] == 0x12)
> +		status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_FAULT;
> +	else
> +		status->c33_pw_status = ETHTOOL_C33_PSE_PW_D_STATUS_DISABLED;
> +
> +	if (buf.sub[1])
> +		status->c33_admin_state = ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED;
> +	else
> +		status->c33_admin_state = ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED;
> +
> +	priv->admin_state[id] = status->c33_admin_state;
> +
> +	return 0;
> +}
> +
> +static struct pd692x0_msg_ver pd692x0_get_sw_version(struct pd692x0_priv *priv)
> +{
> +	struct device *dev = &priv->client->dev;
> +	struct pd692x0_msg msg, buf = {0};
> +	struct pd692x0_msg_ver ver = {0};
> +	int ret;
> +
> +	msg = pd692x0_msg_template_list[PD692X0_MSG_GET_SW_VER];
> +	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to get PSE version (%pe)\n", ERR_PTR(ret));
> +		return ver;
> +	}
> +
> +	/* Extract version from the message */
> +	ver.prod = buf.sub[2];
> +	ver.maj_sw_ver = (buf.data[0] << 8 | buf.data[1]) / 100;
> +	ver.min_sw_ver = ((buf.data[0] << 8 | buf.data[1]) / 10) % 10;
> +	ver.pa_sw_ver = (buf.data[0] << 8 | buf.data[1]) % 10;
> +	ver.param = buf.data[2];
> +	ver.build = buf.data[3];
> +
> +	return ver;
> +}
> +
> +static const struct pse_controller_ops pd692x0_ops = {
> +	.ethtool_get_status = pd692x0_ethtool_get_status,
> +	.ethtool_set_config = pd692x0_ethtool_set_config,
> +};
> +
> +struct matrix {
> +	u8 hw_port_a;
> +	u8 hw_port_b;
> +};
> +
> +static int
> +pd692x0_set_ports_matrix(struct pd692x0_priv *priv,
> +			 const struct matrix port_matrix[PD692X0_MAX_LOGICAL_PORTS])
> +{
> +	struct pd692x0_msg msg, buf;
> +	int ret, i;
> +
> +	/* Write temporary Matrix */
> +	msg = pd692x0_msg_template_list[PD692X0_MSG_SET_TMP_PORT_MATRIX];
> +	for (i = 0; i < PD692X0_MAX_LOGICAL_PORTS; i++) {
> +		msg.sub[2] = i;
> +		msg.data[0] = port_matrix[i].hw_port_a;
> +		msg.data[1] = port_matrix[i].hw_port_b;
> +
> +		ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	/* Program Matrix */
> +	msg = pd692x0_msg_template_list[PD692X0_MSG_PRG_PORT_MATRIX];
> +	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int
> +pd692x0_get_of_matrix(struct device *dev,
> +		      struct matrix port_matrix[PD692X0_MAX_LOGICAL_PORTS])
> +{
> +	u32 val[PD692X0_MAX_LOGICAL_PORTS * 3];
> +	int ret, i, ports_matrix_size;
> +
> +	ports_matrix_size = device_property_count_u32(dev, "ports-matrix");
> +	if (ports_matrix_size <= 0)
> +		return -EINVAL;
> +	if (ports_matrix_size % 3 ||
> +	    ports_matrix_size > PD692X0_MAX_LOGICAL_PORTS * 3) {
> +		dev_err(dev, "Not valid ports-matrix property size: %d\n",
> +			ports_matrix_size);
> +		return -EINVAL;
> +	}
> +
> +	ret = device_property_read_u32_array(dev, "ports-matrix", val,
> +					     ports_matrix_size);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Init Matrix */
> +	for (i = 0; i < PD692X0_MAX_LOGICAL_PORTS; i++) {
> +		port_matrix[i].hw_port_a = 0xff;
> +		port_matrix[i].hw_port_b = 0xff;
> +	}
> +
> +	/* Update with values from DT */
> +	for (i = 0; i < ports_matrix_size; i += 3) {
> +		unsigned int logical_port;
> +
> +		if (val[i] >= PD692X0_MAX_LOGICAL_PORTS) {
> +			dev_err(dev, "Not valid ports-matrix property\n");
> +			return -EINVAL;
> +		}
> +		logical_port = val[i];
> +
> +		if (val[i + 1] < PD692X0_MAX_HW_PORTS)
> +			port_matrix[logical_port].hw_port_a = val[i + 1];
> +
> +		if (val[i + 2] < PD692X0_MAX_HW_PORTS)
> +			port_matrix[logical_port].hw_port_b = val[i + 2];
> +	}
> +
> +	return 0;
> +}
> +
> +static int pd692x0_update_matrix(struct pd692x0_priv *priv)
> +{
> +	struct matrix port_matrix[PD692X0_MAX_LOGICAL_PORTS];
> +	struct device *dev = &priv->client->dev;
> +	int ret;
> +
> +	ret = pd692x0_get_of_matrix(dev, port_matrix);
> +	if (ret < 0) {
> +		dev_warn(dev,
> +			 "Unable to parse port-matrix, saved matrix will be used\n");
> +		return 0;
> +	}
> +
> +	ret = pd692x0_set_ports_matrix(priv, port_matrix);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +#define PD692X0_FW_LINE_MAX_SZ 0xff

That probably works. Most linkers producing SREC output do limit
themselves to lines of 80 charactors max. But the SREC format actually
allows longer lines.

> +static int pd692x0_fw_get_next_line(const u8 *data,
> +				    char *line, size_t size)
> +{
> +	size_t line_size;
> +	int i;
> +
> +	line_size = min_t(size_t, size, (size_t)PD692X0_FW_LINE_MAX_SZ);
> +
> +	memset(line, 0, PD692X0_FW_LINE_MAX_SZ);
> +	for (i = 0; i < line_size - 1; i++) {
> +		if (*data == '\r' && *(data + 1) == '\n') {
> +			line[i] = '\r';
> +			line[i + 1] = '\n';
> +			return i + 2;
> +		}

Does the Vendor Documentation indicate Windoze line endings will
always be used? Motorola SREC allow both Windows or rest of the world
line endings to be used. 

> +static enum fw_upload_err pd692x0_fw_poll_complete(struct fw_upload *fwl)
> +{
> +	struct pd692x0_priv *priv = fwl->dd_handle;
> +	const struct i2c_client *client = priv->client;
> +	struct pd692x0_msg_ver ver;
> +	int ret;
> +
> +	priv->fw_state = PD692X0_FW_COMPLETE;
> +
> +	ret = pd692x0_fw_reset(client);
> +	if (ret)
> +		return ret;
> +
> +	ver = pd692x0_get_sw_version(priv);
> +	if (ver.maj_sw_ver != PD692X0_FW_MAJ_VER) {

That is probably too strong a condition. You need to allow firmware
upgrades, etc. Does it need to be an exact match, or would < be
enough?

w> +	if (ver.maj_sw_ver != PD692X0_FW_MAJ_VER) {
> +		dev_err(dev, "Too old firmware version. Please update it\n");
> +		priv->fw_state = PD692X0_FW_NEED_UPDATE;

Same here.

     Andrew
