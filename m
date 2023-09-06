Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B984794472
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 22:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241877AbjIFUXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 16:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236993AbjIFUWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 16:22:52 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D435D19AD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 13:22:45 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bcfd3220d3so4552021fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 13:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694031764; x=1694636564; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxKCsV8R8YrR5Gy4S8qpXFuMk6MLJhqEnRXr9jkGcto=;
        b=EhfnE2/SPpAjyK8S4cYUaToslBQkg4F8mbbZkbSAjaz4G9VDCAE04tBN4H/3Mji1O7
         P18hBCHGL96otMv4HbyqPUtF7RSppICJaOK8awnHlN0wBr+1D77Qsc3bLyz3b3Rudh1G
         VfPB2uAv8Se9parOuwKzAJcCzhbeFRYiDCQ5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694031764; x=1694636564;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxKCsV8R8YrR5Gy4S8qpXFuMk6MLJhqEnRXr9jkGcto=;
        b=Vq/8taGd0XCAhCg/pZK3izy6n26ON3wEOF7e7u2rBReN/dVMtfJnhlg4oJYpdwq+2H
         YKf2+fTl/8wOu73bGKQEQugeFO8fYn7zCfsPsYPaTJX7jWjpXuIAdFZSEnVRt0K/ncQ4
         TG86R/5ADE/RuZVNYx4CqmL9xOGF2uzQkTD2N+EOgiFYK12mKA0KzJbzHIFKTi7WrPz0
         Fg/yOz5MF2lrkZRQuMRE5n1szNyYTNQ38MTxcHOuPiaVzOVuonmoOfc4KN4Kq3NR1EXa
         yBU6ZBUWsJ8cr4sygspNeJTqgdNIC3gnmM+dE35uieOFbsDvXlapGibEv99b/4Cl9qeB
         bsLQ==
X-Gm-Message-State: AOJu0Yz+hgefz7d4JBkwaDCxRgLSQBLHdBjGCL2PM+iVeM53dNdE37bO
        32YBbx9CEKWPg4SYgC7q3lt3LhrCwEnL/vTUXbIItA==
X-Google-Smtp-Source: AGHT+IEmvetndVdOFFwz7V6Ymy0S4rpC+9TPoqGCwOVPobwU6fcOpZdLTjsBJP1lmQrg+aBzt/1Fql+MvEJ3cIL85Eo=
X-Received: by 2002:a2e:8756:0:b0:2b6:e2aa:8fbc with SMTP id
 q22-20020a2e8756000000b002b6e2aa8fbcmr3268617ljj.8.1694031764129; Wed, 06 Sep
 2023 13:22:44 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 6 Sep 2023 15:22:43 -0500
MIME-Version: 1.0
In-Reply-To: <ZPjdZ3xNmBEBvNiS@smile.fi.intel.com>
References: <20230906180944.2197111-1-swboyd@chromium.org> <20230906180944.2197111-4-swboyd@chromium.org>
 <ZPjdZ3xNmBEBvNiS@smile.fi.intel.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 6 Sep 2023 15:22:43 -0500
Message-ID: <CAE-0n53iGCL3q=CsDKZr28eMjx40miLNG6+-jf12JKMxuAKkKg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] platform/x86: intel_scu_ipc: Fail IPC send if
 still busy
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andy Shevchenko (2023-09-06 13:13:27)
> On Wed, Sep 06, 2023 at 11:09:43AM -0700, Stephen Boyd wrote:
> > It's possible for interrupts to get significantly delayed to the point
> > that callers of intel_scu_ipc_dev_command() and friends can call the
> > function once, hit a timeout, and call it again while the interrupt
> > still hasn't been processed. This driver will get seriously confused if
> > the interrupt is finally processed after the second IPC has been sent
> > with ipc_command(). It won't know which IPC has been completed. This
> > could be quite disastrous if calling code assumes something has happened
> > upon return from intel_scu_ipc_dev_simple_command() when it actually
> > hasn't.
> >
> > Let's avoid this scenario by simply returning -EBUSY in this case.
> > Hopefully higher layers will know to back off or fail gracefully when
> > this happens. It's all highly unlikely anyway, but it's better to be
> > correct here as we have no way to know which IPC the status register is
> > telling us about if we send a second IPC while the previous IPC is still
> > processing.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Also see below.
>
> ...
>
> > @@ -450,6 +468,12 @@ int intel_scu_ipc_dev_simple_command(struct intel_scu_ipc_dev *scu, int cmd,
> >               return -ENODEV;
> >       }
>
> >       scu = ipcdev;
>
> Side observation: Isn't this a bug? We should not override the supplied parameter.

If it is a bug that would be great to know. I wanted to make an API that
got the scu if it wasn't busy but then I ran across this code that
replaced the scu with ipcdev.
