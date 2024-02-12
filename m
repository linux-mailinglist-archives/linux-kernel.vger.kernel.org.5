Return-Path: <linux-kernel+bounces-61084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C890850D0C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 04:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F45F285341
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 03:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF655235;
	Mon, 12 Feb 2024 03:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kl72AWwe"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC7D2F5B;
	Mon, 12 Feb 2024 03:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707709229; cv=none; b=mD/l+hANrJmf0Qxyp/PWCcWe5kh1zPL027bYbGSClLRKWY7os+me+mqxdbTrLQtZy/JJjFNr3pA9rZEpAqIX1ZU4y8VMOLNhzL4twu3hychKovd8hxlwCIqwD5muSFlVnee7P2Ycd7sl4QGF89zhstY1kzD0R8OaXGwq9jzcPjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707709229; c=relaxed/simple;
	bh=4tvg+kQRfVajNMUPBhzZ2Fso5DQSlRU9xLQVBU2OJUs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jQvQrYt9CEH7+ACd59A2ZzwBB+50MvF5aC6NoPihbyQpwPK65lsA8A0wTzI/JQ9+K5jUlQk3KZZoQfjmi37r5wv6RvAhvINIGcdiq+S3/JEA1FcjGPwrfXa3Ytpauqf1hiSfwGAt8WiyrizUf681qcdms7SqGjno5OM+XMlEUCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kl72AWwe; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59a45d8ec91so980190eaf.3;
        Sun, 11 Feb 2024 19:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707709227; x=1708314027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m4X5VSvPzK7InvxxfBHcWCSFZJstUqSBqMhbodVXTKs=;
        b=kl72AWwerg168XMCNKHUkq+p8StOdB3CyI3L+cuoYj9R3oeNoCbfSJQ+NF47SEP+mm
         kRLCzxht9qdA37UM0rjMAdwvcTj0F2TPleq6kBIw0O5zc4Lr02zQIjOkTlS/Ad5WwQW6
         pbfN/0msuz5FOx8WGOeFJLvHiz6lrl2X42QkcQmlN0J/3sqzuwP438FOPcuVoQaCy/W4
         mbqt5F9pXZjGV5GlAb4LFkzNFqOHAW3oIjN93BP+uc/i1hUYfadbM8tLrFSjE0xh/IOc
         RpwHxGLVmiKrlC8c/dYX7EpdPQLnVbycbB5R8uY9rywmt4bMWZ32uG8GXy1FSVEFHnoK
         33gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707709227; x=1708314027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4X5VSvPzK7InvxxfBHcWCSFZJstUqSBqMhbodVXTKs=;
        b=llJnpZ+y5erQy3P/60pNtGbw8Nr4WhxaNFGcd4fttxfj+CZPpES9hbOVYLDQnNwOH6
         3hLoAtZB37vAbP4Vdp0eqyusoXinQ/0khA+dugnue9AbUWQHykeofMk8LY+2JaDzGCpe
         Py2lHOkZtA+jtjuCZrmBJPUu8+okgDLTun0zqAicC85el1jZe487X1+soxBRUBVzGYTE
         3nfqmp5YkQa60wwKuXTxhxN9ysFdKdX+Fu+npPq/W/7oATIocOU53p9RR/1oDnEw0Hty
         jaySjR1BJlID1ZGHflf/RmV9/vEX9dr4MAENTuHotKbF4LskvwFF/lDgLTbmQi2/wSru
         jAYw==
X-Gm-Message-State: AOJu0YzePQqgjY8wGTqUB+d35Gj6w328KVK1DdaKxXgJMOxoouS1sdYv
	fZ6GySFhO9RNntroT36t0mqSqWtQqX526zkjADVa+NSeZblkYa6A
X-Google-Smtp-Source: AGHT+IFH+mhYBMi/Ks/lsR9PhdJZw8QS3ZAoOOA9o2XK80M9/ZhnOtym6yff9HXWrlIF6b1TD8SG2w==
X-Received: by 2002:a05:6358:a09c:b0:176:a2d7:850 with SMTP id u28-20020a056358a09c00b00176a2d70850mr8272343rwn.16.1707709227057;
        Sun, 11 Feb 2024 19:40:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUTkFG/ZtI2dPIQZookFRyFPljdUD7FsZFzOvesXJFeGCU1ncjtIcdFG8QEZSxoG5ndrkP5+jfQW14PIGNw9rCwc6OO9Z+fvSKAb8T+YZ9vzM04eHDhl8AOY8mlmWaECGE+o+FXoQnLJsPm8R7WneSiManWVpletrN3u4X1zILJIWiW+NIrO4IcUW67UbyZWA1A
Received: from mari.. ([2804:431:cfd3:3f64:7da:1321:7c71:86bb])
        by smtp.gmail.com with ESMTPSA id x186-20020a6263c3000000b006e0521c2156sm4795105pfb.173.2024.02.11.19.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 19:40:26 -0800 (PST)
From: MarileneGarcia <marilene.agarcia@gmail.com>
To: ray.huang@amd.com,
	corbet@lwn.net
Cc: MarileneGarcia <marilene.agarcia@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] Documentation/admin-guide/pm/amd-pstate.rst: fix the warning: Title underline too short.
Date: Mon, 12 Feb 2024 00:40:15 -0300
Message-Id: <20240212034015.120697-1-marilene.agarcia@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was the following warning when the documentation was generated:

Documentation/admin-guide/pm/amd-pstate.rst:384: WARNING: Title underline too short.

``amd-pstate`` Preferred Core Switch
=================================

Signed-off-by: MarileneGarcia <marilene.agarcia@gmail.com>
---
Change:
Increasing title underline to solve the warning
Thank you.

 Documentation/admin-guide/pm/amd-pstate.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 0a3aa6b8ffd5..322488a0b2c9 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -381,7 +381,7 @@ driver receives a message with the highest performance change, it will
 update the core ranking and set the cpu's priority.
 
 ``amd-pstate`` Preferred Core Switch
-=================================
+====================================
 Kernel Parameters
 -----------------
 
-- 
2.34.1


