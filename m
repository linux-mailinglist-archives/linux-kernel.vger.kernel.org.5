Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1375E76588F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbjG0QXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbjG0QXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:23:50 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F40D30F5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:23:47 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4039f7e1d3aso7639231cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1690475026; x=1691079826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hp9pmCwWGzwAzkTeiXGH85qKapC6XsGAmKK73+MFpHw=;
        b=J1haLNYl2JEJhQBtxWMQgCiCiuBTD3wDKAdUBcXakw9b1NN3fRU3qVBkifQGofFSMg
         HzSh2iI1NouDxyER6OmIj7kVCy6LyuVwvm9YrpsGcKOkmoY7hCA7y+SgwaosS2lnr7/N
         pIPDMB0ZDeU0FlRqhiTL9xu+T4B2DohyBRMHEHc/wD3sRYGjCKliHUgf+SZl3I/EXTwS
         GdB4L8pB26PwE4YJhx3MhKit81o3fQHFYt/KLmwYPpbNDxekVQYl0aaTM5toEV9F6obI
         8a+xNA1wjCUgO7lgwKdc7SyaU5wvlcG/RvZgw39UVwl61xKRJPiPt94T9ZFs6THFFXiq
         HweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690475026; x=1691079826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hp9pmCwWGzwAzkTeiXGH85qKapC6XsGAmKK73+MFpHw=;
        b=kV3pxz+PJEl5VRubbtDdh63uMyVHZJ9isfrazOcibJUGqn2m9uzC9jgxsy8Yu2Q+q3
         J7DgCCSWR1rndfoI9e5L6k4zNvnGn1XfOXdbBYQPPgopY2raObyPYkSaoYyXjfVyo3WN
         aBYT6x07l+Feq+GEx0LA+PdGZhG8ZK6BO+66IZGrW0fg44aK8tyZx20YfOGvpdkCvTSF
         2h9ME2Wx2WH84JlJlf1mTTI8TSTQL0biviikQoHC4G6Ir+C+p+yrexzHqkuDfPw0D8jr
         Q7KlgE8fb+Laye/4WmgfVTv0u5wyTTIFmdBOr8PhTEkFZZusX2RSNOTY+KoN6p738CNX
         USRQ==
X-Gm-Message-State: ABy/qLZKgtLlGQjxJuwkjCE9n1HNqaJ5v3sKw08djRBBHX8F6PvtvGWy
        2mD8dwIl+hmMH1m8zlF72YL+XQ==
X-Google-Smtp-Source: APBJJlEkxgeKPk9T3JM2J1ezStnG45MZWod/6OaHqToRC162m9EQ2vFK1VOwk4XX3VGzAzMQPmYwDQ==
X-Received: by 2002:a05:622a:1054:b0:403:be2b:590b with SMTP id f20-20020a05622a105400b00403be2b590bmr659374qte.44.1690475026270;
        Thu, 27 Jul 2023 09:23:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ad06])
        by smtp.gmail.com with ESMTPSA id e3-20020ac845c3000000b004055a1005e3sm518847qto.48.2023.07.27.09.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 09:23:45 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] mm: zswap: three cleanups
Date:   Thu, 27 Jul 2023 12:22:22 -0400
Message-ID: <20230727162343.1415598-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three small cleanups to zswap, the first one suggested by Yosry during
the frontswap removal.

 mm/zswap.c | 150 ++++++++++++++++++++++-------------------------------------
 1 file changed, 56 insertions(+), 94 deletions(-)


