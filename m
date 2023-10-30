Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF4A7DB97C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjJ3MHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJ3MHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:07:17 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694A1C9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 05:07:14 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9d2e6c8b542so192696066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 05:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698667633; x=1699272433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mAof5WwCREHhgYvZP5oL9OZtxCJg/p8F1Qyqhopa2tA=;
        b=tk6cYUSbwPm94Sddc5HmcF/6xvZycbisb6NRMHiZRwgedeVomxu3fOpnu6SFB6HRBg
         MFm8fYFiVFe601gpfhjoylVsQ2emYZ6f3CfjrHGe4iHfAZTlo9gvs7rHC9IZF0i0zqaj
         jRiW7zPCD0XZUK95q67FEETmOUgJMG27sQ8Ttr2UUvpKNxCReYXBHTWNrxCdUkq2djIu
         Z9fzGEHsY2rx3rcEXZbPJAAxPYt78Deq2OtFLyKVKKy1Zgbz+VaFT62P9lKdqYH2t7WG
         O4V8mJIsJzONMWKcHpdZh+55xgav5BYEUCBdB6i8fg1Fw6HAmiEB0XXnRvQtfs+mWHFn
         C/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698667633; x=1699272433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAof5WwCREHhgYvZP5oL9OZtxCJg/p8F1Qyqhopa2tA=;
        b=xStc6JpMy0BMJYjhxjHcGGt+BuT5KuX8QEd28h/cd+zjW0fkVNkcBEnuFFnMOA0uOl
         hsu0Aef00y8rg8voenXvf3XSF6M+GaPTQdt1zXc7OdsUGVB+0EAdei1768M/pEY2zDv1
         L1VTLm32GaOvbHLMdKppNUhOHMixxs/O/aHYzGbBcYcTp8W2jICiX7CCCe9nxzxuEusz
         oWQCZTe5iabYNPYRtvpDYXtFM+vsqKK4DfynrWVBC6RnAKxjF0VTxWfXV304db18+Gx5
         5uPYuVl3Or3q0dIDvcCRvFPfrH/rP1C/jhfTI0u+JIHhvntOX44/H9V9e6L9Suj0mEZF
         AIDg==
X-Gm-Message-State: AOJu0YyVh5ikMmkkDXkT+woE1Ye3V2kZ+BlMv6p59L1HKykRHFZoc12W
        b8WmbM5ZfYfonvxhn0hTxYd2Jw==
X-Google-Smtp-Source: AGHT+IGBHK0i5fSOAaHDaa1kq/y9l+3D/IFB+FmpFVFFTGvhuxbi2H37szUupGExcwAp3AVcfJetTw==
X-Received: by 2002:a17:907:7f1e:b0:9c3:e66e:2006 with SMTP id qf30-20020a1709077f1e00b009c3e66e2006mr9039051ejc.9.1698667632723;
        Mon, 30 Oct 2023 05:07:12 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id d26-20020a17090648da00b00988dbbd1f7esm5870031ejt.213.2023.10.30.05.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 05:07:12 -0700 (PDT)
Date:   Mon, 30 Oct 2023 13:07:11 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     hawk@kernel.org, ilias.apalodimas@linaro.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jdamato@fastly.com, shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, linyunsheng@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: page_pool: add missing free_percpu when
 page_pool_init fail
Message-ID: <ZT+cb4sO3PK1EbT5@nanopsycho>
References: <20231030091256.2915394-1-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030091256.2915394-1-shaojijie@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Oct 30, 2023 at 10:12:56AM CET, shaojijie@huawei.com wrote:
>From: Jian Shen <shenjian15@huawei.com>
>
>When ptr_ring_init() returns failure in page_pool_init(), free_percpu()
>is not called to free pool->recycle_stats, which may cause memory
>leak.

Would be nice to see the use of imperative mood in the patch description
too, not only patch subject. Nevertheless, fix looks fine:

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
