Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDCA7DC029
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 19:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjJ3S70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 14:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjJ3S7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 14:59:23 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469C3DA;
        Mon, 30 Oct 2023 11:59:16 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5a1d89ff4b9so2655491a12.0;
        Mon, 30 Oct 2023 11:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698692356; x=1699297156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4r8A7cJSUO7lfmtbA5mwhHvGqetNnRtlKJGlMM6PRY=;
        b=NIiPIMD250EZETgc9HnKfDKpGTgT7HsmW6n3ixbMJghda66sLUx6UCzEaW68cUyZms
         SHhxY8Ieo9P3WgUTN9mkE4MfPQAGgpLb6BwGrnspqy6tT4c5MTdk94YYH17III4HUyxl
         ppXEguWjs3ZIEG7L6l19qj5SBnDjCScX344r93Oh5o3bWJc0jHBcPT1Q3B3ttSLf+SpZ
         RUN6vTGVdG3PKQlSEEyc4+5LB475i3QsYqc1rxhYLPWwJsPJjkQzkfle5cv5l3E79PzQ
         1ea2jluJ5CE8vJaGDI7NgSTW8TLkobC1Cotl0rbkfEA6xXQ+KGnpoz7D9QblOraIpGrr
         QmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698692356; x=1699297156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D4r8A7cJSUO7lfmtbA5mwhHvGqetNnRtlKJGlMM6PRY=;
        b=CGtGg/VPPzSaP6YvhieyG2n0MGh4LGkWcU8cjjILApITpcsVHd6spCMwKYCnbofG3T
         xsDiP37+yDo/HU5maz4ZM+LZEszrK46OV05BLS8PRAA5dYzYwJ4MuHuYkxSo//ZTRunc
         DH0xG0mj8dq+F9UcbGHX4wSEJEGsg4mR3vlI3ldUpBfQv4XkvGIk0/UaXMtjBqmMfMKz
         Lq+7Ftw3fJVLX2GEbJO+EmNzvv3sEyaGPUPPbsqwDE81rv4fQcrQWL3pFqqFxlVZH1qs
         jQ1n4aE26vjLcORTStSHsn+CpAqcE4/VDfrsfuAW3MoS7/EMyQkIzxTHKQKYsARgF/8h
         ZQtw==
X-Gm-Message-State: AOJu0YwYsx/gVw/Gx0yyrfBqJ1zN0H3xX0H/khKRDVEBzY2o8Pxdnv8W
        XUETGhm2+pk7TnlwXDNDJRs=
X-Google-Smtp-Source: AGHT+IHU/caUo7izeKElyOwTfqzasmSBVd/ezx4D3hnVXYJAPrKvlwOmK1T7uaqU/3a+2fG7g0MGSA==
X-Received: by 2002:a05:6a20:da88:b0:174:af85:954b with SMTP id iy8-20020a056a20da8800b00174af85954bmr11840648pzb.22.1698692355705;
        Mon, 30 Oct 2023 11:59:15 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:b306:b3a5:37ab:d58f])
        by smtp.gmail.com with ESMTPSA id a18-20020aa78652000000b006be484e5b9bsm6191396pfo.58.2023.10.30.11.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 11:59:15 -0700 (PDT)
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
Subject: Re: [PATCH][next] perf callchain: Fix spelling mistake "statisitcs" -> "statistics"
Date:   Mon, 30 Oct 2023 11:59:03 -0700
Message-ID: <169869215963.2773399.7096091787995372516.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231027084633.1167530-1-colin.i.king@gmail.com>
References: <20231027084633.1167530-1-colin.i.king@gmail.com>
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

On Fri, 27 Oct 2023 09:46:33 +0100, Colin Ian King wrote:
> There are a couple of spelling mistakes in perror messages. Fix them.
> 
> 

Applied to perf-tools-next, thanks!
