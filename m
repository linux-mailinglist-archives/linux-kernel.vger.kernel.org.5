Return-Path: <linux-kernel+bounces-51279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D29E8488A1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 20:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70451F22BF2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0D55FDD9;
	Sat,  3 Feb 2024 19:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDQEKYYe"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9072F5EE80
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 19:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706990137; cv=none; b=p/99Tpb5x+NoYxpiD0yY3VPPJKGjXZSGrAHwC8imJdCLfHMYyCDOS/8BfKL0940wbVksGITd/qdqZUcXdtjsDbhbaBtPoiQwNAJ0oCYbTbt1YLwslIt41bGQYgrM9Ou6rlw3cSNP4a9HVdg0mALR7iMa1KycPgqJSidcSb0iMGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706990137; c=relaxed/simple;
	bh=Ex6gM/NUTsP2e8s+swh9Obk9z0EfqvzADqG1nJKjn3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDZxBqbuaj182v77Gm2n9drcN9adZjiPr+VSfxpZqg+vj/7z3ki5iZnkkbFTqypkhsrO8cea+lZRbBkLhvNzlJ1TsjxBhMRadGbCe2uqUm6Z1dGPXDUovixRbIVVSZRo9eNf0g12wlu7uBwkT1OSzf09fXnkdW7Hqt7hztZxEHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDQEKYYe; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-363b6fadff9so4560135ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 11:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706990134; x=1707594934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5O4gPRWME0qpw4p43cyejm6nlntjlGGd0ghS67oNKk=;
        b=CDQEKYYeFC0Sz/lrl3RBnacWoB7I4+MZWyPNMVd8SU4RSbCuNGR6KTJ/T7UCTs+nYe
         lwmvpFmk1OBVjFjqONaPCBVyCP5wOXOLC/Og4tvNvGzFsOJbdcksrDOf2RLIZyuJlYzF
         A7aTk+wH5oOnGoVfqdmwH2P3307dzbOFDPdLKN+DIdf2FXHuFCTld0akWROZQPtOC4uO
         FCdG2pLE/HglAB0DvguNQmMByE3hvy0AlSeaSQdCI3HPfoMIBjUq/XiWwaOBbVwnTXi2
         03CKpPt6sVmGflhL/v8fcgNidKzXhzO2fuBVtDCckZnkKSbjd60tHecraTZH338xxRwM
         GWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706990134; x=1707594934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5O4gPRWME0qpw4p43cyejm6nlntjlGGd0ghS67oNKk=;
        b=JQIATWxnAeuxq3QAmc2ghgJFUWpXwQUyAVA+7wuzlq3ZJDfNwDYdWVjY7vuyHQzdiW
         rfxb1UV6s8UebpsKG2T7XZqOf1wh6E+rcENEXUnUPSzmiiZ80KRzmAtz7Gvn0A2FfUFQ
         5n29ieptpnSykVxxPiQAbuQxz5ShE79RzQBtbKS700fqirE9fazADVc1+h1kaB1fCk4p
         tUbflzfFQ8cEx0zqPH8A59RQHA4QGQQLkF6A4E8t3tZa6G8aW1wQqLTQFMEFOAAbraup
         izF7yijuwl6M3vREYYeKOhlP5EtCP66ETS61CabPG54Ln9mkkXhxykTS6NqwbG0oURmk
         NRZw==
X-Gm-Message-State: AOJu0YxoATQEJRzWfdXcHt9r3HwWVITkUk14ziVZ0LxB4Nk9qxSb51py
	k6SkdIEI2iyzbVGw4A2jyB9uIfugQKqI7PC9hBXbrzCMPbjXmN4rEeJzvRDW
X-Google-Smtp-Source: AGHT+IHxMbgbOmNih2lNFXWV/2wMe7ily+THt5b/u9nAclSMPdaTeUbfnX5HnZlFVOc/tvmj0nw+bg==
X-Received: by 2002:a92:cd82:0:b0:363:c1ce:1a6 with SMTP id r2-20020a92cd82000000b00363c1ce01a6mr1430870ilb.13.1706990134278;
        Sat, 03 Feb 2024 11:55:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXR/VrgoYvp2XmHriqtrKxdmM3koeKTW2S9jIbvQV6xbexmDfxmoyjsV2GvAtibMcv8DniFh7j6z/2oYIALy0U9OvRg9xmZ2vIbL1D/a/RvLXOEr+gi7pWNV7wCdvuH
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id bd1-20020a056e02300100b003639075ae9asm1417232ilb.63.2024.02.03.11.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 11:55:33 -0800 (PST)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	akpm@linuxfoundation.org
Cc: joe@perches.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 1/2] checkpatch: tolerate long lines w/o spaces
Date: Sat,  3 Feb 2024 12:55:26 -0700
Message-ID: <20240203195527.212505-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203195527.212505-1-jim.cromie@gmail.com>
References: <20240203195527.212505-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

checkpatch complains about long lines (>75 chars), but allows a few
exceptions:

 file delta changes
 filename then :
 A Fixes:, link or signature tag line

Add another exception, to allow a long "word" without whitespace.  The
regex allows spaces in 1st 10 chars, so it allows the following [1],
which current checkpatch carps about.

[1] https://lore.kernel.org/lkml/20200825153338.17061-1-vincent.whitchurch@axis.com

Dummy-tag: test-generic-tag-format-with-url-length-bla-bla-jeez-dont-give-up-now-there.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 scripts/checkpatch.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9c4c4a61bc83..dc17c6da3af2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3271,6 +3271,8 @@ sub process {
 					# filename then :
 		      $line =~ /^\s*(?:Fixes:|$link_tags_search|$signature_tags)/i ||
 					# A Fixes:, link or signature tag line
+		      $line =~ /^.{10}\S+$/ ||
+					# a long single "word" without whitespace
 		      $commit_log_possible_stack_dump)) {
 			WARN("COMMIT_LOG_LONG_LINE",
 			     "Prefer a maximum 75 chars per line (possible unwrapped commit description?)\n" . $herecurr);
-- 
2.43.0


