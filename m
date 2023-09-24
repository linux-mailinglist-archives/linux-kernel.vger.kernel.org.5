Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F167AC7A6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 13:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjIXLG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 07:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjIXLG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 07:06:57 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EB4101;
        Sun, 24 Sep 2023 04:06:50 -0700 (PDT)
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 38OB68Tn010884;
        Sun, 24 Sep 2023 20:06:08 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Sun, 24 Sep 2023 20:06:08 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 38OB68R7010880
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 24 Sep 2023 20:06:08 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <dfdb82a8-85b2-4704-35b9-3ad901a179f1@I-love.SAKURA.ne.jp>
Date:   Sun, 24 Sep 2023 20:06:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v15 01/11] LSM: Identify modules by more than name
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, john.johansen@canonical.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        Dave Chinner <david@fromorbit.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20230912205658.3432-1-casey@schaufler-ca.com>
 <20230912205658.3432-2-casey@schaufler-ca.com>
 <1f5e725d-58b6-eca2-97dc-d7c1209ff167@I-love.SAKURA.ne.jp>
 <568c0730-b458-04b4-dbfa-77da1758aa05@schaufler-ca.com>
 <94743c22-bc76-e741-e577-3e0845423f69@I-love.SAKURA.ne.jp>
 <6df9f8b8-5653-09a5-ae0a-6526016abaff@schaufler-ca.com>
 <ec37cd2f-24ee-3273-c253-58d480569117@I-love.SAKURA.ne.jp>
 <202309200803.1911A584@keescook>
 <af696700-ae4b-346e-4c52-3a7a21b0f46c@I-love.SAKURA.ne.jp>
 <202309231838.CB16E6B5@keescook>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <202309231838.CB16E6B5@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch description says

  The LSM ID values are sequential, with the oldest module
  LSM_ID_CAPABILITY being the lowest value and the existing modules
  numbered in the order they were included in the main line kernel.
  This is an arbitrary convention for assigning the values, but
  none better presents itself. The value 0 is defined as being invalid.

and your non-sequential assignment

> But lsm_id::id is a u64 (not an enum!), so there is a HUGE space available.

violated it. include/uapi/linux/lsm.h is a userspace API file, where
we can't change this value after once defined.

You withdraw your "Reviewed-by" response unless "The LSM ID values are sequential"
and "must be approved by the LSM maintainers" are removed and "the LSM maintainers/community
shall never complain about what names and/or values are assigned" is added, don't you?

Quoting from https://lkml.kernel.org/r/4a6b6e2c-9872-4d4c-e42e-4ff0fb79f3ae@I-love.SAKURA.ne.jp :

  You are intentionally making life difficult for the out-of-tree LSMs, by
  requiring an LSM ID (and facilitating LSM ID collisions). No matter how
  priority of out-of-tree LSMs is low for you, what you are about to merge
  goes against the "developers try to avoid identifier collisions" effort.

  Introducing a numeric identifier is a good opportunity for permanently
  eliminating possibility of identifier collisions. But current usage of this
  numeric identifier is designed for facilitating possibility of identifier
  collisions.

Keeping how the HUGE space is used under control of the LSM community will be
better for both in-tree and out-of-tree LSM modules. I really can't understand
why you don't want to utilize this opportunity.

