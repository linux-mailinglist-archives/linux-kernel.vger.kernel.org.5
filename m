Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D3D80C904
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbjLKMHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234514AbjLKMHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:07:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29C5F7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 04:07:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4579C43395;
        Mon, 11 Dec 2023 12:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702296449;
        bh=X0lineiGbEOw+if71lLAZ8HUqLj0hNmSIZ78hSwpTDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I7z0jLw0YmiptUk44fTXoCKiT3QeNZ/aTegnhhyJayO6W6a+z+pGxbs8BNYCuNfFv
         GTSvfE5k97FrQjffo17yf07uV6oECh8mMxPRQzNfDblqx9CtsTMQ82zrx6OCkLMKXX
         hB8kyfG+baevsO7LVK11BB++H3hLXcQAksXkOJcsPYp+08qaOA0KZgbcbU/Qs3I4+P
         YPLMRiXbxT0hjcjRZd8EODUpyH5uS3HNL7uFVayjlLiAE6+ZhNpMGOmLl/ZYusUf44
         cn9Q7s/8z4K/L9Ooyj0tGMDC1J4Z/n98PNT9bnXtSZp/PoNu1UzHwpP1YIObje5FI2
         yrWHHK9i9xXcQ==
Date:   Mon, 11 Dec 2023 17:37:14 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        beanhuo@micron.com, thomas@t-8ch.de, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikebi@micron.com, lporzio@micron.com
Subject: Re: [PATCH v4 2/3] scsi: ufs: core: Add UFS RTC support
Message-ID: <20231211120714.GB2894@thinkpad>
References: <20231208103940.153734-1-beanhuo@iokpp.de>
 <20231208103940.153734-3-beanhuo@iokpp.de>
 <20231208145021.GC15552@thinkpad>
 <89c02f8b999a90329f2125380ad2d984767d25ae.camel@iokpp.de>
 <20231208170609.GD15552@thinkpad>
 <fe5eacf2016622f4f3335a1d39063ec523999184.camel@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe5eacf2016622f4f3335a1d39063ec523999184.camel@iokpp.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2023 at 08:28:21PM +0100, Bean Huo wrote:
> On Fri, 2023-12-08 at 22:36 +0530, Manivannan Sadhasivam wrote:
> > Except that the warning will be issued to users after each 10s for 40
> > years.
> > Atleast get rid of that.
> 
> how about using dev_warn_once(), instead of dev_warn, using
> dev_warn_once() ensures the warning is issued only once.
> 

Sounds good to me.

- Mani

> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 953d50cc4256..b2287d2f9bf3 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -8205,7 +8205,7 @@ static void ufshcd_update_rtc(struct ufs_hba
> *hba)
>         ktime_get_real_ts64(&ts64);
>  
>         if  (ts64.tv_sec < hba->dev_info.rtc_time_baseline) {
> -               dev_warn(hba->dev, "%s: Current time precedes previous
> setting!\n", __func__);
> +               dev_warn_once(hba->dev, "%s: Current time precedes
> previous setting!\n", __func__);
> 
> 
> 
> Kind regards,
> Bean

-- 
மணிவண்ணன் சதாசிவம்
