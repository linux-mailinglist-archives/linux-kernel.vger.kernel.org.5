Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7479176E384
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbjHCIqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjHCIqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:46:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A172B10B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691052342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3WTtwxEW9Hl3Gp8FLgTwQrit/9PDxNQU5Gp9J/hakRU=;
        b=Y+fslikFbKoLfOi76DMFrhvF7HaoROKeDEokTC1kz+mv8+Tn/f0sH0aniQ5XOGxQ2HmNZ4
        qK1ZyfdCLTeVzNNWhdX7wcI/0icXDs1/jSR2vwftOzBf82z1hPlmErwHFYE25JZOTgsgw2
        DMgoZCKm4Noq7a2x+vKTWwEH0KRODyw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-LfvvKuEENu2ZpVA4bERpLg-1; Thu, 03 Aug 2023 04:45:41 -0400
X-MC-Unique: LfvvKuEENu2ZpVA4bERpLg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-52310538efaso135666a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 01:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691052340; x=1691657140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WTtwxEW9Hl3Gp8FLgTwQrit/9PDxNQU5Gp9J/hakRU=;
        b=FSH4o+LLeKBJtbQb38GIbgNgppoNp0DTo8slPVqxi0Wc+B/j+vyFf2eAw2XMBYV5Jr
         n9AZUrITq/y9MoQphe/T0usEKenV7DxxtKQYQhBgwMn/e4ROiK+w6CjxaGnxgDrLUFsr
         d/FPgS7N7CXBkEGin3O7EHcnC8AO92O8b5s3l3eSREsoEwrI8ETqe1SQhqL1DHYdKu/i
         ppKGwUasx3PxEoSPzEQU7f72YkOVVcyxFQKQMlrczmgqMtMTtVle/cLfF7KHxwLc8Oah
         wPw/K/kY0xoQ0+vXH7Uhf5LDKJqtE43U+rzefintxQPkLQTU8W+lwHyC7ZGxVli4/JWo
         hm/Q==
X-Gm-Message-State: ABy/qLaEyzIEQHLOGXNg08SfI+llqouMAD8aHpICLGpHyi3FJIYQnP9T
        tkBzKaV4oEP87J0Qty2qu3b8ZKU4eMJVdEe0IeamjtL62epjrMc3qTQRmPDoTlBQHiuQIJcmwEw
        5TgZxzhTRvsGR+p5iXyai2AzTtSMhe7aXJtRLNyB4
X-Received: by 2002:a05:6402:8cc:b0:522:b86f:a22b with SMTP id d12-20020a05640208cc00b00522b86fa22bmr8253563edz.1.1691052340457;
        Thu, 03 Aug 2023 01:45:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHAjcAMDE6gra8l5ZZAW/6UOYK05QYubSQG3i/aSNHLiaaL17sRRjdSBS7YI4g4TJWlArNp+MzSk5AU/TLJRmI=
X-Received: by 2002:a05:6402:8cc:b0:522:b86f:a22b with SMTP id
 d12-20020a05640208cc00b00522b86fa22bmr8253549edz.1.1691052340222; Thu, 03 Aug
 2023 01:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230803023257.9260-1-ltao@redhat.com>
In-Reply-To: <20230803023257.9260-1-ltao@redhat.com>
From:   Tao Liu <ltao@redhat.com>
Date:   Thu, 3 Aug 2023 16:45:04 +0800
Message-ID: <CAO7dBbV=D3N31L-VPS=2Vtreqc-4drKYHT1xWrKphT3J_G5Ndw@mail.gmail.com>
Subject: Re: [RFC][PATCH] iwlwifi: Add pci .shutdown() hook for iwlwifi driver
To:     gregory.greenman@intel.com, kvalo@kernel.org,
        johannes.berg@intel.com, mukesh.sisodiya@intel.com
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kexec to the CC list so kexec people can know this.

On Thu, Aug 3, 2023 at 10:55=E2=80=AFAM Tao Liu <ltao@redhat.com> wrote:
>
> Previously no .shutdown() hook is implemented for iwlwifi driver, a
> ETIMEDOUT error will occur during the kexec kernel bootup. As a
> consequence, wifi is unusable after kexec into the new kernel.
>
> This issue is observed and patch tested on the following wireless cards:
>
> 1) Network controller: Intel Corporation Comet Lake PCH-LP CNVi WiFi,
>    Subsystem: Intel Corporation Wi-Fi 6 AX201 160MHz
> 2) Network controller: Intel Corporation Wireless-AC 9260,
>    Subsystem: Intel Corporation Device e014
>
> Signed-off-by: Tao Liu <ltao@redhat.com>
> ---
>
> Hi folks,
>
> This is a RFC patch and I'm not sure about the correctness of the code,
> especially about the pci_clear_master() part. What I want is to stop any
> ongoing DMA access, in case if the memory overwritting during kexec
> kernel bootup. But there is already pci_clear_master(pci_dev) in
> drivers/pci/pci-driver.c:pci_device_shutdown(), so I'm not sure if it is
> still needed in the driver side. And I only tested the patch against the
> above 2 wireless cards and worked OK, not sure if it can work for others.
> Please review the patch, thanks in advance!
>
> Thanks,
> Tao Liu
>
> ---
>  drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/=
wireless/intel/iwlwifi/pcie/drv.c
> index 73c1fb3c0c5e..24c4c2dd7cb0 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
> @@ -1513,6 +1513,18 @@ static void iwl_pci_remove(struct pci_dev *pdev)
>         iwl_trans_pcie_free(trans);
>  }
>
> +static void iwl_pci_shutdown(struct pci_dev *pdev)
> +{
> +       struct iwl_trans *trans =3D pci_get_drvdata(pdev);
> +
> +       if (!trans)
> +               return;
> +
> +       iwl_drv_stop(trans->drv);
> +
> +       pci_clear_master(pdev);
> +}
> +
>  #ifdef CONFIG_PM_SLEEP
>
>  static int iwl_pci_suspend(struct device *device)
> @@ -1583,6 +1595,7 @@ static struct pci_driver iwl_pci_driver =3D {
>         .id_table =3D iwl_hw_card_ids,
>         .probe =3D iwl_pci_probe,
>         .remove =3D iwl_pci_remove,
> +       .shutdown =3D iwl_pci_shutdown,
>         .driver.pm =3D IWL_PM_OPS,
>  };
>
> --
> 2.40.1
>

