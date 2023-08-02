Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B38D76C3ED
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 06:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjHBEK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 00:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjHBEKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 00:10:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A7CFE;
        Tue,  1 Aug 2023 21:10:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6771D617B2;
        Wed,  2 Aug 2023 04:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702DCC4160E;
        Wed,  2 Aug 2023 04:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690949436;
        bh=CW5MQD6wbPn2XWv3mTPcvjccKvbQtz4v/5O98VDOY8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C6Fbde6DnVnnKeIbxZkFR398Uc5YYsorRG01i6rljwGuuwOh6XPiPXfYFZkmCMpDv
         om6QeBWAYH3mM0cGcUpScnBQP4ZdEuR1osEmdtKV4MpHZeczTmDaDB0Ezgyg2ZhM7N
         y+7Da+lYC3ftEpMs+EjEL+dP5xOJv5Rqm4sIYmOfyIIWKV/kDSbWF12pQiQgVlR+9V
         2gX1zzZUAu7Pnpoq6LcDtEtfM52GcfGPPzgWYzpoW7OnpYzxhZ4kK4DAepaIC66iIk
         6N655rYDaz3/U+YsPCQvUaISJzh9mD14bR0/mWz67z70UW+AGAp7iPGh0o4f0pUslH
         mgEt/nLKPJ6ew==
Date:   Wed, 2 Aug 2023 09:40:19 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     powen.kao@mediatek.com, bvanassche@acm.org,
        alim.akhtar@samsung.com, adrian.hunter@intel.com,
        jejb@linux.ibm.com, stanley.chu@mediatek.com,
        asutoshd@codeaurora.org, quic_cang@quicinc.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        ebiggers@google.com, agross@kernel.org, Arthur.Simchaev@wdc.com,
        konrad.dybcio@linaro.org, quic_ziqichen@quicinc.com,
        quic_nguyenb@quicinc.com, quic_narepall@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Manish Pandey <quic_mapa@quicinc.com>
Subject: Re: [PATCH V2 2/2] scsi: ufs: ufs-qcom: check host controller state
Message-ID: <20230802041019.GC2370@thinkpad>
References: <20230726134140.7180-1-quic_nitirawa@quicinc.com>
 <20230726134140.7180-3-quic_nitirawa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230726134140.7180-3-quic_nitirawa@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 07:11:40PM +0530, Nitin Rawat wrote:
> Commit <52a518019ca1> (Fix missing clk change notification) added UFS
> clock scaling notification to ufshcd_host_reset_and_restore. This
> invokes hibern8 enter and exit on qualcomm platform which fails because
> controller is in reset state.
> 
> Fix this by checking the Host controller state before sending
> hibern8 command.
> 
> __ufshcd_wl_resume()
> ufshcd_reset_and_restore()
> ufshcd_host_reset_and_restore()
> ufshcd_scale_clks()
> ufshcd_vops_clk_scale_notify()
> ufs_qcom_clk_scale_notify()
> ufshcd_uic_hibern8_enter()
> 
> Fixes: 52a518019ca1 ("scsi: ufs: core: Fix missing clk change notification on host reset")
> 

Nit: No need of a newline here.

> Co-developed-by: Manish Pandey <quic_mapa@quicinc.com>
> Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/ufs/host/ufs-qcom.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 8d6fd4c3324f..95412e98a598 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1254,6 +1254,10 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
>  	struct ufs_pa_layer_attr *dev_req_params = &host->dev_req_params;
>  	int err = 0;
> 
> +	/* check the host controller state before sending hibern8 cmd */
> +	if (!ufshcd_is_hba_active(hba))
> +		return 0;
> +
>  	if (status == PRE_CHANGE) {
>  		err = ufshcd_uic_hibern8_enter(hba);
>  		if (err)
> --
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்
