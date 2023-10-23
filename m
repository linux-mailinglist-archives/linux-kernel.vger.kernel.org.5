Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9693D7D40A5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 22:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjJWUJj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Oct 2023 16:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJWUJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 16:09:38 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7712F9;
        Mon, 23 Oct 2023 13:09:36 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-57de3096e25so325511eaf.1;
        Mon, 23 Oct 2023 13:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698091776; x=1698696576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBRQn/+2CoCnRG/UpsIRpdz1Uxer0EBXhtYg8c4HrP8=;
        b=F+8EPtuKJhSXVT9MmCijhEFG4yMGPV1ARLDfhI/l8H1gnrPrTvDkiyd3LycBMvnCfa
         an4nAgSp+R9JAAdujvSvVjXAOePzdgZrUHHP6ytdkbkoY+JrXhHhpoXEVM5Ai/eAHkfX
         ZQen0K+jpfV85aTmGncaOFha0JSEjqSgAp2YKVgrZe1hZEEp5hKGbU8asloQIjnuPCPa
         UbdZXPDMoHn7XJuERK8nwXi2L2m5uwwTTOdJogTrxHFzopIXtgsilEg9oz7jSfmzP78A
         UlBwFVtr9h/SoAoCj1luVM2jlz2tNdS8AI37qdUgUlLbD5DE01kKMIlLIpJFLAYND7gh
         CLoQ==
X-Gm-Message-State: AOJu0Yy3q/qrlDQrSiJWna1JMAgWAhips231IrVjqXux4a/JB9tGfXxE
        5PXXCrMXVMbOkVMKxVhWpGOTPsnlqqFZxtlTUzvnI26p
X-Google-Smtp-Source: AGHT+IGoqvQxwQn+qvVRNOgCRCySjLvm7UySkMEB0RQE4CLReVM7ZkEekFHMAZs1YAuLbjHJQCbuu6gpb0jhlXEaAsE=
X-Received: by 2002:a4a:e7d1:0:b0:583:ec88:e0 with SMTP id y17-20020a4ae7d1000000b00583ec8800e0mr10230228oov.0.1698091775886;
 Mon, 23 Oct 2023 13:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1698081019.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1698081019.git.christophe.jaillet@wanadoo.fr>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 Oct 2023 22:09:24 +0200
Message-ID: <CAJZ5v0h9mfQoiok6URGaw7OHjHCFxPWDxiP68NGe9Ow-8PY0jA@mail.gmail.com>
Subject: Re: [PATCH 0/4] ACPI: sysfs: Fix some issues in create_of_modalias()
 and create_pnp_modalias()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 7:32 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> All issues have been introduced by the same commit, 8765c5ba1949 ("ACPI
> / scan: Rework modalias creation when "compatible" is present")
>
> The first 2 patches fixe some issues related to string truncation checks
> and to computation of the available space in the output buffer.
>
> The 2 others are just some clean-ups.
>
> Christophe JAILLET (4):
>   ACPI: sysfs: Fix the check for a potential string truncation
>   ACPI: sysfs: Fix a potential out-of-bound write in
>     create_of_modalias()
>   ACPI: sysfs: Remove some useless trailing NULL writes
>   ACPI: sysfs: Remove some dead code
>
>  drivers/acpi/device_sysfs.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> --

Thanks for the fixes!

I would combine patch [1/4] with patch [2/4] and patch [3/4] with
patch [4/4], though.

If that's OK, I can do that while applying the patches.
