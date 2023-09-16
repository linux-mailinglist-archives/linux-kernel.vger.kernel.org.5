Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB237A2E36
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 08:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238778AbjIPGdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 02:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238769AbjIPGct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 02:32:49 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D4F19A9;
        Fri, 15 Sep 2023 23:32:43 -0700 (PDT)
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 38G6W5kD044355;
        Sat, 16 Sep 2023 15:32:05 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Sat, 16 Sep 2023 15:32:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 38G6W5Fq044352
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 16 Sep 2023 15:32:05 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <94743c22-bc76-e741-e577-3e0845423f69@I-love.SAKURA.ne.jp>
Date:   Sat, 16 Sep 2023 15:32:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v15 01/11] LSM: Identify modules by more than name
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
References: <20230912205658.3432-1-casey@schaufler-ca.com>
 <20230912205658.3432-2-casey@schaufler-ca.com>
 <1f5e725d-58b6-eca2-97dc-d7c1209ff167@I-love.SAKURA.ne.jp>
 <568c0730-b458-04b4-dbfa-77da1758aa05@schaufler-ca.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <568c0730-b458-04b4-dbfa-77da1758aa05@schaufler-ca.com>
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

On 2023/09/16 2:53, Casey Schaufler wrote:
> I *could* respond with:
> 
> -#define LSM_ID_TOMOYO	103
> 
> but I won't. I won't make a difference because TOMOYO doesn't present
> any attributes. I understand your objections, but don't believe that
> they can't be worked around. The argument that a LSM ID will prevent
> new LSM development is rebuffed by the exact same situation with system
> calls, PRCTL and IOCTL values. The argument that it somehow prevents
> out-of-tree modules falls on deaf ears. The argument that it prevents
> dynamic security modules is subsumed by the other issues surrounding
> dynamic security modules, and does nothing to decrease the likelihood
> of that facility going upstream. Especially since, to the best of my
> knowledge, no one is working on it.

+/**
+ * struct lsm_id - Identify a Linux Security Module.
+ * @lsm: name of the LSM, must be approved by the LSM maintainers

Why can't you understand that "approved by the LSM maintainers" is a horrible
requirement for LSM modules which cannot become one of in-tree LSMs?

One of reasons for not every proposed LSM module can become in-tree is out of
the LSM community's resources for reviewing/maintaining (or failure to acquire
attention from the LSM community enough to get reviewed).

+ * @id: LSM ID number from uapi/linux/lsm.h

Since the LSM community cannot accept all of proposed LSMs due to limited resources,
the LSM community is responsible for allowing whatever proposed LSMs (effectively any
publicly available LSMs) to live as out-of-tree LSMs, by approving the LSM name and
assigning a permanent LSM ID number.

The only exception the LSM community can refuse to approve/assign would be that the name
is not appropriate (e.g. a LSM module named "FuckYou") or the name is misleading (e.g.
"selinux+", "smock", "tomato", "apparmour"). Otherwise, no matter how many times you repeat
"we don't care out-of-tree LSMs" or "I do not intentionally plan to make life difficult for
the out-of-tree LSMs", this patch is intended to lock out out-of-tree LSMs.

+ *
+ * Contains the information that identifies the LSM.
+ */
+struct lsm_id {
+	const char	*name;
+	u64		id;
+};

Therefore, unless you change the policy for assigning LSM ID, I keep NACK on this change.

