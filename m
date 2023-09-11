Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FB479A3FA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 08:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbjIKG6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 02:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjIKG6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 02:58:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A1812D
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 23:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694415432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MxqH6Tn3jjo0ZWDpTkc6jzELn61wJze0oqZwAdBJHRo=;
        b=g0VkRDCrUCuiDOgwKz0gZrGvqzi7iODL5Rrf4G3vENpNwvV/LKSJXmVMUNDyiDhjjk56bP
        O7y2qwnk0ZD3Lr3dkn8GPc3IxFfq2co02dO3zPca4Wniwp59rsLophjCcHe/62p+6gdCC1
        ch212DUplV2f4EFTQ5adR3aYz1u99jE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-Vz4pWJ0JPvyhQDM_BEvu1A-1; Mon, 11 Sep 2023 02:57:11 -0400
X-MC-Unique: Vz4pWJ0JPvyhQDM_BEvu1A-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4fe55c417fcso4187275e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 23:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694415429; x=1695020229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxqH6Tn3jjo0ZWDpTkc6jzELn61wJze0oqZwAdBJHRo=;
        b=eQcPGbP7BaOxquTiNqwdUxUfmfVbXxFy0OHLbHdV5tieFIohe18rxc310DxSm5NDqd
         JNV6ENQM+GH4DRza3aaj8lEtOFqfptprxiXIspK/D8mb6TLxfYP5nFtkZhSckKI70KrK
         oxPhh46zyZS37vsmrJdBabf6+LTVphIgYJ0CMHHhJ7m5bzQqYp+4vi6NO3R3KVok3tyk
         HLe4cIcJOTqr1pgZNd1i2272UjDQCK43Vrs8Ov8qJSH5rZbBm3Oaa8Yblp6YgJrWQoDX
         wdSK6boylCyAgMyvwvRT3pFysPszfr3lxtFoPnWqHra/maUFo4DtpTAM1RHCqsmu3/S6
         twQQ==
X-Gm-Message-State: AOJu0YyE0DcOGTgJRGuMYZB/nR8szFtfTMCshJfVQbzlJ1HLSRvO+Rzr
        m4X8BCC+PGNb0Nz2U4KaZKNY682jdAoivfK3B48igUySbNL3XO5t/rU96AT03/4C5HoVfqZ+3En
        mw9mEiMldUChDeaAm19k6Znd5DmpoYdVWALstbRku
X-Received: by 2002:a05:6512:10ce:b0:500:c2d7:3ab4 with SMTP id k14-20020a05651210ce00b00500c2d73ab4mr7773971lfg.8.1694415429582;
        Sun, 10 Sep 2023 23:57:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD2DFdqiS+J4e4em76cRX2svkyaUCa4g2FN2ipe5WdIInV8vo4cj5F+oOFP/ZKlg4fYDtjOxmlYBJKN7H0e9o=
X-Received: by 2002:a05:6512:10ce:b0:500:c2d7:3ab4 with SMTP id
 k14-20020a05651210ce00b00500c2d73ab4mr7773960lfg.8.1694415429311; Sun, 10 Sep
 2023 23:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693012755.git.jiangdongxu1@huawei.com>
In-Reply-To: <cover.1693012755.git.jiangdongxu1@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 11 Sep 2023 14:56:58 +0800
Message-ID: <CACGkMEsP+3nTjG8gj0PoYg0DvyqqOpJKoAxG=m27t+iv-6GVbQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] vdpa: Add logging operatins
To:     Jiang Dongxu <jiangdongxu1@huawei.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, longpeng2@huawei.com,
        eric.fangyi@huawei.com, eperezma <eperezma@redhat.com>,
        Siwei Liu <loseweigh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Eugenio and Si Wei.

On Sat, Aug 26, 2023 at 9:24=E2=80=AFAM Jiang Dongxu <jiangdongxu1@huawei.c=
om> wrote:
>
> From: jiangdongxu <jiangdongxu1@huawei.com>
>
> Currently, the vdpa device supports suspend and resume operations.
> To support vdpa device live migration, we need to support logging
> operations and device state save/load opertions.
>
> These series introduces some new operations for vdpa devices.
> They allow vdpa to enable logging while vm start live migration.
>
> And I will submit another patches about saving and loading
> vdpa device state later.

Thanks for working on this, I have several questions:

1) Is there an example implementation of the logging in the drivers?
We need a real user in order to merge this.
2) Is the logging based on IOVA or VA? How the DMA isolation is being
done with this? Do we need a SET_LOGGING_ASID uAPI for this? (We had
some discussion on this in the past).

Thanks

>
> jiangdongxu (2):
>   vdpa: add log operations
>   vhost-vdpa: add uAPI for logging
>
>  drivers/vhost/vdpa.c       | 49 ++++++++++++++++++++++++++++++++++++++
>  include/linux/vdpa.h       | 14 +++++++++++
>  include/uapi/linux/vhost.h |  4 ++++
>  3 files changed, 67 insertions(+)
>
> --
> 2.27.0
>

