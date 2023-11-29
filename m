Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062D77FD28C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjK2J2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjK2J1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:27:55 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237B91BE5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:27:54 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40b472f98b1so23751705e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701250072; x=1701854872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cV3cidTfYmhmSEmql6w0XpvkQP5KN8Xk5Nui+lMKWpM=;
        b=xXP/vZkvKH2EOBk1WoODoDKb28pQAo4+I3EKc7Fy8z8szGbQC/q7HR1srmug2TI41q
         81IdDT5fNiKmMDWvPMIi62L09+93bt1pd+xUjEJOUnidGZDOHy0QuYvukoV8tjxzs1Hm
         GVNOXKa5JYJKi3ga1SgZEuid40Qg1eBvfx71PO40kga3qHTCpH4D31M9izGFqQ8hUX0X
         oXQjohx8v4Mq2lnAlOVjXxVXZIuPC4ep40ScIeWkMTCTXHWiRLw/HkRgy0Is+kp8m9hL
         pCxhiCrF1gHXXEQGno3LeqKfxG0mNnt5ebzbUtfrASCoxOqtqdktRMDK7n1UlqQSPn8V
         oo9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701250072; x=1701854872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cV3cidTfYmhmSEmql6w0XpvkQP5KN8Xk5Nui+lMKWpM=;
        b=nI19XRY0RmsU1gpPvVDoenJgpaEQzGpLOcu01DidkC66yDVEbGzf6MdREg9Ud5eHUf
         N/Lkwzap/kmRtvt4kuXjORx/R5jZsTtJ+du5gpEs84rxQ75KO+4QZk5Fu/LHmxLxtvUu
         Nlw8osW53MUyXSj/224w0sdVzvGrSpzseZLx3z7tfhpiwrnCAFzdLU3L+xBF/GLtqRfS
         bfpsglG2CNvF5lvhX3Bl4oNgyp2pH0JEWyKj4RuTU39m5X+35mxr2JwxfjFXrm0N81EV
         C0pOi0inKK2c9boVytiE/Qa1QNdzl3TtfJCX4Uf5tKmjWksu/TANg2uOlIPd//rzFLNt
         LYOA==
X-Gm-Message-State: AOJu0YyZmVpGNb3Ydr6msyW5wvEmj4zh6I0WYhzHLh75fHV+/j0VH+/9
        bHMSDH4KKYvU6dwzIu9tfLbwWA==
X-Google-Smtp-Source: AGHT+IHzeJKMk7WsQi+AyV6Jd4iYFuZOhQ4zg5yYm8Obs7Iu0VnUJhTR/zfpZ5TmSWIfoCzkEkWPQA==
X-Received: by 2002:a05:600c:4e94:b0:40b:4bd3:f8e2 with SMTP id f20-20020a05600c4e9400b0040b4bd3f8e2mr3616704wmq.22.1701250072542;
        Wed, 29 Nov 2023 01:27:52 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r14-20020a05600c458e00b0040a4751efaasm1517697wmo.17.2023.11.29.01.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 01:27:52 -0800 (PST)
Date:   Wed, 29 Nov 2023 12:27:47 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>, error27@gmail.com,
        gost.dev@samsung.com, nitheshshetty@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: prevent potential spectre v1 gadget
Message-ID: <b94b300b-8c09-4246-bd98-95f7b4291c49@suswa.mountain>
References: <20231128122958.2235-1-nj.shetty@samsung.com>
 <CGME20231128123634epcas5p201af168ff4ef4a8a129e5448bccca1a6@epcas5p2.samsung.com>
 <20231128122958.2235-2-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128122958.2235-2-nj.shetty@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 05:59:57PM +0530, Nitesh Shetty wrote:
> This patch fixes the smatch warning, "nvmet_ns_ana_grpid_store() warn:
> potential spectre issue 'nvmet_ana_group_enabled' [w] (local cap)"
> Prevent the contents of kernel memory from being leaked to  user space
> via speculative execution by using array_index_nospec.
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---

When it comes to adding array_index_nospec(), then I don't know enough
about it to comment.

regards,
dan carpenter

