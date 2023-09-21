Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CA77A982E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjIURcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjIURcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:32:03 -0400
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [IPv6:2001:1600:4:17::190e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD8F10919;
        Thu, 21 Sep 2023 10:07:32 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RrlY55m19zMqhBY;
        Thu, 21 Sep 2023 06:16:57 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4RrlY35QQvz3f;
        Thu, 21 Sep 2023 08:16:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1695277017;
        bh=JPGqIw4NybtPv8UXpkiwD6sCB9HCR+gM6q1qZN9IqXk=;
        h=From:To:Cc:Subject:Date:From;
        b=YchhqMwoEcrcTmhUUQ9lpZZ8cs3lJqNM4E1jZL1qt4XqjlAFav6irE0qMM/KUEjor
         M88gN/aDWfE3sWP2nf+DSZjStURCumnvl9CRZ9cj1Y2e4+jYZTFjqbRgUx3GL5+xMj
         oNyd2c6uILdSsyYJu/YaEeK46TOeELV0lOaM0bdo=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Ben Scarlato <akhna@google.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
        Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@google.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Shervin Oloumi <enlightened@google.com>, audit@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [RFC PATCH v1 0/7] Landlock audit support
Date:   Thu, 21 Sep 2023 08:16:34 +0200
Message-ID: <20230921061641.273654-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series adds basic audit support to Landlock for most actions.
Logging denied requests is useful for different use cases:
* app developers: to ease and speed up sandboxing support
* power users: to understand denials
* sysadmins: to look for users' issues
* tailored distro maintainers: to get usage metrics from their fleet
* security experts: to detect attack attempts

To make logs useful, they need to contain the most relevant Landlock
domain that denied an action, and the reason. This translates to the
latest nested domain and the related missing access rights.

Two "Landlock permissions" are used to describe mandatory restrictions
enforced on all domains:
* fs_layout: change the view of filesystem with mount operations.
* ptrace: tamper with a process.

Here is an example of logs, result of the sandboxer activity:
tid=267 comm="sandboxer" op=create-ruleset ruleset=1 handled_access_fs=execute,write_file,read_file,read_dir,remove_dir,remove_file,make_char,make_dir,make_reg,make_sock,make_fifo,make_block,make_sym,refer,truncate
tid=267 comm="sandboxer" op=restrict-self domain=2 ruleset=1 parent=0
op=release-ruleset ruleset=1
tid=267 comm="bash" domain=2 op=open errno=13 missing-fs-accesses=write_file,read_file missing-permission= path="/dev/tty" dev="devtmpfs" ino=9
tid=268 comm="ls" domain=2 op=open errno=13 missing-fs-accesses=read_dir missing-permission= path="/" dev="vda2" ino=256
tid=269 comm="touch" domain=2 op=mknod errno=13 missing-fs-accesses=make_reg missing-permission= path="/" dev="vda2" ino=256
tid=270 comm="umount" domain=2 op=umount errno=1 missing-fs-accesses= missing-permission=fs_layout name="/" dev="tmpfs" ino=1
tid=271 comm="strace" domain=2 op=ptrace errno=1 missing-fs-accesses= missing-permission=ptrace opid=1 ocomm="systemd"

As highlighted in comments, support for audit is not complete yet with
this series: some actions are not logged (e.g. file reparenting), and
rule additions are not logged neither.

I'm also not sure if we need to have seccomp-like features such as
SECCOMP_FILTER_FLAG_LOG, SECCOMP_RET_LOG, and
/proc/sys/kernel/seccomp/actions_logged

I'd like to get some early feedback on this proposal.

This series is based on v6.6-rc2

Regards,

Mickaël Salaün (7):
  lsm: Add audit_log_lsm_data() helper
  landlock: Factor out check_access_path()
  landlock: Log ruleset creation and release
  landlock: Log domain creation and enforcement
  landlock: Log file-related requests
  landlock: Log mount-related requests
  landlock: Log ptrace requests

 include/linux/lsm_audit.h    |   2 +
 include/uapi/linux/audit.h   |   1 +
 security/landlock/Makefile   |   2 +
 security/landlock/audit.c    | 283 +++++++++++++++++++++++++++++++++++
 security/landlock/audit.h    |  88 +++++++++++
 security/landlock/fs.c       | 169 ++++++++++++++++-----
 security/landlock/ptrace.c   |  47 +++++-
 security/landlock/ruleset.c  |   6 +
 security/landlock/ruleset.h  |  10 ++
 security/landlock/syscalls.c |  12 ++
 security/lsm_audit.c         |  26 ++--
 11 files changed, 595 insertions(+), 51 deletions(-)
 create mode 100644 security/landlock/audit.c
 create mode 100644 security/landlock/audit.h


base-commit: ce9ecca0238b140b88f43859b211c9fdfd8e5b70
-- 
2.42.0

