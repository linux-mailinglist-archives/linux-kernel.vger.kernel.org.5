Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926F8799182
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 23:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245374AbjIHVaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 17:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjIHVaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 17:30:04 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F962E46
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 14:30:00 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bd0bc8b429so43781961fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 14:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694208598; x=1694813398; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2qDdudysz/QEH80r6EgYVihuuCpmrfhapLn+3lG+eMs=;
        b=lk0M8VDSF4dVYW7KUFYFSZvb9khIM4fDolhIf3s+VJCbnJM+5WIgsBlIGxDiWWMjZr
         8ZDu1/fA5C2eP02mlVAwDbqFqsdw4ZfwI38/hxYEhgZ2xHPM5RHvy7/pfNN3Gh3TApso
         W4NwWY/C/2RlCkeIinLQMK2MhB6n2m5C50mr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694208598; x=1694813398;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qDdudysz/QEH80r6EgYVihuuCpmrfhapLn+3lG+eMs=;
        b=YZNH0QCdva8ksQSSVJfuu+UIknojiun4AJPX0mmw72KLH6+GZtxUHk4raRsNKn+v20
         dK2kHzwwLwR3XGvHcxPC448UlFghsHUul741o31/Hs4hLtk3dZyU/L+b2UNWcr0K320P
         NS/uG6sSW/t5Jtpb7jSfFC0u+7YOdEPmNIOv4/4J/5aneqCW6yuVMp8XgKi5QVCs8Oro
         nTkee6NfN/eGjcSEwU1cEaWBHKhoFt52/Ep7zcIYuGXbwSsZiap9k3bY4hyaELPrNBHF
         QGzvbmxhCTR2ecCwHbjx1tJgh4OpMMfxJiz3gfpLtXx1/rstFLanPD6MiIYr0J6nwG/H
         mciQ==
X-Gm-Message-State: AOJu0YzbUTA0cUT23Ogr59jUu1jvltDqzmA01L/Cpf5KnObMxve0iY3D
        57Uc41gAihCzVpF/FMNKRcwGD1RWWG9v0aaB30FvzQ==
X-Google-Smtp-Source: AGHT+IHLxc6Pt+LOz/vNpPU9ODhICc7VbTgK0zhU7UukD8vadAWyMGPJPmRY8v9AfR6NmoYisAx+6DTfyXICbK2T2eY=
X-Received: by 2002:ac2:4839:0:b0:500:ac71:8464 with SMTP id
 25-20020ac24839000000b00500ac718464mr2558487lft.66.1694208598596; Fri, 08 Sep
 2023 14:29:58 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 8 Sep 2023 16:29:57 -0500
MIME-Version: 1.0
In-Reply-To: <20230908045946.GM1599918@black.fi.intel.com>
References: <20230906180944.2197111-1-swboyd@chromium.org> <20230906180944.2197111-2-swboyd@chromium.org>
 <20230907053513.GH1599918@black.fi.intel.com> <CAE-0n51Ut296M2ZetuzXGpX32pS11bbWzfcbaFfqNxgSjzafJw@mail.gmail.com>
 <20230908045946.GM1599918@black.fi.intel.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 8 Sep 2023 16:29:57 -0500
Message-ID: <CAE-0n52VoAFopSgXiLMoSzBAdSLg4=x3i2R9Agjz5L7o8=1hew@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] platform/x86: intel_scu_ipc: Check status after
 timeout in busy_loop()
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mika Westerberg (2023-09-07 21:59:46)
> On Thu, Sep 07, 2023 at 01:11:17PM -0700, Stephen Boyd wrote:
> >
> > We can't use readl_busy_timeout() (you mean readl_poll_timeout() right?)
> > because that implements the timeout with timekeeping and we don't know
> > if this is called from suspend paths after timekeeping is suspended or
> > from early boot paths where timekeeping isn't started.
>
> Yes readl_poll_timeout(). :)
>
> I don't think this code is used anymore outside of regular paths. It
> used to be with the Moorestown/Medfield board support code but that's
> gone already. Grepping for the users also don't reveal anything that
> could be using it early at boot.

Ok. Assuming this isn't used from paths during suspend/resume when
timekeeping is suspended it look like readl_poll_timeout() is the
shorter and simpler approach. So if that works for you I'll send another
round with that and a fix for the ipcdev being overwritten.
