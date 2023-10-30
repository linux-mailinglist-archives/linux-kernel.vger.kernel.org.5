Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EDA7DC026
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 19:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjJ3S7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 14:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjJ3S7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 14:59:16 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E9AC9;
        Mon, 30 Oct 2023 11:59:14 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5b980391d7cso832430a12.0;
        Mon, 30 Oct 2023 11:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698692354; x=1699297154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7dazO68napvZmWwEzN+dzxcHG2lRJyOGRlqaZ3GkBE=;
        b=h33tY1yz7GtdjiyBCAP/4emiLIXjLtGAQPRW3yGIAVcQWOE5y56P7jyaF++XfBs0wN
         l0Y8J6G+Vr1nbDMEDSKXqMXzE4ZXjgxMW678Kbe+4uUunoLNpDEDqLiimubhg/9vTXMS
         LyqRKv1m6eADuvVEVu72Uibgz6jJr+i4Q0CSiysTgcSY4xgF8+v9YTsnD/3JCsWJLB6V
         ht5pHSoKcdHowIucrafWS0P/9eEQCSCd7bcmkIa1Ex3kQmnb34EbPI3kQdgzxB6Irrs9
         LmCMEw0PpUnvFNhaIBtDWULTQf/luj/oaR39ol/d8bv27NMAwXQSTYq1TxNQQSBh9zzC
         uJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698692354; x=1699297154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M7dazO68napvZmWwEzN+dzxcHG2lRJyOGRlqaZ3GkBE=;
        b=P0/JEmdO3LrlIW2Y6/XZE3rvgnhy2kdwK5AQr5do+Njq0mEKaSo9f2KVQbnEEUdEZO
         HJ4LM2NJ9OAq3tlwtVvp3eh1cTwfaY41tZQr1Nr+fhFHxqWsFXbwLRVyt6LadPujF5uI
         LlUc2B4nuK7U3J+0zalddoySIYQoMrafpxio/icwUNUQOJaXTGebU29v4qownX6A+/el
         QR/BR42B3e2iiDdGXA+y+kxQBE2p4WX/Dsrx33Zs9bxjZxk/TnP/+hkhurNUMTZH5szU
         GHHePYyttVT/s6y/OXNS/107S4gtkfjhHHouofm7i4tcAE+dJ9INfvnShi7RI3/n6dGm
         JqtA==
X-Gm-Message-State: AOJu0YxFRZbwGbwJYG5b5OcGOcDeInVysojnTnX9j7WI+tU3DEncic8/
        h7GTLwlF0YjbUWeT7UjkHQG7a48eYog=
X-Google-Smtp-Source: AGHT+IEYK/7NIbB9+YwA8+dM/ikdsUtQMR1tqu20/CQEd4UtfD5gmtWuh+QY6UvrBY6+ucg8C8pr7w==
X-Received: by 2002:a05:6a21:778d:b0:180:d45e:7262 with SMTP id bd13-20020a056a21778d00b00180d45e7262mr1243548pzc.56.1698692353692;
        Mon, 30 Oct 2023 11:59:13 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:b306:b3a5:37ab:d58f])
        by smtp.gmail.com with ESMTPSA id a18-20020aa78652000000b006be484e5b9bsm6191396pfo.58.2023.10.30.11.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 11:59:13 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/1] perf build: Disable BPF skeletons if clang version is < 12.0.1
Date:   Mon, 30 Oct 2023 11:59:01 -0700
Message-ID: <169869215963.2773399.8401888084213236204.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <ZTvGx/Ou6BVnYBqi@kernel.org>
References: <ZTvGx/Ou6BVnYBqi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2023 11:18:47 -0300, Arnaldo Carvalho de Melo wrote:
> While building on a wide range of distros and clang versions it was
> noticed that at least version 12.0.1 (noticed on Alpine 3.15 with
> "Alpine clang version 12.0.1") is needed to not fail with BTF generation
> errors such as:
> 
> Debian:10
> 
> [...]

Applied to perf-tools-next, thanks!
