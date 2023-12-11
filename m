Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFBA80C1E2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 08:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbjLKH1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 02:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjLKH1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 02:27:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD46ED9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 23:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702279634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=heMUTgb5GaeOiDdKYyFVi6QpbUm0pw75w+l+VAumXBk=;
        b=iH2ILFK8L2sMh3I1xaDOI59WElfr10U8IE2QCnvzrfVm6PPhfjSJnyY52IZPk+CyDz+hI2
        H/y8JTosId5TEEjGC1DcPXzk93oqi4ZK1UwogKlOsFUEqv+jYiG8+QvB8g+n1L5Iw6yt1f
        HztGKs3wZRHfojnXCpTIQutUEysN0Ms=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-rEgJLCSlPA-mJSu59r3kKQ-1; Mon, 11 Dec 2023 02:27:11 -0500
X-MC-Unique: rEgJLCSlPA-mJSu59r3kKQ-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6ce337ff87fso2526356b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 23:27:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702279631; x=1702884431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=heMUTgb5GaeOiDdKYyFVi6QpbUm0pw75w+l+VAumXBk=;
        b=DCrXhCR3JaPmnXR25n9qgaPJ2xb3gN+ffcpEGNs4N/iBzq3lNSJqFfoIwzDM9s7QHk
         09bMbkBCIt2dxUZSQgCIpN68hK0Q9Omvx8DXX8n21gztCNtxsan3Tg3mMsHOQw019a+h
         kSId+s3v5h4kMKiEhoB9qEuGhd+lsPVq48LVW+WY/K7nvoqc7BgWgUmkvMaH0pypQEW+
         ddGEQHsmKjZyIQoKdi2qXivYsUco/UwN9wPUXlQudhoCwB9zViu7xZ2UtRyQkWjoCbni
         4j51+Aj/cgcD77fmwhmRUXUc9DKtO3GaGFdDRwr+wOZ7XPnPXyjhbKSssnJa5BR6tXcn
         OAaA==
X-Gm-Message-State: AOJu0YzzlCXWf+V+jY1GXHE0VOaSgTkY1DcdAuwrOaaH+72Tl4dTfCno
        i0o285GVggcleMLcf7H13NHZSpy7qk6kHdgzu9JbQ9uFSqaXhZcMayM7LAAw8XMtD3lYS3CHyPf
        iv0lIjEE1jiZWaBI54V4pdM1Hyz0CyzY46zQA4Po3
X-Received: by 2002:a05:6a21:1a3:b0:18f:e956:8332 with SMTP id le35-20020a056a2101a300b0018fe9568332mr5440550pzb.8.1702279630804;
        Sun, 10 Dec 2023 23:27:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwze31CQ0YmqHJ9TW/fpON2L8+D6Rtz1KtVRwdsq+25spKb3eYq8RHvwkd1mgitO/HmDDEBCjbgt5GrAs/TFQ=
X-Received: by 2002:a05:6a21:1a3:b0:18f:e956:8332 with SMTP id
 le35-20020a056a2101a300b0018fe9568332mr5440548pzb.8.1702279630504; Sun, 10
 Dec 2023 23:27:10 -0800 (PST)
MIME-Version: 1.0
References: <20231208070754.3132339-1-stevensd@chromium.org>
In-Reply-To: <20231208070754.3132339-1-stevensd@chromium.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 11 Dec 2023 15:26:59 +0800
Message-ID: <CACGkMEsGK9oQrrYAe4Dp7q2R=dqz+hJdWDsamKywA87S3565Cw@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: Add support for no-reset virtio PCI PM
To:     David Stevens <stevensd@chromium.org>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 3:09=E2=80=AFPM David Stevens <stevensd@chromium.org=
> wrote:
>
> If a virtio_pci_device supports native PCI power management and has the
> No_Soft_Reset bit set, then skip resetting and reinitializing the device
> when suspending and restoring the device. This allows system-wide low
> power states like s2idle to be used in systems with stateful virtio
> devices that can't simply be re-initialized (e.g. virtio-fs).
>
> Signed-off-by: David Stevens <stevensd@chromium.org>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> ---
> v1 -> v2:
>  - Check the No_Soft_Reset bit
>
>  drivers/virtio/virtio_pci_common.c | 34 +++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_p=
ci_common.c
> index c2524a7207cf..3a95ecaf12dc 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -492,8 +492,40 @@ static int virtio_pci_restore(struct device *dev)
>         return virtio_device_restore(&vp_dev->vdev);
>  }
>
> +static bool vp_supports_pm_no_reset(struct device *dev)
> +{
> +       struct pci_dev *pci_dev =3D to_pci_dev(dev);
> +       u16 pmcsr;
> +
> +       if (!pci_dev->pm_cap)
> +               return false;
> +
> +       pci_read_config_word(pci_dev, pci_dev->pm_cap + PCI_PM_CTRL, &pmc=
sr);
> +       if (PCI_POSSIBLE_ERROR(pmcsr)) {
> +               dev_err(dev, "Unable to query pmcsr");
> +               return false;
> +       }
> +
> +       return pmcsr & PCI_PM_CTRL_NO_SOFT_RESET;
> +}
> +
> +static int virtio_pci_suspend(struct device *dev)
> +{
> +       return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_freeze(dev);
> +}
> +
> +static int virtio_pci_resume(struct device *dev)
> +{
> +       return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_restore(dev)=
;
> +}
> +
>  static const struct dev_pm_ops virtio_pci_pm_ops =3D {
> -       SET_SYSTEM_SLEEP_PM_OPS(virtio_pci_freeze, virtio_pci_restore)
> +       .suspend =3D virtio_pci_suspend,
> +       .resume =3D virtio_pci_resume,
> +       .freeze =3D virtio_pci_freeze,
> +       .thaw =3D virtio_pci_restore,
> +       .poweroff =3D virtio_pci_freeze,
> +       .restore =3D virtio_pci_restore,
>  };
>  #endif
>
> --
> 2.43.0.472.g3155946c3a-goog
>

