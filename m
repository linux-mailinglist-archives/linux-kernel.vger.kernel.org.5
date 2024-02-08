Return-Path: <linux-kernel+bounces-58689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B34084E9FD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443EE28248D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AB44B5A7;
	Thu,  8 Feb 2024 20:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="wb4+siUb"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D7B3F9F2
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 20:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707425927; cv=none; b=dQsNZKJcvI8nJpxmZO0mzrPdKML65CM4x/Z17eSo6Y956eNUMIHcCs9KmR7tftiyrYanmoDfrxwlQbOSyZpDozokRfiBgeP8pzzTkQlbOAvvd2G6hfWVntcunN/uaAyEnGpr4qxBnJmTkpf/386ZxyK7jvJSVbkFlhCSM1p2h2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707425927; c=relaxed/simple;
	bh=e4x8s2vq5KE3tjwGiTEDVUMIN4XccFGXeubsbMX6Q10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mg+rhJQHPi9wqfRpLYa2elq8ajfDnXksHf/+2LcmXZsloQCMGliYsuIrO0aWqKm2V0zVnMq6KgQUgYSVNPznVV8RHdI5oHnpcxbIUvCdthMRymb13eUIdnfrDbetBkX9mU8HAGYkRGdp0vLO62Jdny/co90z7USWOPqU0Yp8JvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=wb4+siUb; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55cca88b6a5so433310a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 12:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1707425923; x=1708030723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rh0/SSQbryhTyPsEnw0NTqJHbn4oA+/xslZpcTTvvbk=;
        b=wb4+siUbnrPnf6GvSv0dlhzU7T+ZRvQgyqonY9iZeJbg89adzWlvQoD8UaIdddb8jp
         YK7msf7mKZIsFdPrjB9ijfNw/m0pdjcr3FJTS8sv7Wtv1Qm04vL8yb5Q6aRGcRr9Meu7
         92hL9UUzEsQJmnFdvwPe4/stoX5GKQAmV0G1UtqRbyD/ghY0ffZHEJ4UXz5TL3MU3Kay
         GfnBhuUoOuebM8UcaPpDsq1/766MDevOI06xWZJ6pBEsBEYwkbQxXT68e3sNj0JlPxgD
         V30EbRT5RzVeJl66AIecRcI5TI0GPLc0hxKPYLxkRjsalvFD/R57sA6YUW49o3Fw8nXG
         eSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707425923; x=1708030723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rh0/SSQbryhTyPsEnw0NTqJHbn4oA+/xslZpcTTvvbk=;
        b=m2QvUppJi17G5DilTzUjw/1oRm9WxWufBwS12nx+3UHKLCIw3Rywo9uBKGsBVGiJ9p
         3NRJapPN8k1xcAHkFGR7wTqEMDf1w2FlVJUFaBn9bv8KXgUWOqQFyfSre1vtRter6gpR
         a8ZM9dr22PcKKaRvUlDsku2PfWY1MyNYwtZFp+ZBrOpceR2KMd5DYrnV5k3APLpkBo4+
         RmvP43bP0nCuxw8UL31sXRh2cDHnyP5+vLzSjm8prP2WAINeMd9Y041Nsqm8NdBXC1+Q
         MZvS1oVftRvyF5P9DyDzOjRIojGCG+aCgQgdWW1BNuLjSPUg6aWvLMXCx8R/QJv3k9kz
         MFhw==
X-Gm-Message-State: AOJu0YyMYEsfMVdDQKHhdHINYsyPU10dV60NVnUdlRegVxFvR2zWtfv1
	OOW22E5RTtNg9WqHy//6W/mt/YQG/x+ZOeEricWOspOsljVtKkO4bgfdpIRxdQc=
X-Google-Smtp-Source: AGHT+IGnjsO/HQ+adVUZ8qaCgNjU0tUTH1fyVyLhCxmQ+plbar/MgANb+APLmdnJ7jgvJvsodCgmng==
X-Received: by 2002:aa7:d0d6:0:b0:560:5f1e:f420 with SMTP id u22-20020aa7d0d6000000b005605f1ef420mr291084edo.0.1707425923471;
        Thu, 08 Feb 2024 12:58:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW0Va/BM7rgZ59qsnz+o58yVnLS5n7em3Hm6fyi97lloawcwZwVz0zCmMPg+IHbPmNhdnf5uTWO4Z/3xPZlW8IpKCy9oytAlvhpKnEs3Wx0HtRedaWrqBTSRp/ox7qJEWsHpSg1/k4/eCpgOxdkMbTVuFzMKE2CYL/Mpasu2nHjTTSUrnlDRlWQxZXfNRc6HDCu2hlY
Received: from debian.fritz.box (aftr-82-135-80-180.dynamic.mnet-online.de. [82.135.80.180])
        by smtp.gmail.com with ESMTPSA id k24-20020aa7d8d8000000b00560e72d22b8sm112068eds.2.2024.02.08.12.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 12:58:43 -0800 (PST)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: corbet@lwn.net,
	mchehab@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vegard.nossum@oracle.com,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH v3] docs: scripts: sphinx-pre-install: Fix building docs with pyyaml package
Date: Thu,  8 Feb 2024 21:55:51 +0100
Message-Id: <20240208205550.984-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <ED5D37EF-B353-4EA3-8AC9-7368BDD2CFD9@toblux.com>
References: <ED5D37EF-B353-4EA3-8AC9-7368BDD2CFD9@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Python module pyyaml is required to build the docs, but it is only
listed in Documentation/sphinx/requirements.txt and is therefore missing
when Sphinx is installed as a package and not via pip/pypi.

Add pyyaml as an optional package for multiple distros to fix building the
docs if you prefer to install Sphinx as a package.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Reviewed-by: Vegard Nossum <vegard.nossum@oracle.com>
Tested-by: Vegard Nossum <vegard.nossum@oracle.com>
---
Changes in v2:
- s/pyyaml/yaml/ as suggested by Vegard Nossum
- Make the check require the Python module; was optional

Changes in v3:
- Preserve Reviewed-by: and Tested-by: tags
- Add pyyaml to openSUSE as suggested by Vegard Nossum
---
 scripts/sphinx-pre-install | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 25aefbb35377..88ae75887476 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -361,6 +361,7 @@ sub give_debian_hints()
 {
 	my %map = (
 		"python-sphinx"		=> "python3-sphinx",
+		"yaml"			=> "python3-yaml",
 		"ensurepip"		=> "python3-venv",
 		"virtualenv"		=> "virtualenv",
 		"dot"			=> "graphviz",
@@ -395,6 +396,7 @@ sub give_redhat_hints()
 {
 	my %map = (
 		"python-sphinx"		=> "python3-sphinx",
+		"yaml"			=> "python3-pyyaml",
 		"virtualenv"		=> "python3-virtualenv",
 		"dot"			=> "graphviz",
 		"convert"		=> "ImageMagick",
@@ -472,6 +474,7 @@ sub give_opensuse_hints()
 {
 	my %map = (
 		"python-sphinx"		=> "python3-sphinx",
+		"yaml"			=> "python3-pyyaml",
 		"virtualenv"		=> "python3-virtualenv",
 		"dot"			=> "graphviz",
 		"convert"		=> "ImageMagick",
@@ -951,6 +954,7 @@ sub check_needs()
 
 	# Check for needed programs/tools
 	check_perl_module("Pod::Usage", 0);
+	check_python_module("yaml", 0);
 	check_program("make", 0);
 	check_program("gcc", 0);
 	check_program("dot", 1);
-- 
2.39.2


