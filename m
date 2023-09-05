Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBA7793233
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 00:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjIEW4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 18:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242561AbjIEW4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 18:56:22 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5960B11F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 15:56:17 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-500bbe3ef0eso417331e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 15:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693954575; x=1694559375; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4NGXeEczgA9LphP4UdxC38RekZBY8qrCBSM7+Stq+6I=;
        b=aBXKCU36JS11wSUlj4lIPcqgu7aj9E6PfV5E3/GvmeeofDI5xQ/0kavv1v37id+nel
         7zBYvHa2Qr+ic3YpkY7Q0IXuhWnUxC1PiidUFGhSALFgUDFtZsOObvaRO1G1IIoZBGaO
         A8wG8KaXPueY/sVH0N/FLpm+qqSsirTfZu7HI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693954575; x=1694559375;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NGXeEczgA9LphP4UdxC38RekZBY8qrCBSM7+Stq+6I=;
        b=KPOrGFjQc3XH7TggNl/DCBiuXQEOtppCJYmX7dDoi+HKDCpWDiHO/nULLamknnT1Rv
         EwFK7kjjuP+k6r45MH5gz5XEQaG1Rhgr0ayFnLJu1Hnpvh9Oyr7fMgOF9h1cfrov4Nxe
         9rg3yOqscoIoR4+F1FcBfMiaHvc4KyN84m3uODkXpmUipneTuXgRk67Ta1kZCuCiEmg2
         FapJMblowd1ANYqepD66sxqgPWGeCQepSH731tWZg8duYeZwAsNklJbjHx7Xd8QHPocq
         GuEe5SQ2c2LgiE3W9iSZ/iHKr1Dco4IZsaYgUuZaEWXknphJ/lDiShuu4u8/e8fiX7Ib
         lHLA==
X-Gm-Message-State: AOJu0Yy2UlMAeZLbP4BTtFxREjhEvL4oUpczXrPku0PCrXwU4ilL9Xgg
        KfWOFiLB8jfTAqFmSrLWasBZSDCfy5AdzUllkYJjIw==
X-Google-Smtp-Source: AGHT+IHYUtjBkMfDU9GXRAamcogYrs+yiDDeqP/qm65g/NIerCdBZ0EqaUtXVDrQlBvmo3WeXpe55hJMABEEFT3h5sI=
X-Received: by 2002:a05:6512:2256:b0:4fe:13c9:2071 with SMTP id
 i22-20020a056512225600b004fe13c92071mr395748lfu.2.1693954575649; Tue, 05 Sep
 2023 15:56:15 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 Sep 2023 17:56:15 -0500
MIME-Version: 1.0
In-Reply-To: <321578a9-91fb-4733-b4c7-82dcc0ec8f8f@linux.intel.com>
References: <20230831011405.3246849-1-swboyd@chromium.org> <20230831011405.3246849-3-swboyd@chromium.org>
 <321578a9-91fb-4733-b4c7-82dcc0ec8f8f@linux.intel.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 5 Sep 2023 17:56:15 -0500
Message-ID: <CAE-0n514jMG3ckYF58koSamHDYiuoxry7cyuoNMGjygwQOCb9g@mail.gmail.com>
Subject: Re: [PATCH 2/3] platform/x86: intel_scu_ipc: Check status upon
 timeout in ipc_wait_for_interrupt()
To:     Hans de Goede <hdegoede@redhat.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuppuswamy Sathyanarayanan (2023-08-31 07:27:35)
>
>
> Since you are not using the return value, I would not use time_left. I think the
> following version is easy to read. But it is up to you.
>
> wait_for_completion_timeout(&scu->cmd_complete, IPC_TIMEOUT)
>
> status = ipc_read_status(scu);
>
> if (status & IPC_STATUS_BUSY)
>    return -ETIMEDOUT;
>
> if (status & IPC_STATUS_ERR)
>    return -EIO;
>
> return 0;
>
> With above fixed, you can add

Thanks! That's a lot better.
