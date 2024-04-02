Return-Path: <linux-kernel+bounces-128075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE00B8955B2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB701F22135
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233CE8625A;
	Tue,  2 Apr 2024 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+Frg/IV"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B4D80BFE;
	Tue,  2 Apr 2024 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712065456; cv=none; b=AojUp0HP95vRKq8LQB9A/Oia7b0I4kk3uFYxaWhz4CjY+mFbaoz9QygjZm7zPsyZqHiLefXcqi9TEAbk7O09AnWdQZG3eh4W115HOjW6XYYR7onqAc1qjkzNq/5Lhp+LTRtxSAdV4tj6RMGoM5sSG7PQ3yr+msQDU7nGoC20ppw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712065456; c=relaxed/simple;
	bh=fX4wdNLj4mpJXnKy6OYwufs3fuHwSvr3osAkiv/d/rw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yr8ant2V9zyeEZPSe3F7Up6VSYzQz0Z4des2hf+67DKTJlLmDiK5U9L7qJHVQB13ttxz11N2icf8gTuGOsK9ppAKgy/gAoZDrDTn9nJdz41ArAG7MrGCi3eIY+WWw1eJ8hTXA3eC/2YOEjAhWX/KZf/LZnPDyzPx9baZJcYgOb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+Frg/IV; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56c583f5381so6880387a12.1;
        Tue, 02 Apr 2024 06:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712065453; x=1712670253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h8hhkZTFbU/vuzsYhmShVWNS4yGIt56q5tjAp6Vay20=;
        b=P+Frg/IVXg7zGK6l+IfhBCRwKX9D/ZFduPX/wcdu7qeRYgrKAxr0mHu/4GXMfWMRVa
         RZrBS2iq8rne/DIui0NQQfhea1TbNem0M3C5bJOy91Xqy1iPJV8PxoQpFmWzn9qUkGRO
         1gCAPqnmMJTKancMzRg2izyRP/3EsFdJlujnzKi46VwlSpNWDTUkY8739PNxB8kqvTrC
         VuWpkzrvpY+I1VvrwGnyNtq0Ld96A1Mx8HzNCPBAFJyR7VCsGgheW50UaRkhFZjQ6zNj
         h5If2aE5BACDI80E8iq9sNRIc872610zgl1Y1NnyNi3rvPJKvnLajVV2qKtB9x85lJ8p
         3xuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712065453; x=1712670253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h8hhkZTFbU/vuzsYhmShVWNS4yGIt56q5tjAp6Vay20=;
        b=NvpBkf+u9BuLNHjNDpwRTOlhWzntzotkeGWOdoKcIXbOfctT/4HWjhmYXheMGEk36T
         ZV7vjgkVENi2V6C4OTFjZ3lhKiKqPw2Vh9tumUuchkZ6oknB4coiwpnXSKcMVfkOK7ZS
         3cYRG1gDomXSU5K20M53HLNcs/S5gyKgST5jhecnUhSAb+dGwM7t7vNp2+g3WVjXLjvj
         LdiWZ04YHzRVJzYVJnybhJoZN6uSw8K9uovbXRYMDmaP/TmXlV7dRblfQnUqaJP2ggju
         qWVZ/DSzjpMKPuLwWqjIG5FvizsKy8T7VemSoMZhnlCBhDpvwQ/9ZekZwVCPQl56Nb2D
         /exA==
X-Forwarded-Encrypted: i=1; AJvYcCXePWJJN5Ha3EYcQ+BDly/dKs58o9AFBCALnhyw+aXcpPjt3WXry5uxmxA68Z4qQUZs6qqupOEehjjsaNqCEg5eeuXvd8drrGQEhsOZqvgI1CnIfkRa9uagk5NzZGZYL7ciCjUiKQP52Gg=
X-Gm-Message-State: AOJu0YyETpkB3cZHjhjTsRobFP2EuhvCe7wtIV3y/oP1qk1We0Ja9uwY
	1TTd92A4oIMz47w+OCj0AriwzuXldotSZhOa/PPMuehDnpgkSyya
X-Google-Smtp-Source: AGHT+IHbYAQ9hfvj++/l//lkX9k97qC+cvPqgA97/D4BDSsfP170cjxSJc20nAEgUjLrcC6M+pSGXw==
X-Received: by 2002:a05:6402:3590:b0:56b:ddcb:bb67 with SMTP id y16-20020a056402359000b0056bddcbbb67mr12994163edc.2.1712065452859;
        Tue, 02 Apr 2024 06:44:12 -0700 (PDT)
Received: from lola.. ([178.25.29.59])
        by smtp.gmail.com with ESMTPSA id g28-20020a056402321c00b0056c1c2b851esm6818177eda.0.2024.04.02.06.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 06:44:12 -0700 (PDT)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Radu Sabau <radu.sabau@analog.com>,
	linux-hwmon@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: repair file entry in ADP1050 HARDWARE MONITOR DRIVER
Date: Tue,  2 Apr 2024 15:42:03 +0200
Message-ID: <20240402134203.8297-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4e1008d8aae5 ("dt-bindings: hwmon: pmbus: adp1050: add bindings")
adds the ADP1050 HARDWARE MONITOR DRIVER section, but slips in a typo in
its file entry.

Fortunately, ./scripts/get_maintainer.pl --self-test=patterns complains
about this broken reference.

Remove the typo in ADP1050 HARDWARE MONITOR DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 13ac7ce270b3..272b238d5488 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -506,7 +506,7 @@ M:	Radu Sabau <radu.sabau@analog.com>
 L:	linux-hwmon@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
-F:	Dcumentation/devicetree/bindings/hwmon/pmbus/adi,adp1050.yaml
+F:	Documentation/devicetree/bindings/hwmon/pmbus/adi,adp1050.yaml
 
 ADP1653 FLASH CONTROLLER DRIVER
 M:	Sakari Ailus <sakari.ailus@iki.fi>
-- 
2.44.0


