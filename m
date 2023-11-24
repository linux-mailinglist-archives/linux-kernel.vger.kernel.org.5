Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9487F709E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjKXJ6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjKXJ6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:58:04 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F9F1B6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:58:11 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a877e0f0d8so21149467b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700819890; x=1701424690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0r2ovNNQUwpmQosy3XQrJzCSVmmCu/fIH4I8jzx2+0=;
        b=i9/t2S6iEh35bC8YQH0hgGJv+9qpTo0syhdxpLBtU6suiW5mugBso0Wztrt6NJctZI
         qN3TIau9emPeq8q7S+Cm89lbaAKvT2VsGitV7EC0mgPVpXxfI6cj0Em4/fQCCC1pasfP
         MVfJzNy2h48/jf33MCFaBbmtq82Dr/mPYwCZwzZiZ9bbIIRceX9+IbqRZf9TB1FRmM06
         M+ozdIzSRaq1wONKXJ0YcaqGKLUv2WcH6nl1oLACA5aUYI+LUOBMC0K1e3FL6jdXdwWr
         hss8l/vCKIn3/n7SYmWzJvTtqpSH3QNvG/MJJRKMbH5UwwRYAM22+9KHX+sqispLW7Gw
         u27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700819890; x=1701424690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0r2ovNNQUwpmQosy3XQrJzCSVmmCu/fIH4I8jzx2+0=;
        b=XU2oVr1UBRg8FpcwRNvDWLcPGy/ppO+YsyjO1oPq7zVcEwuB73kYcnIcvo2UbGkJel
         mAVzBgcD89YGGzO2R6d7U2e9d5uqA18ogcZ47aVUx+lQS3Epwq+Q0p/hjsrY5cBFkjeB
         k3JHquixI3JBA3K5Isp1ZyXKTi3xShgGKInMNG7yEPLGaitTEWqYhtxkza+bcHFft4mL
         kW877IiE870kcrosq1Gj/5vWNbCUAFCdZd5uRrkMCTANV+BThHHHLENJjmpZLZmjAX/n
         QMb84iCWR6xQdG1emF3wTvCrl7t1OYme2MwjBn5Mv0XHX/xKoPNdLlhJMfc4UiE4Me/F
         s3bg==
X-Gm-Message-State: AOJu0YxFRYR9pYFd/j3DWVU1HafKxx0dzyN3tnqXXmykIcaB5wWeIckh
        SHyokpeVW3AoKoIECQW5LUEBJagZRv5VxOZb8stNCQ==
X-Google-Smtp-Source: AGHT+IH3bPUgrfuFQLes8tecktD2wXSd8PJOzNH0dAaOMXtiZNeJPc+iVFWvKlDdSg+qekI3fv5dBHwrzlEH3fIx8NM=
X-Received: by 2002:a0d:d904:0:b0:5cc:5421:e4e6 with SMTP id
 b4-20020a0dd904000000b005cc5421e4e6mr4391983ywe.16.1700819890357; Fri, 24 Nov
 2023 01:58:10 -0800 (PST)
MIME-Version: 1.0
References: <20231116223045.274211-1-afd@ti.com>
In-Reply-To: <20231116223045.274211-1-afd@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 Nov 2023 10:57:59 +0100
Message-ID: <CACRpkdaf9krpNkd-ZeGtaLS+UzM9Z7zSFtqFYdQk=TGLuUeB-Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: as3722: Use devm_gpiochip_add_data() to simplify
 remove path
To:     Andrew Davis <afd@ti.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 11:30=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:

> Use devm version of gpiochip add function to handle removal for us.
>
> Signed-off-by: Andrew Davis <afd@ti.com>

Patch applied!

Yours,
Linus Walleij
