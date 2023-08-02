Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C90E76C3DB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 06:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjHBEER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 00:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjHBEEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 00:04:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9631FFA;
        Tue,  1 Aug 2023 21:04:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD026617A2;
        Wed,  2 Aug 2023 04:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31356C433C8;
        Wed,  2 Aug 2023 04:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690949048;
        bh=pVu7S5QVKqg8Edil0qyB4hB47nc4PSQZ2wOKymXFxEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RD7vTzMxtx4I1tyKGePTqvUqu3dIJgUptVZDQQIywIpmErfh04lzdGMkhskcyULRf
         eQiCywUKBtuw4He3wAe0WV5EJ86clHbSNsaQr79ukZEd1yQlJQOlez0pt5UG5gsubC
         2GrqVx1MGzYszbJnPtSCtjpcad3z1HFTFwBi+k1eyXLJwAl14cU0AR57X/N56XfRNI
         TYonNYjhSaOf7Pg46IIETHBT9AvK/C4LptzddwaXT/+Nv3JdjipeNIkmMUtTVJ17FH
         9vfyVfM7WOoHZTt6QhYU/5WJx1n09Sr9HUfQliBnwQRCyMve7AGAYhtn9B6AdzrX63
         Zw/C/4nf0LXyw==
Date:   Wed, 2 Aug 2023 09:33:53 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Masney <bmasney@redhat.com>
Subject: Re: [PATCH 2/2] scsi: ufs: qcom: Add support for scaling
 interconnects
Message-ID: <20230802040353.GA2370@thinkpad>
References: <20230731145020.41262-1-manivannan.sadhasivam@linaro.org>
 <20230731145020.41262-3-manivannan.sadhasivam@linaro.org>
 <43cd0057-c6d8-bc92-08f4-d767336d2cfe@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43cd0057-c6d8-bc92-08f4-d767336d2cfe@acm.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 01:09:52PM -0700, Bart Van Assche wrote:
> On 7/31/23 07:50, Manivannan Sadhasivam wrote:
> > +struct __ufs_qcom_bw_table {
> > +	u32 mem_bw;
> > +	u32 cfg_bw;
> > +} ufs_qcom_bw_table[MODE_MAX + 1][QCOM_UFS_MAX_GEAR + 1][QCOM_UFS_MAX_LANE + 1] = {
> > +	[MODE_MIN][0][0]		   = { 0,		0 }, /* Bandwidth values in KB/s */
> > +	[MODE_PWM][UFS_PWM_G1][UFS_LANE_1] = { 922,		1000 },
> > +	[MODE_PWM][UFS_PWM_G2][UFS_LANE_1] = { 1844,		1000 },
> > +	[MODE_PWM][UFS_PWM_G3][UFS_LANE_1] = { 3688,		1000 },
> > +	[MODE_PWM][UFS_PWM_G4][UFS_LANE_1] = { 7376,		1000 },
> > +	[MODE_PWM][UFS_PWM_G1][UFS_LANE_2] = { 1844,		1000 },
> > +	[MODE_PWM][UFS_PWM_G2][UFS_LANE_2] = { 3688,		1000 },
> > +	[MODE_PWM][UFS_PWM_G3][UFS_LANE_2] = { 7376,		1000 },
> > +	[MODE_PWM][UFS_PWM_G4][UFS_LANE_2] = { 14752,		1000 },
> > +	[MODE_HS_RA][UFS_HS_G1][UFS_LANE_1] = { 127796,		1000 },
> > +	[MODE_HS_RA][UFS_HS_G2][UFS_LANE_1] = { 255591,		1000 },
> > +	[MODE_HS_RA][UFS_HS_G3][UFS_LANE_1] = { 1492582,	102400 },
> > +	[MODE_HS_RA][UFS_HS_G4][UFS_LANE_1] = { 2915200,	204800 },
> > +	[MODE_HS_RA][UFS_HS_G1][UFS_LANE_2] = { 255591,		1000 },
> > +	[MODE_HS_RA][UFS_HS_G2][UFS_LANE_2] = { 511181,		1000 },
> > +	[MODE_HS_RA][UFS_HS_G3][UFS_LANE_2] = { 1492582,	204800 },
> > +	[MODE_HS_RA][UFS_HS_G4][UFS_LANE_2] = { 2915200,	409600 },
> > +	[MODE_HS_RB][UFS_HS_G1][UFS_LANE_1] = { 149422,		1000 },
> > +	[MODE_HS_RB][UFS_HS_G2][UFS_LANE_1] = { 298189,		1000 },
> > +	[MODE_HS_RB][UFS_HS_G3][UFS_LANE_1] = { 1492582,	102400 },
> > +	[MODE_HS_RB][UFS_HS_G4][UFS_LANE_1] = { 2915200,	204800 },
> > +	[MODE_HS_RB][UFS_HS_G1][UFS_LANE_2] = { 298189,		1000 },
> > +	[MODE_HS_RB][UFS_HS_G2][UFS_LANE_2] = { 596378,		1000 },
> > +	[MODE_HS_RB][UFS_HS_G3][UFS_LANE_2] = { 1492582,	204800 },
> > +	[MODE_HS_RB][UFS_HS_G4][UFS_LANE_2] = { 2915200,	409600 },
> > +	[MODE_MAX][0][0]		    = { 7643136,	307200 },
> > +};
> 
> Why has the above data structure not been declared as 'static const'?
> 

Missed that! Sent a patch now. Thanks for spotting.

- Mani

> Thanks,
> 
> Bart.

-- 
மணிவண்ணன் சதாசிவம்
