Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3646A793208
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 00:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239290AbjIEWgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 18:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjIEWgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 18:36:07 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF64CED
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 15:36:03 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-500b0f06136so5347853e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 15:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693953362; x=1694558162; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqBAjXdhOu8rNG8LZMfu2X/hCbioMgAzV1nWy8X96U8=;
        b=G1SddAwlgGlIc/1ZFZTrLPuyFIL3pkcTb3hcA5H5x6PEv8/1OP6P/hrgWIRkC5wanV
         NM8XIdMH9XM8cpp9hCUTZ7LpW5Toa7weRwP6YIS3OFYXAPNPBSK9ncBeMTkuTCmt1A2J
         rcnaylnZl5UuZGmwUhBz91PjPXRZZvGHeaHEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693953362; x=1694558162;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqBAjXdhOu8rNG8LZMfu2X/hCbioMgAzV1nWy8X96U8=;
        b=NLAurqUlyxDo0bVuz8AOBmKcralJkjkix8ONwEZzTd3zknuk+duXMcN8d/1q0/1AtW
         H8kXs/q8qaoui7kntk6uiMDTsGu8F00qHkyknfAAursiKHVZ3eUGFsPCWs6mUr4sAmW3
         Xpm593lBSHk84GdN+3YSG/0QuRoJ3365PtMkA6ZSjFX4lhwYc1fJHyexr//jcy1uxHis
         EtFa/uyKZnzveLXoilCiFo8JLKi6u1bCZ7LlgaxNy+EK/GgB+2VdNq7RG3MhHuF6Kkzp
         +YAqySX88NWMLpZEa2SKxU7agpnTpilWBanGaIybgPrgnRlX8y8HC9AXzR+8OdTAYEVE
         DOnw==
X-Gm-Message-State: AOJu0YzQzeuBfw/M0dHkdbLsESK2H6wrDO1eQ09kV5DuZvSfAIAP8w0k
        Ssz28ow9OetXtgsNFZkFUmw/4kIcTWa/llCc/2Z5fw==
X-Google-Smtp-Source: AGHT+IFEuggODTqIQUeNem7qYIdM/4a0tHs0r7nKkpG27Kc/WYRkH5LZUMm1RWDH7/xha6Fhn4IhMm50ZT6fmlDJJxg=
X-Received: by 2002:a19:e00d:0:b0:500:ba68:2344 with SMTP id
 x13-20020a19e00d000000b00500ba682344mr863179lfg.20.1693953361989; Tue, 05 Sep
 2023 15:36:01 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 Sep 2023 17:36:01 -0500
MIME-Version: 1.0
In-Reply-To: <ZPCcevAt4CwCADe2@smile.fi.intel.com>
References: <20230831011405.3246849-1-swboyd@chromium.org> <20230831011405.3246849-3-swboyd@chromium.org>
 <ZPCcevAt4CwCADe2@smile.fi.intel.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 5 Sep 2023 17:36:01 -0500
Message-ID: <CAE-0n53=8NEO0To++WYj+PVgGDNu5M3Tz93O+fsBo8_aAhr8EQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] platform/x86: intel_scu_ipc: Check status upon
 timeout in ipc_wait_for_interrupt()
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

Quoting Andy Shevchenko (2023-08-31 06:58:18)
> On Wed, Aug 30, 2023 at 06:14:02PM -0700, Stephen Boyd wrote:
> > It's possible for the completion in ipc_wait_for_interrupt() to timeout,
> > simply because the interrupt was delayed in being processed. A timeout
> > in itself is not an error. This driver should check the status register
> > upon a timeout to ensure that scheduling or interrupt processing delays
> > don't affect the outcome of the IPC return value.
> >
> >  CPU0                                                   SCU
> >  ----                                                   ---
> >  ipc_wait_for_interrupt()
> >   wait_for_completion_timeout(&scu->cmd_complete)
> >   [TIMEOUT]                                             status[IPC_BUSY]=0
> >
> > Fix this problem by reading the status bit in all cases, regardless of
> > the timeout. If the completion times out, we'll assume the problem was
> > that the IPC_BUSY bit was still set, but if the status bit is cleared in
> > the meantime we know that we hit some scheduling delay and we should
> > just check the error bit.
>
> Makes sense, thanks for fixing this!
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Also see below.
>
> ...
>
> >  /* Wait till ipc ioc interrupt is received or timeout in 10 HZ */
>
> Not sure if this comment needs to be updated / amended.

Or removed?
