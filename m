Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EB57D17F2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjJTVVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjJTVVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:21:37 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EB2D67;
        Fri, 20 Oct 2023 14:21:31 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68fb85afef4so1270927b3a.1;
        Fri, 20 Oct 2023 14:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697836891; x=1698441691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuP8YmqjvAlLIcNW4aU20JarMo0gwdZcRbyTjH6FcUY=;
        b=VtAiWMPblTy3nSPxhb89xwOZKW97ZTsawo9dDPhFle9uW3SXnVsrNEpP6YleKKXsfs
         6OtaSFqO0wxb5OSJrHecwyhSROA1ql0IvvAW5tCw52WEL9gSwevduQLeGBrp/J3dFdjS
         +0M72CuV3aRYK32OWPJTanIJViBy7KOtXu3HzFItzHnlFCqoqvKbF7D/yjfruhkx9fIG
         B1YPaK3+qXJOvCiSHGKEQcjtmjQoXpEXy96gpXZE0ssOJRJz73yFw3PoT3x6zzRQdfPG
         2dWPBz+A0N8B0GDgsSFjn1bRk/T4Drk8/BYme8ViqBFBYUWqxVPxwcMuK2cHQZ7MiYRk
         6FpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697836891; x=1698441691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QuP8YmqjvAlLIcNW4aU20JarMo0gwdZcRbyTjH6FcUY=;
        b=Pk1jiyGMBK7FRPYLvV4T+zBMxw+cviVs5kHQtxeM/VOw6PNyh/hRTxfENj47fxvm+p
         vJ1o3q1ThjEvISkAxO4xom9m/03ian4hEYPsd+1ai4TTzl0HZCvvBDgTeIblE53pidnF
         cAsg5AcLq9+JjtE46RfEehXztQidtnNr9gSCJq7rM5xyu7VUlnhghAV+Gf8MXL5mUrow
         4e84/RkXAmKRr1hVPTD3mikqz/fMmm932LJ4KNE7/Gbn1el0m+1g6LTURkA1kqEZDTg0
         tkQzjiqJ3QNKSoc/I2ggOspqEROlyixZ9eG0ePJiKZXgPWo4M63Sj2ZvV0F1D5n2giri
         LiIg==
X-Gm-Message-State: AOJu0YytlWSEJ1VjsexpP+VrWCp7lzWpq0BQsPeJk6IBniE/yuQiVDL6
        AEhMKw38GDrWVhY66deQxBs=
X-Google-Smtp-Source: AGHT+IEfVi+7TdZGvtAx553ZwnhE1hTapL459+g+lFPn8/nql2it7L/WU+SuNSkyjwLfvoslBBF0HQ==
X-Received: by 2002:a05:6a20:2615:b0:151:7d4c:899c with SMTP id i21-20020a056a20261500b001517d4c899cmr2338039pze.25.1697836891024;
        Fri, 20 Oct 2023 14:21:31 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:5cd3:25e1:1589:ad95])
        by smtp.gmail.com with ESMTPSA id p9-20020a63e649000000b0057412d84d25sm1919583pgj.4.2023.10.20.14.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 14:21:30 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
        irogers@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        Yang Jihong <yangjihong1@huawei.com>, mingo@redhat.com,
        jolsa@kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Subject: Re: [PATCH] perf data: Increase RLIMIT_NOFILE limit when open too many files in perf_data__create_dir()
Date:   Fri, 20 Oct 2023 14:21:16 -0700
Message-ID: <169783679858.2217970.17247677172655395443.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231013075945.698874-1-yangjihong1@huawei.com>
References: <20231013075945.698874-1-yangjihong1@huawei.com>
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

On Fri, 13 Oct 2023 07:59:45 +0000, Yang Jihong wrote:
> If using parallel threads to collect data, perf record needs at least 6 fds
> per CPU. (one for sys_perf_event_open, four for pipe msg and ack of the
> pipe, see record__thread_data_open_pipes(), and one for open perf.data.XXX)
> For an environment with more than 100 cores, if perf record uses both
> `-a` and `--threads` options, it is easy to exceed the upper limit of the
> file descriptor number, when we run out of them try to increase the limits.
> 
> [...]

Applied to perf-tools-next, thanks!
