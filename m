Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03287F9FC4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjK0MkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbjK0MkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:40:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34281137
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:40:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1E6C433C7;
        Mon, 27 Nov 2023 12:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701088806;
        bh=uTJ91VZ9bOH63Qr5KyfXaGtqhL/xUMXc4lb5CtuYGQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DQSeWzdPGYG2T/Kkz3sP6B8l0KR5+6IwD5z4+sHV9Vvm4pxRqiA9BJjx5IvLGAThH
         vlJ8HFPD2CSu+gGnJhX5ZFPnJSsxEhhhPvOvUbyxwIxbgEJyIArqFrm6ST29OHG6qr
         plss7VLFUC7PSuCejuziiQdR2sVDet0/JW+Obamk=
Date:   Mon, 27 Nov 2023 12:40:04 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     djakov@kernel.org
Cc:     linux@roeck-us.net, sam@gentoo.org, akpm@linux-foundation.org,
        allen.lkml@gmail.com, conor@kernel.org, f.fainelli@gmail.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        lkft-triage@lists.linaro.org, patches@kernelci.org,
        patches@lists.linux.dev, pavel@denx.de, rwarsow@gmx.de,
        shuah@kernel.org, srw@sladewatkins.net, stable@vger.kernel.org,
        sudipm.mukherjee@gmail.com, torvalds@linux-foundation.org
Subject: Re: [PATCH 5.10] interconnect: qcom: Add support for mask-based BCMs
Message-ID: <2023112753-detector-silent-18bd@gregkh>
References: <05678c48-bac1-4f17-99f8-21b566c17a6e@roeck-us.net>
 <20231127114551.1043891-1-djakov@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127114551.1043891-1-djakov@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 01:45:51PM +0200, djakov@kernel.org wrote:
> From: Georgi Djakov <djakov@kernel.org>
> 
> From: Mike Tipton <mdtipton@codeaurora.org>
> 
> [ Upstream commit d8630f050d3fd2079f8617dd6c00c6509109c755 ]
> 
> Some BCMs aren't directly associated with the data path (i.e. ACV) and
> therefore don't communicate using BW. Instead, they are simply
> enabled/disabled with a simple bit mask. Add support for these.
> 
> Origin commit retrieved from:
> https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/commit/2d1573e0206998151b342e6b52a4c0f7234d7e36
> 
> Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
> [narmstrong: removed copyright change from original commit]
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Link: https://lore.kernel.org/r/20230619-topic-sm8550-upstream-interconnect-mask-vote-v2-1-709474b151cc@linaro.org
> Fixes: fafc114a468e ("interconnect: qcom: Add SM8450 interconnect provider driver")
> Fixes: 2d1f95ab9feb ("interconnect: qcom: Add SC7180 interconnect provider driver")
> Signed-off-by: Georgi Djakov <djakov@kernel.org>
> ---
> 
> There is a build error reported in the 5.10.201 stable tree (arm64 allmodconfig),
> which is caused by a patch that has a dependency we missed to backport. This is
> the missing patch that we need to get into 5.10.202 to fix the build failure.
> Thanks to Guenter and Sam for reporting that!
> 
>  drivers/interconnect/qcom/bcm-voter.c | 5 +++++
>  drivers/interconnect/qcom/icc-rpmh.h  | 2 ++
>  2 files changed, 7 insertions(+)

Now queued up, thanks.

greg ik-h
