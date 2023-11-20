Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FC07F0F3B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjKTJkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjKTJkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:40:15 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE358A7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:40:11 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a00191363c1so29821266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700473210; x=1701078010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CV6jnuj0MIJn5B1cSBOWhgza7MPZBJRiYSVUNCCfxoQ=;
        b=tnKBTdqTH2v5QIK/8edrvzQFZb8apHTEAfY+wELANUcP85EWRU6FKdoInsFm2HiZzc
         hEelushABY33DtQO5HoRg0ZZX+JwbKmXktlT3f7vYALWMk9An5kIE2MuVfRs0Qw2MugE
         tKdSBBmfJOVg5MBNV5SB1bqOmaRtqRgxnVgFvGAiIo5bE1lfarRG8ABSybfl7tJ+qp42
         BiGTMnip3Y0Bc/dZhDoQZzceWcblOysCuYe4/EeltHLTV4RomX7i7BQhXFymP89KP4ES
         0TnEP6BD7TL9DXRQqy4asHudx6ACdh5UiHwMOLlg4hnTyY456LTD5NmiXbHxCrvntYgX
         9/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700473210; x=1701078010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CV6jnuj0MIJn5B1cSBOWhgza7MPZBJRiYSVUNCCfxoQ=;
        b=v4Vo4vww9aji0tKTY2fA+9x1xVPJ9iRk1klfMSxqvwDW5+5JzaqBBXIwSezGmY2qPZ
         V7P2saWZSOAGvHV/RgylAdnBOmMeicze5WFmu0Yrj8AbNKL6g3qpz+4JLLrGEPfIluUJ
         +bk+WPilq40yIe4HVUHFMpQHsWm163NJp0GoYGttnNiE1SXbeHpLPvTIDVrwcOKwnS58
         XN5cntsfo2l11ZmOp69n1jTvI0XVsbMyIMxFuqQDwzxLE2h8+XVJXdZDfD5Rw0fuIkg8
         NMG0XC8vUtt4/x4FI0oDsXYtJlwhin45Q6xgTFXEsO5drNDqCkT0AiffQGDhYV5WmQYR
         lrDg==
X-Gm-Message-State: AOJu0YxBGw5OlS0hpuZYr3sDhSNVTPoORs7NXkPjl3633T/i6rrXCu6V
        81f8hzM+cfUwQi6VnxvnEtYtg5YYKrAA4mZcFBJchg==
X-Google-Smtp-Source: AGHT+IHpuPkkpzf6HvIRoyFCjRddB6IaTOcD9D4X7AuwnDGekaJENUnnI2Ieq7XREu67tB5Cf1SPCBLE6vU7Bq9YmRk=
X-Received: by 2002:a17:906:41:b0:9bf:6200:fe33 with SMTP id
 1-20020a170906004100b009bf6200fe33mr4386460ejg.16.1700473210292; Mon, 20 Nov
 2023 01:40:10 -0800 (PST)
MIME-Version: 1.0
References: <20231117173650.21161-1-johan+linaro@kernel.org> <20231117173650.21161-4-johan+linaro@kernel.org>
In-Reply-To: <20231117173650.21161-4-johan+linaro@kernel.org>
From:   Shawn Guo <shawn.guo@linaro.org>
Date:   Mon, 20 Nov 2023 17:39:59 +0800
Message-ID: <CAAQ0ZWTbAqnX2te5SEMT+q_FyHY5jopDciqF6sY7a9nr76f0QA@mail.gmail.com>
Subject: Re: [PATCH 3/3] USB: dwc3: qcom: fix ACPI platform device leak
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2023 at 1:38=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> Make sure to free the "urs" platform device, which is created for some
> ACPI platforms, on probe errors and on driver unbind.
>
> Compile-tested only.
>
> Fixes: c25c210f590e ("usb: dwc3: qcom: add URS Host support for sdm845 AC=
PI boot")
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
