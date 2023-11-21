Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD517F337D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjKUQUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjKUQUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:20:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE10CB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:20:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0751C433C9;
        Tue, 21 Nov 2023 16:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700583599;
        bh=/ftsIOr6PtvXmwDXJG2lgHpbTRDyOZqNHqOkYX1msmg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qQnYJ74n8oQzVtLAxKlA0npDWvAXMG5BczCbtm8Q7r1U9tmCrT/NYDhrCDJgV4dxH
         FpzqPbjUjkeuZ1oqf8JbcXboxg0/5HF3aXuCOud2H9tRy3N1oeJO28yQVzyEPboON7
         tHv97fMIje/U8dP08iA6XHgtkk/cXHcezhCVMTdr2aJ0F/tAE2VrMR+7xF82QLBeUn
         ELAtG3qCN7qEO9ahwWMgIlGiuJby3jBl04eev+q+T54u5IjB0I2A3PEj3YfbuSFFmc
         05pobXOY9fPL66pCFy2QE3Tq5YI8vodE9OrSts1ygetRcZ6fP85P+BVaydWq75EdPz
         CeAb/VRx+JLbw==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2c8879a1570so22352571fa.1;
        Tue, 21 Nov 2023 08:19:59 -0800 (PST)
X-Gm-Message-State: AOJu0Yx8QC+R9Ctqz1UXYhkqq/JDF0l4ip6o1CI757nS3wwxzLLUn/HJ
        6zMhzVP9q+6qFAzMus5i1n4vq1wWP8YvsCxhE4w=
X-Google-Smtp-Source: AGHT+IEtMGQDvBsJOPcKtWdelsFIWrHMFFYwL5uPNIQYz3nN/aRSQXRn2eA7w9M9xQKYjfsRUgSQym1LFQCd9rSwY0M=
X-Received: by 2002:a2e:9e1a:0:b0:2c5:1f92:b464 with SMTP id
 e26-20020a2e9e1a000000b002c51f92b464mr6822339ljk.10.1700583597994; Tue, 21
 Nov 2023 08:19:57 -0800 (PST)
MIME-Version: 1.0
References: <20231121103829.10027-1-raag.jadav@intel.com> <20231121103829.10027-6-raag.jadav@intel.com>
In-Reply-To: <20231121103829.10027-6-raag.jadav@intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 21 Nov 2023 11:19:46 -0500
X-Gmail-Original-Message-ID: <CAMj1kXEr2O8LZNq1r0zr1ZHPhtpbNu0PmZBk=UQvp7m0=ETodA@mail.gmail.com>
Message-ID: <CAMj1kXEr2O8LZNq1r0zr1ZHPhtpbNu0PmZBk=UQvp7m0=ETodA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] efi: dev-path-parser: use acpi_dev_uid_match() for
 matching _UID
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
        will@kernel.org, mark.rutland@arm.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023 at 05:39, Raag Jadav <raag.jadav@intel.com> wrote:
>
> Now that we have _UID matching support for integer types, we can use
> acpi_dev_uid_match() for it.
>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  drivers/firmware/efi/dev-path-parser.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/firmware/efi/dev-path-parser.c b/drivers/firmware/efi/dev-path-parser.c
> index f80d87c199c3..937be269fee8 100644
> --- a/drivers/firmware/efi/dev-path-parser.c
> +++ b/drivers/firmware/efi/dev-path-parser.c
> @@ -18,8 +18,6 @@ static long __init parse_acpi_path(const struct efi_dev_path *node,
>         struct acpi_device *adev;
>         struct device *phys_dev;
>         char hid[ACPI_ID_LEN];
> -       u64 uid;
> -       int ret;
>
>         if (node->header.length != 12)
>                 return -EINVAL;
> @@ -31,10 +29,9 @@ static long __init parse_acpi_path(const struct efi_dev_path *node,
>                         node->acpi.hid >> 16);
>
>         for_each_acpi_dev_match(adev, hid, NULL, -1) {
> -               ret = acpi_dev_uid_to_integer(adev, &uid);
> -               if (ret == 0 && node->acpi.uid == uid)
> +               if (acpi_dev_uid_match(adev, node->acpi.uid))
>                         break;
> -               if (ret == -ENODATA && node->acpi.uid == 0)
> +               if (!acpi_device_uid(adev) && node->acpi.uid == 0)
>                         break;
>         }
>         if (!adev)
> --
> 2.17.1
>
