Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBB5784AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 22:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjHVUFS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Aug 2023 16:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjHVUFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 16:05:17 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2961DCE3;
        Tue, 22 Aug 2023 13:05:16 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so311985a12.0;
        Tue, 22 Aug 2023 13:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692734715; x=1693339515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6nEly565Pd1n4WCOmXfLlZXqFmNl3e/Ja0A4TkYgo6M=;
        b=JfABTYuDcKNUNptaVknLE+zVdd8OhcYdhZnX3P0LhRQ3Or2/UTzQl9rTiumqSm6oGm
         0tdpGCtm7qmNpDcpo9048vZ/e/B7OZvC5dm0/0CrRZosP/CCPYuPWDzT5HDhXaBhuIDp
         xXcIkc0Ht9pa2koTWRdj3P74Dn6fATNeXmdj3g/NSGI2McgfyqNC9B6bCGF7p64vw3gG
         npv7UGDyTsyLTMJJKE2zUBMctpGoAoN/B4I3wLoy36xHQsTNHjjj1l4tvFAoswAADS0g
         cWG97NDPq/Dj7UdXUR0usZzD55vWSQpmGd+ejRq3oncCiyL2Kie2qDlCxfhApd4KGygy
         h9KA==
X-Gm-Message-State: AOJu0YxktNqRVzjqfYo5GNODGdfP+fjyfG5ViDqDhvihA2GghTBHPdAA
        NMoB9NXWjbzl+93HSGmuG7pnyJYWXQAl8xe6Tnk=
X-Google-Smtp-Source: AGHT+IG6mc3lJzxWNu/ElWNj2ObP6RcbJ1uBedWK259bxTSk3JV+Q6upDJQ61fv8Xf8AiZswjscDuYPw1TcteOJXnTI=
X-Received: by 2002:a05:6a20:7da2:b0:13e:7439:1449 with SMTP id
 v34-20020a056a207da200b0013e74391449mr12997402pzj.0.1692734715646; Tue, 22
 Aug 2023 13:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230810162119.152589-1-ulf.hansson@linaro.org> <DU0PR04MB94175C3C8869A61403975E76881AA@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB94175C3C8869A61403975E76881AA@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Aug 2023 22:05:03 +0200
Message-ID: <CAJZ5v0iBOSnSdMitUHGk6aUJaA6+6NFOLP06FJJai-Fe3kpOnQ@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: Add helpers to allow a device to remain powered-on
To:     Peng Fan <peng.fan@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Patrice Chotard <patrice.chotard@st.com>,
        Ajay Agarwal <ajayagarwal@google.com>,
        Michael Shavit <mshavit@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 11:40 AM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: [PATCH] PM: sleep: Add helpers to allow a device to remain
> > powered-on
> >
> > On some platforms a device and its corresponding PM domain, may need to
> > remain powered-on during system wide suspend, to support various use
> > cases.
> > For example, when the console_suspend_enabled flag is unset for a serial
> > controller, the corresponding device may need to remain powered on.
> > Other use cases exists too.
> >
> > In fact, we already have the mechanism in the PM core to deal with these
> > kind of use cases. However, the current naming of the corresponding
> > functions/flags clearly suggests these should be use for system wakeup.
> > See device_wakeup_path(), device_set_wakeup_path and
> > dev->power.wakeup_path.
> >
> > As a way to extend the use of the existing mechanism, let's introduce two
> > new helpers functions, device_awake_path() and device_set_awake_path().
> > At this point, let them act as wrappers of the existing functions. Ideally,
> > when all users have been converted to use the new helpers, we may decide
> > to drop the old ones and rename the flag.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

Applied as 6.6 material, thanks!
