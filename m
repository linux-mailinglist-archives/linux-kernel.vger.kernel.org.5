Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265C980780A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378962AbjLFStX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378977AbjLFStU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:49:20 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916EA1985
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 10:48:42 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5a0dc313058so8296a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 10:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701888522; x=1702493322; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jAybnoXUPmmnjimwppJwbCtNCv9V5v2xiMszdqym8XU=;
        b=fmcDYdypDnTvjH8tRPNHPt4wlwNf7mqz6Ii0wfKdPUWiOTWWmg/J6xzjx4c3lJjQuJ
         N7NOm+u24CybB7Ez16UEM8csfUq6sOkTZC09weNPxv73GR6Uyz3LjD65+iEkaubYK8n1
         nz6hujL7c54ia58NjoDjXs+v+gvbaKaILnoNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701888522; x=1702493322;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAybnoXUPmmnjimwppJwbCtNCv9V5v2xiMszdqym8XU=;
        b=fPaxql9On6dbekB1dEMESa/SD7ezQ0ee+inPL+NuziSNF5vrTrq+e6JOfsZLzbB5m3
         ge1E2QBh65BcQwJpIKYQN1ovC3nHX+sUrCBaSZILlS4oT6Jt5GVaothWrlQFjARjCiBq
         RpXoqnbg08fqA3NQlJTpl+tVEw+GWtz2KbjP+QRgK8cO8IPKDZLOKHtYBI5IuEMLvek/
         h4Xz+iPrnjU6K7BhLz1CcabVhcbZ6t2LXCQNlMNZYcki0OtRN3WDT0p73ia6uopb9/Sa
         uvFpWNbXIQYGa0UGRFUeuR6tNF+iu02FmN7v4JyhkP9BoVFtFqUSXZCd3FWTuCnq8aVs
         H72g==
X-Gm-Message-State: AOJu0YwU89yDaYoT5O8gshXdwBWpuhD4FUSntlR1LrR1VwCA4esaLTE0
        e3E1zhNXFXx652lFnDCorLJMLHNKP6KtR0kxMWiO7w==
X-Google-Smtp-Source: AGHT+IGUzqnQbIAp0NKPi2togelz22nMFB8YKrQx+sSw32s78lLb4ultUCt0fKhCD2OhbHNNqZHTUapKVsBevmbyJnU=
X-Received: by 2002:a17:90b:1e05:b0:286:6cbf:e240 with SMTP id
 pg5-20020a17090b1e0500b002866cbfe240mr2673295pjb.4.1701888521864; Wed, 06 Dec
 2023 10:48:41 -0800 (PST)
MIME-Version: 1.0
References: <20231205184741.3092376-1-mmayer@broadcom.com> <20231205184741.3092376-4-mmayer@broadcom.com>
 <e63906cf-9f76-4fed-91b0-1a9168b179bd@linaro.org> <12f3c515-71cf-46a5-ad92-15bf6c4c2f2c@broadcom.com>
 <c483e962-a565-45b0-91e2-41f47e2cf4bb@linaro.org>
In-Reply-To: <c483e962-a565-45b0-91e2-41f47e2cf4bb@linaro.org>
From:   Markus Mayer <mmayer@broadcom.com>
Date:   Wed, 6 Dec 2023 10:48:30 -0800
Message-ID: <CAGt4E5smwohGsPkvFOY8o270mNQnTkSWz8UKh3un2=XtEibzAg@mail.gmail.com>
Subject: Re: [PATCH 3/4] memory: brcmstb_dpfe: support DPFE API v4
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2023 at 09:32, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 06/12/2023 17:18, Florian Fainelli wrote:
> >
> >
> > On 12/6/2023 3:10 AM, Krzysztof Kozlowski wrote:
> >> On 05/12/2023 19:47, Markus Mayer wrote:
> >>> Add support for version 4 of the DPFE API. This new version is largely
> >>> identical to version 3. The main difference is that all commands now
> >>> take the MHS version number as the first argument. Any other arguments
> >>> have been pushed down by one (i.e. what used to be arg0 in v3 is arg1 in
> >>> v4).
> >>>
> >>> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> >>
> >> ...
> >>
> >>> +
> >>>   static const char *get_error_text(unsigned int i)
> >>>   {
> >>>     static const char * const error_text[] = {
> >>> @@ -929,8 +954,12 @@ static const struct of_device_id brcmstb_dpfe_of_match[] = {
> >>>     { .compatible = "brcm,dpfe-cpu-v1", .data = &dpfe_api_old_v2 },
> >>>     { .compatible = "brcm,dpfe-cpu-v2", .data = &dpfe_api_new_v2 },
> >>>     { .compatible = "brcm,dpfe-cpu-v3", .data = &dpfe_api_v3 },
> >>> +   { .compatible = "brcm,dpfe-cpu-v4", .data = &dpfe_api_v4 },
> >>>
> >>
> >> No, use SoC specific compatible.
> >
> > This is not that simple because for a given SoC, the API implemented by
> > the firmware can change, in fact it has changed over the lifetime of a
> > given SoC as firmware updates get rolled out. Arguably the dialect
> > spoken by the firmware should not have changed and we told the firmware
> > team about that but it basically went nowhere and here we are.
> >
> > The Device Tree gets populated by the boot loader which figures out
> > which API is spoken and places one of those compatible strings
> > accordingly for the kernel to avoid having to do any sort of run-time
> > detection which is slow and completely unnecessary when we can simply
> > tell it ahead of time what to use.
>
> Thanks for providing justification, quite reasonable. A pity that none
> of the commit msgs answered this way.

The real pity is how this API was designed, making all of this
necessary in the first place.

We can definitely spell out more clearly in the commit messages what
is going on and why all of this is needed. I'll pull all the pieces
together from the various responses. As long as there's a way we can
reasonably implement what we need, we'll be happy.

> Best regards,
> Krzysztof
