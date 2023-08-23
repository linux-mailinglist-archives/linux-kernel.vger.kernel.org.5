Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836327859AE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbjHWNpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbjHWNpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:45:36 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618EFCDF;
        Wed, 23 Aug 2023 06:45:30 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68a529e1974so2418587b3a.3;
        Wed, 23 Aug 2023 06:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692798330; x=1693403130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qqdn+eOwDUqSX9HrghP3tS5DzqU2avN1+WRRwdx99Js=;
        b=hLJpuKTtjaONqbib32Jk9AKS4bEsu90BjNMcRCBCALCCDiXJJ6f/QApHOHP4pdA6za
         RkwcUjmdj9A/+GiWCo+Pcp5PpMuXHlPXUIV5YsHb5/UPvrs03FFfummHqI6laWILo8ZI
         WBLHLeZjt0aJBCowoV1hphfhH0sL4biT1q40I+/vLazZWFC6oVyZeDwc36Cs25WF5gWY
         +cz218TOqpbtzqTR5vikezBoc41cniCnLm+ZeAXeT5BeV6U424j0I4VUp6Yk6r9uEWmF
         Egz+mk+f0+Rydbmu5zMNLWG+vwx3/TqbbemZeK065uSCvZF5rjb3dnMAJLcGEAuTAXeQ
         fUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692798330; x=1693403130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qqdn+eOwDUqSX9HrghP3tS5DzqU2avN1+WRRwdx99Js=;
        b=JLosluxucioQhD9DUg7HS4xGqnPyLprAP5EGGYuC5KP/5MLnZ7AdKGeAKK4DPvtyeR
         JelGAgsGnMlxnc42n/KEgd3rLspWzoPMFxIbFE+rj64/qgs09JhYx25QrmciwGon2Yv4
         CQXDfK9B10T8OoxM3Smx06AxU3E2lSIIq7dh4CjYQ2igtB4EBvSVIenm/ALjP/KloPk2
         HhYa3hOPvo1ONj/0Lwo5Pk75a2ToW9LLn6ThMqeiaarTcSfLaqIiUnWJ23pwk+w6BfUH
         mNwXqxDTnTrSVVWvbngZTLtnzP8s2F9Cn+e1Dlqwgo7ghVkUpKrHCTARrvC8x+djBL+s
         KXeg==
X-Gm-Message-State: AOJu0YwcGsMpdwrYRiTqNUQfJstEClLN2Mp53iNwcYSGQMBnrZ61cSuv
        HB6A4LI9Dijvbj8K9mCv9v0=
X-Google-Smtp-Source: AGHT+IE+ty57Edcmaz1RstJ5Tca3n71GgSn53PxAW5EcMatyag/vRjKbAoWbWHlWnvympXNgFwUCog==
X-Received: by 2002:a05:6a00:b55:b0:68b:a137:373f with SMTP id p21-20020a056a000b5500b0068ba137373fmr3914064pfo.33.1692798329675;
        Wed, 23 Aug 2023 06:45:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n15-20020aa78a4f000000b00682a27905b9sm6003348pfa.13.2023.08.23.06.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:45:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 23 Aug 2023 06:45:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     quic_huliu@quicinc.com
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_fenglinw@quicinc.com,
        subbaram@quicinc.com
Subject: Re: [PATCH] usb: typec: qcom: check regulator enable status before
 disabling it
Message-ID: <84beb263-306e-4b93-8bf4-291085584e06@roeck-us.net>
References: <20230823-qcom-tcpc-v1-1-fa81a09ca056@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823-qcom-tcpc-v1-1-fa81a09ca056@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 05:15:53PM +0800, Hui Liu via B4 Relay wrote:
> From: Hui Liu <quic_huliu@quicinc.com>
> 
> Check regulator enable status before disabling it to avoid
> unbalanced regulator disable warnings.
> 
> Signed-off-by: Hui Liu <quic_huliu@quicinc.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> index bb0b8479d80f..ca616b17b5b6 100644
> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> @@ -422,7 +422,8 @@ static int qcom_pmic_typec_pdphy_disable(struct pmic_typec_pdphy *pmic_typec_pdp
>  	ret = regmap_write(pmic_typec_pdphy->regmap,
>  			   pmic_typec_pdphy->base + USB_PDPHY_EN_CONTROL_REG, 0);
>  
> -	regulator_disable(pmic_typec_pdphy->vdd_pdphy);
> +	if (regulator_is_enabled(pmic_typec_pdphy->vdd_pdphy))
> +		regulator_disable(pmic_typec_pdphy->vdd_pdphy);
>  
>  	return ret;
>  }
> 
> ---
> base-commit: bbb9e06d2c6435af9c62074ad7048910eeb2e7bc
> change-id: 20230822-qcom-tcpc-d41954ac65fa
> 
> Best regards,
> -- 
> Hui Liu <quic_huliu@quicinc.com>
> 
