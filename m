Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FD17DB4C2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjJ3IF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjJ3IFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:05:55 -0400
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5527FC9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 01:05:46 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id xNHKqXbMchjcfxNHKq5hVe; Mon, 30 Oct 2023 09:05:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698653144;
        bh=eQeOxn3lchQjy9IwIOUUEredww/rqkL2X7LAfreMOiQ=;
        h=Date:Subject:Cc:References:From:To:In-Reply-To;
        b=bLXibatjRS5tWgqTWfDNAAz0gLqWsSbpcYGOnLBlQd5HQ3ksEwjRy8mhW75WwaxtL
         jU85TaDGWgz6zHlCz257bqbDg8wbK8CA2w36swL4HYhZhgm144T39xncBYt0FzCzJk
         8ouf/Z7SQZrUlXhQq4USRsbi0MO6ElyMlJCBw+aup2AWpGoUB0J/J7ZBprZm0LOBJp
         bADnpD1Qk5JLVZdIxUX5daJVJbo7gpnMs+z1BmNZEFo0OBuGwnnClg/RYBcjSGeb60
         IiQwHqeJ65+Zm5B6Aw9Bqt/VYCNxzTc6U4zDhpf5NHEPFIsKnrNrodwL108m+OtEt+
         6cJ8xGH+YgIKw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 30 Oct 2023 09:05:44 +0100
X-ME-IP: 86.243.2.178
Message-ID: <6654879e-f577-4e0c-a00a-0ee45d379b51@wanadoo.fr>
Date:   Mon, 30 Oct 2023 09:05:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] usb: dwc3: add Realtek DHC RTD SoC dwc3 glue layer
 driver
Content-Language: fr
Cc:     Thinh.Nguyen@synopsys.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org
References: <20230826031028.1892-1-stanley_chang@realtek.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     stanley_chang@realtek.com
In-Reply-To: <20230826031028.1892-1-stanley_chang@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 26/08/2023 à 05:10, Stanley Chang a écrit :
> Realtek DHC RTD SoCs integrate dwc3 IP and has some customizations to
> support different generations of SoCs.
> 
> The RTD1619b subclass SoC only supports USB 2.0 from dwc3. The driver
> can set a maximum speed to support this. Add role switching function,
> that can switch USB roles through other drivers, or switch USB roles
> through user space through set /sys/class/usb_role/.
> 
> Signed-off-by: Stanley Chang <stanley_chang-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>
> Acked-by: Thinh Nguyen <Thinh.Nguyen-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
> ---

...

> +static int dwc3_rtk_probe_dwc3_core(struct dwc3_rtk *rtk)
> +{
> +	struct device *dev = rtk->dev;
> +	struct device_node *node = dev->of_node;
> +	struct platform_device *dwc3_pdev;
> +	struct device *dwc3_dev;
> +	struct device_node *dwc3_node;
> +	enum usb_dr_mode dr_mode;
> +	int ret = 0;
> +
> +	ret = dwc3_rtk_init(rtk);
> +	if (ret)
> +		return -EINVAL;
> +
> +	ret = of_platform_populate(node, NULL, NULL, dev);
> +	if (ret) {
> +		dev_err(dev, "failed to add dwc3 core\n");
> +		return ret;
> +	}
> +
> +	dwc3_node = of_get_compatible_child(node, "snps,dwc3");
> +	if (!dwc3_node) {
> +		dev_err(dev, "failed to find dwc3 core node\n");
> +		ret = -ENODEV;
> +		goto depopulate;
> +	}
> +
> +	dwc3_pdev = of_find_device_by_node(dwc3_node);
> +	if (!dwc3_pdev) {
> +		dev_err(dev, "failed to find dwc3 core platform_device\n");
> +		ret = -ENODEV;
> +		goto err_node_put;
> +	}
> +
> +	dwc3_dev = &dwc3_pdev->dev;
> +	rtk->dwc = platform_get_drvdata(dwc3_pdev);
> +	if (!rtk->dwc) {
> +		dev_err(dev, "failed to find dwc3 core\n");
> +		ret = -ENODEV;
> +		goto err_pdev_put;
> +	}
> +
> +	dr_mode = usb_get_dr_mode(dwc3_dev);
> +	if (dr_mode != rtk->dwc->dr_mode) {
> +		dev_info(dev, "dts set dr_mode=%d, but dwc3 set dr_mode=%d\n",
> +			 dr_mode, rtk->dwc->dr_mode);
> +		dr_mode = rtk->dwc->dr_mode;
> +	}
> +
> +	switch (dr_mode) {
> +	case USB_DR_MODE_PERIPHERAL:
> +		rtk->cur_role = USB_ROLE_DEVICE;
> +		break;
> +	case USB_DR_MODE_HOST:
> +		rtk->cur_role = USB_ROLE_HOST;
> +		break;
> +	default:
> +		dev_dbg(rtk->dev, "%s: dr_mode=%d\n", __func__, dr_mode);
> +		break;
> +	}
> +
> +	if (device_property_read_bool(dwc3_dev, "usb-role-switch")) {
> +		ret = dwc3_rtk_setup_role_switch(rtk);
> +		if (ret) {
> +			dev_err(dev, "dwc3_rtk_setup_role_switch fail=%d\n", ret);
> +			goto err_pdev_put;
> +		}
> +		rtk->cur_role = dwc3_rtk_get_role(rtk);
> +	}
> +
> +	switch_usb2_role(rtk, rtk->cur_role);
> +
> +	return 0;
> +
> +err_pdev_put:
> +	platform_device_put(dwc3_pdev);
> +err_node_put:
> +	of_node_put(dwc3_node);
> +depopulate:
> +	of_platform_depopulate(dev);
> +
> +	return ret;
> +}
> +
> +static int dwc3_rtk_probe(struct platform_device *pdev)
> +{
> +	struct dwc3_rtk *rtk;
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	void __iomem *regs;
> +	int ret = 0;
> +
> +	rtk = devm_kzalloc(dev, sizeof(*rtk), GFP_KERNEL);
> +	if (!rtk) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	platform_set_drvdata(pdev, rtk);
> +
> +	rtk->dev = dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(dev, "missing memory resource\n");
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	regs = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(regs)) {
> +		ret = PTR_ERR(regs);
> +		goto out;
> +	}
> +
> +	rtk->regs = regs;
> +	rtk->regs_size = resource_size(res);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (res) {
> +		rtk->pm_base = devm_ioremap_resource(dev, res);
> +		if (IS_ERR(rtk->pm_base)) {
> +			ret = PTR_ERR(rtk->pm_base);
> +			goto out;
> +		}
> +	}
> +
> +	ret = dwc3_rtk_probe_dwc3_core(rtk);
> +
> +out:
> +	return ret;
> +}
> +
> +static void dwc3_rtk_remove(struct platform_device *pdev)
> +{
> +	struct dwc3_rtk *rtk = platform_get_drvdata(pdev);
> +
> +	rtk->dwc = NULL;
> +
> +	dwc3_rtk_remove_role_switch(rtk);
> +

Hi,

Is something like
	platform_device_put(dwc3_pdev);
	of_node_put(dwc3_node);
needed in the remove function?

(as done in the error handling path of dwc3_rtk_probe_dwc3_core())

Or should it be added at the end of dwc3_rtk_probe_dwc3_core() if the 
reference are nor needed anymore when we leave the function?

CJ

> +	of_platform_depopulate(rtk->dev);
> +}
> +

...

