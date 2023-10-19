Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3571A7CFF80
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbjJSQ0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSQ0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:26:37 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FE9119
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:26:31 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4084de32db5so2965335e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697732790; x=1698337590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wh6i6kjw/IrUvRTQsZubF/CVyHBmvJLo/KFurkfeXZU=;
        b=WKG+nnrTTbB1Fj7UTNUdWuN/Byv2tl3T4D7cjCOAR4hfJ60Uv91/SsPRSKVVKbZymI
         wwdoRr3HuiNMsRZnXpyn72dQQZCQIm78/py+PDmFV7riSDFHH+yr4FPyF8Qp+6KKtphd
         Ix/VhdevtRXORm+y7w9cjvvQD4bN/8NT/A3zZGWquhv9TjTyzweN9Mtp/UijKPmEyagX
         fMTgGDFKh4aNwu5GWYLS/3fGKUCO8j8Sw1bjP2O0M/L8/fpN0HeDC+zU7jhtU0jxxJWw
         SP+CHJYXT/DRPiIsYmvjLMlzJR2/ueRk2C91VflslJAbrKm88AT7WUhjG9mBQ+ljKWZx
         aooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697732790; x=1698337590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wh6i6kjw/IrUvRTQsZubF/CVyHBmvJLo/KFurkfeXZU=;
        b=hsrrbok7qRKoQBr0HWUmZGfLHgdY6/pFV0VABCvYrercqrBiL+yEDHbqRtaMrt34tE
         Mv7jViEjUvI7qTmaeZtsiR7WK9EZRp0QnexG6CqgzFPCxVp1nhSRLZJM9LzUACPx45a/
         q6q3JWsh+r117BYiGzyS+3B5ZDr7ug3PDxhS3F3CtTgyLLWIyVWodEM9CjYZ+VgcDipT
         CSG8hQuAI11wkdYGNMtkZUgIkBLR5T4w9mKJenxddjXR4qgNarsuB6GkNFnvpTBjZaZE
         5WeeY14v0z5QyncWQZmwQ9KvN8UrwDVTK5P1Brn2E51Ep3ynBeKs83sJ09FlQwinF+TK
         Qeqw==
X-Gm-Message-State: AOJu0Yyqa6OAzaIvC6JsCKJrUfpzbhbysozFjcyaqmXX+C+dngwoZm46
        yEhGojQ5g1pKfWPRDCdERNYxlw==
X-Google-Smtp-Source: AGHT+IHIPZr477OgepS79IUkR1E9LQDeJwqb7faAfPdDQxpY8JSWfrb7M3KxNxAIBgpsgWv0A9tLBA==
X-Received: by 2002:a05:600c:4591:b0:406:8491:ec2 with SMTP id r17-20020a05600c459100b0040684910ec2mr2320133wmo.15.1697732789639;
        Thu, 19 Oct 2023 09:26:29 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n11-20020a05600c3b8b00b004068de50c64sm4894803wms.46.2023.10.19.09.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 09:26:29 -0700 (PDT)
Date:   Thu, 19 Oct 2023 19:26:26 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] i40e: add an error code check in i40e_vsi_setup
Message-ID: <24585602-11ef-4c08-8c56-56a70c1a971c@kadam.mountain>
References: <20231019084241.1529662-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019084241.1529662-1-suhui@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 04:42:42PM +0800, Su Hui wrote:
> check the value of 'ret' after calling 'i40e_vsi_config_rss'.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index de7fd43dc11c..9205090e5017 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -14567,6 +14567,8 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
>  	if ((pf->hw_features & I40E_HW_RSS_AQ_CAPABLE) &&
>  	    (vsi->type == I40E_VSI_VMDQ2)) {
>  		ret = i40e_vsi_config_rss(vsi);
> +		if (ret)
> +			goto err_rings;

This function uses Come From label names.  Instead of telling you what
the function/goto does it tells you where it is called from.  Here
"err_rings" means that the rings allocation failed.  However, the rings
allocation actually succeeded and we need to free it
with i40e_vsi_clear_rings().

What clean up we need to do depends on vsi->type as well but here
we know the type is vsi->type == I40E_VSI_VMDQ2 so it's needs to call
the i40e_vsi_clear_rings().

regards,
dan carpenter
