Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDDB78DC52
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242273AbjH3Soa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245126AbjH3ObC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:31:02 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB9B1A2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:30:59 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5008d16cc36so8834426e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693405855; x=1694010655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Z1Z9G4G/KVFZhr9R3sGbutXUCNsEgKocPQNRqGJxWY=;
        b=CQdKIkaLl/QEMaQQAghV3Eo0qUT1QT2VAmg6iQ1K2utQxi5eQjCnlJMWqFVdNIuIrm
         8bGLH87ZwUX/N/Fz5jJlqnz5Kv/mYuAD85ek2Zs/jB9zVi2KgLMY+a+CCfm5TVeP45xo
         SjfC43jpee9/0x6uehLKJobGo6in5iB5oOe0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693405855; x=1694010655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Z1Z9G4G/KVFZhr9R3sGbutXUCNsEgKocPQNRqGJxWY=;
        b=BDkkM+dsuUkRsYQFI0UuNrx0Kba+q4299OQP6N905QkziRl7eOy+U3defN6lU46kS0
         W5xA0uf4mzkPhTJbh0Lp8GfnmY6x5MdPFX1Mv66C3/akTLsLkrp4GCc4cjicx8zCAK9B
         G/563ZO6QCVBBv3MrIKHmUU5e0rf5wTv3mPGo4NkWNLSIWdKv8ja1XgBhnUJWuLWqt1+
         pzpHGb+dBhHrk9Glq1yQuDfl2crHgtWe929fQqZ7XR3Sy3ENPnA5t2vkAJ/jBNrgmCUu
         kEfcvyhw0Dtl2IckiVEEQ08sNn1KRmCSUWF6YSIoFlvlNXZ7K20uPsQwnpndavrC75zX
         nVJQ==
X-Gm-Message-State: AOJu0YxOjnu9wCxfT6RCBRL/n9jA9F8Cv6bjTFkpX/fJpkOCuROLUhfv
        qbQVMTJTSiwPfQ9GjiF9Xydg2JVlLY6EnMdL3dCOLm1/
X-Google-Smtp-Source: AGHT+IEP9EMRy2AnO5QlzyuPskUwjbABwmvuUHNLhqOOyaCq7ob10ASFUUoY2MaCc1OW5qjTmQi94A==
X-Received: by 2002:a05:6512:b8e:b0:4f8:6d53:a68f with SMTP id b14-20020a0565120b8e00b004f86d53a68fmr1854796lfv.64.1693405854787;
        Wed, 30 Aug 2023 07:30:54 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id vi18-20020a170907d41200b0099c53c4407dsm428991ejc.78.2023.08.30.07.30.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 07:30:53 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3fe2d620d17so97055e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:30:53 -0700 (PDT)
X-Received: by 2002:a05:600c:4f93:b0:3f4:fb7:48d4 with SMTP id
 n19-20020a05600c4f9300b003f40fb748d4mr325936wmq.3.1693405853267; Wed, 30 Aug
 2023 07:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com> <20230830-fp5-initial-v1-2-5a954519bbad@fairphone.com>
In-Reply-To: <20230830-fp5-initial-v1-2-5a954519bbad@fairphone.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 30 Aug 2023 07:30:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WS2hgY=bQjLOs3Fdp8pbZyMsaS-0BpoxPq90Etfi+Xuw@mail.gmail.com>
Message-ID: <CAD=FV=WS2hgY=bQjLOs3Fdp8pbZyMsaS-0BpoxPq90Etfi+Xuw@mail.gmail.com>
Subject: Re: [PATCH 02/11] nvmem: qfprom: Mark core clk as optional
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 30, 2023 at 2:58=E2=80=AFAM Luca Weiss <luca.weiss@fairphone.co=
m> wrote:
>
> On some platforms like sc7280 on non-ChromeOS devices the core clock
> cannot be touched by Linux so we cannot provide it. Mark it as optional
> as accessing qfprom works without it.
>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/nvmem/qfprom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Are you actually testing burning fuses from the OS, or are you just
using the nvmem in "read-only" mode? From comments in the bindings, if
you're trying to burn the fuses then the clock is required. If things
are in read-only mode then the clock isn't required.

When I compare to the driver, it seems like the driver assumes that if
more than one memory region is provided then you must be supporting
burning fuses. The bindings agree that having 4 memory regions
specified means that the nvmem supports burning and 1 memory region
specified means read-only. The extra 3 memory regions in the nvmem are
all about fuse burning, I believe.

So maybe the right fix here is to just change your dts to specify one
memory region?

-Doug
