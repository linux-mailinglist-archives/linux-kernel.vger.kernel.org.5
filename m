Return-Path: <linux-kernel+bounces-162931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599F78B6259
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ADA51C21298
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4721A145325;
	Mon, 29 Apr 2024 19:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFhsRt6O"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C0D13BC0B;
	Mon, 29 Apr 2024 19:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419157; cv=none; b=BQaoRyvoPvPxKADtn44NVWAfyRJgdW5rm7RHNFB/lqlmTw/c0xqsVXbS84xnbqzzJkQ7eCqZcs40ExjIyJVDYiXe4xpuHbINPQLqK5U7Pu2fvkHEXCasMvLEw0m/6OssOkw/kyTM+6fRIqdD6iiWCDrB407VXVz7QZUeKBscsgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419157; c=relaxed/simple;
	bh=x7B9BhpJuCT/yiJlP8c8jHaBWHjbviFGNIalzLJuqtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V0TZE5t2Arw2EM/eQyLK/xGph8Vf2Xs2pncUg/uxSh0Hx40VaZ3aRV+wfvhEtfTxBQbHY8cjglg9kBs7uNLmyq16svih2OjtZHI15ADTK2Yl414stH2SZmZz/VbrqUCVdr70DZOzNRqgpcEEQsvlMi/mFpGyQ8ya68WRVjMqNP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFhsRt6O; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7ded01aa1d2so54843339f.3;
        Mon, 29 Apr 2024 12:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419155; x=1715023955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQVyPBV5Ch/zzQnquQeBlF3N9BA6vTpLwN146FcLEmI=;
        b=PFhsRt6OBsmPZf4iUWvFR17BeIy5qcRsvsdP8zcpL7ARICPwTTdRkhSjF31Ke8n0mP
         T1fEMlCkheVlQSRN7vtes0HYqU9tFJMWiR0y1ZdO6xABbTPsP+WBGgMMUmApEc34gmda
         X9oDW2969+aqNYyi0IXoKqw+KjMHWXt5obDFuoSmq/6eJGyoJvk5ihH7YSRcJk7pLjt8
         7zZz3M+YnN79uRDGRTWVZ1+k8O1i0jwTLpd2F+bjnRkhSSg3tp+uG8IrWCtQ3oNcooAC
         csgk/TW6kCF7fg+ohSLPCYOiGKc7F9iilVQHW7rb6lR8j80nAOGErkn7+0hHxwfbBuxR
         xRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419155; x=1715023955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQVyPBV5Ch/zzQnquQeBlF3N9BA6vTpLwN146FcLEmI=;
        b=tdFayXonAg4ncJ1aH2YWvED0EBPefvSd40MHaNpckxBSnJkVsuArHf9tARAKOrUEPC
         SeTGOB91WONmY6Sei4YI70u8VTtMZjBN3XAmtApDZZMGXY0wWeUO11E+rOrjBq4F9I/E
         Ch/x+94CH7RfkIW7CKfUf25Or94yoRpjGz7g+FUQK1omq+k7yzgzwP6RQydJ6AIGrQl8
         sWM8V6BBFqDThQGBSOisLClVZrn9NAQX/n2YnzbQ+X3xGhT3qLPlctF6hQjqorJBKUZx
         ODN1D3TQ34SkzEl0FnRz6gU9iUMESu4PgCFvrByK+cPjbujJBnHu44fuuXClRjlYD7CH
         uJyg==
X-Forwarded-Encrypted: i=1; AJvYcCW4EBeMJ+ENpIt6Pc/GpQ3f5+4/yvq5mpwI3jo1jR779w+4cJUnZ2CX0GwR+KJFZ7HRGR2oLiBfVcAF6EGCedGgmt6Ywa3U+Dv+xnwibMlrx3U2yAM1W5JolZM7CzFI6FvOKzSMdhx7
X-Gm-Message-State: AOJu0YxFhn87yDcQTIoicFVJ2ApXz4dVEBAogyI+WcwCSIHmSKI8cPGX
	TpzTUrgw77D6fja9XLVZVNnSG0K34vogy+PoNPK3XG87iYmQktWx
X-Google-Smtp-Source: AGHT+IFwjPQnHNdpL82QFoyvK82ch9P2MSNspb9WoQ/jz8r4btCyyStrJ5splTPFta5Lxtp3yMCjpQ==
X-Received: by 2002:a5d:8498:0:b0:7d5:f78f:ab21 with SMTP id t24-20020a5d8498000000b007d5f78fab21mr13368935iom.11.1714419155409;
        Mon, 29 Apr 2024 12:32:35 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id dq18-20020a0566021b9200b007d5ec9b77aesm5988402iob.51.2024.04.29.12.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:32:34 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: ukaszb@chromium.org,
	linux-doc@vger.kernel.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8 18/35] selftests-dyndbg: exit 127 if no facility
Date: Mon, 29 Apr 2024 13:31:28 -0600
Message-ID: <20240429193145.66543-19-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429193145.66543-1-jim.cromie@gmail.com>
References: <20240429193145.66543-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test if /proc/dynamic_debug/control exists, exit 127 otherwise.
This distinguishes an untestable config from both pass & fail.
The 127 choice is pretty arbitrary, but imitating bisect.

That control file's presense guarantees that dynamic-debugging is
configured (unless /proc is off, unusually), without dealing with the
<debugfs> mount.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 1be70af26a38..cb77ae142520 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -11,6 +11,11 @@ CYAN="\033[0;36m"
 NC="\033[0;0m"
 error_msg=""
 
+[ -e /proc/dynamic_debug/control ] || {
+    echo -e "${RED}: kernel not configured for this test ${NC}"
+    exit 127
+}
+
 function vx () {
     echo $1 > /sys/module/dynamic_debug/parameters/verbose
 }
-- 
2.44.0


