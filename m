Return-Path: <linux-kernel+bounces-18414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63635825D1E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 00:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3C77285259
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 23:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1173F364A1;
	Fri,  5 Jan 2024 23:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="At26JjcB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF93F364A5
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 23:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-781706de787so7025985a.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 15:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1704496869; x=1705101669; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbSz98fOdnQt3nksKWuR0pA6Q2Dp2j6+68aJGsQtapI=;
        b=At26JjcBsXH0wjv5BphJc0ECTqrfO+hRixoxrEHJdexrXkQa0KbvIZXvu/JqM+QgSm
         utcpdy+FQn+7xr4fDT72T42TDoPaL4g4gWn7weUA0L3gOe9tlMLOgh/Qe3Ch1tvE6Fx3
         XA0CS+zx6OLS5X5O7312UbRvo92fkwJOhZ7ajjYOJnxu+wy29LjhROaHSglB9FN5cHGS
         Gbklhhc7vI1FnGHiiWVCEVv4pyvc0H6JG8SeZJZzLGfauNx3n5RdPXKoA4DoOGvSFuFe
         6mF7xP2U8H0RdFVV5HD3GnBCf5TH7k9OsrTpy1WBoxVIVR2tlByDbEKJ8/MMSeZyN8Sl
         jBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704496869; x=1705101669;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbSz98fOdnQt3nksKWuR0pA6Q2Dp2j6+68aJGsQtapI=;
        b=i4hp1ny0+rnGpbOGvhhzk4n2mvtE4Pdi5oIb3sNtwo8DVMCwFDN7fyvkUb65WgN8vD
         Lu9f68ENpUpAOi4+AvfCbhYyOgob2Tg8R2eJYvWiJT+yZCyzDO98V3eYT8vNR+FdvPW2
         dKZXKxvI02hp0WFgKSFwFq1+TfT9KtD7lcUDKogcWipzRJGcTpMiVgu7AE2Ih9OwsGbM
         +V0kD7pYeLCFbm4yPI8D+In45cJzCdS21Fr9qjfirGGsQTU1kHeVHarmpgAqhzelvOmC
         DzJxcHfzjasARIrbdVKnU5kEhDCa5ZDVUWAkzUR5OB7n/HKjrVF6xNoTVC2LZf1kdMDw
         klvQ==
X-Gm-Message-State: AOJu0YyXMzPpPWU8d3sQuFFaXqKgeAmX6W7q8GMsvQG058hvgyjWIyIz
	Os48PEpq5tVPXG/L1tIyar5BA0+yAaLI
X-Google-Smtp-Source: AGHT+IGB5yFnKyeTjqYHJilbFCir28a2yVGXJxysj2kaRkmoO1A16BkbkXgcPNsx7oJ7HFQOdDlG/Q==
X-Received: by 2002:a05:620a:2994:b0:77f:9736:aeec with SMTP id r20-20020a05620a299400b0077f9736aeecmr194255qkp.22.1704496868704;
        Fri, 05 Jan 2024 15:21:08 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id vy17-20020a05620a491100b0077dc528fd6asm933371qkn.73.2024.01.05.15.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 15:21:08 -0800 (PST)
Date: Fri, 05 Jan 2024 18:21:08 -0500
Message-ID: <7502247c0a4439b9bcf2c2ae315f2433@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20240105
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi Linus,

I realize this is a little early, but my network access is expected to
be a little spotty the first half of next week so I wanted to get the
Linux v6.8 pull requests out now.  The highlights of the SELinux pull
request are below:

* Add a new SELinux initial SID, SECINITSID_INIT, to represent
userspace processes started before the SELinux policy is loaded in
early boot.  Prior to this patch all processes were marked as
SECINITSID_KERNEL before the SELinux policy was loaded, making it
difficult to distinquish early boot userspace processes from the
kernel in the SELinux policy.  For most users this will be a non-issue
as the policy is loaded early enough during boot, but for users who
load their SELinux policy relatively late, this should make it easier
to construct meaningful security policies.

* Cleanups to the selinuxfs code by Al, mostly on VFS related issues
during a policy reload.  The commit description has more detail, but
the quick summary is that we are replacing a disconnected directory
approach with a temporary directory that we swapover at the end of
the reload.

* Fix an issue where the input sanity checking on socket bind()
operations was slightly different depending on the presence of
SELinux.  This is caused by the placement of the LSM hooks in the
generic socket layer as opposed to the protocol specific bind()
handler where the protocol specific sanity checks are performed.
Mickaël has mentioned that he is working to fix this, but in the
meantime we just ensure that we are replicating the checks properly.
We need to balance the placement of the LSM hooks with the number of
LSM hooks; pushing the hooks down into the protocol layers is likely
not the right answer.

* Update the avc_has_perm_noaudit() prototype to better match the
function definition.

* Migrate from using partial_name_hash() to full_name_hash() the
filename transition hash table.  This improves the quality of the code
and has the potential for a minor performance bump.

* Consolidate some open coded SELinux access vector comparisions into
a single new function, avtab_node_cmp(), and use that instead.  A
small, but nice win for code quality and maintainability.

* Updated the SELinux MAINTAINERS entry with additional information
around process, bug reporting, etc.  We're also updating some of our
"official" roles: dropping Eric Paris and adding Ondrej as a reviewer.

* Cleanup the coding style crimes in security/selinux/include.  While
I'm not a fan of code churn, I am pushing for more automated code
checks that can be done at the developer level and one of the obvious
things to check for is coding style.  In an effort to start from a
"good" base I'm slowly working through our source files cleaning them
up with the help of clang-format and good ol' fashioned human
eyeballs; this pull request has the first batch of these changes.
I've been splitting the changes up per-file to help reduce the impact
if backports are required (either for LTS or distro kernels), and I
expect the some of the larger files, e.g. hooks.c and ss/services.c,
will likely need to be split even further.

* Cleanup old, outdated comments.

Thanks,
-Paul

--
The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20240105

for you to fetch changes up to bbf5a1d0e5d0fb3bdf90205aa872636122692a50:

  selinux: Fix error priority for bind with AF_UNSPEC on PF_INET6 socket
    (2024-01-04 16:54:54 -0500)

----------------------------------------------------------------
selinux/stable-6.8 PR 20240105

----------------------------------------------------------------
Al Viro (1):
      selinux: saner handling of policy reloads

Jacob Satterfield (1):
      selinux: refactor avtab_node comparisons

Mickaël Salaün (1):
      selinux: Fix error priority for bind with AF_UNSPEC on PF_INET6 socket

Munehisa Kamata (1):
      selinux: remove the wrong comment about multithreaded process handling

Ondrej Mosnacek (1):
      selinux: introduce an initial SID for early boot processes

Paul Moore (19):
      selinux: update filenametr_hash() to use full_name_hash()
      MAINTAINERS: update the SELinux entry
      MAINTAINERS: add Ondrej Mosnacek as a SELinux reviewer
      MAINTAINERS: drop Eric Paris from his SELinux role
      selinux: fix style issues in security/selinux/include/audit.h
      selinux: fix style issues in security/selinux/include/avc.h
      selinux: align avc_has_perm_noaudit() prototype with definition
      selinux: fix style issues in security/selinux/include/avc_ss.h
      selinux: fix style issues in security/selinux/include/classmap.h
      selinux: fix style issues in security/selinux/include/conditional.h
      selinux: fix style issues in security/selinux/include/ima.h
      selinux: fix style issues in security/selinux/include/netif.h
      selinux: fix style issues with security/selinux/include/netlabel.h
      selinux: fix style issues in security/selinux/include/objsec.h
      selinux: fix style issues in security/selinux/include/policycap.h
      selinux: fix style issues with
        security/selinux/include/policycap_names.h
      selinux: fix style issues in security/selinux/include/security.h
      selinux: fix style issues in security/selinux/include/xfrm.h
      selinux: fix style issues in
        security/selinux/include/initial_sid_to_string.h

 MAINTAINERS                                      |   8 +-
 security/selinux/hooks.c                         |  36 ++-
 security/selinux/include/audit.h                 |   1 -
 security/selinux/include/avc.h                   |  41 +--
 security/selinux/include/avc_ss.h                |   2 +-
 security/selinux/include/classmap.h              | 342 +++++++------------
 security/selinux/include/conditional.h           |   4 +-
 security/selinux/include/ima.h                   |   2 +-
 security/selinux/include/initial_sid_to_string.h |  57 ++--
 security/selinux/include/netif.h                 |   4 +-
 security/selinux/include/netlabel.h              |  53 ++--
 security/selinux/include/objsec.h                | 129 ++++-----
 security/selinux/include/policycap.h             |   2 +
 security/selinux/include/policycap_names.h       |   4 +
 security/selinux/include/security.h              | 161 +++++------
 security/selinux/include/xfrm.h                  |   4 +-
 security/selinux/selinuxfs.c                     | 148 +++++-----
 security/selinux/ss/avtab.c                      | 101 +++----
 security/selinux/ss/policydb.c                   |  38 ++-
 security/selinux/ss/services.c                   |  13 +-
 20 files changed, 545 insertions(+), 605 deletions(-)

--
paul-moore.com

