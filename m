Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E578811313
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379285AbjLMNhw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Dec 2023 08:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379284AbjLMNhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:37:50 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2694B95;
        Wed, 13 Dec 2023 05:37:57 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6d9db2f1ddfso1032486a34.0;
        Wed, 13 Dec 2023 05:37:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702474676; x=1703079476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZUkkC62WrEEa3c6+GRaTxNGlZbmcSMO/iY5g7nd1ts=;
        b=XxeevKb7UA3TH/JjArIFdSLcI4rXKjlcG3cYQP6QszRqbhFISURYz4XypfoG9xTQRs
         7v6oHgoH/JCrzYYB4sgMhttehXZDIeKkqpRHC2itb2IHQ4dRgpfowcgmaqjiCU1fHfiP
         il33NlHt4+YyaVzfKjtL7GoNnOaI25qY1m7jX8eNZLxRr7uEovpb0xe39CuiPfQCpULk
         tAU+T/195wPNDfa+6IxSbc36QqpsE9kN+aFFzcNivO0oJ5t5+LOVKbl1F6u1iBgeqwTD
         6MsM/iWTZ/DgDEtK1AZUitb+K/pJQUvZhGxeudpI/LKCR1T98o4DkddcUwxqccIp68pb
         k3YA==
X-Gm-Message-State: AOJu0YzOoDt9bBX7aX9XO6toTbYf4QlyeXR3VngEh9H4tJwun6eCKYr2
        dSePhvSlqFnPDQ5VuLBDJlusafODM1+SXgnVgF4=
X-Google-Smtp-Source: AGHT+IFmc+A9rorq/rOdGz8gjI08UuZ4ZgrInVsHLw0n8i3P7dAy8xko9rmmdYPzruTZNBiDN83j7nxY/28jo2J/kqM=
X-Received: by 2002:a05:6871:600d:b0:1ff:6527:3519 with SMTP id
 qx13-20020a056871600d00b001ff65273519mr14455355oab.0.1702474676254; Wed, 13
 Dec 2023 05:37:56 -0800 (PST)
MIME-Version: 1.0
References: <20231213121322.2486967-1-daniel.lezcano@linaro.org>
 <CAJZ5v0gjeiCb9wBjdG+yWp5E_g2SPUMNNf-Stm_xkGau0Cbr2g@mail.gmail.com> <c7e4a344-ef15-4316-ac41-6ec9c062eabe@linaro.org>
In-Reply-To: <c7e4a344-ef15-4316-ac41-6ec9c062eabe@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Dec 2023 14:37:45 +0100
Message-ID: <CAJZ5v0jOAEJx1xcRZ5ybz2dKXMG4CbEmShE+zQJy=0gdqqzbPA@mail.gmail.com>
Subject: Re: [PATCH] thermal/core: Check get_temp ops is present when
 registering a tz
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 2:31 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 13/12/2023 13:46, Rafael J. Wysocki wrote:
> > On Wed, Dec 13, 2023 at 1:13 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> Initially the check against the get_temp ops in the
> >> thermal_zone_device_update() was put in there in order to catch
> >> drivers not providing this method.
> >>
> >> Instead of checking again and again the function if the ops exists in
> >> the update function, let's do the check at registration time, so it is
> >> checked one time and for all.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >
> > Looks good.  Do you want me to pick it up?
>
> Yes please

Applied, thanks!
