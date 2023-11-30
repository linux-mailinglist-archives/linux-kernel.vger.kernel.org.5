Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD35C7FFC09
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376626AbjK3UMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376597AbjK3UMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:12:18 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A33C1708
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:12:24 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cfa5840db3so12926935ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701375144; x=1701979944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7yRpge09PX0Wdf+lXNd5GtHqIwiw9GJP88cctVPhIEQ=;
        b=KQI/x0XKzHUwiun86pdojo9dG4VYDwNQHFMDnMXJ7jzWyRHIkwBARxnOnK+beQJo/c
         r4tPQ6ymCmsC/hT6wcqH19AItRpxtJVSsWWJBKGmCUi9x6oTSO9rpo+Sxkagf4WEUBx2
         WZvUWICIpqV8kynmH8B8vZs8UAmXLn6cva9o8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701375144; x=1701979944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7yRpge09PX0Wdf+lXNd5GtHqIwiw9GJP88cctVPhIEQ=;
        b=WKIP6Y1uhqhCSMDOWpKAPRgcBfDnyxe4uHo1dPxeFbZeuxS+d5cxvkDKOPwqa2zHUe
         NfaUS3aG/nXZ/F0dTliT4u85kEb20KyaOrTxj+V07i4+rqE7PYvvsuvwG308S5hK1huD
         Mj41+qf11EukhbInSXJhZHspiaUz2uTG9BLnCCPoDDo3ThAgieRpNB2sXpKscSaPISLL
         3OXWixpje9TrXK/MR0TAjnG7nyttBc59b0F2iPi3Fwkv8jsbA8bChfpUBR38p0On25ti
         bNPFzEeBLys6AAjhXVuc3nAxBPvsKuyUYBDvurFqammoAtjEIQkil2ukzXDYKczQQMCS
         ZSjQ==
X-Gm-Message-State: AOJu0YxXgRHY0IFK9KgqRfAZg5MIhozvK6J5Sk5/r42/OZTElYTxJTvh
        hquSyg/pTZZQ87LOfbw4Za/FpA==
X-Google-Smtp-Source: AGHT+IEDYvGJDcvQf6eDCqExzllAKwKdXUTeiStyIwP++5uBdiMWqPss+P+SimJ7F/qh2uGJAVp4Og==
X-Received: by 2002:a17:902:ecc8:b0:1d0:4d29:59fe with SMTP id a8-20020a170902ecc800b001d04d2959femr560911plh.11.1701375143939;
        Thu, 30 Nov 2023 12:12:23 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z10-20020a170902834a00b001c9bfd20d0csm1576359pln.124.2023.11.30.12.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:12:23 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Tejun Heo <tj@kernel.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/3] kernfs: Convert from strlcpy() to strscpy()
Date:   Thu, 30 Nov 2023 12:12:16 -0800
Message-Id: <20231130200937.it.424-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1072; i=keescook@chromium.org;
 h=from:subject:message-id; bh=aEUE6lE4Q4cUS7kmRUCpsCDoI/XFYy6JmG/BqtvEWnc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlaOyjI+ulGzRHZE1zwS6WR9cpBI2cEhkIYffMO
 9/dfSozg3iJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZWjsowAKCRCJcvTf3G3A
 JvOLEACZaWfvn9Cv8vZlRQpBSWc4rShaO8nhhX/XpPHxU6M1Z5+XfBC2zl+AXSjGhXP4DV//eAJ
 /vRrKbqPD9FeLzKL45byGmDMqvYx5dV6aNAbzSFFHBltO5+yseaCpQpxQiowujYsZf7ggkHpPtb
 Br+dw8RrG6G9toJQz/2YW3z9ajNBETHg8Gi+DSyt4JhfTbVWb6mYukNCbyA43kqJPb2P3DKZjiq
 fVR2NmIsr1A7WnIyelCG8vMYUvOcaNeDkIVDg03yqfYUwDpITC8LRkTlkZyuz3jxvhzMRcWBswD
 pjYUqtjknDg1Ml60j29/Rqc2OkMM5o+IWNLmsx7pNR7vNo99Pzz8kqokZyo4nwGVB5OEwq4s8sM
 BO7JZVu4uhFLo939MvouGYFnXni3ka8rAZL+PY6wQD2aY4SvOYrvRn9K+pPLTImGc1RZbbGunQO
 ztkb+zjBiSlGDVUZ/qLogaTl7ngdqaGlBmh0uKIieptT4mdowHTkLci9peGu2KWCHWur6YBwIfu
 sXYEMP0mIluc6E+ZgnH7j1Duv3uLb1d2rW5G6xFT56jASPCfyKVlNuXCjdhYUtv+4TPfY2R1b4t
 HE8DQqBL7dCoA9Y3ViBzBe2Ql1UDcpQYm88yc5yYKiMkYtbaVwh3BGfB3ErxdERREMFmxqOYB3G
 JW65K4X oSJm3ZEA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

One of the last users of strlcpy() is kernfs, which has some complex
calling hierarchies that needed to be carefully examined. This series
refactors the strlcpy() calls into strscpy() calls, and bubbles up all
changes in return value checking for callers. Future work in kernfs and
sysfs will see the replacement of open-coded string handling with the
seq_buf API, but we need to do one thing at a time.

Thanks!

-kees

v2:
 - drop extraneous kernel/trace/trace_uprobe.c change
v1: https://lore.kernel.org/linux-hardening/20231116191718.work.246-kees@kernel.org/


Kees Cook (3):
  kernfs: Convert kernfs_walk_ns() from strlcpy() to strscpy()
  kernfs: Convert kernfs_name_locked() from strlcpy() to strscpy()
  kernfs: Convert kernfs_path_from_node_locked() from strlcpy() to
    strscpy()

 fs/kernfs/dir.c           | 53 +++++++++++++++++++++------------------
 kernel/cgroup/cgroup-v1.c |  2 +-
 kernel/cgroup/cgroup.c    |  4 +--
 kernel/cgroup/cpuset.c    |  2 +-
 4 files changed, 32 insertions(+), 29 deletions(-)

-- 
2.34.1

