Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE81A808010
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 06:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjLGFSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 00:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjLGFSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 00:18:36 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF1CD53
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 21:18:42 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-28670a7ba84so472976a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 21:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701926321; x=1702531121; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0i9fCVWdp8675S0rpZslXHDfs7IhFjRrMa9ntmatNFw=;
        b=hlXRPPdyhTYYOaLEQlrtacYNVduZJoQLEWsWK1F6Lzlj5MTs31ReaC57eMKziuHYru
         NQcCy6+TZh1WDThAVEqRNP77BHLnPtEmQgDxFegRDKSK/ct0oY7jr7IRMnfeAiHV/rqX
         C/HPYZkij4SkqRtMi+evJeXHKyidY0q8s+YVDOuoXzFZaBFbK/hJ2bZLP7Ph74uhRMNn
         vl5iuSsuNQE7ot8gXvYjWNwvABPbPYWgeOqODKKuk8hUVJGvXsZldwDQnB6UBRzx0gQu
         H7mLh22yK23WCd0pgMjM8Y1KZGp2BYzfFwyU2o9E0PWYUeVunydJxZOQUKAfZyp60caf
         gHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701926321; x=1702531121;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0i9fCVWdp8675S0rpZslXHDfs7IhFjRrMa9ntmatNFw=;
        b=eYk8BEshbZmly1EcrqNILJs+RbmWiO1UgreSic4b+iJuT5i+SE/GqNsNFeS2lqaw3u
         Urfp9widGr972jTZ8P03KlBlwNmWEkXYSMNEL9shEt/rDJscIdYGtyR0MN8Rqq5Eawd0
         qqmK/t67RiBq8cj5oF9YdIRT57TzQl8OmeJp9YZZfg0uKvyrvwlka43VDl2ljlq0jRyW
         haUGJysP6nWbI3MpvbykWUeivawwgRm0izr+2cdI8nnZP3eh/4o/85SGB/FNOpayBhGP
         N4OkWHADFI/CM3GDHQ/dRbOG9aW+JXDyJko68KjaUgVKGoUpN1K31MN98nVMt2ePlKYV
         7uZA==
X-Gm-Message-State: AOJu0YzEDpAIJvdDfRzCMax11BiVnmMyjzcJDBDWjt3T/GcuTr16EOd+
        kWH/BbdyQhPpIUxPK4wyJWV+
X-Google-Smtp-Source: AGHT+IFDinIj0ePzDqdc1lVKsz5u851IMvfdtrGp+1wkUAw4kbBceg5pw5hiGidd8o9jy3RJCW8KMQ==
X-Received: by 2002:a17:90b:1289:b0:286:b484:a5ce with SMTP id fw9-20020a17090b128900b00286b484a5cemr1692666pjb.58.1701926321408;
        Wed, 06 Dec 2023 21:18:41 -0800 (PST)
Received: from thinkpad ([117.248.6.133])
        by smtp.gmail.com with ESMTPSA id gc4-20020a17090b310400b00288622137dfsm362540pjb.5.2023.12.06.21.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 21:18:40 -0800 (PST)
Date:   Thu, 7 Dec 2023 10:48:35 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com
Subject: Re: [PATCH 05/13] scsi: ufs: qcom: Remove the warning message when
 core_reset is not available
Message-ID: <20231207051835.GA2932@thinkpad>
References: <20231201151417.65500-1-manivannan.sadhasivam@linaro.org>
 <20231201151417.65500-6-manivannan.sadhasivam@linaro.org>
 <ru2zdpls5tx2wjt3oknqndikuc4we7d3haeawzrdyl7cbsycti@clx55b27nzvn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ru2zdpls5tx2wjt3oknqndikuc4we7d3haeawzrdyl7cbsycti@clx55b27nzvn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 12:36:41PM -0600, Andrew Halaney wrote:
> On Fri, Dec 01, 2023 at 08:44:09PM +0530, Manivannan Sadhasivam wrote:
> > core_reset is optional, so there is no need to warn the user if it is not
> > available (that too not while doing host reset each time).
> 
> What's the bit in the parenthesis mean here? I'm having a hard time
> following. Otherwise, this looks good to me.
> 

I was just mentioning that the core reset can happen multiple times depending on
the scenario, so it doesn't make sense to print a warning each time if the reset
was not available.

- Mani

> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/ufs/host/ufs-qcom.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> > index dc93b1c5ca74..d474de0739e4 100644
> > --- a/drivers/ufs/host/ufs-qcom.c
> > +++ b/drivers/ufs/host/ufs-qcom.c
> > @@ -296,10 +296,8 @@ static int ufs_qcom_host_reset(struct ufs_hba *hba)
> >  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> >  	bool reenable_intr;
> >  
> > -	if (!host->core_reset) {
> > -		dev_warn(hba->dev, "%s: reset control not set\n", __func__);
> > +	if (!host->core_reset)
> >  		return 0;
> > -	}
> >  
> >  	reenable_intr = hba->is_irq_enabled;
> >  	disable_irq(hba->irq);
> > -- 
> > 2.25.1
> > 
> > 
> 

-- 
மணிவண்ணன் சதாசிவம்
