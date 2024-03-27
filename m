Return-Path: <linux-kernel+bounces-120178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8434288D3C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C351C257F6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 01:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935581CD2B;
	Wed, 27 Mar 2024 01:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eu3X/HBi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6461862C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 01:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711503378; cv=none; b=I+riCUFWfUmXJ2yKCE7JZKuzken1tQ4zTxBTNDj6ohyQ752sAJJI44EPbmSRA/vTUgBuSaMLxkA0Ctz6hFJE0Ds73hLq4NMg9T9dmLujS9lhiRGufRwGGA5wGlCd5HDGQvSTXybZJnTJFTEG+0y2C9vZHRBIXpXdi4Pp42TIYFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711503378; c=relaxed/simple;
	bh=ECemb7/KX8BGFyghPRdr8JHojkYBtQzWD/1aRhBEX7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RwD3Xrcuevf3Uxm4MBRZH1XcNHRMEjby5ZKu+AaAlwVCubdOccMxkHZz0yqcCbJJAsqA9zC/I/VVd0ITZ3tDUb+KUroV/CA/k7645xJyB15eNqGgn1/yrp+9CchXsfJkS8sf5xGKFnyc3bsACcQQK4d5HT7cSWIH40Q3qmyKrKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eu3X/HBi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711503375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iYPTOunHLd/Diy0hNlVVbA0CQwtG77CQYjtLHeiLuNo=;
	b=Eu3X/HBiPgUwywAvsA2JT5akEyLVjmMinuHQeMfqw4UKePoNiDpOplFI2R5Q7yK/82YLnS
	958yqbhM1OwKArKeQWrXaOPImlpGrIM1p23AIi+cMv8Su0xlNlZU78+gl7QPOjS+UJ0eme
	b9ZG7mzxFTIUSwkDYaYhs1So53wJj+0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-LkaNSJ3YNy2Cx1WJHUkc9w-1; Tue, 26 Mar 2024 21:36:14 -0400
X-MC-Unique: LkaNSJ3YNy2Cx1WJHUkc9w-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-696914b6d2dso25566676d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 18:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711503374; x=1712108174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYPTOunHLd/Diy0hNlVVbA0CQwtG77CQYjtLHeiLuNo=;
        b=L+7LzkJVbOhkDUDo9lV01eymSW11RD5uMRjSq37nUEvcHiopwZi+Yv3UPjRoHY2Tv3
         pulslS0juhNlMv6qeFTJxjN5aY3Gz/LBXcvQtwzfuWUZhWvboPLRl9W7WlB3LtOtmSXH
         ySbfjAA2ClmvB8Tk3JyR7gcHBpE/MxyrWikz+Fub987eU5ZvjZb0Vq2ChJKArQ2LTL0v
         0LRzWe/GCPq897OPFoeGfqqVsfRUtGpmXaYckujFQD/cmiQiNM0FOJcSXHx+bpA7SLcU
         boNsIYqj6h1rXo/KoWG2ZVlFa6AWW0jHCVfkuBOCVQaoKeO4a64xQ7/B1rFmUirGGA89
         xLHw==
X-Gm-Message-State: AOJu0YyZID7disobWwW67E56GeyNCkb8XMdqSiidxdzE43mfg6MapSpw
	wqnrinENkSo7nvg5YzykgClYfmjEZmlfmHsKLbX9hOaplNLCsoOiBKp6kC71Xc09cPvpu0yAZsD
	xOyfkYQ6lNuqcGfMdXo1F3UfANsFa+kSr0u0pzb0ekYza/jZeekXwkfUjiacIVA==
X-Received: by 2002:a05:6214:e6c:b0:690:b3a3:2261 with SMTP id jz12-20020a0562140e6c00b00690b3a32261mr2857118qvb.53.1711503374032;
        Tue, 26 Mar 2024 18:36:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhUP8icqSJJoJYHIjBdnpMjQxvYXH/YAk6xTmiVd4FaN0LmOOpbpBO3pJH1Xwh2Qag7NMJiA==
X-Received: by 2002:a05:6214:e6c:b0:690:b3a3:2261 with SMTP id jz12-20020a0562140e6c00b00690b3a32261mr2857103qvb.53.1711503373718;
        Tue, 26 Mar 2024 18:36:13 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a801:90ea:8d3f:e47:b819:941d])
        by smtp.gmail.com with ESMTPSA id x11-20020ad4458b000000b00696a47179a1sm819669qvu.14.2024.03.26.18.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 18:36:12 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: Helen Koike <helen.koike@collabora.com>,
	Leonardo Bras <leobras@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v1 1/1] gitlab-ci: Let project define runner using environment variables
Date: Tue, 26 Mar 2024 22:30:54 -0300
Message-ID: <20240327013055.139494-2-leobras@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently it's not possible to select which runner will handle a pipeline
without changing the codebase.

Add CI_TAGS environment variable, which can be used to select a runner
either from a commit message, or directly from Gitlab interface.

Also add Documentation for this variable.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---

This patch goes on top on a previous patchset sent by Helen:
https://lore.kernel.org/all/20240228225527.1052240-1-helen.koike@collabora.com/

With this patch I could run CI with gitlab.com runners, by setting
CI_TAGS=saas-linux-medium-amd64 

The result of this pipeline can be seen in:
https://gitlab.com/linux-kernel/linux/-/pipelines/1228999646

 Documentation/ci/gitlab-ci/gitlab-ci.rst | 5 +++++
 ci/gitlab-ci/yml/gitlab-ci.yml           | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/ci/gitlab-ci/gitlab-ci.rst b/Documentation/ci/gitlab-ci/gitlab-ci.rst
index 4f7ef03cca95..18360da835bd 100644
--- a/Documentation/ci/gitlab-ci/gitlab-ci.rst
+++ b/Documentation/ci/gitlab-ci/gitlab-ci.rst
@@ -304,20 +304,25 @@ Description of Each Variable
 **KCI_CHECKPATCH_OPTIONS**
     Used in `checkpatch.pl "$KCI_CHECKPATCH_OPTIONS"` (see checkpatch
     documentation). It is commonly used with the --ignore flag to suppress
     specific warnings generated by checkpatch.pl. It can also be defined in the
     commit message, since it is evaluated in run time.
 
 **KCI_PATCH_SERIES_SIZE**
     Used to define the size of the patch series, see `job: checkpatch` section
     above. It is evaluated in run time, and can be set in the commit message.
 
+**CI_TAGS**
+    Used to help choose which runner will deal with the current pipeline.
+    If using Gitlab.com runners, set saas-linux-medium-amd64 or a better runner
+    so there is enough resources to build & commit the base image.
+
 .. _triggering-pipelines-from-command-line:
 
 Triggering Pipelines from Command Line
 --------------------------------------
 
 Pipelines can be triggered from the command line with custom variables using the
 `GitLab CLI tool <https://docs.gitlab.com/ee/editor_extensions/gitlab_cli>`_.
 
 Example:
 
diff --git a/ci/gitlab-ci/yml/gitlab-ci.yml b/ci/gitlab-ci/yml/gitlab-ci.yml
index 57b9c0290471..359b7715e3ab 100644
--- a/ci/gitlab-ci/yml/gitlab-ci.yml
+++ b/ci/gitlab-ci/yml/gitlab-ci.yml
@@ -33,20 +33,22 @@ workflow:
     - if: $FORCE_CI == 'true'
 
 variables:
   FDO_UPSTREAM_REPO: helen.fornazier/linux   # The repo where to look for cached images
     # ccache builds in gitlab-runner to speed up builds
   SMATCH_DB_DIR: /smatch/smatch_data
   # exit code of bash script on `script` will be the exit code of the job
   FF_USE_NEW_BASH_EVAL_STRATEGY: "true"
 
 default:
+  tags:
+    - $CI_TAGS
   artifacts:
     paths:
       - artifacts/
     when: always
 
 include:
   - remote: 'https://gitlab.freedesktop.org/freedesktop/ci-templates/-/raw/16bc29078de5e0a067ff84a1a199a3760d3b3811/templates/ci-fairy.yml'
   - remote: 'https://gitlab.freedesktop.org/freedesktop/ci-templates/-/raw/16bc29078de5e0a067ff84a1a199a3760d3b3811/templates/debian.yml'
 
   - ci/gitlab-ci/yml/kernel-combinations.yml
-- 
2.44.0


