Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874597F28DF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjKUJZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbjKUJZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:25:34 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BE32D79;
        Tue, 21 Nov 2023 01:24:32 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507bd644a96so7497654e87.3;
        Tue, 21 Nov 2023 01:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700558670; x=1701163470; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQ6DLGxkIkFU3HRsA7T5dzcptPhq9KaRwLqwuRCVi+Q=;
        b=E/Alva4CwFKMvAWUp/f1lLb5d8v7JiFjfA9hD31zzV2Q/1vIwHLBojW5RVQfnQisL2
         eN2E732R7ie/fL6+fVairMOQp1iuAxxq0MDmEKk9uxDKkjuP4bR/yjIz4wlgzNPjTDp4
         nD+/0uE20UXNrb7ptWocQOuqrycXnc2/F/A5NSJNBn6dVlrn1BgmNLQht6UWURVP3ox+
         gvhRVa1zgaGVHwfU5gdIoKgQ7t1ctJFe5qOnQhRhXUvAekhy9H//2sWt5b7KgwLrX+T1
         4OH/Hddr1Rb5dczAi0hRrAZZxDbDTWGlpdTcSBRtuj0JmylygPY4JUotoPP+tbECld9n
         f/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700558670; x=1701163470;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lQ6DLGxkIkFU3HRsA7T5dzcptPhq9KaRwLqwuRCVi+Q=;
        b=bBLNIJvdwTvDQYUP7qHKvVE8fcRX2IDRbz4PH51FJH/2kiCX/JMlAh1FgHrHWb+nSd
         HQXL6lH+4a4DhPTc/U3UXi+VfGU3tbmnQnjFuO99PN6E+PdZNrINsnjZjkh3my9qgyRy
         pAhSH/mpDKJHME8/DIIhDI97d7nqGoXP9sQHomIrPC/7hGP9TfEP/5ioV3ntxo9hJujx
         vcsAzcmtGu8mwOUZOxvZSypL3AWCJxrLXmLQMrxdRhMs2Sl5tNo4SGJnke+7MAehe0Mc
         7g6moUhQ4MYghAcG/ks51ecMLNRcaZisdvCj9qP5I+DfpmoFXJ6T1c4CY/BPxeBqnAme
         jpwg==
X-Gm-Message-State: AOJu0Yy+YmipjX/nifkpeuiy/0n1Cz9eov4fk0LGhMwati7dwIIvK2pp
        1NHPoDCCO0ACsTVJGKSyv8wcJbKZRYH4Nw==
X-Google-Smtp-Source: AGHT+IH3NsigeAnMIUBIcoWP9F71idnAemVeO7dDHXF12jSgtDL5pYx+JievGI704BmzgB/y3zDLqA==
X-Received: by 2002:a19:c217:0:b0:507:aa44:28fa with SMTP id l23-20020a19c217000000b00507aa4428famr7202181lfc.26.1700558670135;
        Tue, 21 Nov 2023 01:24:30 -0800 (PST)
Received: from [192.168.1.103] ([31.173.81.93])
        by smtp.gmail.com with ESMTPSA id p20-20020ac24ed4000000b00507b869b068sm1466248lfr.302.2023.11.21.01.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 01:24:29 -0800 (PST)
Subject: Re: [PATCH 2/2] usb: typec: tcpm: Parse Accessory Mode information
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20231120231757.2309482-1-dmitry.baryshkov@linaro.org>
 <20231120231757.2309482-3-dmitry.baryshkov@linaro.org>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <1421f23b-20c5-dbdd-8964-4c4cb37b1a96@gmail.com>
Date:   Tue, 21 Nov 2023 12:24:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20231120231757.2309482-3-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/23 2:11 AM, Dmitry Baryshkov wrote:

> Some of the boards supported by the TCPM drivers can support USB-C
> Accessory Modes (Analog Audio, Debug). Parse information about supported
> modes from the device tree.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 6e843c511b85..6297f803de53 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -6114,6 +6114,7 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>  {
>  	const char *opmode_str;
>  	int ret;
> +	int mode;
>  	u32 mw, frs_current;
>  
>  	if (!fwnode)
> @@ -6132,6 +6133,12 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>  	if (ret < 0)
>  		return ret;
>  
> +	if (fwnode_property_read_bool(fwnode, "accessory-mode-audio"))
> +		port->typec_caps.accessory[mode++] = TYPEC_ACCESSORY_AUDIO;
> +
> +	if (fwnode_property_read_bool(fwnode, "accessory-mode-debug"))
> +		port->typec_caps.accessory[mode++] = TYPEC_ACCESSORY_DEBUG;
> +

   Hm, I don't see where that mode variable is initialized?

[...]

MBR, Sergey
