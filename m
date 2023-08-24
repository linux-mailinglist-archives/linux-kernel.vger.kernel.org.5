Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7277871BF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238054AbjHXOg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241737AbjHXOgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:36:36 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568391FF1;
        Thu, 24 Aug 2023 07:36:17 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-68a4bcf8a97so3454698b3a.1;
        Thu, 24 Aug 2023 07:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692887777; x=1693492577;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EtlLPQ4XkMFpJySjQ9OXycirNX1t9e/eOV9xbgj8ih0=;
        b=aVUWLIkQVv4H0GnuQoc12swNgvWH3LBbmlavY7yGnOT8zdUEIROuiAFnX2WfpMZONV
         u+HCm0XRag9BZdx7d3cXrn8NBX4ScvITMLMebJUeMzFOMvqeRvH9MZhrl7Mzrov7lgVz
         l5P1YCFnTIxWcvLwCwmIByasa4vg/wadSFtEtlOQkIGuFNGG4Bh7l99JkoDiXZCmyYHU
         DX4VioMvAapUtMlAddUlzqRySpAkGZUv9xpqf2bSL/Vy/nyfgTalkI2cz0ROujUIABKz
         Ii03ZHxKfXpBp7y2Dw/f0NfTxclLhKNZWnA8wbSVPSs7KyLYJIK1SlWb9Gy/SwE3YP5e
         LUbQ==
X-Gm-Message-State: AOJu0Yya2EQsUheTWM1MD90XSOfKS2uw7TQjTb701zo+Bu7jg/kHtmbQ
        58bGeT0DMTxi3oERxAvOkVc=
X-Google-Smtp-Source: AGHT+IFhh/yEEq8jK9/1mUwkjtgL9PDsZzGFDBhhP31JIt8DlZgc7qS60r6ZxJZj+KRAPFQGufVKHQ==
X-Received: by 2002:a05:6a00:1406:b0:682:4ef7:9b17 with SMTP id l6-20020a056a00140600b006824ef79b17mr15252022pfu.32.1692887776574;
        Thu, 24 Aug 2023 07:36:16 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:e6ec:4683:972:2d78? ([2620:15c:211:201:e6ec:4683:972:2d78])
        by smtp.gmail.com with ESMTPSA id z12-20020aa791cc000000b00682c864f35bsm11533887pfa.140.2023.08.24.07.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 07:36:16 -0700 (PDT)
Message-ID: <7b5fc500-afeb-7edf-383c-0cdda77b3cf6@acm.org>
Date:   Thu, 24 Aug 2023 07:36:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH blktests v3 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Daniel Wagner <dwagner@suse.de>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20230822083812.24612-1-dwagner@suse.de>
 <20230822083812.24612-4-dwagner@suse.de>
 <fbyacmtpqfhfb763s7utwbt4kdbr3pli4rp7prj7jlklq2tit6@mkkjzy73r3a3>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <fbyacmtpqfhfb763s7utwbt4kdbr3pli4rp7prj7jlklq2tit6@mkkjzy73r3a3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/23 20:09, Shinichiro Kawasaki wrote:
> CC+: Bart,
> 
> This patch makes shellcheck unhappy:
> 
> tests/nvme/003:26:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> tests/nvme/004:26:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> tests/nvme/005:26:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> tests/nvme/006:24:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> tests/nvme/008:25:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> tests/nvme/010:25:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> tests/nvme/012:29:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> tests/nvme/014:28:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> tests/nvme/018:26:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> tests/nvme/019:27:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> tests/nvme/023:25:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> 
> But I think the warn SC2119 is false-positive and we should suppress it. In the
> past, blktests had suppressed it until the recent commit 26664dff17b6 ("Do not
> suppress any shellcheck warnings"). I think this commit should be reverted
> together with this series.
Please do not revert commit 26664dff17b6 because it produces useful
warnings. Do you agree that the above warnings are easy to suppress,
e.g. by changing "_nvmet_target_setup" into
"_nvmet_target_setup ignored_argument"?

Thanks,

Bart.
