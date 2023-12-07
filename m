Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA260808981
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442202AbjLGNud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442008AbjLGNub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:50:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0836410F3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 05:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701957037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R6axPfpwmuXoAc+1JQucNBxzliOnKigTAtXbyQTKh0Y=;
        b=SQulwZKRC2+y1cx8T0E99dboQzHePwEDboOurcexhZB8ofJ+5r3BwbMMKzlOy1fqf89C1+
        eavx+060eO9G/AZRE95ApkDJncq+B/Zvc90KVD0Cfyq6GZfG4W9Wdj8t7SDphT4PWMyE/x
        2h+Oq9qZ2TjTVtmQmLKhP8kcs1Cr26k=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-C9wgdougO2GAY3AwKVAzcw-1; Thu, 07 Dec 2023 08:50:35 -0500
X-MC-Unique: C9wgdougO2GAY3AwKVAzcw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-67ab70c547fso11614586d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 05:50:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701957035; x=1702561835;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R6axPfpwmuXoAc+1JQucNBxzliOnKigTAtXbyQTKh0Y=;
        b=vRm3+yHRYANpXhbpCs10qzlPE7kpNGsamyUOW6FBw1+PBzPmj4S49irZW0hPNDYSmv
         9OY0lUzqDwW/RwSzmW3nFo+1hm2TdTtG4Y8UMBA7S0UWxe47ZRjTN10tCo44+msAP62O
         cGNyNQhfV+aqp2CtvyXnTkG06ya+DhJ9/s9WnXJLh9Nmj0Yayjw8mVzB39E6fjqHIIpt
         bJ7qO2ZVlK5OtGsp8mSJxieRfkVesneRNp1QdlQHc1TzRWoULNUy/PSlagnnYlN4ezrb
         WwGYG+b0F0X5vG+qt5zNHZjoMnzLw/VEFzRNFEHP0TqozrUxZXJeNv0xLvPqgeYSJig2
         SXvQ==
X-Gm-Message-State: AOJu0YymjWts4Zl7580pc+fiXKco9et3vBDsKGEqLKJ+W+z3OiAmqS4r
        1dUXa3/KlSC7vU+TYKpH6Tw8Pf6IBOF5uADsf5UwtUvdCoTTiMWHpqAFWGGju4zHIclZpEUQ6Ot
        W/xZWb0rgLYO+V5A5GPvB8gvL
X-Received: by 2002:a0c:f351:0:b0:67a:b9a0:4319 with SMTP id e17-20020a0cf351000000b0067ab9a04319mr2406189qvm.19.1701957035079;
        Thu, 07 Dec 2023 05:50:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZBWZcIWJ2MV9pzVQHSh0yyNdjibmYG2gnxP3BG1CcupHTtfFwc+icr33hOoAThDYIiluJHg==
X-Received: by 2002:a0c:f351:0:b0:67a:b9a0:4319 with SMTP id e17-20020a0cf351000000b0067ab9a04319mr2406177qvm.19.1701957034833;
        Thu, 07 Dec 2023 05:50:34 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id d13-20020a0cea8d000000b0067a9d48fdc8sm501435qvp.19.2023.12.07.05.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 05:50:34 -0800 (PST)
Date:   Thu, 7 Dec 2023 07:50:32 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com
Subject: Re: [PATCH 05/13] scsi: ufs: qcom: Remove the warning message when
 core_reset is not available
Message-ID: <cg46pekffsfj2jwazgbv2y4nk5gqmivnksbczfgxlmdi76tx5o@lickjmmfiahw>
References: <20231201151417.65500-1-manivannan.sadhasivam@linaro.org>
 <20231201151417.65500-6-manivannan.sadhasivam@linaro.org>
 <ru2zdpls5tx2wjt3oknqndikuc4we7d3haeawzrdyl7cbsycti@clx55b27nzvn>
 <20231207051835.GA2932@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231207051835.GA2932@thinkpad>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 10:48:35AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Dec 06, 2023 at 12:36:41PM -0600, Andrew Halaney wrote:
> > On Fri, Dec 01, 2023 at 08:44:09PM +0530, Manivannan Sadhasivam wrote:
> > > core_reset is optional, so there is no need to warn the user if it is not
> > > available (that too not while doing host reset each time).
> > 
> > What's the bit in the parenthesis mean here? I'm having a hard time
> > following. Otherwise, this looks good to me.
> > 
> 
> I was just mentioning that the core reset can happen multiple times depending on
> the scenario, so it doesn't make sense to print a warning each time if the reset
> was not available.

Ahh gotcha, maybe be a little more verbose in that part on the next
spin? As is I'm struggling to get that from the commit message's text.

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> 
> - Mani
> 
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  drivers/ufs/host/ufs-qcom.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> > > index dc93b1c5ca74..d474de0739e4 100644
> > > --- a/drivers/ufs/host/ufs-qcom.c
> > > +++ b/drivers/ufs/host/ufs-qcom.c
> > > @@ -296,10 +296,8 @@ static int ufs_qcom_host_reset(struct ufs_hba *hba)
> > >  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> > >  	bool reenable_intr;
> > >  
> > > -	if (!host->core_reset) {
> > > -		dev_warn(hba->dev, "%s: reset control not set\n", __func__);
> > > +	if (!host->core_reset)
> > >  		return 0;
> > > -	}
> > >  
> > >  	reenable_intr = hba->is_irq_enabled;
> > >  	disable_irq(hba->irq);
> > > -- 
> > > 2.25.1
> > > 
> > > 
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
> 

