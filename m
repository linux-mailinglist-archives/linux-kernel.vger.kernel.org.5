Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7537AD812
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjIYMbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjIYMbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:31:14 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3558C0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:31:07 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d857847be8cso6751562276.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1695645067; x=1696249867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4d5TkM4wqAm2oqOAlR3gzptkgtI79OgpV/vOvlphjaQ=;
        b=XTZdBlYKYNyka74NqQkpAQERM9WVCd5bXNu9j4ac7jgaGL8rlcCQ0292Hn1Ry0AM15
         RXXJM+JZp+qRbW/DTMYHbrtlH3xiFXwwS5awMVpb6ITf9xGCtNEVw6zbELwx6WEFQ3S5
         XSsIoNheUx/VtjvQ0+78ULtGkAqovdLalHvWi4pEAg3TTRyWZG3ZEZ94tAP2l+N/U2Fp
         9YDamHdeerwLJ6JKaIoFzip4rkkKuP1QSuFRDf3OVasWczDWjPg2QJj2ub4Vq1NuFTSj
         YddDMGMzKyXSVyGhbalBdNcCsL1WjY+1tlrb32y307iNVGRrNWoLe8Rs1UhpRU9RIR3S
         xZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695645067; x=1696249867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4d5TkM4wqAm2oqOAlR3gzptkgtI79OgpV/vOvlphjaQ=;
        b=YURoMQTfimVUb1Mjxs9igztqsnprDiawGYeAjB89P3eZtDkWxZAplIQw/5Awn0EHbU
         OqcppG59ODh8BPEX/q7ifvCoAFoMCxMmJFjx8M2BfCawJOcCYXT9efLyW9jgSg9HhKW8
         Jpzy55MRilIAxlfh2kFTawBqGgFjmr+bhbFu3wosKleBnTggi4IKf3Ycn8hJbCdOHyju
         uPrVudCNSsIuu6sbmSpdzPFSjZNMolihMAGjq4BmNN99ESH6mdRhXAmb6PFwN42MYkQ7
         PgTeiHMgldn3Z6JdYvgzat0XT4l9R7EFvvnpXDZWI33Ylg+e3pFiYDUBg8Ro1IYpdyPA
         1xzg==
X-Gm-Message-State: AOJu0YyCtX5EhUhe7r7725+/w9eGwsvN47K3VDbG3G2nBQvXbQtAfuXA
        bNqtfLt3HjzAJg0vh5oQtlytFv6A0vZ5pwwGmaw=
X-Google-Smtp-Source: AGHT+IGgPhhscAdQQ+2GKTTv1TjS7rvGD6bqdXMwRVW+LN+U5bniHo4jxk29efMZoyWRQDvoOTnGyg==
X-Received: by 2002:a25:ec0c:0:b0:d0c:9ab2:72d3 with SMTP id j12-20020a25ec0c000000b00d0c9ab272d3mr5971327ybh.14.1695645067233;
        Mon, 25 Sep 2023 05:31:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ba06])
        by smtp.gmail.com with ESMTPSA id b14-20020a0cc98e000000b006564bba15cdsm4048964qvk.128.2023.09.25.05.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 05:31:06 -0700 (PDT)
Date:   Mon, 25 Sep 2023 08:31:06 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     surenb@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/psi: bail out early from irq time accounting
Message-ID: <20230925123106.GB347250@cmpxchg.org>
References: <20230925102143.462545-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925102143.462545-1-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 10:21:43AM +0000, Haifeng Xu wrote:
> We could bail out early when psi was disabled.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Can you please resend this with Peter Ziljstra <peterz@infradead.org>
in CC? Thanks
