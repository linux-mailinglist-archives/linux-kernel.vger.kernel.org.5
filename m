Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069AF80AB0C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbjLHRqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjLHRqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:46:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A2EF4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702057577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eK8WutytSz3F60Rl2nxPhK1kwwDpKHRRkbGPCAgiMXQ=;
        b=MXtx457EqFCGzsIW9WNSC5wIR4sjPEF7+dgis521BQ0+FoG2BhM3E1DrgC1uhFk8Qq8cW5
        F/3qmGAVO8daNTHRJ4gX91p4NAVwC1VYyZn+22GhZJHo1+vKcTpg3LEGgmxZ4AUwX2SrX7
        NgkEZPky4eCTxxsnJwKywgjHNahYuGo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-uyml8AF6PWKqbUL8YiCgjQ-1; Fri, 08 Dec 2023 12:46:14 -0500
X-MC-Unique: uyml8AF6PWKqbUL8YiCgjQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-77f38f2f6fbso348064885a.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 09:46:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702057574; x=1702662374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eK8WutytSz3F60Rl2nxPhK1kwwDpKHRRkbGPCAgiMXQ=;
        b=v/4XQPthIhhbB1140koggRqbbiM2fuRZ8w3wuJtgaBYxqK0K+A6WVo4C6uJw8NkxEH
         iMeKgLwMZH3M4gk48ZXE0d+9mmjTbYEZ2WWjXiEM8HH7rhhz5jWf7o42KOYgGzzDrswA
         IkUy8TNQ/Hr1RaWKFVKmIlZRo/aToKzFkXMXcvlzjtwVvtvv11zwblXJUWzfuu3jImHN
         oL82s9c5FlbJ1Ytm/FwXqWTPkcpST9p/pCwGusxQRlj17OyRKn8UiVsnnqCU6E2l+53s
         T6Rcp7g1IX1dJn6bI/VKhMMGNu+71n4PvxOLZk2+cyPdl196XCjb0F/ABJOWtaqeksEx
         A7MA==
X-Gm-Message-State: AOJu0YzO+5PgYSCWMFo63xuseujmNfq0XO12xQirMMrqMqMN8/puWwmJ
        IV75RvfybO8cCLyDROqdPTiBQy+2owhwrDriXuneFIK67IGskiEES/S0yMCi7Jb+AlQrAYzdyKn
        5xtWlQ94a73UIt6P9UoF58sT9
X-Received: by 2002:a05:620a:24d6:b0:77f:56f7:8a8a with SMTP id m22-20020a05620a24d600b0077f56f78a8amr1178687qkn.20.1702057573952;
        Fri, 08 Dec 2023 09:46:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKpXkgN5JW84WjaqfJ/Jad2WtjBPYW0HrpnzHhaUBDSgtALPzLuH10yyRlapWlhpBegIs/HQ==
X-Received: by 2002:a05:620a:24d6:b0:77f:56f7:8a8a with SMTP id m22-20020a05620a24d600b0077f56f78a8amr1178678qkn.20.1702057573706;
        Fri, 08 Dec 2023 09:46:13 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id i19-20020a056214031300b0067aa164861dsm967730qvu.35.2023.12.08.09.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:46:13 -0800 (PST)
Date:   Fri, 8 Dec 2023 11:46:11 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com
Subject: Re: [PATCH v2 14/17] scsi: ufs: qcom: Simplify
 ufs_qcom_{assert/deassert}_reset
Message-ID: <uz6ely7fzsejqnrelmqtqt4lofjvcfxxywro6ae2lfbrfnqtpl@rnyneul7eazo>
References: <20231208065902.11006-1-manivannan.sadhasivam@linaro.org>
 <20231208065902.11006-15-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208065902.11006-15-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 12:28:59PM +0530, Manivannan Sadhasivam wrote:
> In both the functions, UFS_PHY_SOFT_RESET contains the mask of the reset
> bit. So this can be passed directly as the value to be written for
> asserting the reset. For deasserting, 0 can be passed.
> 
> This gets rid of the FIELD_PREP() inside these functions and also
> UFS_PHY_RESET_{ENABLE/DISABLE} definitions.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  drivers/ufs/host/ufs-qcom.h | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index 53db424a0bcb..a109d3359db4 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -92,9 +92,6 @@ enum {
>  #define TEST_BUS_SEL		GENMASK(22, 19)
>  #define UFS_REG_TEST_BUS_EN	BIT(30)
>  
> -#define UFS_PHY_RESET_ENABLE	1
> -#define UFS_PHY_RESET_DISABLE	0
> -
>  /* bit definitions for REG_UFS_CFG2 register */
>  #define UAWM_HW_CGC_EN		BIT(0)
>  #define UARM_HW_CGC_EN		BIT(1)
> @@ -157,8 +154,7 @@ ufs_qcom_get_controller_revision(struct ufs_hba *hba,
>  
>  static inline void ufs_qcom_assert_reset(struct ufs_hba *hba)
>  {
> -	ufshcd_rmwl(hba, UFS_PHY_SOFT_RESET, FIELD_PREP(UFS_PHY_SOFT_RESET, UFS_PHY_RESET_ENABLE),
> -		    REG_UFS_CFG1);
> +	ufshcd_rmwl(hba, UFS_PHY_SOFT_RESET, UFS_PHY_SOFT_RESET, REG_UFS_CFG1);
>  
>  	/*
>  	 * Make sure assertion of ufs phy reset is written to
> @@ -169,8 +165,7 @@ static inline void ufs_qcom_assert_reset(struct ufs_hba *hba)
>  
>  static inline void ufs_qcom_deassert_reset(struct ufs_hba *hba)
>  {
> -	ufshcd_rmwl(hba, UFS_PHY_SOFT_RESET, FIELD_PREP(UFS_PHY_SOFT_RESET, UFS_PHY_RESET_DISABLE),
> -		    REG_UFS_CFG1);
> +	ufshcd_rmwl(hba, UFS_PHY_SOFT_RESET, 0, REG_UFS_CFG1);
>  
>  	/*
>  	 * Make sure de-assertion of ufs phy reset is written to
> -- 
> 2.25.1
> 

