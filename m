Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E377DBD7C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbjJ3QJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjJ3QJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:09:44 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499AEE6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:09:42 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7d9d357faso43714327b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698682181; x=1699286981; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wr/jxaJ7QqShhEcFIDq6cD/wBcEhf/ws8RdosBofh7o=;
        b=I4+HEgGui6Mn7RytlAGqxxW3SG01q3esXmnYL5UssH+i9Z2V5fIYM3SgHX9wQbbHS8
         Y0tVPdRd9IFhcKsZZE69RGge4KjXn2l+uosXUMiK4DmJnd+17oTaQIHKn+9HWHj8CioQ
         WUCjkKi2BsTrryqu9a1EliGUBB1AOI/CHwGw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698682181; x=1699286981;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wr/jxaJ7QqShhEcFIDq6cD/wBcEhf/ws8RdosBofh7o=;
        b=QSwZWOCti0XSc7/FPYxSfz0lTuPrBHTDy4SFGWfoZn47RMD59jHUH59DDnOiSZnINb
         T4tt+cLCR5ZaYv9QuLx58SQq+WNOEiNU3V3bvvSAKDIHaLTmfibsTSSHA0Bse1QBLPOw
         EK71sMd0mG1sWs68Jumtu8kjyveoCjzP68c/tF5CQZ55IkWOAv0S1NNS98ij4eQgKLeP
         Em4Pe39AYFQz6z0SSn5bGr7Zh0MhyOTC/wYAFqFVRFawBpz4XykpfutjbYHIaK8IXXQu
         ZWqEjCMg0+hxj8Lu8Cm6jUCmm6WAAy82bc5naoT+7eIH0wThI3pdvUTemAUO3x/+6zp1
         GHqw==
X-Gm-Message-State: AOJu0YwZ6lpHK9x0FnTQyggcXIsOKv5mbEmr+DPBwfpJx9gtmng0NSFe
        K02icRkxW7MvT+DUyt4xGNLdv1d8nGDiOZ/8YJb4XQ==
X-Google-Smtp-Source: AGHT+IHcpaBDZRHAegPcq5YcTF3Yh4eChLz0DkEBpyDv6q/El4KSwrY79izU/nCquH/9dMRPlV3TJcRn+Q6wErU6MFE=
X-Received: by 2002:a81:b603:0:b0:5a7:c777:2be1 with SMTP id
 u3-20020a81b603000000b005a7c7772be1mr9989396ywh.11.1698682181460; Mon, 30 Oct
 2023 09:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231027212916.1035991-1-markhas@chromium.org> <2b8335a7-4b9b-825-c1b8-84158aaf2c42@linux.intel.com>
In-Reply-To: <2b8335a7-4b9b-825-c1b8-84158aaf2c42@linux.intel.com>
From:   Mark Hasemeyer <markhas@chromium.org>
Date:   Mon, 30 Oct 2023 10:09:30 -0600
Message-ID: <CANg-bXCcNPjmQC9vgd1JJcV4QoruhhbeEg8o=S9K-22kb746kQ@mail.gmail.com>
Subject: Re: [PATCH v1] platform/x86/amd/pmc: Get smu version before reading
 dram size
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Sanket Goswami <Sanket.Goswami@amd.com>,
        platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
>
> Thank you for your patch. This has already come up but no acceptable patch
> has emerged since. Please see this thread for what needs to be done if you
> want to provide one (or maybe Shyam already has one which has just not
> been sent out yet):
>
> https://lore.kernel.org/platform-driver-x86/3b224c62-a1d8-41bd-aced-5825f5f20e66@amd.com/
>
> (Since this dram size is on an init path that always needs SMU version,
> the SMU version can just be called by the init unconditonally rather than
> adding more of this lazy initialization everywhere).

Thanks for pointing me to that thread. I think Shyam/AMD can come up
with a better long term solution, but it may be worth pushing this
patch through for a couple reasons:
1. Probing of the driver currently fails on STB enabled systems with a
Mendocino SoC. A slower boot time is better than the driver failing to
load IMO.
2. This patch only affects Mendocino SoCs, and was a suggested
solution from Mario in the thread you mentioned.

That said, I can also just disable STB for now...
