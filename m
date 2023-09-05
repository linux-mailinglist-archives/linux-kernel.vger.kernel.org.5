Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E704A792857
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239753AbjIEQIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350431AbjIEFCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 01:02:05 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9666CC7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 22:02:02 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bdf4752c3cso10170215ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 22:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693890122; x=1694494922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUzgQhmUcrpYjy4XRQMDJNrGSBxTkLFduYpDV6nXTf4=;
        b=dcYZotGLb/Y407iDJHpSYDCKweMjVvjrwwhOwr9G8nDWsBUyx02jhiZn0JI9/y2T4X
         sGYF5Oyr9m4s5oPbfEMgbA3N7GtADmV1G8rAmynCe92/XqRFcSPcDQWomFAeKyCj+cOA
         SCpgYrvafMa1SVw+hOnK2rQix9a0MQ3sSmMY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693890122; x=1694494922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUzgQhmUcrpYjy4XRQMDJNrGSBxTkLFduYpDV6nXTf4=;
        b=By3hyI7BJrrHQd7yZE5OkElArvJmesuQHiYsPSCC0rDhTe+mKjrUvM5+jUaM1Lqh+B
         AVy7EaQy33e0GJ5wyewJh2KNGQF4cNVoe7bEKqPa2OpyEaMh3B9wLuRQEUfxj8n+wOrk
         1+xeetJxGxdGxXNcV+29ONzuVo0HACASqGc+1OcIZWcnaCSjZonh6CCtKfFIPL9Y5Ulr
         pbgjQpoU3+oqN5UnICDPOvtbSWz3NCHw26F3eL9SacSfI0ptAwCRUzr3ynDS+78K4LlI
         O9pJbjX3OivqUoDjYpAXL8zfU4Ch61WRJpcsuUNeMs9N7ljX3TiKvTxL7eIkHYRmeaT/
         0dLw==
X-Gm-Message-State: AOJu0Yx4gRbZBii7h99k6bI2S+laj4vkA9T62ci8e1FMQ3QcmovuYts6
        QKHhLw8grI0vD6dN4e31wvI5AbOGhRxhhXkbLO4=
X-Google-Smtp-Source: AGHT+IHg9457MHuGXNN4ZmcVXfXbY1b00sKmCn2j8JB+/PbcADiHRIDBL3G2Fq4BpQboAJ0SD8b4uQ==
X-Received: by 2002:a17:902:c94d:b0:1c3:3c0f:3dee with SMTP id i13-20020a170902c94d00b001c33c0f3deemr4069125pla.31.1693890122119;
        Mon, 04 Sep 2023 22:02:02 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:46d9:d35:d74e:cbe0])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902e98900b001bbbbda70ccsm8313006plb.158.2023.09.04.22.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 22:02:01 -0700 (PDT)
Date:   Tue, 5 Sep 2023 14:01:57 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Ze Zuo <zuoze1@huawei.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk,
        akpm@linux-foundation.org, ying.huang@intel.com,
        aneesh.kumar@linux.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH 1/2] zram: add a parameter "node_id" for zram
Message-ID: <20230905050157.GD610023@google.com>
References: <20230901071942.207010-1-zuoze1@huawei.com>
 <20230901071942.207010-2-zuoze1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901071942.207010-2-zuoze1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/09/01 15:19), Ze Zuo wrote:
> Now, zram memory allocation is random, however in some cases, specifying
> specific nodes for memory allocation for zram may have good effects.

I'm sorry, but that needs benchmarks in order to be justified.

> In addition, when memory tier is supported, demotion can be achieved not
> only through page migration,  it is also possible to apply for memory by
> specifying zram on low-speed device nodes, such as CXL memory devices,
> and compressing pages to these devices through memory reclamation to
> achieve similar effects to migration.

zram->table has nothing to do with zsmalloc pool. zram->table is a
fixed size (it depends on block device size) array that maps block
index to zsmalloc handle. It's allocated once, when the device is
initialized. Compressed pages are not stored there, zsmalloc pool
is a separate thing.

[..]

> +	zram->table = vzalloc_node(array_size(num_pages, sizeof(*zram->table)), node_id);
