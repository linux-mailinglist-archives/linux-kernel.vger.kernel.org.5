Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3DF7ABAFE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 23:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjIVVTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 17:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjIVVT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 17:19:28 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD72C1;
        Fri, 22 Sep 2023 14:19:23 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3add83c9043so1580036b6e.2;
        Fri, 22 Sep 2023 14:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695417562; x=1696022362; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=33plBw2S6RxLVTFtd8vbQkwkLM7hKUemGtBycCXA6jA=;
        b=DKJEpv40AlsLxKXnWmRq1YWHL3gZqrPlE3qPHg5SVijtsQFgfKiK/KyjL4Kp+Vwep+
         Bxkc1bTKAum7eyqoUXinVRp66EmgXbcCM2J3J4Etx80ym3jVMOi9XZYSU/Z4Wl5byXJ3
         IGHCT+/7uTyPmJQb7Sj6spwfm+TU2EtRgerXh45iBryWge/7gxDYEIU06RfHXodUK3Se
         e45ebQY6TTjNzCKkSiYYI5E9oZJDsp5g+SgIpsg/XaweW+QhOEh9rReFSvYlIkq1sRX+
         q4sWXhQZROQqVlsJZvaCMHFR2GrardBZmrmcuFtiI9ow7Z5fsXjcraoXroYx7oEy6JyS
         84yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695417562; x=1696022362;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=33plBw2S6RxLVTFtd8vbQkwkLM7hKUemGtBycCXA6jA=;
        b=cMyvW4zt3y2F3qJR/CObFHCQirIlmoignV7iZ625SiI+iHU5lbY5s8bIK34mXKLcHt
         TNtX5UvGKOichHLr3GQTlJeZN/Jh9q6RyXflFcal1J/obr1sWuaTs1LfXBdOj/z4xYkU
         +Po4FDulQQqNSO0dCbi7eAFPjqXCh/alpQFFY1VFlpEsiBozvYSQz28ouaHgzC7t0LOK
         3xBvxyUbqxS2sJYoo20Uvr+DMU5e03W8QX7zs8VLMa+MkUdlEYddRb1izIHISz3FXLqk
         CJ4pswntQaNhB78G5FeINzaXxi4QtKzZMx/ZrT9Fqss5nYdtF0Gn6ZVmbhQMB9EUruQC
         R62A==
X-Gm-Message-State: AOJu0YyRmq8RRK5UGpKkdQU1uho+JqOQbaoSp+uYUNQETLXiP7voSaz8
        GA5TYr8UswFVlQsIbxh3mxBxzAJKqldO5w9ub2RjfbC9
X-Google-Smtp-Source: AGHT+IEYL77hJxK6Usm7w5Mx7ub+ceAqRbev1H58TlAkTLpno6EgQQCAoipS/BPBlCKgfN735T3QADZuX7LDc0xvryo=
X-Received: by 2002:aca:2101:0:b0:3a7:4802:c3f with SMTP id
 1-20020aca2101000000b003a748020c3fmr821282oiz.52.1695417562384; Fri, 22 Sep
 2023 14:19:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5dc9:0:b0:4f0:1250:dd51 with HTTP; Fri, 22 Sep 2023
 14:19:21 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Fri, 22 Sep 2023 23:19:21 +0200
Message-ID: <CAGudoHFfG7mARwSqcoLNwV81-KX4Bici5FQHjoNG4f9m83oLyg@mail.gmail.com>
Subject: use per-cpu refcounts for apparmor labels?
To:     John Johansen <john.johansen@canonical.com>
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sanity-checking perf in various microbenchmarks and I found
apparmor to be the main bottleneck in some of them.

For example: will-it-scale open1_processes -t 16, top of the profile:
  20.17%  [kernel]                   [k] apparmor_file_alloc_security
  20.08%  [kernel]                   [k] apparmor_file_open
  20.05%  [kernel]                   [k] apparmor_file_free_security
  18.39%  [kernel]                   [k] apparmor_current_getsecid_subj
[snip]

This serializes on refing/unrefing apparmor objs, sounds like a great
candidate for per-cpu refcounting instead (I'm assuming they are
expected to be long-lived).

I would hack it up myself, but I failed to find a clear spot to switch
back from per-cpu to centalized operation and don't want to put
serious effort into it.

Can you sort this out?

Thanks,
-- 
Mateusz Guzik <mjguzik gmail.com>
