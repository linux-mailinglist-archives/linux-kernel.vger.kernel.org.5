Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228B57E42F3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbjKGPLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbjKGPLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:11:08 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7F759C5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 07:05:24 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-66d87554434so40143136d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 07:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699369523; x=1699974323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zQkRUxp/qdG+mcqyz+AwKHOCtNKbDsz1x2+FtX/ZT2k=;
        b=FmC6ZS3rgh2v3az8ahjpxsKchW6HZObnAuKA2JeZa4bog5qXX5tFMmpgI8t1LiwkDe
         DRXE0nXZvginlZttYn7W2E1j59g0ia2XHw9IFhDNZ1ct++Z6fKbGpWDAq+tgi2NL++Lk
         1JTU8Mo6+saijEM+P/iYjewovJ0bwpDgHV2iv1sXHtge9C80Fsqnw8rh5/Mi4M+PO9t3
         rDxp7VAnhbSilvtL5Ka5BE4f9t3T3J5/qfdz7ZP7oFip3tOMmnT+rpnIPXaFxWNwvQKY
         sbKkHTnDdiMLcd1YzFtt3zdATwyKmjgB8Z1YJKUCCQz6IBtpSNCdVfqHIlTCPpbVk631
         XRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699369523; x=1699974323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQkRUxp/qdG+mcqyz+AwKHOCtNKbDsz1x2+FtX/ZT2k=;
        b=ukUuYUSMGmOW4FjD7bVHtDgvNkxkV96N2qYyn7JS7wT63f8Wf8xMfMcIUVgdB51VU9
         unVC8GoJgZQ6HfOISuULZJpsOor9auES1oSXJTpQ8vp8NW11ulTZp/7Lr1b6GrQFYsNr
         FJKBJ9et1R2OOXJCjRUlEGHigHzyr4fgeTIJjFBZCkiQADdpXy9stxRfoVxSU7/rT+C/
         IlzhhLeAHi5fEuHIzYVC182UAUhsWI5SCYxoltv60s/8500T3BcwkgGjybUBIIaO5I3H
         csn5efdqnNhxQkQy3DT3WJij+6lNq5N3vdoKgCABpEEXvcJtSje2B4i1nEgxKpkAfArP
         9OdQ==
X-Gm-Message-State: AOJu0Yweien7XHI4PGm8FNRmvgy9s4eREeqYp9NSgFDiI4DerM+H4217
        i5EctlvGdga+tFwAUMqe1WTVXr831B/Y0mA1GcHHJw==
X-Google-Smtp-Source: AGHT+IEabMSzZhzNJnvV8OfKHuh5oG/MF4IuVEHRT7Fo18Mvt+izrWP08VqFjmSyWeotreAUOrkDnA==
X-Received: by 2002:a05:6214:2465:b0:66d:145b:4591 with SMTP id im5-20020a056214246500b0066d145b4591mr44234443qvb.27.1699369523061;
        Tue, 07 Nov 2023 07:05:23 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id ev20-20020a0562140a9400b0066cfbe4e0f4sm4414806qvb.26.2023.11.07.07.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 07:05:22 -0800 (PST)
Date:   Tue, 7 Nov 2023 10:05:20 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Li Lingfeng <lilingfeng@huaweicloud.com>
Cc:     linux-kernel@vger.kernel.org, hch@lst.de,
        linux-block@vger.kernel.org, nbd@other.debian.org, axboe@kernel.dk,
        chaitanya.kulkarni@wdc.com, yukuai1@huaweicloud.com,
        houtao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        lilingfeng3@huawei.com
Subject: Re: [PATCH v2] nbd: fix uaf in nbd_open
Message-ID: <20231107150520.GA3913709@perftesting>
References: <20231107103435.2074904-1-lilingfeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107103435.2074904-1-lilingfeng@huaweicloud.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 06:34:35PM +0800, Li Lingfeng wrote:
> From: Li Lingfeng <lilingfeng3@huawei.com>
> 
> Commit 4af5f2e03013 ("nbd: use blk_mq_alloc_disk and
> blk_cleanup_disk") cleans up disk by blk_cleanup_disk() and it won't set
> disk->private_data as NULL as before. UAF may be triggered in nbd_open()
> if someone tries to open nbd device right after nbd_put() since nbd has
> been free in nbd_dev_remove().
> 
> Fix this by implementing ->free_disk and free private data in it.
> 
> Fixes: 4af5f2e03013 ("nbd: use blk_mq_alloc_disk and blk_cleanup_disk")
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
