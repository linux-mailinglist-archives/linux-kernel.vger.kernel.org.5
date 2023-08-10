Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CE9776E94
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 05:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjHJDeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 23:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjHJDeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 23:34:12 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3824E1FF7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 20:34:11 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-583ae4818c8so6153477b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 20:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1691638450; x=1692243250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Owh1PXmuDi3+G1fZ02mr5p8F6eCwrNc9fPU6RwtfNGo=;
        b=IgCP4YL42l4DMFP7qaISiAPr0DbqBeTleqt/D1ym6y1nR7lUNgBbTn4hJpGXEB6x1X
         RXnvujbNKPQ5dzvvNtD/zfJreg69Ot0hw2qRPfCVq74+dHB7BVcLPXxZhAnPc8YbelH7
         jSmvBTM8kpTwqUXaTXUWqvodmHJ+bicAchWIc6yF1n064G7Wy7nFt//W9FNfv5OQ0U77
         2EotOvQXpZ2csIitnr07MP+RQ564D8CoSya1eR7M85yQaYDRZne4wh2qukUxmRDm/Ggn
         Ig67z2EuuZWCAGu2xn0F984ZFQ+xsfqgGMCeEe2YDjYW3EV3NCq1xm0LsnwsFZV3cgR3
         i/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691638450; x=1692243250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Owh1PXmuDi3+G1fZ02mr5p8F6eCwrNc9fPU6RwtfNGo=;
        b=eGUinBoDr1CqHJPscv5sd+dwBVUz3ppuJpZWMd4xQ1DI3yXNfm7vlbvXggY8xTwbFo
         koTAsU62sxQbwrAb/Nu5kNLLz7NCFG/6HNXcw8K2G68XQmyHVEFkSYhwx2Uy6jctAx6+
         nHkgal3gdRXV0Ai66ewjlkQoQELt62sHtMwEa94LvUTYkw42X3FsswA57gWneumzlHlJ
         ELYYGf6SdXwit6NwwKuDq3bnUbxNS/xQe8yMx0DOi/YHSWsXRdvdwWKfPWWE6feWNL8L
         VEvDCmt0Y2RbDecf06UTvfwMFvAuYstH3udegvXf/s/Cv5qXVGKJ/CrjUaQd89kf4kv5
         qXzQ==
X-Gm-Message-State: AOJu0YwkZQvzfbbPVCC2lzHLLtadbnv+crZPhJyD6UkwGH6wiMa9zJvA
        MK5plmZAeY6MyimnlYJQaVt2QjRW6HnDiVHSMBbrTg==
X-Google-Smtp-Source: AGHT+IHkGXkMY5PiCwLbEzVqX2WAd7DAZvuE+jPnwHciFWXu3tnxWrL0PgJ4yRY+eJouQi1/BCc7K5809rixQXdbl2E=
X-Received: by 2002:a81:6956:0:b0:583:fad9:e241 with SMTP id
 e83-20020a816956000000b00583fad9e241mr1550190ywc.18.1691638450434; Wed, 09
 Aug 2023 20:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230809081840.16034-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20230809081840.16034-1-manivannan.sadhasivam@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
Date:   Wed, 9 Aug 2023 22:33:59 -0500
Message-ID: <CAKXuJqgyCJmWF=LfSGPOr85n0SzLSRbDRvLtfAsw=tXwxXjiCQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] PCI: qcom: Enable ASPM on host bridge and devices
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        robh@kernel.org, gustavo.pimentel@synopsys.com,
        jingoohan1@gmail.com, andersson@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 3:19=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Hi,
>
> This series enables ASPM by default on the host bridge and devices of sel=
ected
> Qcom platforms.
>
> The motivation behind enabling ASPM in the controller driver is provided =
in the
> commit message of patch 2/2.
>
> This series has been tested on SC8280-CRD and Lenovo Thinkpad X13s laptop
> and it helped save ~0.6W of power during runtime.
>
> - Mani
>
> Manivannan Sadhasivam (2):
>   PCI: dwc: Add host_post_init() callback
>   PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops
>
>  .../pci/controller/dwc/pcie-designware-host.c |  3 ++
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>  drivers/pci/controller/dwc/pcie-qcom.c        | 28 +++++++++++++++++++
>  3 files changed, 32 insertions(+)
>
> --
> 2.25.1
>
While not extremely scientific, and I don't have any way to measure
the power usage on my Thinkpad X13s, with these patches applied, I've
only gone down 29% battery power in the past 6 hours, suspend and
resume cycles don't see any issues either.

Tested-by: Steev Klimaszewski <steev@kali.org>
