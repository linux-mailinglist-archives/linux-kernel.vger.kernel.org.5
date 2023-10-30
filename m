Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F987DC02B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 19:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjJ3S72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 14:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjJ3S7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 14:59:23 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CADE6;
        Mon, 30 Oct 2023 11:59:17 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6bf03b98b9bso4193847b3a.1;
        Mon, 30 Oct 2023 11:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698692357; x=1699297157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knMwkxFa68hfSIsQl/QdFKqFBy1S5UyMiN3QESx1V0s=;
        b=j0tZNsOq6NHouOS338u5s45Nd17Q3Mpk8J+HiMaR9kP23usOh/W2qRA/R77GPDJCM9
         aPp1hAA4fPMLhtI+gozXaa9tOHD/h3Xiciw3QMslyaPkuVdMevQeQvPGd3tbgiWU4z5I
         OSTqKQPVHd5Bpo8mEyC6X1hb1XAcGTZtAgHRvRCYW5RjMoUN5onFq7QK5EFgpk/KGeqr
         Cgh+BqN1xr28BOXlfdw3pdd68ywBBNKC24zXQTRD4QCsnhN39/vbUvwxRHY0bUKFCfWe
         feHCTnoQ+jJfLzqD46sLFLaOrvxuzp7avpyfCQsN7XOKNXolfysM667x5hEUZxWkKQNU
         d7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698692357; x=1699297157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=knMwkxFa68hfSIsQl/QdFKqFBy1S5UyMiN3QESx1V0s=;
        b=PhayFT9PFWiShJZx45C0eLboUXWfrnZYFaLo2ue+qpp5Vou0JCCIVT++P18UJsEnuq
         sr/VzjagkVEWUvBTmWe3FhxXI/5bF9vw7NrvhCMPDSRSo867Sb6r3L2atUEhQxR1twgZ
         qGbwf8Lct6zJBaoLw0Xl0DBtRDdhDuJTXRBvFMoZdBI5ODu8yX7Nz0R+pyY51T4/wOxA
         nrgpJ3PbAJNPIDGy5Pvdu2HtldUgLU9r5xqwutmTOsSjY//e29wcm38Zv9PjrO0+Gddx
         dglGku2l/FYUTmy5DfM0v9lmi1rGhWXmJWDK5LkXP78dLJDbleOX5FWirYA9ANCzWA/a
         Uqzw==
X-Gm-Message-State: AOJu0YzEkoHS9A75orLGSng7ZY+LZhWNRdnfFg4LodZuNC+GxWf1scFf
        AXMLyvQBrrUYiExYzpvfyHQ=
X-Google-Smtp-Source: AGHT+IHXTtB6NesUPcpsh6mXYFtJAyhsRDSs5DnxPiyXSU2DZ1XXRdqMc/Gn9WySAq7dwdKpF+DCGg==
X-Received: by 2002:a05:6a00:3187:b0:68f:cdb8:ae33 with SMTP id bj7-20020a056a00318700b0068fcdb8ae33mr430576pfb.10.1698692356829;
        Mon, 30 Oct 2023 11:59:16 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:b306:b3a5:37ab:d58f])
        by smtp.gmail.com with ESMTPSA id a18-20020aa78652000000b006be484e5b9bsm6191396pfo.58.2023.10.30.11.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 11:59:16 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] perf report: Fix spelling mistake "heirachy" -> "hierarchy"
Date:   Mon, 30 Oct 2023 11:59:04 -0700
Message-ID: <169869215963.2773399.5401456107402502726.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231027084011.1167091-1-colin.i.king@gmail.com>
References: <20231027084011.1167091-1-colin.i.king@gmail.com>
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

On Fri, 27 Oct 2023 09:40:11 +0100, Colin Ian King wrote:
> There is a spelling mistake in a ui error message. Fix it.
> 
> 

Applied to perf-tools-next, thanks!
