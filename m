Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9796762AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 07:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjGZFiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 01:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjGZFiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 01:38:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FFDCC;
        Tue, 25 Jul 2023 22:38:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E55E661536;
        Wed, 26 Jul 2023 05:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA2AC433C7;
        Wed, 26 Jul 2023 05:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690349885;
        bh=iQOB7tO4loCykPUVe5qLzo1AABQ81jx4x3ex2u+OqVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jpnW0o5cWQAPGRay3/KJ3pkDcFQ3UnCpaTUMHth4tBTzUQCFfQto6RVnMH2L41ThT
         R7G2nGWG74Y7HnjWztO7tiNvRGvX05jytcIsboKdjOro9tEKnwjb3orZgUmw2dJoz6
         U45Wp8TCVk9sXLVpZev1F9gIGPqZHPIyEocbVmpwyIVxPUsv1oThiSLUs2MIJZA+QE
         KW9tyBAidj5YOS3qUYPQeVUlUUmf/4MXHDjBC0FFivy4DMXF6dLh2P5LP0SAdS62ZY
         hMrGvcQrwPVS5qpeXwriAVEBI3FDJe5ivffWBWpDA/kTQ6UUdHYLeO3Qlz9NcI0ODS
         +VRdeN1lS5xPQ==
Date:   Tue, 25 Jul 2023 22:41:17 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     powen.kao@mediatek.com, bvanassche@acm.org,
        alim.akhtar@samsung.com, adrian.hunter@intel.com,
        jejb@linux.ibm.com, stanley.chu@mediatek.com,
        asutoshd@codeaurora.org, quic_cang@quicinc.com, mani@kernel.org,
        martin.petersen@oracle.com, beanhuo@micron.com,
        ebiggers@google.com, agross@kernel.org, Arthur.Simchaev@wdc.com,
        konrad.dybcio@linaro.org, quic_ziqichen@quicinc.com,
        quic_nguyenb@quicinc.com, quic_narepall@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V1 0/2] Fix hibern8 enter failure during host reset
Message-ID: <h6icfhn6xi2iuibrnum5rfre3yeycilkxtowzfu5gwh6mptbua@nhhitqvbwzp4>
References: <20230725192710.26698-1-quic_nitirawa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725192710.26698-1-quic_nitirawa@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 12:57:08AM +0530, Nitin Rawat wrote:
> Commit <52a518019c> ("Fix missing clk change notification on host reset")
> added clock scaling notification to ufshcd_host_reset_and_restore.
> This invokes hibern8 enter and exit on qualcomm platform which fails
> because controller is in reset state.
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

Sorry, I missed this before I looked at the individual patches.

The cover-letter is not included in the git history, so this information
will be lost. This explains the reason for patch 2, so please put it
there.

Thanks,
Bjorn
