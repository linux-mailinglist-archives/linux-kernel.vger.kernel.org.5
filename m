Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EC87AF0FD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbjIZQm2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Sep 2023 12:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbjIZQm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:42:26 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DADBF;
        Tue, 26 Sep 2023 09:42:20 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-57b68555467so672930eaf.0;
        Tue, 26 Sep 2023 09:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695746539; x=1696351339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kCKtZzVEPLURLD/XA5Ia6gWfPjg1Q/OgPrW15KMXS4=;
        b=Rcog3NUpfC0RwTygrn3cFhVymK2RJd/rB1fRltMKPL69GquDJieXMaQn1AfWax2zzR
         0ni0UR3GnBfplr6KSlhK1Q+Rfkb2qYbh79r/c/KsGischj2NALIKuCZPbezFJFSlL5rk
         bf4Cw9kF/G0z46v9uYAUZJprVfrTC8cc3elKOXzZhgykaFhfFxcFnKg6RLjurx+TDq2G
         m1QIoH1Fu4ZBokv+bfCTBhARzEcOkHKHs/EGhqUD/K5+OuxivdvDADsbTNlNkhjXQs6w
         JyZdcfnfdLq+3iOxoKwuJvUgQwy8thGA+fUFO8Yf5MoPoLOeiXfEx8AwxAajsllp0l2j
         4ptw==
X-Gm-Message-State: AOJu0YyMVujEyOH2BlNAZFFyL6GQU7GcOf6W3M/kqhz1cuLe9BF2VW/k
        1nB1x7irEF/+nz0MOBR7qwRH99To/7/JiUTWJk8=
X-Google-Smtp-Source: AGHT+IGvBonHN0fdxI56wOYu4Nz8TpfjHmGtue8FGFtL5uQvBetZe5mdoCWbrgqOkOXQncIV4rZljZEZLJzJ2PNlejU=
X-Received: by 2002:a4a:e8c4:0:b0:57b:73f6:6f80 with SMTP id
 h4-20020a4ae8c4000000b0057b73f66f80mr9270220ooe.0.1695746539202; Tue, 26 Sep
 2023 09:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230922054552.3570-1-raag.jadav@intel.com> <7537e654bfda45ecac953392267e271e37d28ea4.camel@crapouillou.net>
In-Reply-To: <7537e654bfda45ecac953392267e271e37d28ea4.camel@crapouillou.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Sep 2023 18:42:07 +0200
Message-ID: <CAJZ5v0i=+BVZ4D4kEx7jPKiCuB4tuUMYX3tEJ5c-GVca++pJDg@mail.gmail.com>
Subject: Re: [PATCH v4] PM: Fix symbol export for _SIMPLE_ variants of _PM_OPS()
To:     Paul Cercueil <paul@crapouillou.net>,
        Raag Jadav <raag.jadav@intel.com>
Cc:     len.brown@intel.com, pavel@ucw.cz, Jonathan.Cameron@huawei.com,
        andriy.shevchenko@linux.intel.com, rf@opensource.cirrus.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
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

On Mon, Sep 25, 2023 at 11:01 AM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi,
>
> Le vendredi 22 septembre 2023 à 11:15 +0530, Raag Jadav a écrit :
> > Currently EXPORT_*_SIMPLE_DEV_PM_OPS() use EXPORT_*_DEV_PM_OPS() set
> > of macros to export dev_pm_ops symbol, which export the symbol in
> > case
> > CONFIG_PM=y but don't take CONFIG_PM_SLEEP into consideration.
> >
> > Since _SIMPLE_ variants of _PM_OPS() do not include runtime PM
> > handles
> > and are only used in case CONFIG_PM_SLEEP=y, we should not be
> > exporting
> > dev_pm_ops symbol for them in case CONFIG_PM_SLEEP=n.
> >
> > This can be fixed by having two distinct set of export macros for
> > both
> > _RUNTIME_ and _SIMPLE_ variants of _PM_OPS(), such that the export of
> > dev_pm_ops symbol used in each variant depends on CONFIG_PM and
> > CONFIG_PM_SLEEP respectively.
> >
> > Introduce _DEV_SLEEP_PM_OPS() set of export macros for _SIMPLE_
> > variants
> > of _PM_OPS(), which export dev_pm_ops symbol only in case
> > CONFIG_PM_SLEEP=y
> > and discard it otherwise.
> >
> > Fixes: 34e1ed189fab ("PM: Improve EXPORT_*_DEV_PM_OPS macros")
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
>
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Applied as 6.7 material, thanks!
