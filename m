Return-Path: <linux-kernel+bounces-141344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EE18A1CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F131F21FCD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF00815532D;
	Thu, 11 Apr 2024 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="PuQsFBwt"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7D547A64
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853902; cv=none; b=MjZfO6Ew1ioGG+l5MJKtRAdU0Nc0JPFEry+1BW51Cu8xEr7x/NmdC9Vs7vYOGVPIzwUirK3vJZNoM4zq6RT1ppkpJHSpoJIXInzt/Yn9UeDUzCHb4pnT8LSqnzFOcOhYUFzNndYOoupSsuQ/FAKli3bWxQQ+/YJymlLgmoi7TiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853902; c=relaxed/simple;
	bh=L/lbl4FoIUs6UZhGod6ET5XcpMpQIGR9o3M2LvmcI74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JKWhy+ns89mSu3rCG83AHf+TfQfSnEH2ePDgNrtWg1hVreR14cJ8ZBJBkuYTEg6kqgjBZ58BZBzP98rgZ5DIOeBbCRWH4brlAnCeRWDQ1CHM7fE+49UruqY3OruY2AvY/P15nF/R/fRXQKKW5LPCIZMK6Z8B+X3MvHagmfMaol8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=PuQsFBwt; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d717603aa5so93594351fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712853899; x=1713458699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rciLgnl7jf3ltOZtOlJxI5UnFTTiSa13ydmrz5IK0H8=;
        b=PuQsFBwtol4LegRne+QPeidNSP82MtA9+eOEw6uWQLB9Hoz1VUYaUz3yLHFhvIuqzx
         VdKYsGeNhTikBlGgNpk97+uWrfmsKbRiSs7KfQYyKQz91jdRb0H1N2V9ovBlkh6RcWsf
         Uq6liugBhxqu/7g/mcC3MUDMPpvNF9nwMYO3Hsdx7tWnBCuMWEUhMBNjjcPIrzwrKyL5
         DkWTUAZ+HIv3WxGCdmIfVLZJej1aAa9MzBvogbsuzbOQV97NbiNFTWcIUct5lAa9BnZ6
         QhduDU8DuFnjlpu1mEAqUKfS5AEFoxF+llXPaoKwI7Jb7qldEHlNyz11jxAY3jvM9d5j
         WOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712853899; x=1713458699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rciLgnl7jf3ltOZtOlJxI5UnFTTiSa13ydmrz5IK0H8=;
        b=WjOcdBH7QvLKW3enEIWbDnvP5uhk36WelNWdSwfou3aB9YkXnz++c4UjI6qB8B/Dvd
         YlqWbd7oKqdima+HC+DAUAGY4dk3lCh00VcfulV4Wa3si8c1pib5H1TkR1x6e29crgg/
         6HwDI4sDmdoR7+7diT4WaoTNwIh7pjuagmK4i3/KqzSfiSSCwqR+oD7/JyzjphSjpJ09
         guSiVNrUpYLxFbKHxcQDLB8jBXpTBhvEfkPXHcPA4B/9VRcRy9oE8XUGaViL4TP6CwqT
         PpshazMGiy1JNCepmEBe/tUfgY4cOE5w7+pcVKn8fcV1Jt0Hfa4AnRwTkBnbgA2wmsYd
         r44A==
X-Forwarded-Encrypted: i=1; AJvYcCUETMBvpU+9r0mUr2AMrtCDZuQDZeTCg0bZWAvkHCVIVtZMrHvrQ+tzavb9y1J1QWr/2I8CBHqRNxjhT2iIt1Y3M+ND57965HvRLYKf
X-Gm-Message-State: AOJu0YwoR9ggI5KXUnO1HCYdel+n068Nwua8AQhHdMRx0avJDae5sTKD
	+43DSz/++imAp1Zd82PjdUyPcw/+FmgWuc2bJ8TxdyfEEOfYywMXvMfpDqIis94=
X-Google-Smtp-Source: AGHT+IEwll1rsUMGNeW1FuXusul1A8HmVEsJ7Cvp9KCtA/BhU0LJTecUFPwwGIjIOVXlugNh32cL9w==
X-Received: by 2002:a05:651c:512:b0:2d6:8e54:80a1 with SMTP id o18-20020a05651c051200b002d68e5480a1mr168779ljp.19.1712853898891;
        Thu, 11 Apr 2024 09:44:58 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id ig4-20020a056402458400b0056fe7e308c3sm766529edb.0.2024.04.11.09.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 09:44:58 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Quentin Monnet <qmo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [RESEND PATCH] bpftool: Fix typo in error message
Date: Thu, 11 Apr 2024 18:43:00 +0200
Message-ID: <20240411164258.533063-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s/at at/at a/

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Resending this because I forgot to CC the mailing lists
---
 tools/bpf/bpftool/prog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 9cb42a3366c0..c5cb0f9beb07 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -2078,7 +2078,7 @@ static int profile_parse_metrics(int argc, char **argv)
 		NEXT_ARG();
 	}
 	if (selected_cnt > MAX_NUM_PROFILE_METRICS) {
-		p_err("too many (%d) metrics, please specify no more than %d metrics at at time",
+		p_err("too many (%d) metrics, please specify no more than %d metrics at a time",
 		      selected_cnt, MAX_NUM_PROFILE_METRICS);
 		return -1;
 	}
-- 
2.44.0


