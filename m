Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0DE7DC02C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 19:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjJ3S7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 14:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjJ3S7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 14:59:23 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1592ED3;
        Mon, 30 Oct 2023 11:59:19 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5b8c39a2dceso2999026a12.2;
        Mon, 30 Oct 2023 11:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698692358; x=1699297158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=So3aY4FlkZVxmSDWIXnKczJGjc5FfKNoN8ebCZefWpE=;
        b=SeGyKxnhT2RdiBX9E94Sr/qPXiW1PStbMxhmwzj75SoWMWDz6t+fD83i2rKP9KJvWW
         TOoufsrJHj5eT0P/9HPU9UMD3ckQu3aODiRHSEWEBwSAxXfwXodU2bJ2jLGLjAH4mly6
         mmmhjDgLmzi5bdDblJR5J96N/AndCwwbrLb2qSfZjIUFcOiacDNgSb7o2Fr01Io/dOqV
         Xuje4bUfr+bsLWLYPCOd6tvHLvLcnkXPev5U+Q4U6h+M1/Z/9mlXeFUYYXghFxrvWitV
         /IvDx4Wrdw/dwJ+rNAmWepHjF/QUClpeWT5NgciYnd1v+IAZN4CJyew4w4V+H33RjVeg
         gOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698692358; x=1699297158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=So3aY4FlkZVxmSDWIXnKczJGjc5FfKNoN8ebCZefWpE=;
        b=demMAl1rvjjSy6v3Ck7xblcUmfIj6aP8bhwEgehhfZgvhHNlvjgR81rhV7+OYKhPjJ
         PyJGjlGKOWUlG/3ctpdwVSq/G9meE+fI0SkT1xPrAH0FdN0KoUD6l68H3cv+LFpybZYx
         BOl1JJtXvllI0CrbwwI8fAxuNwd0OnarXKaza4qs+/8Od8cvoeMPkBX3chHKnJejxjav
         ew72/WYl6OFy5pwIMsP9ZNwlEc16uFPi8+y+TJCX5j1HWpCyDRCscMIkgmT6lVjsQ9oe
         3YyT77lyCOgCrgiT8MCy9VLvA9Hle/dH+uf5XWYi3A7mJ5Y/YeGz1dPOcmmt1PBU0PEC
         tbFg==
X-Gm-Message-State: AOJu0YyZLKzkEL6gNHH+52KYWKqWHziHt3XBlV1KbJcPjjBbT+Ny0R7l
        B2iBUdAvbzfCYBfOG15vnSnRnX6FYdU=
X-Google-Smtp-Source: AGHT+IGEXQ7yeY2xtReUtGwtr4ha3gDVwgt6/WfnSV/XZ6boqxoii5zpMx/44M3Vd6iPNRQa76PrOw==
X-Received: by 2002:a05:6a21:66c7:b0:17f:cf8e:2415 with SMTP id ze7-20020a056a2166c700b0017fcf8e2415mr6073607pzb.54.1698692358189;
        Mon, 30 Oct 2023 11:59:18 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:b306:b3a5:37ab:d58f])
        by smtp.gmail.com with ESMTPSA id a18-20020aa78652000000b006be484e5b9bsm6191396pfo.58.2023.10.30.11.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 11:59:17 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     linux-perf-users@vger.kernel.org, atrajeev@linux.vnet.ibm.com,
        tianruidong@linux.alibaba.com, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, James Clark <james.clark@arm.com>
Cc:     Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Kajol Jain <kjain@linux.ibm.com>
Subject: Re: [PATCH] perf tests: test_arm_coresight: Simplify source iteration
Date:   Mon, 30 Oct 2023 11:59:05 -0700
Message-ID: <169869215960.2773399.671365445660310243.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231023131550.487760-1-james.clark@arm.com>
References: <20231023131550.487760-1-james.clark@arm.com>
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

On Mon, 23 Oct 2023 14:15:49 +0100, James Clark wrote:
> There are two reasons to do this, firstly there is a shellcheck warning
> in cs_etm_dev_name(), which can be completely deleted. And secondly the
> current iteration method doesn't support systems with both ETE and ETM
> because it picks one or the other. There isn't a known system with this
> configuration, but it could happen in the future.
> 
> Iterating over all the sources for each CPU can be done by going through
> /sys/bus/event_source/devices/cs_etm/cpu* and following the symlink back
> to the Coresight device in /sys/bus/coresight/devices. This will work
> whether the device is ETE, ETM or any future name, and is much simpler
> and doesn't require any hard coded version numbers
> 
> [...]

Applied to perf-tools-next, thanks!
