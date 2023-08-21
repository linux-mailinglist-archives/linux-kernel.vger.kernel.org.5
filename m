Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95554782615
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbjHUJMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjHUJMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:12:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676ADC4;
        Mon, 21 Aug 2023 02:12:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBA7960EF3;
        Mon, 21 Aug 2023 09:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344E4C433C8;
        Mon, 21 Aug 2023 09:12:05 +0000 (UTC)
Message-ID: <a834b202-7d5c-2a04-fc69-1913cd063a67@xs4all.nl>
Date:   Mon, 21 Aug 2023 11:12:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 7/9] media: cros-ec-cec: Allow specifying multiple HDMI
 connectors
Content-Language: en-US, nl
To:     Reka Norman <rekanorman@chromium.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Stefan Adolfsson <sadolfsson@google.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
References: <20230814043140.1108917-1-rekanorman@chromium.org>
 <20230814043140.1108917-8-rekanorman@chromium.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230814043140.1108917-8-rekanorman@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reka,

On 14/08/2023 06:29, Reka Norman wrote:
> Update the cec_dmi_match_table to allow specifying multiple HDMI
> connectors for each device.
> 
> Signed-off-by: Reka Norman <rekanorman@chromium.org>
> ---
> 
>  .../media/cec/platform/cros-ec/cros-ec-cec.c  | 47 +++++++++++--------
>  1 file changed, 28 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> index c68ed5d4bda0..f2f397d9a6d8 100644
> --- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> +++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> @@ -284,38 +284,41 @@ static SIMPLE_DEV_PM_OPS(cros_ec_cec_pm_ops,
>  #if IS_ENABLED(CONFIG_PCI) && IS_ENABLED(CONFIG_DMI)
>  
>  /*
> - * The Firmware only handles a single CEC interface tied to a single HDMI
> - * connector we specify along with the DRM device name handling the HDMI output
> + * Specify the DRM device name handling the HDMI output and the HDMI connector
> + * corresponding to each CEC port. The order of connectors must match the order
> + * in the EC (first connector is EC port 0, ...), and the number of connectors
> + * must match the number of ports in the EC (which can be queried using the
> + * EC_CMD_CEC_PORT_COUNT host command).
>   */
>  
>  struct cec_dmi_match {
>  	const char *sys_vendor;
>  	const char *product_name;
>  	const char *devname;
> -	const char *conn;
> +	const char *conns[EC_CEC_MAX_PORTS];

Since EC_CEC_MAX_PORTS is 16, this will waste a lot of space here.

I would suggest creating a separate define (CEC_MAX_PORTS?) that is set
to 2 and is the max port that is actually used.

When you get the actual number of ports from the EC you can check if
CEC_MAX_PORTS isn't too small and return an error if it is.

You can use CEC_MAX_PORTS here and in the ports array of struct cros_ec_cec.

Regards,

	Hans

>  };
>  
>  static const struct cec_dmi_match cec_dmi_match_table[] = {
>  	/* Google Fizz */
> -	{ "Google", "Fizz", "0000:00:02.0", "Port B" },
> +	{ "Google", "Fizz", "0000:00:02.0", { "Port B" } },
>  	/* Google Brask */
> -	{ "Google", "Brask", "0000:00:02.0", "Port B" },
> +	{ "Google", "Brask", "0000:00:02.0", { "Port B" } },
>  	/* Google Moli */
> -	{ "Google", "Moli", "0000:00:02.0", "Port B" },
> +	{ "Google", "Moli", "0000:00:02.0", { "Port B" } },
>  	/* Google Kinox */
> -	{ "Google", "Kinox", "0000:00:02.0", "Port B" },
> +	{ "Google", "Kinox", "0000:00:02.0", { "Port B" } },
>  	/* Google Kuldax */
> -	{ "Google", "Kuldax", "0000:00:02.0", "Port B" },
> +	{ "Google", "Kuldax", "0000:00:02.0", { "Port B" } },
>  	/* Google Aurash */
> -	{ "Google", "Aurash", "0000:00:02.0", "Port B" },
> +	{ "Google", "Aurash", "0000:00:02.0", { "Port B" } },
>  	/* Google Gladios */
> -	{ "Google", "Gladios", "0000:00:02.0", "Port B" },
> +	{ "Google", "Gladios", "0000:00:02.0", { "Port B" } },
>  	/* Google Lisbon */
> -	{ "Google", "Lisbon", "0000:00:02.0", "Port B" },
> +	{ "Google", "Lisbon", "0000:00:02.0", { "Port B" } },
>  };
>  
>  static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
> -						const char **conn)
> +						const char * const **conns)
>  {
>  	int i;
>  
> @@ -332,7 +335,7 @@ static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
>  			if (!d)
>  				return ERR_PTR(-EPROBE_DEFER);
>  			put_device(d);
> -			*conn = m->conn;
> +			*conns = m->conns;
>  			return d;
>  		}
>  	}
> @@ -346,7 +349,7 @@ static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
>  #else
>  
>  static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
> -						const char **conn)
> +						const char * const **conns)
>  {
>  	return ERR_PTR(-ENODEV);
>  }
> @@ -388,7 +391,7 @@ static int cros_ec_cec_get_write_cmd_version(struct cros_ec_cec *cros_ec_cec)
>  static int cros_ec_cec_init_port(struct device *dev,
>  				 struct cros_ec_cec *cros_ec_cec,
>  				 int port_num, struct device *hdmi_dev,
> -				 const char *conn)
> +				 const char * const *conns)
>  {
>  	struct cros_ec_cec_port *port;
>  	int ret;
> @@ -406,7 +409,13 @@ static int cros_ec_cec_init_port(struct device *dev,
>  	if (IS_ERR(port->adap))
>  		return PTR_ERR(port->adap);
>  
> -	port->notify = cec_notifier_cec_adap_register(hdmi_dev, conn,
> +	if (!conns[port_num]) {
> +		dev_err(dev, "no conn for port %d\n", port_num);
> +		ret = -ENODEV;
> +		goto out_probe_adapter;
> +	}
> +
> +	port->notify = cec_notifier_cec_adap_register(hdmi_dev, conns[port_num],
>  						      port->adap);
>  	if (!port->notify) {
>  		ret = -ENOMEM;
> @@ -435,10 +444,10 @@ static int cros_ec_cec_probe(struct platform_device *pdev)
>  	struct cros_ec_cec *cros_ec_cec;
>  	struct cros_ec_cec_port *port;
>  	struct device *hdmi_dev;
> -	const char *conn = NULL;
> +	const char * const *conns = NULL;
>  	int ret;
>  
> -	hdmi_dev = cros_ec_cec_find_hdmi_dev(&pdev->dev, &conn);
> +	hdmi_dev = cros_ec_cec_find_hdmi_dev(&pdev->dev, &conns);
>  	if (IS_ERR(hdmi_dev))
>  		return PTR_ERR(hdmi_dev);
>  
> @@ -460,7 +469,7 @@ static int cros_ec_cec_probe(struct platform_device *pdev)
>  
>  	for (int i = 0; i < cros_ec_cec->num_ports; i++) {
>  		ret = cros_ec_cec_init_port(&pdev->dev, cros_ec_cec, i,
> -					    hdmi_dev, conn);
> +					    hdmi_dev, conns);
>  		if (ret)
>  			goto unregister_ports;
>  	}

