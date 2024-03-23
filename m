Return-Path: <linux-kernel+bounces-112349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A87B58878C3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 14:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57B31C22421
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB033A8F5;
	Sat, 23 Mar 2024 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="01f+S3IU"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B53282F0
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711198961; cv=none; b=JgLz5d+FiSFnoUjtepJ4Vm/iUxiIfd8pYVgjCda21+UwsqzqpdqtfghYLesutklLV8ZVB02x4rudY1VkFrexNmQ6UP2e1AS+bH5OVKmFB4IZa/UrmLbLbUwg/msU9aRqbgQ7qCRk/RlI+ysv+YcOqDZeAlXt+VIUC6ThCoc8MnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711198961; c=relaxed/simple;
	bh=T7Mgu+MLzqWjzpi1LxLlvfVpGSX814PLr418pafoqeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E3xiuvqc/ttFwxEZnpiSIpggCc8PQHTmfTJjFdR6SwIaSXdzwstfh/Eln7wRx3ZS+mBKAs1czvxZVUsh6rXUUekiQ68ZWBcVJvnRM2/psSPejNDOCHjc6T0wcUFmqvduGpb32kIhRFPPwr1hGrhDnpA2lJh5UrvHERPS7hLvDG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=01f+S3IU; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56bdf81706aso2294578a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 06:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1711198958; x=1711803758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4AhIBO4PzLNRqcsQH2WrtOdVm/lP2EH+zIIytq3CL4s=;
        b=01f+S3IUtYd/meYR3cu6U5xgGx7ePaekBjSrNvPs81V2H4P11JfeO4891SoJLCCWNF
         BeaLwMkEdV0fGMbaI3ix8i/UZiLysAGlFbwwYibShb5zirE1IpcMFEEvIXfHfYbqIkjU
         FVyKv04AC9H9wiEde7zhuJE78QsmCYqeEa/ygeOtgbIOYrvg6O89Y7VqIiDbenuYfvuL
         rTxGEcKAB/7fRqB+ujPRSvVOER7+z8jb2+6HSPjUYS76vO6soAL5SsM40wk3BXc0zU/I
         JLyM/6UwoGyNuGPU7idX3yGSoV/xFen84GEktx1Vql2AC4ilzxvreJMtxXsfZg4oqfYq
         FOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711198958; x=1711803758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4AhIBO4PzLNRqcsQH2WrtOdVm/lP2EH+zIIytq3CL4s=;
        b=PvDaFkDGFULOfU2LcbAUPuAFtBPggrbhDBZOldsQ8PXJkyrCYOXaYYmUFoeRzAfwIY
         QMJAETLJGGiGijbfIYBNAGh00toFk+Pj61iYY6WUUNgkfj2HXiK6HbKKGykUYBcChVbE
         NrHQy+5k8KCX4+4FxLtjOtdpUg5/gniUmCJjAxiQq9L5RIlMq+p6QbZNEyd3mJU/J3xD
         DW4qbmiwKZoYqkrcnO2fXbcueU/HFjruEzBvBYZFNDqIbE7dVrjOExN5U7aCX/EoYDpm
         f3eIFNz1c6aMQtkSc+9xOU66YItnGEIX9Tpf0Mjjp7YSLRNY42D1ugQ7eup9bQpHh19R
         bPhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMAI6V/EU0wV/Eo8DoEDm0N4LqqIqlO3jzjPeMFbDIcWPfBM/80MLJstkQSSo1UlJqLzInxPNdiUM7T8qOOtozHC/9VJWgLdSfWPp1
X-Gm-Message-State: AOJu0YwaYQro+xU7vqdPg8QtE4MZnNKl14Uw0ttIREUP29PBRtChuICc
	nyu+4KAVFD8Umqljx7xsuhx2t56dGtRNMa2WLJg4er0z5w/80vFLgePTZYmZi94=
X-Google-Smtp-Source: AGHT+IEJcwa9KRylcPbZWBjipR/pVElG6lPBbsxJgzVNd0Q1WdTXThMSTUZVkDL1aExm6EkwUEZ2eQ==
X-Received: by 2002:a50:8706:0:b0:566:1952:694c with SMTP id i6-20020a508706000000b005661952694cmr1382283edb.20.1711198958348;
        Sat, 23 Mar 2024 06:02:38 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id v17-20020aa7d9d1000000b00569aed32c32sm865385eds.75.2024.03.23.06.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 06:02:37 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] scripts: sphinx-pre-install: Add pyyaml hint to other distros
Date: Sat, 23 Mar 2024 13:58:38 +0100
Message-ID: <20240323125837.2022-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend commit 84b4cc8189f2 ("docs: scripts: sphinx-pre-install: Fix
building docs with pyyaml package") and add pyyaml as an optional
package to Mageia, ArchLinux, and Gentoo.

The Python module pyyaml is required to build the docs, but it is only
listed in Documentation/sphinx/requirements.txt and is therefore missing
when Sphinx is installed as a package and not via pip/pypi.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 scripts/sphinx-pre-install | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 4c781617ffe6..d4f05216ca23 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -514,6 +514,7 @@ sub give_mageia_hints()
 {
 	my %map = (
 		"python-sphinx"		=> "python3-sphinx",
+		"yaml"			=> "python3-yaml",
 		"virtualenv"		=> "python3-virtualenv",
 		"dot"			=> "graphviz",
 		"convert"		=> "ImageMagick",
@@ -557,6 +558,7 @@ sub give_mageia_hints()
 sub give_arch_linux_hints()
 {
 	my %map = (
+		"yaml"			=> "python-yaml",
 		"virtualenv"		=> "python-virtualenv",
 		"dot"			=> "graphviz",
 		"convert"		=> "imagemagick",
@@ -587,6 +589,7 @@ sub give_arch_linux_hints()
 sub give_gentoo_hints()
 {
 	my %map = (
+		"yaml"			=> "dev-python/pyyaml",
 		"virtualenv"		=> "dev-python/virtualenv",
 		"dot"			=> "media-gfx/graphviz",
 		"convert"		=> "media-gfx/imagemagick",
-- 
2.44.0


