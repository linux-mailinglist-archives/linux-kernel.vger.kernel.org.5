Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349447EC7EC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjKOPxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjKOPwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:52:37 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD8E1FF9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:51:52 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a87ac9d245so80945107b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700063511; x=1700668311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pylINcL01yD77xhpL+jHM3PYJlt+NwgOinNtm8pq3k=;
        b=B+RbvBST7aI9PFS1iePt1s+nnzVtmQYFsioSVQct/FOX6M+TC5IwFws7nbTpNgOUae
         7AieerAKE8HaKTTqVLTR54rRhRt1SVeb768x/ecwt9tts5IsqQBFlkcwinZ+Ctkw47Xc
         J7MyV3j8djshUGTSuz83pyBUspCRzcrZx5H6TSkWsZAggDRx6Ucm3BNMu1YW1se3vYui
         TXCcvvwEFsVGMjNa/eK06tuAj9sLSPpCSGPW9v47bL5oDi4PC3Ko9YZFxzD+EeTq2T65
         5OOzUMkkZL3KYmr6x0CAVQQ5FsUn5TZIi2A1eVjLdPkR+j9o3s3HoUPFBFKzIZZMXrkz
         6RNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700063511; x=1700668311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pylINcL01yD77xhpL+jHM3PYJlt+NwgOinNtm8pq3k=;
        b=XWWRqQlxRDCs5vbH/3ktJQFTGpIv34r8ClzDMuev5+MPs6Ko4wQB1L9fXryVsFiUNS
         Uh+DMDtSyK4wNdjBP1eZa0WmjRnFz10+lPlcqVtrGG34vIxwviyZDZJlRCkP9ee80BQQ
         CTkHmHlAv37s9BTpRfn6ItfSGknd3T01h6WgNoK8IO1iDZF/XANTjIKeaDfuLgwLLfnr
         TQTPhl7yMiWDs0WaXh7QuZ7ww7glPEFaJdGhI5EQRWmyzg0G5e1YrNM1fW60vHq5Fp1i
         14HiUonyb7+CfgNDmSuLVagQmRinRCKxFL6Uv4ASDyDfhieESA/AAVUT2afCy0nLsOVk
         3TjQ==
X-Gm-Message-State: AOJu0YwOIvuH65XMqb0EyQqBUV8EsleF430gNzxNNL8PsaBvBbd7BtT9
        MV2wcxegEAIe49Wsq8aj6uONMk7hQIF8pipzF7xlIA==
X-Google-Smtp-Source: AGHT+IE25KRtFWaHwm+jpmKSkJDsBeLuZ4Hzg2tjN55Chq6SWsCPVfpnkg/ef4gKEWoWmFCCN7ovHISOzCAa0ugcc0M=
X-Received: by 2002:a0d:f5c3:0:b0:5a8:7cb2:15d0 with SMTP id
 e186-20020a0df5c3000000b005a87cb215d0mr13042799ywf.11.1700063511623; Wed, 15
 Nov 2023 07:51:51 -0800 (PST)
MIME-Version: 1.0
References: <20231103084720.6886-1-adrian.hunter@intel.com>
In-Reply-To: <20231103084720.6886-1-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Nov 2023 16:51:15 +0100
Message-ID: <CAPDyKFrbXAV4-KyA1nXKzLtB8qTq9kX+Vwe0=BcX=-0XSVXK7A@mail.gmail.com>
Subject: Re: [PATCH V2 0/6] mmc: block: Fixes for CQE error recovery recovery
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@chromium.org>,
        Radoslaw Biernacki <biernacki@google.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Bhavya Kapoor <b-kapoor@ti.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Thierry Reding <thierry.reding@gmail.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2023 at 09:48, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Hi
>
> Some issues have been found with CQE error recovery.  Here are some fixes=
.
>
> As of V2, the alternative implementation for the patch from Kornel Dul=C4=
=99ba:
>
>         https://lore.kernel.org/linux-mmc/e7c12e07-7540-47ea-8891-2cec73d=
58df1@intel.com/T/#u
>
> is now included, see patch 6 "mmc: cqhci: Fix task clearing in CQE error
> recovery")
>
> Please also note ->post_disable() seems to be missing from
> cqhci_recovery_start().  It would be good if ->post_disable()
> users could check if this needs attention.
>
>
> Changes in V2:
>
>       mmc: cqhci: Fix task clearing in CQE error recovery
>             New patch
>
>       mmc: cqhci: Warn of halt or task clear failure
>             Add fixes and stable tags
>
>
> Adrian Hunter (6):
>       mmc: block: Do not lose cache flush during CQE error recovery
>       mmc: cqhci: Increase recovery halt timeout
>       mmc: block: Be sure to wait while busy in CQE error recovery
>       mmc: block: Retry commands in CQE error recovery
>       mmc: cqhci: Warn of halt or task clear failure
>       mmc: cqhci: Fix task clearing in CQE error recovery
>
>  drivers/mmc/core/block.c      |  2 ++
>  drivers/mmc/core/core.c       |  9 +++++++--
>  drivers/mmc/host/cqhci-core.c | 44 +++++++++++++++++++++----------------=
------
>  3 files changed, 31 insertions(+), 24 deletions(-)
>
>

Applied for fixes, thanks!

Kind regards
Uffe
