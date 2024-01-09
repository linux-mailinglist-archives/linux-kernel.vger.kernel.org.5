Return-Path: <linux-kernel+bounces-20826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3E08285BC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41E3DB2158F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF4D374F3;
	Tue,  9 Jan 2024 12:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kectSwra"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EE0381A2;
	Tue,  9 Jan 2024 12:07:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A902AC433F1;
	Tue,  9 Jan 2024 12:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704802067;
	bh=Qxfrp9zAMsEhbKE3Ymgg87kkMOomQyLS0vfWL4J0F+M=;
	h=From:To:Cc:Subject:Date:From;
	b=kectSwrav1yP+2Vo5B7n6YkqnAOY1bAeskbI2G2sd3FVqZCWElsyoWKI6nToelpfC
	 34l4cUwgzh77kQKAc2+2g/z2gE4tfrTUgBdirDlcCwEUw3T+fH1fwhVMDxXuCr9MHo
	 bRDbs6zRRDtcfH8Xzm9MugQhM+3NCZh8LC1TEsrxnrTvJMOFWGQ/tduCa60Yhuzowi
	 jgqJcnSGpbks0R1MsEDbB+iI0yc8vTTsKdVvUeACBomRNHQjWM4HfPEscVdSpk0IGe
	 p/gdMuMDKS1HHsweC3K0mnk/HEai/Q6gD+u84hRxlZlCFnPQGkhrTUkCAL9xznh/X5
	 rNDDRjaYKFWNw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Simon Glass <sjg@chromium.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] kbuild: create a list of DTBs and allow to install base dtb and overlays
Date: Tue,  9 Jan 2024 21:07:33 +0900
Message-Id: <20240109120738.346061-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1/4 and 2/4 are less controvertial refactoring. This will be useful
for future cleanups.

3/4 and 4/4 address the current dtbs_install limitation; when the
generic -dtbs syntax is used in Makefiles, only the final assembled
dtbs are installed. We need to manually copy base dtbs and overlays
if necessary. It would be sometimes useful to install such base
componennts.


Masahiro Yamada (4):
  kbuild: create a list of all built DTB files
  kbuild: simplify dtbs_install by reading the list of compiled DTBs
  kbuild: create a list of base and overlays for each DTB
  kbuild: allow 'make dtbs_install' to install primitive DTBs

 .gitignore                      |  2 ++
 Documentation/kbuild/kbuild.rst |  6 ++++++
 Makefile                        |  6 +++---
 scripts/Kbuild.include          |  6 ------
 scripts/Makefile.build          | 26 +++++++++++++++-------
 scripts/Makefile.dtbinst        | 38 +++++++++++++++++++++------------
 scripts/Makefile.lib            |  8 +++++++
 7 files changed, 61 insertions(+), 31 deletions(-)

-- 
2.40.1


