Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D997EB33A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbjKNPO2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Nov 2023 10:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbjKNPO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:14:26 -0500
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83341F9;
        Tue, 14 Nov 2023 07:14:23 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-9c603e2354fso1154706266b.1;
        Tue, 14 Nov 2023 07:14:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699974861; x=1700579661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxz8QkUMUdK70UcIufkcCTFuHM/iFKukNXMBMippDVw=;
        b=FIBpXliRegubGy+6t3SLZZwguEKbefm3L9aQ85WbDYkbvsfUqFNJ2xN3c0swfetd8n
         k3GzwS2EFw0z3yde+Ct2F5umIHBEiEdDW2wHRJTS7iGyn9Oydi/zq66aVsb8Uc052PnV
         HUA2MNawtAFk4T3pwr1xZLsPMVEXL2IAkss7TrIMHcD1RO99rZLbx1y24uYvXL46NJf+
         W+ecnXIkNrj3Z5rZK/R/DEmNyiG5p84MZUqiFCgpANn4UbEWOYanWHeQnHvhqDg+0K+W
         bjr/obiRu9qpAe5Kqq/wc28kp38DOwUB53GkkMckBkdar81XSIYqjb34nRaVn0g2AQPy
         +PfA==
X-Gm-Message-State: AOJu0YxkV6vet8vlyO/5s3wMSfLt4i3lSjgl4CcBWb7dbVvEDmOM2Wpp
        77JKRGj4UYO29L8LVbPFsfaTwS2zdHY7iAkYjWo=
X-Google-Smtp-Source: AGHT+IEgOIolvgTrfEjV0AmDGor4/vOucGkOxuTp6WsVbqYowytfw1cdybx6FVvSq9b7+MGpLatTlg==
X-Received: by 2002:a17:906:68d6:b0:9a1:b528:d0f6 with SMTP id y22-20020a17090668d600b009a1b528d0f6mr2181514ejr.27.1699974861181;
        Tue, 14 Nov 2023 07:14:21 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id rp13-20020a170906d96d00b009ddb919e0aasm5664465ejb.138.2023.11.14.07.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 07:14:20 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-540c54944c4so11571581a12.1;
        Tue, 14 Nov 2023 07:14:20 -0800 (PST)
X-Received: by 2002:a05:6402:440f:b0:531:14c4:ae30 with SMTP id
 y15-20020a056402440f00b0053114c4ae30mr3214229eda.0.1699974860727; Tue, 14 Nov
 2023 07:14:20 -0800 (PST)
MIME-Version: 1.0
References: <20231114-bluetooth-msgid-fix-v1-1-1d15394bf342@marcan.st>
In-Reply-To: <20231114-bluetooth-msgid-fix-v1-1-1d15394bf342@marcan.st>
From:   Neal Gompa <neal@gompa.dev>
Date:   Tue, 14 Nov 2023 10:13:43 -0500
X-Gmail-Original-Message-ID: <CAEg-Je-SvvMpAAqtOPgaKt1PuoZi37K0Tprf3KDts-SBTzNpUA@mail.gmail.com>
Message-ID: <CAEg-Je-SvvMpAAqtOPgaKt1PuoZi37K0Tprf3KDts-SBTzNpUA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_bcm4377: Fix msgid release
To:     Hector Martin <marcan@marcan.st>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Aditya Garg <gargaditya08@live.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 2:05 AM Hector Martin <marcan@marcan.st> wrote:
>
> We are releasing a single msgid, so the order argument to
> bitmap_release_region must be zero.
>
> In practice this was probably harmlessly masked to 0 anyway, which is
> why it worked, but it trips ubsan.
>
> Fixes: 8a06127602de ("Bluetooth: hci_bcm4377: Add new driver for BCM4377 PCIe boards")
> Reported-by: Aditya Garg <gargaditya08@live.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/bluetooth/hci_bcm4377.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
> index 19ad0e788646..5e9f79235cde 100644
> --- a/drivers/bluetooth/hci_bcm4377.c
> +++ b/drivers/bluetooth/hci_bcm4377.c
> @@ -715,7 +715,7 @@ static void bcm4377_handle_ack(struct bcm4377_data *bcm4377,
>                 ring->events[msgid] = NULL;
>         }
>
> -       bitmap_release_region(ring->msgids, msgid, ring->n_entries);
> +       bitmap_release_region(ring->msgids, msgid, 0);
>
>  unlock:
>         spin_unlock_irqrestore(&ring->lock, flags);
>
> ---
> base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
> change-id: 20231114-bluetooth-msgid-fix-29769be7e45b
>
> Best regards,
> --
> Hector Martin <marcan@marcan.st>
>
>

LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>


-- 
真実はいつも一つ！/ Always, there's only one truth!
