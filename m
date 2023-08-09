Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEF0776C73
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjHIWu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjHIWuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDE7138
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6333663C1F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 22:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A561C433C8;
        Wed,  9 Aug 2023 22:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691621423;
        bh=d8fqHLUBifTkUQGLp60CBi6upU3g/APJywI4LSpujRk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vMJb2fALDbcVGxRtmYaXHBvAMecaa9bad9cF2DpNnsGbEtdGT5hlKHsIXxNmooynf
         2Q8oLgqytjJ5PC5KMEk/fTnJBT2yY+rBnk8q//WLzp74eGHhZq3QBi2hGlteWuMHXu
         Gcu5k8U8ub/3tMPqCdxw4vIURBFedINnjcPwq2vNlF/h4S9wKiibwKOy7Wy6e+Z82f
         pkoN+fqvbYM2upeaLVahNou8oVsR1XN303lTCqaAmLjIGKWcWwviJ22wuT9740MZT6
         PP+T87eLNdbH206u1OhhqEhALbKX2+BB3ZsnFcWXl7GtmcxWIZ2cnIaoKN+dErzX4p
         HtOfNHWAWZcMA==
Date:   Wed, 9 Aug 2023 15:50:22 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Sai Krishna <saikrishnag@marvell.com>
Cc:     <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <richardcochran@gmail.com>,
        Naveen Mamindlapalli <naveenm@marvell.com>
Subject: Re: [net-next PATCH v2] octeontx2-pf: Use PTP HW timestamp counter
 atomic update feature
Message-ID: <20230809155022.132a69a7@kernel.org>
In-Reply-To: <20230807140535.3070350-1-saikrishnag@marvell.com>
References: <20230807140535.3070350-1-saikrishnag@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Aug 2023 19:35:35 +0530 Sai Krishna wrote:
> Some of the newer silicon versions in CN10K series supports a feature
> where in the current PTP timestamp in HW can be updated atomically
> without losing any cpu cycles unlike read/modify/write register.
> This patch uses this feature so that PTP accuracy can be improved
> while adjusting the master offset in HW. There is no need for SW
> timecounter when using this feature. So removed references to SW
> timecounter wherever appropriate.

> -#include "ptp.h"
>  #include "mbox.h"
>  #include "rvu.h"
> +#include "ptp.h"

If you reorder the includes - maybe put them in alphabetical order?

>  static bool cn10k_ptp_errata(struct ptp *ptp)
>  {
> -	if (ptp->pdev->subsystem_device == PCI_SUBSYS_DEVID_CN10K_A_PTP ||
> -	    ptp->pdev->subsystem_device == PCI_SUBSYS_DEVID_CNF10K_A_PTP)
> +	if ((is_ptp_dev_cn10ka(ptp) &&
> +	     ((ptp->pdev->revision & 0x0F) == 0x0 || (ptp->pdev->revision & 0x0F) == 0x1)) ||
> +	    (is_ptp_dev_cnf10ka(ptp) &&
> +	     ((ptp->pdev->revision & 0x0F) == 0x0 || (ptp->pdev->revision & 0x0F) == 0x1)))

Please refactor the revision check to avoid these long lines repeating
the same logic

>  		return true;
> +
>  	return false;
>  }
>  
> -static bool is_ptp_tsfmt_sec_nsec(struct ptp *ptp)
> +static bool is_tstmp_atomic_update_supported(struct rvu *rvu)
>  {
> -	if (ptp->pdev->subsystem_device == PCI_SUBSYS_DEVID_CN10K_A_PTP ||
> -	    ptp->pdev->subsystem_device == PCI_SUBSYS_DEVID_CNF10K_A_PTP)
> -		return true;
> -	return false;
> +	struct ptp *ptp = rvu->ptp;
> +	struct pci_dev *pdev;
> +
> +	if (is_rvu_otx2(rvu))
> +		return false;
> +
> +	pdev = ptp->pdev;
> +
> +	/* On older silicon variants of CN10K, atomic update feature
> +	 * is not available.
> +	 */
> +	if ((pdev->subsystem_device == PCI_SUBSYS_DEVID_CN10K_A_PTP &&
> +	     (pdev->revision & 0x0F) == 0x0) ||
> +	     (pdev->subsystem_device == PCI_SUBSYS_DEVID_CN10K_A_PTP &&
> +	     (pdev->revision & 0x0F) == 0x1) ||
> +	     (pdev->subsystem_device == PCI_SUBSYS_DEVID_CNF10K_A_PTP &&
> +	     (pdev->revision & 0x0F) == 0x0) ||
> +	     (pdev->subsystem_device == PCI_SUBSYS_DEVID_CNF10K_A_PTP &&
> +	     (pdev->revision & 0x0F) == 0x1))

why are you not using cn10k_ptp_errata() here?

> +		return false;
> +
> +	return true;
>  }

> -static int otx2_ptp_adjtime(struct ptp_clock_info *ptp_info, s64 delta)
> +static int otx2_ptp_tc_adjtime(struct ptp_clock_info *ptp_info, s64 delta)
>  {
>  	struct otx2_ptp *ptp = container_of(ptp_info, struct otx2_ptp,
>  					    ptp_info);
>  	struct otx2_nic *pfvf = ptp->nic;
>  
> +	if (!ptp->nic)
> +		return -ENODEV;

Is this check related to the rest of the patch?

>  	mutex_lock(&pfvf->mbox.lock);
>  	timecounter_adjtime(&ptp->time_counter, delta);
>  	mutex_unlock(&pfvf->mbox.lock);
-- 
pw-bot: cr
