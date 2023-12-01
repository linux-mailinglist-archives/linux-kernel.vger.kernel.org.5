Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BC2800708
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378112AbjLAJbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378068AbjLAJbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:31:03 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FA5469E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:29:06 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5d34d85e610so17601717b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 01:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701422945; x=1702027745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMJWPTMz3I601PDaKg2G9zUK8oGX7I/FmdndTXV+PEQ=;
        b=cgJ+49/0UbaSjAIUhmS5SocHDBx5KjVQSIBtJrMHoKlfni5Q76uujUzQBPpBqh2pgz
         CLhspyrejyhIj5Jnih4hoDikQ+kOaHTF2sXwGXboSVwdLQ7vEtHuWgtC0aW64a7Ybnw6
         yZbmjKQcq4ZG5a329c7iubSwnUzjNz0f3T8vSjigMUp/j75uiF5k72ICj3OdagoPbhwj
         UDe3VaURzy7E1ZJORcfnF6mM0CQBisKEIfyKNCe8zfRamQTL0dVgBvtHH7BinhaVAdtu
         j0Ll7MhKQ5q3P7pYpRPUtbkq61hWzlqD64979xH6O3lRDodkChzRht7JURyaSAtfVPZj
         h7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701422945; x=1702027745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMJWPTMz3I601PDaKg2G9zUK8oGX7I/FmdndTXV+PEQ=;
        b=fNUz036TfQ1hqN1cmO6nHjTgKm4NU1FzUJKitPvpdWKFFGF05ZOxvx8z7PTN1OY93r
         Akc1BBHZMpsrfJS8qXmCXlcNVz2c9XiHaZ6uNgGzR3rE9JfBKmsZyAO7LBwE5lfwl87S
         I5+OMyGhwAD5pwzrEusyIfF5qIHbaND9q2wKOawZ2yYa2LE8DUs56C3/YHewDopxcQEu
         ZKI7oUvZTKfajscAFEpakfXdrGqrNEpMc18ViTeSoPjYpfNYwhxEunUMlxuMVsLyExsA
         gTBgz0xyJASJ4DkhI0ExKg++ciTMNRbe665t27NkJGRfphAgy8qycRMS5xnp5vxn+Hul
         xb8w==
X-Gm-Message-State: AOJu0YzG5yo/+LpthGqocdLpUhK9dWFkzdhwP5IkF9g+NrQ3bUY1fFaJ
        rIKNepLVrRtVClubvgCMf3xjcAd6jls6br8GWb5jaA==
X-Google-Smtp-Source: AGHT+IH7z5fSeuufF5Cxad9UDRaE+shZZJy1gQvx2kCB4e/jW1K7Fe5gWDdyHCZzHgjNd7epaL2M0znaAmC6vZYwWYo=
X-Received: by 2002:a81:ae59:0:b0:5d4:313c:4b07 with SMTP id
 g25-20020a81ae59000000b005d4313c4b07mr937537ywk.23.1701422945075; Fri, 01 Dec
 2023 01:29:05 -0800 (PST)
MIME-Version: 1.0
References: <20231201091034.936441-1-jorge@foundries.io>
In-Reply-To: <20231201091034.936441-1-jorge@foundries.io>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 1 Dec 2023 10:28:52 +0100
Message-ID: <CACRpkdaMnphBxvqpmvNG_72O02Umny3qdxfyrKdA4BsDwZmtfg@mail.gmail.com>
Subject: Re: [PATCH] mmc: rpmb: fixes pause retune on all RPMB partitions.
To:     Jorge Ramirez-Ortiz <jorge@foundries.io>
Cc:     ulf.hansson@linaro.org, CLoehle@hyperstone.com,
        adrian.hunter@intel.com, jinpu.wang@ionos.com, hare@suse.de,
        beanhuo@micron.com, asuk4.q@gmail.com, yangyingliang@huawei.com,
        yibin.ding@unisoc.com, victor.shih@genesyslogic.com.tw,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jorge,

thanks for your patch!

On Fri, Dec 1, 2023 at 10:10=E2=80=AFAM Jorge Ramirez-Ortiz <jorge@foundrie=
s.io> wrote:

> When RPMB was converted to a character device, it added support for
> multiple RPMB partitions (Commit 97548575bef3 ("mmc: block: Convert RPMB
> to a character device").
>
> One of the changes in this commit was transforming the variable
> target_part defined in __mmc_blk_ioctl_cmd into a bitmask.
>
> This inadvertedly regressed the validation check done in
> mmc_blk_part_switch_pre() and mmc_blk_part_switch_post().
>
> This commit fixes that regression.
>
> Fixes: 97548575bef3 ("mmc: block: Convert RPMB to a character device")
> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>

My bug :/
Shouldn't we also add Cc: stable@vger.kernel.org?


> +       const unsigned int mask =3D EXT_CSD_PART_CONFIG_ACC_RPMB;
>         int ret =3D 0;
>
> -       if (part_type =3D=3D EXT_CSD_PART_CONFIG_ACC_RPMB) {
> +       if (part_type & mask =3D=3D mask) {

That looks complex, can't we just:

if (part_type & EXT_CSD_PART_CONFIG_ACC_RPMB)?

> +       const unsigned int mask =3D EXT_CSD_PART_CONFIG_ACC_RPMB;
>         int ret =3D 0;
>
> -       if (part_type =3D=3D EXT_CSD_PART_CONFIG_ACC_RPMB) {
> +       if (part_type & mask =3D=3D mask) {

Dito here.

Yours,
Linus Walleij
