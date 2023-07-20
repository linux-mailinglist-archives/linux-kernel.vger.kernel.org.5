Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD0375AB38
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjGTJpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjGTJpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:45:14 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C8D5B8A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:41:30 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-263253063f9so342506a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689846089; x=1690450889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+SuzeACTIOA12bslV6UjXteYfQ39xaXxVv1ezDBpkXs=;
        b=DtmmaKnwLz9laGXKWOpGzlZU52NZ8/CNqMm+SIu37ldYik4X1ML5zRZ5K57SWsCd6w
         eXWrqNraWTwl+xaOzPPByQuOjjCIPmp9jQwdjyMaykAKQM8Eyc5KV6SuKZSrHTlcs22E
         6E2g3pc+8QWxhm2zedmaLBx2dyCGGXjXyMTFogar7kv4LzGah70LpzKRFcUpkiCko5e9
         fKfuPhur4Le3xmze3cZhiEPqRamq9jUDssAF3+u7zaECDoDS38Jov5iEsH74RrtLkDW1
         7qPSqgE1XR7812WkIp/U0om45dOz6btF7RyuCjdPebFuDfnO/+CpKHLHpJcUH03sMP2f
         LXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689846089; x=1690450889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SuzeACTIOA12bslV6UjXteYfQ39xaXxVv1ezDBpkXs=;
        b=kSHH1wr8kOeDQhHQVwhhNdg0N2ue46Ap4dOXJdHx78G0oaTwq5YT9cV4W82tmwd3/f
         t8JRnxvfR+ZkkJHwu8aGg14/9Xtfvqcgk3hYwZSuWoKFftyQUTjyaocALGuxBuNJpp+O
         huCe99qiMPUuNBcaGA/ur3ynz8j2zrKUJ7TFH9jQ1kJw7ALYsAqG4cXzHJERF9uMrKHD
         jDN/mjUAYlWIkTBMvPFdUkOmUF9HjL3PCLD3u0xjkZc9UPfr2r2ECrdWE2R8l6aY2PBY
         ZnVUVYrhwpbZXR7uKO+Pryqbtl53m1IT1jwhFyQYNlh4mn2CaVwQUm/ZwTTBTST79IC0
         IVYQ==
X-Gm-Message-State: ABy/qLamHAkh+NiK9W+kLi7vfpfMazravSKD13QgDk7ggBWQMI3mbI3j
        M6MIn42qhl3WjiGSXx7reSTb5g==
X-Google-Smtp-Source: APBJJlGuE6xqtIRVcarBtL+5N0XK4nCPMj9Vzs4ke5eqWsBK4A0UgqVzdS4XRwcj71761mb9CNXOxQ==
X-Received: by 2002:a17:90b:4a51:b0:263:2495:c27f with SMTP id lb17-20020a17090b4a5100b002632495c27fmr1541541pjb.15.1689846089653;
        Thu, 20 Jul 2023 02:41:29 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id 13-20020a17090a030d00b0025bbe90d3cbsm701388pje.44.2023.07.20.02.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 02:41:29 -0700 (PDT)
Date:   Thu, 20 Jul 2023 15:11:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        "stratos-dev@op-lists.linaro.org" <stratos-dev@op-lists.linaro.org>,
        Erik Schilling <erik.schilling@linaro.org>,
        Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen: privcmd: Add support for irqfd
Message-ID: <20230720094127.zsqpvryj36cbekik@vireshk-i7>
References: <d4e0233524b8c7c48614b09cae4d23f2cdf10988.1689150266.git.viresh.kumar@linaro.org>
 <a5521a9d-72c6-4e03-0fbb-8a37418c32f2@suse.com>
 <97e63191-e2ba-34f6-ca6c-99b9e9841587@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97e63191-e2ba-34f6-ca6c-99b9e9841587@epam.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-07-23, 14:40, Oleksandr Tyshchenko wrote:
> Viresh, great work!

Thanks Oleksandr.

> Do you perhaps have corresponding users-space (virtio backend) example 
> adopted for that feature (I would like to take a look at it if possible)?

This is taken care by the xen-vhost-frontend Rust crate in our case
(which was initially designed based on virtio-disk but has deviated a
lot from it now). Here is the commit of interest. The backends remain
unmodified though.

https://github.com/vireshk/xen-vhost-frontend/commit/d79c419f14c1f54240b3147c342894998c274364

And I have updated the commit with CONFIG_ARM64 thingy..

-- 
viresh
