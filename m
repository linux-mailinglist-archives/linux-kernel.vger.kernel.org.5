Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10BC7D875B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345573AbjJZRLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345480AbjJZRLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:11:30 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6216D55;
        Thu, 26 Oct 2023 10:11:26 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68fb85afef4so1094238b3a.1;
        Thu, 26 Oct 2023 10:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698340286; x=1698945086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4Hz68yI660ipLu+CvI0RKlL1QB9xvpcH1iNo665HDk=;
        b=Qv5+DA2y0IsfYTsN8CG0HGSi2OTHa1IXRpEKtnaKGVqNW42SHBhspDRnisJS/jxyZP
         zxbzCV33vF4uV5epB1LncBg6h+g7kTFIMOcJjT/eJFhqdc+4SI7lDBpeAdsG2M4FRLku
         UEe0AJ/jRv6GxTmeWOGUB+a9vHMOFhq4epdGGmknk+1S4Ia2zmbAm48byJOmkZ4MPLPU
         MryZoIYiclkNjCgKDwo3+SvG1foAELpL8yeN7od/GSZeIE48v7B20gjR3BQWhga0ou7Q
         7AnwquKrrpu+wGf+KrrynjT92DGZxv/OzJdy6RBiIuUjGFNI5bmeX79DJ5sjkM47ginM
         1dJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698340286; x=1698945086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d4Hz68yI660ipLu+CvI0RKlL1QB9xvpcH1iNo665HDk=;
        b=fJcukXlMazFMmkWx0zZiEZ+kY63wSD71N5fn3MXiPJplgOoI2OvivSdkTF+t1otWOz
         JC5/dIb3+yRL431STKKyeTedae9dslRTk3oCbYdEvUR3GEn2Y96FNdni2JLk2+JLyDyp
         gNikfZYPWZSpIuuii9/01AKPntWJKVc0iN96Mffusw47/PM5TM1pCxgrAGuz4lhvzfk2
         AJ4NG+y31G1Z3GEEpAIAf/JmcbvRuUWCvlYfUHjFVw41DubdPPOTBeDEB7xpmoZyHxnZ
         e0tQVnnA7sU5Pc/6Q9xhq1/vze9d+zxekTP+AyXYs/X4DP6ou+/0Y6ZJUxObg8RQwp4R
         Lqbg==
X-Gm-Message-State: AOJu0YwXMkSACAZ1OOg0grsD3ljq0Ihha/bi9x0BDwmi05ehn4BTeSx/
        3f8edVZoj+dF92MZydLRqtg=
X-Google-Smtp-Source: AGHT+IEkQ2kARqa/dlXjvPVpOC4YCNNY/e4UPZDHmu9VPne5KKX6ea12A7c0Zbn9R1W+Ovy5RezpSA==
X-Received: by 2002:a05:6a00:2284:b0:6be:5367:2131 with SMTP id f4-20020a056a00228400b006be53672131mr128978pfe.24.1698340286275;
        Thu, 26 Oct 2023 10:11:26 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:ec51:cb82:a169:2ada])
        by smtp.gmail.com with ESMTPSA id k15-20020aa7998f000000b00688965c5227sm11356315pfh.120.2023.10.26.10.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 10:11:26 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     jolsa@kernel.org, irogers@google.com, mingo@redhat.com,
        mark.rutland@arm.com, peterz@infradead.org,
        linux-perf-users@vger.kernel.org,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, Yang Jihong <yangjihong1@huawei.com>,
        acme@kernel.org
Subject: Re: [PATCH] perf evsel: Rename evsel__increase_rlimit to rlimit__increase_nofile
Date:   Thu, 26 Oct 2023 10:11:14 -0700
Message-ID: <169833996386.1181734.1116022702370415307.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231023033144.1011896-1-yangjihong1@huawei.com>
References: <20231023033144.1011896-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 03:31:44 +0000, Yang Jihong wrote:
> evsel__increase_rlimit() helper does nothing with evsel, and description
> of the functionality is inaccurate, rename it and move to util/rlimit.c.
> 
> By the way, fix a checkppatch warning about misplaced license tag:
> 
>   WARNING: Misplaced SPDX-License-Identifier tag - use line 1 instead
>   #160: FILE: tools/perf/util/rlimit.h:3:
>   /* SPDX-License-Identifier: LGPL-2.1 */
> 
> [...]

Applied to perf-tools-next, thanks!
