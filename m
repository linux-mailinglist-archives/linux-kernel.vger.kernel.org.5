Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F81E7517FB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 07:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjGMFVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 01:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjGMFVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 01:21:14 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2512A2116
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 22:21:11 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-c5e76dfcc36so263580276.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 22:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689225670; x=1691817670;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bvEDh9AEFIPHTypy+lK6+Z0dQlmVoSVtBmXQP+xaAaQ=;
        b=QA+zGEjBeyHt0cV0Uz7PbIpya13d7qWMvWntFl+eRdQ3FkPQMRSl2Ki9QVA0CNTmqg
         Q3ZM4kmPl3c7A32BiABJTH8mp0BoyTU9Rw/roZrfSkOqbKADG/hbv+Dy5yAkZ5ZYcGHw
         NNcfFy6f2lCMnTV4pnZ+nV+ClBMgnz9GHCmzfSfbtj4xixdI7z8EoO+AVPspkv3Yu4fC
         UIC2OIboX8VHlLNV0LvAv6Z+uTY7ggzco4J+Ccmh3jQcAnSqwBzDWeVbGh4T8tNNkvkD
         bUNato4fU7mixogsJtoGUTR8/p1lI4xvVgW7m/M1u9cHXKOU5HQveBzaA0p21Xvh7wHA
         efkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689225670; x=1691817670;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bvEDh9AEFIPHTypy+lK6+Z0dQlmVoSVtBmXQP+xaAaQ=;
        b=K7XCXZvB/08uwoDQF1+3wL55JxoFNHhPGEnOGureyuX/MdYggQxR/JSsMOY587w8VE
         /3SJx8BSoUhB+zoEPnbwy0N2PcrpsBv5TRWyIk+F1Cqunas5dmWIau/ukINIPWPOM0Z2
         1qCPthUenaC8NYWLTqzypoBrShHOXYXspRgHa+C2D+DCGV+Ibi0cp3WOnuR0nV8BUJVq
         GcvvKtLiml1dJbriHyZejAfvJ1p1/as+SmfrpiXohXHRFBkpNoZJP1rLeyEReUQRulI7
         1FARc5MsbzePHJpJtOaJP1Qx2clRA2IMnWIdwLXSFCA4mTFS4A2T1LSSzzsv3OAFoGBA
         reUQ==
X-Gm-Message-State: ABy/qLaLOfNdkA32ZvCyCqovU85mMmpBpzCwUg7eUgM6Kl1yhlxpUZlE
        /5FfJmzq8GoYNmzCgE7Emg3H
X-Google-Smtp-Source: APBJJlHsGvCKCPMEj7H4StJghGWQQZCLHG/114XU/zHU3L8JdhKuVwXIXQRvNiQXMAkvI0/1h9zxMQ==
X-Received: by 2002:a25:2597:0:b0:c64:ef5b:dc65 with SMTP id l145-20020a252597000000b00c64ef5bdc65mr597865ybl.3.1689225670295;
        Wed, 12 Jul 2023 22:21:10 -0700 (PDT)
Received: from thinkpad ([117.207.27.112])
        by smtp.gmail.com with ESMTPSA id k22-20020aa792d6000000b00682868714fdsm4622938pfa.95.2023.07.12.22.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 22:21:09 -0700 (PDT)
Date:   Thu, 13 Jul 2023 10:50:52 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH 14/14] scsi: ufs: qcom: Add support for scaling
 interconnects
Message-ID: <20230713052052.GD3047@thinkpad>
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
 <20230712103213.101770-19-manivannan.sadhasivam@linaro.org>
 <107aad9f-40c0-f32b-9f74-6c82ee6785bf@linaro.org>
 <20230712164114.GH102757@thinkpad>
 <be734fa0-1b16-0dad-6205-d1f1acb1f179@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be734fa0-1b16-0dad-6205-d1f1acb1f179@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 08:23:02PM +0300, Dmitry Baryshkov wrote:
> On 12/07/2023 19:41, Manivannan Sadhasivam wrote:
> > On Wed, Jul 12, 2023 at 04:22:51PM +0300, Dmitry Baryshkov wrote:
> > > On 12/07/2023 13:32, Manivannan Sadhasivam wrote:
> > > > Qcom SoCs require scaling the interconnect paths for proper working of the
> > > > peripherals connected through interconnects. Even for accessing the UFS
> > > > controller, someone should setup the interconnect paths. So far, the
> > > > bootloaders used to setup the interconnect paths before booting linux as
> > > > they need to access the UFS storage for things like fetching boot firmware.
> > > > But with the advent of multi boot options, bootloader nowadays like in
> > > > SA8540p SoC do not setup the interconnect paths at all.
> > > > 
> > > > So trying to configure UFS in the absence of the interconnect path
> > > > configuration, results in boot crash.
> > > > 
> > > > To fix this issue and also to dynamically scale the interconnects (UFS-DDR
> > > > and CPU-UFS), interconnect API support is added to the Qcom UFS driver.
> > > > With this support, the interconnect paths are scaled dynamically based on
> > > > the gear configuration.
> > > > 
> > > > During the early stage of ufs_qcom_init(), ufs_qcom_icc_init() will setup
> > > > the paths to max bandwidth to allow configuring the UFS registers. Touching
> > > > the registers without configuring the icc paths would result in a crash.
> > > > However, we don't really need to set max vote for the icc paths as any
> > > > minimal vote would suffice. But the max value would allow initialization to
> > > > be done faster. After init, the bandwidth will get updated using
> > > > ufs_qcom_icc_update_bw() based on the gear and lane configuration.
> > > > 
> > > > The bandwidth values defined in ufs_qcom_bw_table struct are taken from
> > > > Qcom downstream vendor devicetree source and are calculated as per the
> > > > UFS3.1 Spec, Section 6.4.1, HS Gear Rates. So it is fixed across platforms.
> > > > 
> > > > Cc: Brian Masney <bmasney@redhat.com>
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >    drivers/ufs/host/ufs-qcom.c | 131 +++++++++++++++++++++++++++++++++++-
> > > >    drivers/ufs/host/ufs-qcom.h |   3 +
> > > >    2 files changed, 133 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> > > > index 8d6fd4c3324f..8a3132d45a65 100644
> > > > --- a/drivers/ufs/host/ufs-qcom.c
> > > > +++ b/drivers/ufs/host/ufs-qcom.c
> > > > @@ -7,6 +7,7 @@
> > > >    #include <linux/time.h>
> > > >    #include <linux/clk.h>
> > > >    #include <linux/delay.h>
> > > > +#include <linux/interconnect.h>
> > > >    #include <linux/module.h>
> > > >    #include <linux/of.h>
> > > >    #include <linux/platform_device.h>
> > > > @@ -46,6 +47,49 @@ enum {
> > > >    	TSTBUS_MAX,
> > > >    };
> > 

[...]

> > > };
> > > 
> > > Also, do we have defines for gears? Can we use them instead of indices?
> > > 
> > 
> > There are defines for the gears but not for lanes. So I ended up using numbers
> > for simplicity.
> 
> My suggestion would be to use them for gears at least. Then it becomes
> cleaner (and maybe will solve some of my other comments).
> 

I think it'd better to add enums for lanes as well (in unipro.h) and use both.

> > 
> > - Mani
> > 
> > > > +	[MODE_PWM][1][1] = { 922,	1000 },
> > > > +	[MODE_PWM][2][1] = { 1844,	1000 },
> > > > +	[MODE_PWM][3][1] = { 3688,	1000 },
> > > > +	[MODE_PWM][4][1] = { 7376,	1000 },
> > > > +	[MODE_PWM][1][2] = { 1844,	1000 },
> > > > +	[MODE_PWM][2][2] = { 3688,	1000 },
> > > > +	[MODE_PWM][3][2] = { 7376,	1000 },
> > > > +	[MODE_PWM][4][2] = { 14752,	1000 },
> > > > +	[MODE_HS_RA][1][1] = { 127796,	1000 },
> > > > +	[MODE_HS_RA][2][1] = { 255591,	1000 },
> > > > +	[MODE_HS_RA][3][1] = { 1492582,	102400 },
> > > > +	[MODE_HS_RA][4][1] = { 2915200,	204800 },
> > > > +	[MODE_HS_RA][1][2] = { 255591,	1000 },
> > > > +	[MODE_HS_RA][2][2] = { 511181,	1000 },
> > > > +	[MODE_HS_RA][3][2] = { 1492582,	204800 },
> > > > +	[MODE_HS_RA][4][2] = { 2915200,	409600 },
> > > > +	[MODE_HS_RB][1][1] = { 149422,	1000 },
> > > > +	[MODE_HS_RB][2][1] = { 298189,	1000 },
> > > > +	[MODE_HS_RB][3][1] = { 1492582,	102400 },
> > > > +	[MODE_HS_RB][4][1] = { 2915200,	204800 },
> > > > +	[MODE_HS_RB][1][2] = { 298189,	1000 },
> > > > +	[MODE_HS_RB][2][2] = { 596378,	1000 },
> > > > +	[MODE_HS_RB][3][2] = { 1492582,	204800 },
> > > > +	[MODE_HS_RB][4][2] = { 2915200,	409600 },
> > > > +	[MODE_MAX][0][0] = { 7643136, 307200 },
> > > > +};
> > > > +

[...]

> > > > +static int ufs_qcom_icc_update_bw(struct ufs_qcom_host *host)
> > > > +{
> > > > +	struct __ufs_qcom_bw_table bw_table;
> > > > +
> > > > +	bw_table = ufs_qcom_get_bw_table(host);
> > > > +
> > > > +	return ufs_qcom_icc_set_bw(host, bw_table.bw1, bw_table.bw2);
> > > > +}
> > > > +
> > > >    static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
> > > >    				enum ufs_notify_change_status status,
> > > >    				struct ufs_pa_layer_attr *dev_max_params,
> > > > @@ -852,6 +941,8 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
> > > >    		memcpy(&host->dev_req_params,
> > > >    				dev_req_params, sizeof(*dev_req_params));
> > > > +		ufs_qcom_icc_update_bw(host);
> > > > +
> > > >    		/* disable the device ref clock if entered PWM mode */
> > > >    		if (ufshcd_is_hs_mode(&hba->pwr_info) &&
> > > >    			!ufshcd_is_hs_mode(dev_req_params))
> > > > @@ -981,7 +1072,9 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
> > > >    	switch (status) {
> > > >    	case PRE_CHANGE:
> > > > -		if (!on) {
> > > > +		if (on) {
> > > > +			ufs_qcom_icc_update_bw(host);
> > > > +		} else {
> > > >    			if (!ufs_qcom_is_link_active(hba)) {
> > > >    				/* disable device ref_clk */
> > > >    				ufs_qcom_dev_ref_clk_ctrl(host, false);
> > > > @@ -993,6 +1086,9 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
> > > >    			/* enable the device ref clock for HS mode*/
> > > >    			if (ufshcd_is_hs_mode(&hba->pwr_info))
> > > >    				ufs_qcom_dev_ref_clk_ctrl(host, true);
> > > > +		} else {
> > > > +			ufs_qcom_icc_set_bw(host, ufs_qcom_bw_table[MODE_MIN][0][0].bw1,
> > > > +					    ufs_qcom_bw_table[MODE_MIN][0][0].bw2);
> 
> With MODE_MIN values being initialised to 0, can we use the value directly
> instead? You are not defining the whole table for MODE_MIN anyway.
> 

I initially thought about it, but having all the values in the table gives
better visibility IMO. Otherwise, one has to look into the actual call to
determine what is being set for min and max.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
