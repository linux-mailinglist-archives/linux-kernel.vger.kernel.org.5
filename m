Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CAB79D2E3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbjILNxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbjILNxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:53:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08D7A170E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694526736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C4ZDT0QRa1Q+8y0wTjNXL6JhVStydiLlcCxHKZqKT+w=;
        b=hLglHfqZfPb1Vx7ZHeWQYZRzgALWGbjCbDI2uxHFnmGDehKCukawwjYlM8UrAEIuK6SA7n
        TkL+CnrqehRy0Lu0vuslaQ3cSshBTRvmr15IZKlMuq8pVmjyD/4rKBHPSKQJG7Paf1W9mq
        eHbVO+hBr0bbXOW93E86vS/Ca8H9WBM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-FssxpqDCN56T9C3V-2dxhQ-1; Tue, 12 Sep 2023 09:52:14 -0400
X-MC-Unique: FssxpqDCN56T9C3V-2dxhQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4122b472e43so44582341cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694526734; x=1695131534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4ZDT0QRa1Q+8y0wTjNXL6JhVStydiLlcCxHKZqKT+w=;
        b=q1YoxLAY/Pb8sw8nhxawtLLaxjnJtYLe8RnvBs45OAoai1mZVkiXti0LTJs0THWace
         s1MNiZoNhqngR11jMg32emKTPmXW/DKv6za8Ke9q3h473Cm+nYkBoU3RevuTxIjRMYiF
         JJ0dvyVo7IlN9CKG4PC+DUm+aO2obDuQ6vfycH0pa0cfH4gj+lE3vXjt/7DeNTtfN9Pm
         kFJDNj/ZWftJPNNqNa7tlTZ9ppxZtzNsb5nDktP+NAg7euR2vfiHlDsUQP8tlUgprpI2
         r2iW5Yu/y51JcaRNd5/FY0Sqd/qV9JNCkNnnPZTJBnS8MqB7Hu2/YUOHulRWR4OI86nX
         QTzw==
X-Gm-Message-State: AOJu0YyZOg23KzPv30T90M78QvBOyUBSda53yI8HHx9D4MCZn8xdNTi8
        j/XPLZc3BWavw0N2y8l0jLISMsAXN7SCoeiPJhECR6mlAxisP1giDUXq6nq+RWk1/4iHbwtTTCJ
        W7tkeQCUtMx4OjRve1nk7/hDd
X-Received: by 2002:ac8:5d88:0:b0:405:4816:6eef with SMTP id d8-20020ac85d88000000b0040548166eefmr3610260qtx.24.1694526734444;
        Tue, 12 Sep 2023 06:52:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM0G+zZdHUX5WBQDo4BBPF6QIKFHXDFwq50y2SceqPwU/KXuyxQ5nyOiwyZMqwk/DVhl5z7w==
X-Received: by 2002:ac8:5d88:0:b0:405:4816:6eef with SMTP id d8-20020ac85d88000000b0040548166eefmr3610242qtx.24.1694526734227;
        Tue, 12 Sep 2023 06:52:14 -0700 (PDT)
Received: from bfoster (c-24-60-61-41.hsd1.ma.comcast.net. [24.60.61.41])
        by smtp.gmail.com with ESMTPSA id z17-20020ac84551000000b004108f6788a6sm3326401qtn.41.2023.09.12.06.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:52:13 -0700 (PDT)
Date:   Tue, 12 Sep 2023 09:52:26 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-bcachefs@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5][next] bcachefs: clean up some redundant assignments
Message-ID: <ZQBtGi+iLEglpt8x@bfoster>
References: <20230912123744.3929609-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912123744.3929609-1-colin.i.king@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 01:37:39PM +0100, Colin Ian King wrote:
> Clean up some redundant assignments and variables based on warnings
> found by clang scan build static analysis.
> 

These all look good to me. For the series:

Reviewed-by: Brian Foster <bfoster@redhat.com>

> Colin Ian King (5):
>   bcachefs: remove redundant initialization of pointer d
>   bcachefs: remove redundant initialization of pointer dst
>   bcachefs: remove redundant initializations of variables start_offset
>     and end_offset
>   bcachefs: remove duplicated assignment to variable offset_into_extent
>   bcachefs: remove redundant pointer q
> 
>  fs/bcachefs/btree_update_interior.c | 2 +-
>  fs/bcachefs/buckets.c               | 2 +-
>  fs/bcachefs/disk_groups.c           | 3 +--
>  fs/bcachefs/fs-io.c                 | 4 ++--
>  fs/bcachefs/io.c                    | 1 -
>  fs/bcachefs/quota.c                 | 3 ---
>  6 files changed, 5 insertions(+), 10 deletions(-)
> 
> -- 
> 2.39.2
> 

