Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD1D807868
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 20:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379273AbjLFTL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 14:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379234AbjLFTL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 14:11:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC6AEE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 11:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701889891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rdbwGcL3xfTd0SQ2ofmFtSrkLP5S7WJXgHm5WJg2yPQ=;
        b=CIL4zGptTVHfqpOrzTHbLn6PI2QfTX9uIF3EOUbBO9azhlHUaE0F1LmZzubZnbZk5RQCuo
        El8fm3GIbhgUk8xsD1Kr0+falqXEvUwWyMFXnL3um+8Qg6cv03LalAdeIuvbexQAllsxKZ
        zu8j1hxVqSnqD6EjF0yjkPMUrZgo+Pg=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-enxDxbUxO26wsDd7Qu4uzg-1; Wed, 06 Dec 2023 13:43:34 -0500
X-MC-Unique: enxDxbUxO26wsDd7Qu4uzg-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-58d5604c050so66358eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 10:43:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701888214; x=1702493014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdbwGcL3xfTd0SQ2ofmFtSrkLP5S7WJXgHm5WJg2yPQ=;
        b=vZJEirFwiQgQ2AeMwcI4qD/ZzFZqPds0h1yvbd/vgwTGEyraES1AlyJlwHLFDBI7z6
         KBpHoSjCU/v4fF8eJwzjEHbGOKWo4SJf4ZQOpls3DWyjFjjs/4qXnyqtg5aRXa2PSunu
         tczWhuO9p3qxMM19URo3cWpvkdRgoBBRFaXe7jCl6Y3bJvfWrly9ZSMmnjF48ozPnpMO
         UWmx1sn6pVDqogaqCSRGOHff4koMob8Mj+D/RVgcZmZNab+kwSio/GIT6G3UVDRQHBbG
         B/fmFaiWIYOr/pnFJXQPcPcwW3nwN3TKHiEH6kATlw3WzrAVG9VpoERyNpdut1tQLL9q
         1gPA==
X-Gm-Message-State: AOJu0Yzlwg8fyjFtBGh4hPsTPlwMiqKHzHo8/GXYmMNbZUhV2hzmKQ2b
        npw+EZ75IyRKHidxFpo7wfggOVEoY/D4AULMhavZEi3v37nyXl1Xa4GCMOGKZwmLCk7A0yEVcoc
        oI6YcPL8dVrF7NRax2XCFi//v
X-Received: by 2002:a05:6358:91a6:b0:16d:aead:f74f with SMTP id j38-20020a05635891a600b0016daeadf74fmr894783rwa.13.1701888214072;
        Wed, 06 Dec 2023 10:43:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZve0jDN+whXG9Fyrygjtk5nDhHS4D1oiR1nOY5YrJFkYaAmPCNcVIlXYPMaf+xGLMIHTxNQ==
X-Received: by 2002:a05:6358:91a6:b0:16d:aead:f74f with SMTP id j38-20020a05635891a600b0016daeadf74fmr894768rwa.13.1701888213764;
        Wed, 06 Dec 2023 10:43:33 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id bz6-20020ad44c06000000b0067a2a621fadsm183188qvb.53.2023.12.06.10.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 10:43:33 -0800 (PST)
Date:   Wed, 6 Dec 2023 12:43:31 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com
Subject: Re: [PATCH 08/13] scsi: ufs: qcom: Check the return value of
 ufs_qcom_power_up_sequence()
Message-ID: <7ch3mroun3pnaxpej4orlukotdrrnzdkuts6rzjruk4hghtira@x7txcjve56wb>
References: <20231201151417.65500-1-manivannan.sadhasivam@linaro.org>
 <20231201151417.65500-9-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201151417.65500-9-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 08:44:12PM +0530, Manivannan Sadhasivam wrote:
> If ufs_qcom_power_up_sequence() fails, then it makes no sense to enable
> the lane clocks and continue ufshcd_hba_enable(). So let's check the return
> value of ufs_qcom_power_up_sequence().
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  drivers/ufs/host/ufs-qcom.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 4948dd732aae..e4dd3777a4d4 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -415,7 +415,10 @@ static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,
>  
>  	switch (status) {
>  	case PRE_CHANGE:
> -		ufs_qcom_power_up_sequence(hba);
> +		err = ufs_qcom_power_up_sequence(hba);
> +		if (err)
> +			return err;
> +
>  		/*
>  		 * The PHY PLL output is the source of tx/rx lane symbol
>  		 * clocks, hence, enable the lane clocks only after PHY
> -- 
> 2.25.1
> 
> 

