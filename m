Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B27B7BF314
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442291AbjJJGa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442322AbjJJGav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:30:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8CCC6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 23:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696919404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gkyhygrn0LjKBs+Gy+HOQR/ROK9i9+TCjbjoKrbTIPI=;
        b=aHF1hNP853ZMyFdi7jvx2d8+aAJ+LRf0tYe6p6QVpl+5ZaeigEy+gx4oXuKoCoFcnvtlP+
        YP/CSegHX5N0uqrcxEGotBe/2aN6nYIpycrvrDR7TqYGPFwe/dMJcVmhphGTKTP3u22BgW
        i2AYNoA2/4Xtl4hEucrDB000nycmGvI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-rdPx9e2RN--nWNk3bVsy6g-1; Tue, 10 Oct 2023 02:30:01 -0400
X-MC-Unique: rdPx9e2RN--nWNk3bVsy6g-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50318e9067eso4506953e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 23:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696919400; x=1697524200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gkyhygrn0LjKBs+Gy+HOQR/ROK9i9+TCjbjoKrbTIPI=;
        b=ZtNglFeOg5xaAymCVE31Iy/Nz94SXEafSceO82whHIvtQtu8cIO4mQVWs4iXtwy675
         dQ9JuqbyLE4DPkam9+P0SzV6/9kohs4CDhCS5sDuS9js79BuAQaZRDgwnOAR2g/a3Oqw
         AWqwQvDE5E0qGuPuXsx18WKguG4V+3Dot9N8RhX8l1Zakijihe1yL1D7tHrV3wtTgDpT
         ZfGRP2fmeKEgbz/7vwEohDguvounoTa+iD8mzacGF4INkw3AyzwF4PRDLz2FC5jinIq5
         sprbvR6kqUvOEfpxlINNKgRe5bHyTJWihk8QLx/9UQgOpYPiHsEHLBsSJvTm2SAxVftI
         VkqA==
X-Gm-Message-State: AOJu0Yw7UIvWhn91tfyV1SftB8+jJ5uD4cah0BbFo8r/spSpRG8F6rk5
        cxIyRm+nlNsk8nteejsRa6jGUbOCLiwH4ymQR9zg9QK6Pnsx4BMVaIQxBLmGzHVnVgw8Y6/R2JS
        /h2PAfSQmfdZPpjsLEv4lEGUYHJ3XeatgZanwPB6B
X-Received: by 2002:a05:6512:3444:b0:504:7cc6:1ad7 with SMTP id j4-20020a056512344400b005047cc61ad7mr14922264lfr.1.1696919399896;
        Mon, 09 Oct 2023 23:29:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhwDe3FDKZFhiwrOl5KVXL4P0qXDeJGMy+/g0KGSF4lR/hfI+JvoID/birDGa8k73PyhD9Jc/VWYdZ2/MiwBc=
X-Received: by 2002:a05:6512:3444:b0:504:7cc6:1ad7 with SMTP id
 j4-20020a056512344400b005047cc61ad7mr14922251lfr.1.1696919399537; Mon, 09 Oct
 2023 23:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231009112401.1060447-1-dtatulea@nvidia.com> <20231009112401.1060447-13-dtatulea@nvidia.com>
In-Reply-To: <20231009112401.1060447-13-dtatulea@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 10 Oct 2023 14:29:48 +0800
Message-ID: <CACGkMEseT3P6s6XC4+=7LMrBtP_uG5q6oXDjTtkX_N8u2D0SVQ@mail.gmail.com>
Subject: Re: [PATCH vhost v3 12/16] vdpa/mlx5: Improve mr update flow
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Parav Pandit <parav@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 7:25=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> The current flow for updating an mr works directly on mvdev->mr which
> makes it cumbersome to handle multiple new mr structs.
>
> This patch makes the flow more straightforward by having
> mlx5_vdpa_create_mr return a new mr which will update the old mr (if
> any). The old mr will be deleted and unlinked from mvdev.
>
> This change paves the way for adding mrs for different ASIDs.
>
> The initialized bool is no longer needed as mr is now a pointer in the
> mlx5_vdpa_dev struct which will be NULL when not initialized.
>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

