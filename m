Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F23880B8A2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 04:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjLJDt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 22:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjLJDtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 22:49:24 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1725C123
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 19:49:31 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5c627dd2accso1449694a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 19:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702180170; x=1702784970; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MW0tH0tCLOPnmE9TK7jB709vE7J7udoTWRcjSJbRbzw=;
        b=MVA3ncTv2ztH8VVDR196PceGHb1j2OlSZrlL9Lw2Z9wX6UV2E/Z7XDjt5ZD7SDGkQY
         tlWHdq4lxTiyvBUAkbTmLAnlnhSqqlhFoLb51b5SdgrG3NTW42ditNtt2dquiK22e2xx
         Nw689Lh4It2U5heO9IEQmZwv3c3mM3nARmOuJMgEG3Fs+Rwa45tEbyggTQPX1s+IcwtO
         u3Wiqqvto7KipLkZsC4PQE1A8RgR5sT+O1xaA8N2w+wHjPG1xRdP1x6zOnuCs9mKTdFv
         04hbe0IOyZyj/hqPtSfyu4DtiDdktMxlvPL5bH+Fgu9pBBtlLtruM13bGr+El8lT1Frm
         WP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702180170; x=1702784970;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MW0tH0tCLOPnmE9TK7jB709vE7J7udoTWRcjSJbRbzw=;
        b=d4OhI2kyfpnH8Qt7OskeNBiMJRgPZK4jLvhPFkzzAKYgd3udF5FAxErUmy5xLq3JD2
         zgetUgXwRCm47gABa32X3yF+Sc8/gVux2T67DKcYqAp0dAnxsZOWcDCiwjGhvS+ra+yz
         6+gAhg0lrtW/ejE0GeSvx0/+fM+5mWrKrbA8W6zNDdJ5kae4EkIrQiV/a4dfcgsl5Qy0
         VBJjg3KFdWcSwXDAziAywE8mxS2VMykHwlafsYyJO9osFlg28duoHFwmtwdUasRDauyf
         YcuTVJrNj6B3/jA5WBc1buM5DfYH8PDiHyb+ycWFWAqOePLArfSW3ax2ZRjTr+pt7B6K
         83Eg==
X-Gm-Message-State: AOJu0YzzpXfrdSFz6MZTDNZypTGJflBqyJzMwkHBKOhdcFx8W8tBGbx+
        2QpKEHwE7J5c9O/G8Ood52yp2J7iGf6N6w==
X-Google-Smtp-Source: AGHT+IHLBajZsz0VxcL0CaCLjiP+JcpZ3Z6iSNDh4oLOCNKWTm9OPBX9RXcqYsgny9cLWKIkHF4CYYDwWcNIvw==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a63:7317:0:b0:5b8:fe99:152d with SMTP id
 o23-20020a637317000000b005b8fe99152dmr15385pgc.7.1702180170422; Sat, 09 Dec
 2023 19:49:30 -0800 (PST)
Date:   Sun, 10 Dec 2023 03:49:28 +0000
In-Reply-To: <20231208005250.2910004-2-almasrymina@google.com>
Mime-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com> <20231208005250.2910004-2-almasrymina@google.com>
Message-ID: <20231210034928.mk4ufxqis2w3wesg@google.com>
Subject: Re: [net-next v1 01/16] net: page_pool: factor out releasing DMA from
 releasing the page
From:   Shakeel Butt <shakeelb@google.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Christian =?utf-8?B?S8O2bmln?=" <christian.koenig@amd.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Harshitha Ramamurthy <hramamurthy@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 04:52:32PM -0800, Mina Almasry wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> Releasing the DMA mapping will be useful for other types
> of pages, so factor it out. Make sure compiler inlines it,
> to avoid any regressions.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 

Reviewed-by: Shakeel Butt <shakeelb@google.com>
