Return-Path: <linux-kernel+bounces-86081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4D286BF52
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42EA81F2441C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E0136B17;
	Thu, 29 Feb 2024 03:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZYC4tSo"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56608364A4;
	Thu, 29 Feb 2024 03:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709176090; cv=none; b=PlKCc4HEFnOIw4PtADmcBydw69FC0UTlq/po7p/POtNt18YSnyjg1+42je14mVNR6BYoz1modi6hCgGe8/vfbueTcksRUliCt/NEspF+ls+G7GdTZR/pODeYgQTUIwGTF5pXKnnAZzE14whUMVXrqUsUNGX1K0Hj64jyvMIQE9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709176090; c=relaxed/simple;
	bh=ht433vMi1TOdghnnmW8mJ+u5PWJCJikJmYtSS+v9v1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3EZRuHwR4pnMIJefuu676JBJOFUGkA+u1iw6kWYW5b3jfFt1wijKdUgcj6EezmT5xF+Bn0rFXP1uFIeFoU4G2w/XfXDINorS8N72fu61KO4NJgcytirf6OfquUTT0Wg3KWwRuFVCWN4k0Igg8zu3JBedSIYCVcTXTk5Fl/KW5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZYC4tSo; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412b5a9916eso3266735e9.1;
        Wed, 28 Feb 2024 19:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709176087; x=1709780887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hS0LEDmNn2urbgs7Rk9ueAuKUUBQ5p1mwcNjc8V2Cu8=;
        b=dZYC4tSomKhh9Uq9/Ge5z8ryXKUJZl9g/vTh/eerSgVnfa44INrWTS/IN0DW5vW4Ct
         tSoXv/oI/5zTd3CEkXlqZF5nMRz/Y+kmH4NidZvRzyBLIJB46rWEGhtZ04JyuYkcKMe4
         Qovht4PGYqcqiRmV7h8x0aZyJ3CxBQtebA+z/XNI3mdEolfMsxVvPAMJ7ya3Ql9Mn8JT
         oeYVsEyWiTkUnQi5Fetsd4boM2Gr73pVYxLVaNXAB3jRGYs08lSwWaxk1JG61xEdmfKj
         vXpEmxA0cAntkwENjj00YTom7NdlLTBfOh8wC3Lw2UGIc4UVPvs86xPD0O1Jr0yn6lDO
         WrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709176087; x=1709780887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hS0LEDmNn2urbgs7Rk9ueAuKUUBQ5p1mwcNjc8V2Cu8=;
        b=BUDxlcf5OmXZfrYa8dLyL9lERKrSERiXqw8Zq6j9kV71Pd/cFzGYqLzRTZsnsfe6M5
         LfExciPcvafZtyPcLjYvXPJPWuN9wc6R0uFkiPLGzcoII+4J/yXS1X9HmhsOB0M9bWVR
         VONyO0JR+3EIQzXUBo0Oa1PuobNXUUlwFd4/l+kR4bnbo7s3IwfqYNtjbrBULrpq8VHU
         68WRE/J3aN1kudFAfVmVAplOmhg7ih+VxM6rCqpHDYd5W0fmObe8qAo+2jXsPPa9NEcL
         7uiOKWGYiUj27VMPPnj3yjoIY1V85TBgf0FJSWfw7wZ8QQ8pP915mFVuoG4zzaL9QPsV
         kaiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeTwPPkocY3W7W7TYZDN9Sa0RZOsP4xPZ0iuRH0f5I49MpKQHiT30EpKOPAwMoMknAfvuPjcXSRyasuOHMqCSKsmsnsoPw4lzhwdrhUkQqmd3e5nVrhItqpH3KEu3eXVSk62c7G9tXAZH/vpzunnWDNrHRPyCtDOEtNnT+z+xeOGyW
X-Gm-Message-State: AOJu0YzhxfztFG4yPLwoBVofPAFriNWxwssZxTVR1dtuSUseLkv+aOoJ
	/0DkkhPZw84NgWUBTVQ/pBcSiyvYQK9EoGZesHNTbE/8EExn+rtv
X-Google-Smtp-Source: AGHT+IFZ1yeAw/AFq5AarM7sc7vo/nGggeIcQSFIF7NkXmVZF/VdPb6GykfSsW2x713MI1Tb8JFs8g==
X-Received: by 2002:adf:f684:0:b0:33d:f473:89d0 with SMTP id v4-20020adff684000000b0033df47389d0mr406556wrp.62.1709176086660;
        Wed, 28 Feb 2024 19:08:06 -0800 (PST)
Received: from lola.. ([2a02:810d:7e40:14b0:d371:e319:5dd0:9b35])
        by smtp.gmail.com with ESMTPSA id u1-20020adfb201000000b0033b1c321070sm417512wra.31.2024.02.28.19.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 19:08:06 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Jani Nikula <jani.nikula@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2 2/3] docs: submit-checklist: use subheadings
Date: Thu, 29 Feb 2024 04:07:42 +0100
Message-ID: <20240229030743.9125-3-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240229030743.9125-1-lukas.bulwahn@gmail.com>
References: <20240229030743.9125-1-lukas.bulwahn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During review (see Link), Jani Nikula suggested to use proper subheadings
instead of using italics to indicate the different new top-level
categories in the checklist. Further the top heading should follow the
common scheme.

Use subheadings. Adjust to common heading adornment.

Link: https://lore.kernel.org/linux-doc/87o7c3mlwb.fsf@intel.com/
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/process/submit-checklist.rst | 26 ++++++++++++----------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/Documentation/process/submit-checklist.rst b/Documentation/process/submit-checklist.rst
index 7d8dba942fe8..e531dd504b6c 100644
--- a/Documentation/process/submit-checklist.rst
+++ b/Documentation/process/submit-checklist.rst
@@ -1,7 +1,8 @@
 .. _submitchecklist:
 
+=======================================
 Linux Kernel patch submission checklist
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+=======================================
 
 Here are some basic things that developers should do if they want to see their
 kernel patch submissions accepted more quickly.
@@ -10,8 +11,8 @@ These are all above and beyond the documentation that is provided in
 :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
 and elsewhere regarding submitting Linux kernel patches.
 
-
-*Review your code:*
+Review your code
+================
 
 1) If you use a facility then #include the file that defines/declares
    that facility.  Don't depend on other header files pulling in ones
@@ -24,8 +25,8 @@ and elsewhere regarding submitting Linux kernel patches.
    comment in the source code that explains the logic of what they are doing
    and why.
 
-
-*Review Kconfig changes:*
+Review Kconfig changes
+======================
 
 1) Any new or modified ``CONFIG`` options do not muck up the config menu and
    default to off unless they meet the exception criteria documented in
@@ -37,7 +38,8 @@ and elsewhere regarding submitting Linux kernel patches.
    combinations.  This is very hard to get right with testing---brainpower
    pays off here.
 
-*Provide documentation:*
+Provide documentation
+=====================
 
 1) Include :ref:`kernel-doc <kernel_doc>` to document global kernel APIs.
    (Not required for static functions, but OK there also.)
@@ -57,8 +59,8 @@ and elsewhere regarding submitting Linux kernel patches.
 6) If any ioctl's are added by the patch, then also update
    ``Documentation/userspace-api/ioctl/ioctl-number.rst``.
 
-
-*Check your code with tools:*
+Check your code with tools
+==========================
 
 1) Check for trivial violations with the patch style checker prior to
    submission (``scripts/checkpatch.pl``).
@@ -72,8 +74,8 @@ and elsewhere regarding submitting Linux kernel patches.
    but any one function that uses more than 512 bytes on the stack is a
    candidate for change.
 
-
-*Build your code:*
+Build your code
+===============
 
 1) Builds cleanly:
 
@@ -107,8 +109,8 @@ and elsewhere regarding submitting Linux kernel patches.
    ``CONFIG_PCI``, ``CONFIG_BLOCK``, ``CONFIG_PM``, ``CONFIG_MAGIC_SYSRQ``,
    ``CONFIG_NET``, ``CONFIG_INET=n`` (but latter with ``CONFIG_NET=y``).
 
-
-*Test your code:*
+Test your code
+==============
 
 1) Has been tested with ``CONFIG_PREEMPT``, ``CONFIG_DEBUG_PREEMPT``,
    ``CONFIG_SLUB_DEBUG``, ``CONFIG_DEBUG_PAGEALLOC``, ``CONFIG_DEBUG_MUTEXES``,
-- 
2.43.2


