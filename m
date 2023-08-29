Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3853378CC7E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238513AbjH2Sxa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 29 Aug 2023 14:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238579AbjH2SxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:53:05 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C4A193;
        Tue, 29 Aug 2023 11:53:02 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-56e280cc606so924669eaf.1;
        Tue, 29 Aug 2023 11:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693335181; x=1693939981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AfSDZ/dgKFPiSgUxPI5mSIIzAZGAHbSq6a8PZxJCvGs=;
        b=hjM6gmhDshSdC2GDMZg7h+4ETKURO+i3OJQEtf9zmbxFDFwHBJ94smtyC+BrtgHppP
         3nRlANT6BwpEZMcJurGWOkdwjD+vgASYqRGfes6Yg1BJXQciAqHscEyAz+ROWU6zyhcR
         fXZbn1XhwrMH9gtPuao2L02SkMWjhGy+JHVFKkxXkcLMuWQomZxQ+2yNs202qETACrrj
         wZGffpeBo5E+D9CkwCwma5aM2NbuW698KdPfh/dW/W4UZ3XBwZb5feo7b4WQCZ5qhqbT
         MhFhPmpDsIMBPsnZgSCcANY01j/zAMm/2Ur+Sq/uvj0sVY+k5ZLpxLQy8jiSdqPUx6Mg
         GJnQ==
X-Gm-Message-State: AOJu0YzE0ea5Sx3dko/b+Vy6N3Z6CF2c6wpvOtBKpqRVsow3evaZ6X4B
        HU4Vyb+lkt1r3z3PZ9/+i6Tib5XwVLFUVVwPLiQ=
X-Google-Smtp-Source: AGHT+IEHY4p8TLSuRXDSk3hU9E9gXLwGPUwOGeZW+5kzU+WW5WCDkwOUpzLmKKM3IQioCKuqbz3DzFLeIQr4o1lL+Sg=
X-Received: by 2002:a4a:df4f:0:b0:573:764b:3b8d with SMTP id
 j15-20020a4adf4f000000b00573764b3b8dmr8310316oou.0.1693335181382; Tue, 29 Aug
 2023 11:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230822124837.3016641-1-zhanjie9@hisilicon.com>
 <20230825063926.n4o7cp6x56r5i2it@vireshk-i7> <75f04346-7776-0bd0-19c9-c63f2f329f56@hisilicon.com>
In-Reply-To: <75f04346-7776-0bd0-19c9-c63f2f329f56@hisilicon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 29 Aug 2023 20:52:50 +0200
Message-ID: <CAJZ5v0hUwyHwWKsJqB+Gabk+x+jaiVVAzcpSB4jGK9fxJ-K9SQ@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: Support per-policy performance boost
To:     Jie Zhan <zhanjie9@hisilicon.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, rafael@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, xuwei5@huawei.com, wanghuiqiang@huawei.com,
        jonathan.cameron@huawei.com, wangxiongfeng2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 9:11 AM Jie Zhan <zhanjie9@hisilicon.com> wrote:
>
>
>
> On 25/08/2023 14:39, Viresh Kumar wrote:
> > Looks good now, thanks.
> >
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
> Many thanks!

Applied as 6.6-rc material, thanks!
