Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E090776FF1B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjHDK6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjHDK55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:57:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E09D49C5;
        Fri,  4 Aug 2023 03:57:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF1B361F9C;
        Fri,  4 Aug 2023 10:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB21C433CD;
        Fri,  4 Aug 2023 10:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691146629;
        bh=lbZSdb+lLKV7Au60KMEayyUewgOND9KVkB1sK/VtkaI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ElMIgrdmQPa8MNuUwQEyj7DYZJlNj2Fsni842WjWaDpm4IwKqLGpXUcFoKWYvOtaD
         UWXKg/aA3e8tu1i2k0WHTzze42dGsJobD7kbcYNsnqVRHYl3SplcjpwKe5HxT7x9QA
         JMaOx9/uTuKxk0De+9tgQEvnJ08g5e3ajvleUVsxBj6W5pPrlcDswKoDtZCnFbOvB+
         rQlMW3iaADwiQmZFdGJ90g7YT+EsobmZc4OzTS7spZnAiV/6BsSi+HK6A5ATMkHtOO
         zKU7C9gXJTGWlygb4MwbcVXMK2bmm7h0TXeKEVefBB/R5DOyedd11b7rv1V/NYsZPu
         sByOUmtKlPYKQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4fe3c7f16bbso3332203e87.0;
        Fri, 04 Aug 2023 03:57:09 -0700 (PDT)
X-Gm-Message-State: AOJu0YzLKY/XlDa5cJs14AHu49a43+uRNlrugcjHSAjJ+h2WtS5Sbygp
        VM++KvMk/PydKjnHdNND7X6EoRFDQmluRQ0wnNg=
X-Google-Smtp-Source: AGHT+IGOHqdFKuXv2e7rHiHuv5FYKwvdoYzd5DLCmJynTbIFaIbrkNLqDWnU2KUgGZ3Dpa2Xxu5tbHcP//ZVwIpG9B8=
X-Received: by 2002:a05:6512:1cd:b0:4fb:8f79:631 with SMTP id
 f13-20020a05651201cd00b004fb8f790631mr942049lfp.46.1691146626978; Fri, 04 Aug
 2023 03:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230730161906.606163-1-luzmaximilian@gmail.com>
 <20230730161906.606163-4-luzmaximilian@gmail.com> <CAMj1kXHOaEuP2Wds9ZU4RLx9oKhthvE=yR-Ju_Ka2boqTmTYNw@mail.gmail.com>
 <b8b82aee-45a5-5e56-1737-4ec78f6279c2@gmail.com>
In-Reply-To: <b8b82aee-45a5-5e56-1737-4ec78f6279c2@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 4 Aug 2023 12:56:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEWf=Wd8kgt=3AHUquE+NOZ6DMXUZam75_44qD8YPXHkg@mail.gmail.com>
Message-ID: <CAMj1kXEWf=Wd8kgt=3AHUquE+NOZ6DMXUZam75_44qD8YPXHkg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] firmware: Add support for Qualcomm UEFI Secure Application
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Johan Hovold <johan@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2023 at 19:09, Maximilian Luz <luzmaximilian@gmail.com> wrote:
>
> On 8/3/23 17:44, Ard Biesheuvel wrote:
> > On Sun, 30 Jul 2023 at 18:19, Maximilian Luz <luzmaximilian@gmail.com> wrote:
>
> [...]
>
> >> +/* -- Driver setup. --------------------------------------------------------- */
> >> +
> >> +static int qcom_uefisecapp_probe(struct auxiliary_device *aux_dev,
> >> +                                const struct auxiliary_device_id *aux_dev_id)
> >> +{
> >> +       struct qcuefi_client *qcuefi;
> >> +       int status;
> >> +
> >> +       qcuefi = devm_kzalloc(&aux_dev->dev, sizeof(*qcuefi), GFP_KERNEL);
> >> +       if (!qcuefi)
> >> +               return -ENOMEM;
> >> +
> >> +       qcuefi->client = container_of(aux_dev, struct qseecom_client, aux_dev);
> >> +
> >> +       auxiliary_set_drvdata(aux_dev, qcuefi);
> >> +       status = qcuefi_set_reference(qcuefi);
> >> +       if (status)
> >> +               return status;
> >> +
> >> +       status = efivars_register(&qcuefi->efivars, &qcom_efivar_ops);
> >
> > Will this also work if the EFI runtime services were already
> > registered by the time we reach this point?
>
> That's actually a good question. In short: No. However, let me explain
> that a bit:
>
> First, we assume that we're the only other non-generic provider
> (arguably, multiple non-generic providers don't make much sense on a
> single platform anyway, so I'd say in that case it's okay to fail here).
>
> Second, we assume that the generic ops are not going to be registered at
> all on the platforms that this implementation is used. In particular, on
> the platforms I've tested and heard reports from so far, "standard"
> efivars either aren't actively advertised as "supported" or they return
> EFI_UNSUPPORTED for all calls. So we assume that either the check in
> efisubsys_init() or in generic_ops_supported() prevents registration
> of the generic ops.
>
> Further, I'd hope that the uefisecapp would not be loaded if generic ops
> would be supported on such a platform, thus preventing instantiation of
> the respective client device.
>
> So the only issue that I can see is that if uefisecapp is loaded and
> generic ops are supported, we would need a way to choose one over the
> other. But I think that is fairly unlikely to happen and I think it
> would probably be best to sort that out then (e.g. by refusing to load
> this new driver with some additional check).
>
> Apart from that case, there should not be any timing issues that could
> cause registration to fail spuriously.
>

Fair enough.

The series looks good to me.

Acked-by: Ard Biesheuvel <ardb@kernel.org>

I take it this will go via the QCOM tree?
