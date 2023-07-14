Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119F6753A67
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbjGNMKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbjGNMKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:10:18 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8483588
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:10:16 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-78362f57500so72394639f.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689336616; x=1691928616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTnCivJa6V1hU3gmCwf5cpAO3tcrHJmd3hauO64yweY=;
        b=qOygXVWS5fvvN23a5fvdDDNkk56cwrbmzVBlM0yYjDF3KSa2mAKQlJZzbkvmz8SGVy
         BW/X9T+3Qnp+zaqK5GFGSVhmn6/9Gcq9h38fxNVrCTbvFLtcTe4Ncj2/FsUa+ha/CIYr
         apjjJTOhKBOBjk0t0hJVRhI/A6J/FWooDWhogMNNECWcsP9HU1zeMpqp72bIWy8jO/I/
         c1A0BIqM5Zu9s8VZ/GMfydFGljdK1Xdw0X7L6/OqogI5FMIiSJDnuySJOuYBhI0wpe/t
         +sHheXNLe3DOQF4om8Pe81hGf36/e8YndpNIEsAVbrkAc4wY2jgTr9ZLdry+QyCLvWyJ
         dFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689336616; x=1691928616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTnCivJa6V1hU3gmCwf5cpAO3tcrHJmd3hauO64yweY=;
        b=P8YboHGlKYNs4JvQAycq4uW7cSvma1IWD9QAW3kwjfkyVHAWT+TMHwMpSRqHIpqBmd
         X7KLsVp7SaKp1yhKt3fm8KZ4ZsTksKElakQmLjeCCwVyGze26QqaUpBorRTZRt1PZWH0
         KMX117Q9oX+VhVYgQlu6pRMzEBhA652nOAp82WFBZzzchu5qUVzYkgyTPUgolPInlWhq
         7CNyUn2cbIg/CN9vQq7doqRtM5PgqXDY9kYhT3SrmuBPuhC2fatnS+WFSEfeF0rrHDbH
         LpE5YnKp1Qv1WqYjbcaOZRrGfPCBW/r+ztjdp9a5hDt69izfMEdKjhcTDJAlF5kUlvJY
         2qMg==
X-Gm-Message-State: ABy/qLaoemdgbufy0lrY9grcdLJmpXicPsG4XAZibQJ3MNlsvmCO79RQ
        B/OjEUQFRgPC+icefH+W506rCU/0Ltgx10qLrPcFt7TryOCciUVjgwo=
X-Google-Smtp-Source: APBJJlE9uriJNtYVDev3Xkq9Zf7hY0m1FuqIRQrw0tQzmv26bfcLrbSdI6hxEey0Qbjg9xT+/3O7Ha5OwSl2DGeKCKw=
X-Received: by 2002:a6b:a04:0:b0:776:fd07:3c96 with SMTP id
 z4-20020a6b0a04000000b00776fd073c96mr4915645ioi.7.1689336615600; Fri, 14 Jul
 2023 05:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230714015238.47931-1-ajd@linux.ibm.com>
In-Reply-To: <20230714015238.47931-1-ajd@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 14 Jul 2023 14:09:39 +0200
Message-ID: <CAG_fn=WLot3UecUrbTQKRrx-QNskuTiBwQr8RbtesbGYkK4wLA@mail.gmail.com>
Subject: Re: [PATCH] lib/test_meminit: Allocate pages up to order MAX_ORDER
To:     Andrew Donnellan <ajd@linux.ibm.com>
Cc:     akpm@linux-foundation.org, xkernel.wang@foxmail.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 3:53=E2=80=AFAM Andrew Donnellan <ajd@linux.ibm.com=
> wrote:
>
> test_pages() tests the page allocator by calling alloc_pages() with
> different orders up to order 10.
>
> However, different architectures and platforms support different maximum
> contiguous allocation sizes. The default maximum allocation order
> (MAX_ORDER) is 10, but architectures can use CONFIG_ARCH_FORCE_MAX_ORDER
> to override this. On platforms where this is less than 10, test_meminit()
> will blow up with a WARN(). This is expected, so let's not do that.
>
> Replace the hardcoded "10" with the MAX_ORDER macro so that we test
> allocations up to the expected platform limit.
>
> Fixes: 5015a300a522 ("lib: introduce test_meminit module")
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
