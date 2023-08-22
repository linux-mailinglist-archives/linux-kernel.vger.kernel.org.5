Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C906F784677
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237479AbjHVQCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237510AbjHVQCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:02:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE00512C;
        Tue, 22 Aug 2023 09:02:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D44063589;
        Tue, 22 Aug 2023 16:02:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5A5C433C8;
        Tue, 22 Aug 2023 16:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692720156;
        bh=B4dVX7JomV77pBcVqtD0PNTGXOQTdjWiq/Ji2vFROpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kmxPkkTwYCQZnR4ofNmuKm7gv2uiQDKusaOVm4+AvZ6IaaGd8xX75E8iqHzAfVUw5
         WllJU/8IG1KKWLe9HO7xE4RyAubCZPuh2861jQMReIEjT/jwsULtwHAzWnK2sflFHx
         BWGx+sXx0R63DjB2YbS4DY4RkP7rvaI6Ct0+T+AmYQXo//IzyuvK3erHkxLrST2aBp
         6wDaYVitItaDSb6yLzD86wcSYz89JYn/a96LwoLfqyzx8jGTsOeTKen2XN+Bavk8iy
         f64BmIsFGJ3zcYPeD/A4gfz345Nz8ho1wOhRIte5vdAcWyH2GI188wKcS34cx44Rmu
         O37NQ2ZTMJ/0w==
Received: from johan by theta with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qYTpw-00015s-0B;
        Tue, 22 Aug 2023 18:02:32 +0200
Date:   Tue, 22 Aug 2023 18:02:32 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>, quic_jjohnson@quicinc.com,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.4 03/10] Revert "wifi: ath11k: Enable threaded
 NAPI"
Message-ID: <ZOTcGEfqsBkWugAa@hovoldconsulting.com>
References: <20230822113101.3549915-1-sashal@kernel.org>
 <20230822113101.3549915-3-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822113101.3549915-3-sashal@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 07:30:53AM -0400, Sasha Levin wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> [ Upstream commit d265ebe41c911314bd273c218a37088835959fa1 ]
> 
> This reverts commit 13aa2fb692d3717767303817f35b3e650109add3.
> 
> This commit broke QCN9074 initialisation:
> 
> [  358.960477] ath11k_pci 0000:04:00.0: ce desc not available for wmi command 36866
> [  358.960481] ath11k_pci 0000:04:00.0: failed to send WMI_STA_POWERSAVE_PARAM_CMDID
> [  358.960484] ath11k_pci 0000:04:00.0: could not set uapsd params -105
> 
> As there's no fix available let's just revert it to get QCN9074 working again.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217536
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> Signed-off-by: Kalle Valo <kvalo@kernel.org>
> Link: https://lore.kernel.org/r/20230720151444.2016637-1-kvalo@kernel.org
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This commit break machines like the Lenovo ThinkPad X13s so please do
not backport until this has been resolved:

	https://lore.kernel.org/lkml/20230809073432.4193-1-johan+linaro@kernel.org

Johan
