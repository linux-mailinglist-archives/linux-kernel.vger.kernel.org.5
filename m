Return-Path: <linux-kernel+bounces-58139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD18084E1D3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E34AB20FA4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E347D413;
	Thu,  8 Feb 2024 13:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="letYUnSD"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183BB7D410
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 13:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707398154; cv=none; b=G3WAeHLIGb3NwmfoAtTyX05pVa4iPCqmI/iSik7HAf/9jE5TmSTay1nz5bm0GOyu+fqVvwyqGGAMd3F+MBDlcC1jkuKn2PmjyeJcml9Rdu8XI3b5ou4g1sp8HiLAyN4cI4crmkZK+05pcHRZJnms1sM3caj/V4KjQw5zSZd2GJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707398154; c=relaxed/simple;
	bh=SEyLV8EA3UDikWXZ2JGORmUmCOCr2Fe68O2kEh9Su9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hZxRXAeCyfSmglcG6uBdr6ryBiOi06d8EVR9r6WH0z/V5SVaChbRWtrY11ZjjlMxiKQHlrJ7fOpxXbx/xq6lmHUiCsdp9Eluwim1YcsjlaWuss3nc8P2r++XV8Ezb2U3yd9u8HDyV2xlszA0lhzG9C1S6Jog62F0hcld+2cr9Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=letYUnSD; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-511717cfa62so401712e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 05:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1707398150; x=1708002950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tN5AQ/TNx9xhXcl1uoql+eElOXefKNcD2qx18n9oR4A=;
        b=letYUnSDAswX+eIl9SWuqGBNebhGdqr8qZrLQcjn0N53+mIgGZt0/YJ97n6iKHtz7b
         WAjdJJOdp7tJ/20miuKxZV3R+RiSkQe057C9KksptxtS4P4iVyP9L/dxO/tqUHZozlu5
         aslVwWP2EYoo2rLnUicxJqloTrjxQzNbIeDImkb66AufAKjYREZgSWQzc2Hp3UaUAHMk
         O9Za8hGyFBaNEzmrPrS0rQ5ZM/FHg0rhiGF4GSILUTdqcOgi94Hexl2yYWXwr2orCjIN
         vVpwkX3WSyHZMoaAis04f9aDSYeFlVnKHUlaujmk/a5R77DyqSEAOeXSKVs9KkWuZzX6
         ARjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707398150; x=1708002950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tN5AQ/TNx9xhXcl1uoql+eElOXefKNcD2qx18n9oR4A=;
        b=b068W7eKxlyhof0Zdytxqs73+KgSddWXQBE5u2JpxsVviadOVnauoBlE2ExmIlsChA
         feboVXhKfm5htSKfydUyK7C6J+PI4W6O9u97wL+CSLk7grbjf44Uj96GAqm3kjIxi0nM
         +J5iF0pyLOdvWu6ePbrbUAoKCfJ2IAL9GsQmBSFAo+kRvJDgUWhPW7q9elmuB8gtrEnp
         4ct/NWgtpWsZBCLmpo0WD4ndNP3wBSsJw1mBGIOFwcXR1gSO8X+dWa6a3RK+Pd4bGor/
         g3RpbrSE3Jyhv6SEobJodKVVlcVKYiIbndUlpXe1/oYW8HgVCF/YiT+vlF8XO7zmE2gg
         mbuw==
X-Gm-Message-State: AOJu0YxZYT65yowLzX5SS87MV4IQaNMBBWRls9AMxylNz+92NYTbhIvD
	ZBgYingSwvT6JJiKuEZfNcmx61FppL736+dkGswY6wE+Nm6vsiGpqaBatwr0ggM=
X-Google-Smtp-Source: AGHT+IGAqOf4DQcqfONgGpO02Y92fts42fxxYssdJfsFXf7d88iLObcv18TXvK28nb5eSZyikxSilg==
X-Received: by 2002:a05:651c:220d:b0:2d0:ccc4:4f8e with SMTP id y13-20020a05651c220d00b002d0ccc44f8emr3465928ljq.44.1707398149935;
        Thu, 08 Feb 2024 05:15:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLw0HIQIivXh67dDbUpoRHuOQ86nOXfOYUIkSo73l5AQU7Cw1UcYIanz/UxfwMufn4QhhtDx8YoyVOVIgMF6wLc3pYqAdkZy5ijpyQQyhPf50BiLqUAv1MlwCAIc9BQeNXFBydILe+kEbx/Uo7/TwTE1YhcqlI/blk1KHjV/HYVq+lQwPw4pZx3vwybO5JKEZliytsIg==
Received: from debian.fritz.box (aftr-82-135-80-180.dynamic.mnet-online.de. [82.135.80.180])
        by smtp.gmail.com with ESMTPSA id k10-20020a056402340a00b00560651808a6sm776678edc.67.2024.02.08.05.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 05:15:49 -0800 (PST)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: vegard.nossum@oracle.com
Cc: corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	thorsten.blum@toblux.com
Subject: [PATCH v2] docs: scripts: sphinx-pre-install: Fix building docs with pyyaml package
Date: Thu,  8 Feb 2024 14:13:06 +0100
Message-Id: <20240208131305.52577-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <c6555e01-1945-410e-9950-53c40052626a@oracle.com>
References: <c6555e01-1945-410e-9950-53c40052626a@oracle.com>
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

Add pyyaml as an optional package for Debian- and Red Hat-based distros to
fix building the docs if you prefer to install Sphinx as a package.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- s/pyyaml/yaml/ as suggested by Vegard Nossum <vegard.nossum@oracle.com>
- Make the check require the Python module; was optional
---
 scripts/sphinx-pre-install | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 25aefbb35377..7e49a020c25e 100755
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
@@ -951,6 +953,7 @@ sub check_needs()
 
 	# Check for needed programs/tools
 	check_perl_module("Pod::Usage", 0);
+	check_python_module("yaml", 0);
 	check_program("make", 0);
 	check_program("gcc", 0);
 	check_program("dot", 1);
-- 
2.39.2


