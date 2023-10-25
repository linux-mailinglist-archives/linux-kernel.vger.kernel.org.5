Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8567D6C0D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343973AbjJYMgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344058AbjJYMgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:36:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFDB182
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 05:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698237360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vvU+ODlhbBzCksS16LHKl+sMj+DM+WDalvoXiTfFa+g=;
        b=RYc5hthBKMJPZje1BHIm6mXvDJqiA6alVL7l5EySZ7WXEHLTmzHU7pe5pVUtiD/Te1apfv
        aP44ByU0D/YuCflrQRfDC0FAhLDCYPDDHhS+tI3RPkv18lu05n1jLgPHm6HWjm6f30qaLT
        2xddBcud3Jzx5d0BbW2RnzLQaSM0UvE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-A6s7jHGRMh-yERqHpw417A-1; Wed, 25 Oct 2023 08:35:58 -0400
X-MC-Unique: A6s7jHGRMh-yERqHpw417A-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1c5ff1ee155so58784825ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 05:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698237357; x=1698842157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvU+ODlhbBzCksS16LHKl+sMj+DM+WDalvoXiTfFa+g=;
        b=eh872cO9yEtfHAhZGZb8sbRDY8uRQffUBs4nolE3m4lAyKQovEnCXMECBzx57lT9HV
         v/xXtzajAUAUc7nKDfJ0aB7a+3YD8o29wIIi3mVjkQq+JY0tUp9EL74qer8f/LmFoy+K
         8b+i2xU/sUTXGCl+JjjszsoWeI5VwF9lAF0WjCRyJD72kikQmEAMOF9P09JZrQxb7vGP
         s5KdLhPlOWvnUH9BIl8NTnxOY8USC7GG9UwQA3R38cNa7DOp6yGiobNJ69QpZ8ndYx+/
         j0T4r1fnbQspu7FtlM98pU9KyVU2dI2EB6Ue1+r8jUW5S6eawi353hK++k4zvGasVoej
         ueCQ==
X-Gm-Message-State: AOJu0Yz4iZ0rogLpdZe4tKRnGlgSx2AEii0C++SfqS2A+qqeWLiM2fvZ
        Fi+k64ULMXBxF4l6w1F6dTp7hBFwr+pLcWG5spVBn8F+UGtXO4nzSsS3OQuzWOieMNlFhRrLqEb
        3pg6igQVdyG3plbxxYTqwxeBpkrqu+mSLo/z9PJ5P
X-Received: by 2002:a17:902:e841:b0:1b6:6f12:502e with SMTP id t1-20020a170902e84100b001b66f12502emr17465922plg.49.1698237357772;
        Wed, 25 Oct 2023 05:35:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/lVpfMUNBBfWqBo8bfvljBYSBCHKzm8BaAaoys67eChIuLm8w5Asc6ul+K1gzocSNYltZL1dL0BrIqtcbXRQ=
X-Received: by 2002:a17:902:e841:b0:1b6:6f12:502e with SMTP id
 t1-20020a170902e84100b001b66f12502emr17465908plg.49.1698237357450; Wed, 25
 Oct 2023 05:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <0b9cb1ea-4656-4802-b7a7-811c1e9e118a@moroto.mountain>
In-Reply-To: <0b9cb1ea-4656-4802-b7a7-811c1e9e118a@moroto.mountain>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 25 Oct 2023 14:35:45 +0200
Message-ID: <CAHc6FU646Jj3iODoHoAYpps2PL732Feb_w+5p=8GfUOMfYTHhw@mail.gmail.com>
Subject: Re: [PATCH] gfs2: uninitialized variable in __gfs2_iomap_get()
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Bob Peterson <rpeterso@redhat.com>, gfs2@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
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

Dan,

On Wed, Oct 25, 2023 at 1:57=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
> The "ret" variable is uninitialized when we goto out because
> gfs2_is_stuffed(ip).
>
> Fixes: 2cd225820b91 ("gfs2: Initialize metapaths outside of __gfs2_iomap_=
get")

thanks for catching this. I've fixed that patch directly.

Andreas

