Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531CF7D28EA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 05:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbjJWDKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 23:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbjJWDKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 23:10:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F30F7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 20:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698030559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uR3upPr1un9Y15hnQrF7MdsdEdC4wHgJk4tSO1HctOg=;
        b=bo4GjMMfsM0isUr3fmvyDFhE2Qsc/Sf78SjxL2R+LPlAzoew0V9vPhDOGfF11g+W2f8q4r
        rDcsK2Fy+o4zhFoE6r+KnkoyMiGBvpj4mZoPY0yl9FI4Pi/8QRNVAaq4f2MYqB+bSHzSys
        mxCCp5/Y2KsScJZI6paMARWlgsnk0tc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-UMj4ea14O_-h-2z_gzkcOg-1; Sun, 22 Oct 2023 23:09:18 -0400
X-MC-Unique: UMj4ea14O_-h-2z_gzkcOg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-507c996104fso2964588e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 20:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698030557; x=1698635357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uR3upPr1un9Y15hnQrF7MdsdEdC4wHgJk4tSO1HctOg=;
        b=TOxwj+eryGvmT/sId2YFhS9+gHIBTkRdfaWc/vIFLBmLbOvn7dS0B8jIbSFxwyPQy9
         0ZSlfS1sMiOElxx33WveZprTM5+IqPX05vuda76TawsddZpCvEweHhL0uN9Q+05xoMDU
         Jn4MZtFE05Opg7fV1+CydqqukEZJN2gA4YvaHI3Q4il7Alf2EibUhQvbGtQvhdICsM2N
         L4ADYbvkmXsiwbybfbJRGvYe0Vhp1B3a3Ai/VNVy3a3mldFONC3eNBfIAlsIbxQQS2az
         W5gkZThvzpOcf/XuEkc08YewsmWhU2EZOtglZdtzOzzXaedi+GRFiD4bgJj6Ey8Hc7LS
         pgnA==
X-Gm-Message-State: AOJu0Yxfq6HP0R4p4yd9ZQV+Gsrp16aX1bCqxrOflQC+3r7FO1CJm66p
        6Yh4+st9W8TidqWaWNYszAjD/KhqpzTHA9uDApz77urK6foDs0e0vOwKzXByProUqtKee9JZ6C9
        IAQrnJeREWZOL6HWL49t/5FHJY6UqHCO0n0EuvPty
X-Received: by 2002:ac2:518b:0:b0:503:55c:7999 with SMTP id u11-20020ac2518b000000b00503055c7999mr4906976lfi.34.1698030556999;
        Sun, 22 Oct 2023 20:09:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgWCb7RrjHP+YKyif/eQ3pCH0351kwLRVv4y6D+4xjgstUC95BiBq1L5oqqzYLzjBLiA8Wpf2Vn16vXSmNb5E=
X-Received: by 2002:ac2:518b:0:b0:503:55c:7999 with SMTP id
 u11-20020ac2518b000000b00503055c7999mr4906972lfi.34.1698030556727; Sun, 22
 Oct 2023 20:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231020155819.24000-1-maxime.coquelin@redhat.com> <20231020155819.24000-5-maxime.coquelin@redhat.com>
In-Reply-To: <20231020155819.24000-5-maxime.coquelin@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 23 Oct 2023 11:09:05 +0800
Message-ID: <CACGkMEvht+u9nO96u-Tosw9un8_rt+-RuJJo-kAA+0mrkNspbw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] vduse: Add LSM hooks to check Virtio device type
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     mst@redhat.com, xuanzhuo@linux.alibaba.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        xieyongji@bytedance.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        david.marchand@redhat.com, lulu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 11:58=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> This patch introduces LSM hooks for devices creation,
> destruction and opening operations, checking the
> application is allowed to perform these operations for
> the Virtio device type.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---

Hi Maxime:

I think we need to document the reason why we need those hooks now.

Thanks

