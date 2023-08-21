Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CFC7826D5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 12:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbjHUKOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 06:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbjHUKOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:14:36 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579CACA;
        Mon, 21 Aug 2023 03:14:34 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1bbdddd3c94so1972438fac.0;
        Mon, 21 Aug 2023 03:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692612873; x=1693217673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xix+bfwoZhUEybAXvXyM541ugcckuk0KY7O535Gb2DM=;
        b=plrS0m6n9OfUCHYcoyhYk7u/Y1yLWvMclWRsGPxkgUFP9v9PVdlEmYILQPCPSbNLlg
         y9fKe21iMRs1/nyC4JZWbKdmnnumU5RZmamfEiJssQiM+1aPuLHiq+BISok0mo4e8KFS
         K6nyk//l4S2WXfephrzlE4Mr9xzTbDHG6vcdI390UDWAbmSvCW8h/DEGclAtonT+op9D
         5PyHrNg/Uqw20kLr2tyxu0HD8YeWqWCsIBs71Gm5Y1RKE2oIQzHEVfqTXt2HIGQHRtnl
         Ob6J/BoMPWZitfrF6dxk61GTtDHc3XBQ9NXouMRZKSyopzvPnID4I72wcwucadOWwuYm
         rJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692612873; x=1693217673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xix+bfwoZhUEybAXvXyM541ugcckuk0KY7O535Gb2DM=;
        b=TVqmc9V+lP5cP+cgRX7fFnxBnJFKrV6syelgQMWikWI650EsS3Qfrc3g8S2fXGR0X5
         64qj2zj250TmNP+UZSSgV3fS6mHgY450VhgPZdUVmoYZA4DkNzngvYebfrvdLcCRvAXH
         4mu6Y0K6p/5PfdUgm114/N9X+3lOhKvt54Bf5lrMWRdRHTJ05ytxjKY13Vnu4HK5zcT/
         w2SQaYMKV5TQijL+7mUp90CBovmeWXdZc/tGDRheEP1sXCF23FWNco9GskjA6yhCs9VR
         T1NT1XoX7+4HeubrsNtDQV9v6qhgODPT0kTeofC3mDviAbTghoXpcjROnMrORPubCGyX
         fSxw==
X-Gm-Message-State: AOJu0YygLXrReDobRCdHOVUcSh873g/MN/61AUAGAIdghWsITnUunn6Z
        ijMHknF/Cfy+0PVHuG1vRuazqWycaucfo4a7XwQ=
X-Google-Smtp-Source: AGHT+IHkf5UIFyWgI7XeEmpIKxSHHnOsD66h0oMJAD35s387UVY/ZAJOQy+7BT8gP97RKxNH6JUpMj6Ru2vsxEunO9Y=
X-Received: by 2002:a05:6870:3307:b0:1ba:3ff0:493c with SMTP id
 x7-20020a056870330700b001ba3ff0493cmr8916032oae.19.1692612873439; Mon, 21 Aug
 2023 03:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230816164641.3371878-1-robimarko@gmail.com> <20230816164641.3371878-2-robimarko@gmail.com>
 <e89b4a5a-e634-45b5-a8dc-cf7d1a968ccc@linaro.org>
In-Reply-To: <e89b4a5a-e634-45b5-a8dc-cf7d1a968ccc@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Mon, 21 Aug 2023 12:14:22 +0200
Message-ID: <CAOX2RU7R2q1R5W1H1KekHy-QdRspcPx9fHGG1pzxXAbw_5tiww@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] firmware: qcom_scm: disable SDI if required
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_gurus@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_mojha@quicinc.com, computersforpeace@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2023 at 19:33, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 16.08.2023 18:45, Robert Marko wrote:
> > IPQ5018 has SDI (Secure Debug Image) enabled by TZ by default, and that
> > means that WDT being asserted or just trying to reboot will hang the board
> > in the debug mode and only pulling the power and repowering will help.
> > Some IPQ4019 boards like Google WiFI have it enabled as well.
> >
> > Luckily, SDI can be disabled via an SCM call.
> >
> > So, lets use the boolean DT property to identify boards that have SDI
> > enabled by default and use the SCM call to disable SDI during SCM probe.
> > It is important to disable it as soon as possible as we might have a WDT
> > assertion at any time which would then leave the board in debug mode,
> > thus disabling it during SCM removal is not enough.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> [...]
>
>
> > +     /*
> > +      * Disable SDI if indicated by DT that it is enabled by default.
> > +      */
> > +     if (of_property_read_bool(pdev->dev.of_node, "qcom,sdi-enabled"))
> > +             qcom_scm_disable_sdi();
> Should we care about the return value?

I dont really see a point, as we cant really do anything about it if it fails.
Also, the SDI SCM call seems to have weird return codes, for example, it works
but it returns 2.

Maybe somebody from QCA can shine some light on that?

Regards,
Robert
>
> Konrad
