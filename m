Return-Path: <linux-kernel+bounces-91934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F68E8718C3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 889F2B21C62
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053DB5102B;
	Tue,  5 Mar 2024 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="SLCP2Bjn"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5754F207
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629180; cv=none; b=qRkEBuWf51W/JqehQcZGL7f6pxVgDI8UazpGK6zCZFLI0At/mp4EmqBNi4Zlc4tatLSRvw7dLfUa5xlgckv1wVZioh9kV7hvL3WVrimQpcuzVlxY/duxZc0aQN/gHgjtjgRh7ZwWTJVziE1cazG9KQS4v5aEMmonE6jwhfXoZxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629180; c=relaxed/simple;
	bh=7E++P3NE3gX/uG8sJhez163L//hFb7dWE0h0h4Q6OTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKu63YiHQVPd1ibxohLzkFr8/1zFK2GJa1STRY6vAeupLLV1+cG4aSjFiefJZKbhIr3rl8Q7SOszdGZCanr78687YnOYMQ1S+7e3YuycBMH6ZhnkyYCEHa4Juphe7tIwQKPvzq5l90o6ZIurKG3VzaFqQzH1Oqrc0u3nGpgbZ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=SLCP2Bjn; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56682b85220so8616609a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 00:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1709629176; x=1710233976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BL1pmIo7s1MX4N9LU8kIbt0i/wU5mZK2rTJkOzRk4Zc=;
        b=SLCP2BjnXaa8DJ38mRocxropkJdKQfdE9Ktvtb0Dn5121g0FyWHpAjOzWlNAIRYuBg
         aGbLSQkC64poFN7Y6iTbeBbycp+E4iuUHlgA40r1Cqow2ek2mbyZ0YBdp2D0IJ9LC5iq
         WesVplUqjSccjpid1rKyMkhZpAUKH+tIuRJBB9H7Q7NM/I8sJhrGr4y8k0kICDx8GNHO
         KDbhQfbDICrAfdBX/SS3FXPh82T0QFeBNdrXcB64Fu4buSAUovmREBZqGiMN7gZtfrR8
         xWZKTc9xklJPMnfITQePUeeRQerh5N+RPIy1vaNG0p5gZCfEcHFIlngVjn3p6KhzQHKm
         rsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709629176; x=1710233976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BL1pmIo7s1MX4N9LU8kIbt0i/wU5mZK2rTJkOzRk4Zc=;
        b=XVpsK0EmM49oYwIaJNxpgIbvw2y2sHYa289oDcpNtSK7W7Ynzp0opCox+9txEwJ6no
         L9mSDXuCor+tVDnBMsZp1g1xQIXTCYuUFJOVAnsETOVrwe7hAgAVMMQW3e2spO805GZG
         lOymK6934AWUDz2lT/8tBUa07lzb2YfOsllAUIy/+sHP4aDFGh50U9Lqav/arznFFiw9
         LodrozE0zJ9DduSU0pla11B4JXWMF3Lk58nM3dMWIS3q51VoPwXlLSxhBK9I0e0Wqqj8
         3gHhop+Ua3vJYMRGIPbgHhkV+zvYtiHCxl54E/qWOz7n3BpRz1AYBjJf91ETk5kXxmak
         5YDg==
X-Forwarded-Encrypted: i=1; AJvYcCW5gktTFXRsgp6knvKBL4qdUBKg4X36NifKVlSOWTkaOO0VNu15lz6ErL9FWkzLMzHbbRzk1K9inhqypi0eKpFK+OHf6No0gE1g4J6D
X-Gm-Message-State: AOJu0YwgGNq3ko3eqyzZprPFSZdZVhiQ4VHLgqAx4PlRfygTPPHO9RWY
	31Q7AdHnAbV2BZSeDRV86IqKn1S4WpA9c/mUgxkuxiTe0x19pEcLowVt1rfKopQ=
X-Google-Smtp-Source: AGHT+IFECPH+najh1MX5zMcxH632u551jNgiqYN/FKRfvXxmD0N9/VMCEcGbJDINMY/jajNmROur7w==
X-Received: by 2002:a17:906:7809:b0:a3f:29c:c8fa with SMTP id u9-20020a170906780900b00a3f029cc8famr7642550ejm.66.1709629176544;
        Tue, 05 Mar 2024 00:59:36 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id gs4-20020a170906f18400b00a449d12cdc5sm4453005ejb.119.2024.03.05.00.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:59:35 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 02/14] include/drm/drm_gem.h: add poll_table_struct forward declaration
Date: Tue,  5 Mar 2024 09:59:07 +0100
Message-Id: <20240305085919.1601395-3-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305085919.1601395-1-max.kellermann@ionos.com>
References: <20240305085919.1601395-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After eliminating includes of linux/mm.h, the following build failure
occurred:

 ./include/drm/drm_file.h:443:45: warning: ‘struct poll_table_struct’ declared inside parameter list will not be visible outside of this definition or declaration
   443 | __poll_t drm_poll(struct file *filp, struct poll_table_struct *wait);
       |                                             ^~~~~~~~~~~~~~~~~
 In file included from drivers/gpu/drm/imagination/pvr_gem.h:12,
                  from drivers/gpu/drm/imagination/pvr_fw.h:9:
 ./include/drm/drm_gem.h:447:27: error: initialization of ‘__poll_t (*)(struct file *, struct poll_table_struct *)’ {aka ‘unsigned int (*)(struct file *, struct poll_table_struct *)’} from incompatible pointer type ‘__poll_t (*)(struct file *, struct poll_table_struct *)’ {aka ‘unsigned int (*)(struct file *, struct poll_table_struct *)’} [-Werror=incompatible-pointer-types]
   447 |         .poll           = drm_poll,\
       |                           ^~~~~~~~

The compiler is confused, and that can be fixed easily by
forward-declaring the struct expicitly.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/drm/drm_file.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index ab230d3af138..f24ade9f766f 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -44,6 +44,7 @@ struct drm_device;
 struct drm_printer;
 struct device;
 struct file;
+struct poll_table_struct;
 
 /*
  * FIXME: Not sure we want to have drm_minor here in the end, but to avoid
-- 
2.39.2


