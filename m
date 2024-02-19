Return-Path: <linux-kernel+bounces-71197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 871CD85A1E1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95C11C22EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D112C1B4;
	Mon, 19 Feb 2024 11:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaQnJTr5"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87E42C19E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341795; cv=none; b=Z6vTYmO7iplz4cb3lMGlVeuW40vWq1scob2TFQnjqdGSbyWRQ0AAFTKAMb1iy/6U0CzHwckUz5q4u1nzTL8cSMhoyr3o2m710aqt0TTA6NyJyKouYc3krxS5O9jP/aB+uLC7heHvfVZnbgfimStmoqiltDwZPtps3a7K0ZytKms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341795; c=relaxed/simple;
	bh=OhSMZSbqG2+dG7tJMeWV0mIyqHyqbRp3b14eCVIHPp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MBHG8sAXelyUEWDi5AjEQ7jpMccO9yFaJ4GBy6FBWRDtqWDrAkKmraN1qNAPdri+nXCoLh2AFXSlCyou2xW5lu/jTyr028yRg0JCSME8h3nJiB0gVkgnbyz0Ip5bxs3/8pyLSy98lpnbAT6KplOZ/k/03HBDoZQD+VeWLwDgQ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaQnJTr5; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5649c25369aso659355a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708341792; x=1708946592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxy8D8aTsjXwHxlAaH9IbSuI4bH2UUXck9m7FNE/P/w=;
        b=YaQnJTr5CSJJGFnF7sXqEOzKbtMoUh6+0mhBAKoPM9yI1WEW7vhfSg+uTPocsBrfKl
         s1a4uS3Z/+7vAZETV6Cg/vxUwR1FVHd4GvFWWJfx0mh71Rs4PPypP56AkVo1Q7lUigvA
         oOn/FOCHLItTnSygzRA8Ha7WRv2FpkqHXC9oVI3m11GLu0LOMR/Be2xbq6pV0yKBynTS
         AIUx0b7HTowroKEJYd5GlIp70kdpHRUviPgKRjTCtQGnR7YCi25AEI/9ZQGjbyTyyLS5
         JWRERzfYJWlNG5pnLJo1N+YJOh6mI6S7nrM27T73sc9GflZEJHsSFPV8r8/Qx2gBqBYb
         GyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708341792; x=1708946592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxy8D8aTsjXwHxlAaH9IbSuI4bH2UUXck9m7FNE/P/w=;
        b=c70gkuMKT1jZq/FzfAJRVATx+aQ3i08YIIu7eP3WeUIG5gMiUGBSN3cAK5Ewo7dHrW
         iesC4Wq9cIr58gfcxV8kUSg53AtUuaIKZlTPgWlxgIDzoXspnY1PI+NS0opiSqBDMtuR
         vjsawxdkl6LkfrNsiyLhW1Ur7EdNEDly5lRlIak7Foo4LY1neH+bzvO4QQ6oz/S/GA2E
         o8AGMGCZs//fjjxBsOEE3AemwKzJuGcoxgJrTjwUzMBElMMoFXlZJZ+Y/AfjQ40DHjDp
         Aa4mXlLtkGQl0cP0u5GPkBpur8U/hwpInqwzofusaJZoKpntzAvKCQ++MyHvAB0f5NPw
         t/+A==
X-Forwarded-Encrypted: i=1; AJvYcCXkiECuTpyyh93FoFMYBfItPHiwLyy/HdEEUPAXr86jIvbD+a7r3eVdZC2dcoI14oCgrLP94JUPfCTBpVbfqi7iswBHHD4EwjJGY49o
X-Gm-Message-State: AOJu0YwpVD/9LMH5mON9UmYl0VyjVOQamam3qYZodDJsZUp6UV+1yhV6
	wX+BMmueZBxSyCpOczquAZfeku/TUB29nSaXkITtV2JqXbtP6Vi/
X-Google-Smtp-Source: AGHT+IFrLVkQX4NonWzI1LnBhJ46XoGwDP0asxttWvhtZt3Sb+YSrDJSw9AE6SEm24esO76lWNkESg==
X-Received: by 2002:a17:906:f206:b0:a3e:39f7:52b4 with SMTP id gt6-20020a170906f20600b00a3e39f752b4mr3464574ejb.49.1708341791821;
        Mon, 19 Feb 2024 03:23:11 -0800 (PST)
Received: from pinguine.lan (ip-176-198-146-182.um43.pools.vodafone-ip.de. [176.198.146.182])
        by smtp.gmail.com with ESMTPSA id ti12-20020a170907c20c00b00a3d581658bfsm2826495ejc.24.2024.02.19.03.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 03:23:11 -0800 (PST)
From: "Moritz C. Weber" <mo.c.weber@gmail.com>
To: florian.fainelli@broadcom.com
Cc: linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Moritz C. Weber" <mo.c.weber@gmail.com>
Subject: [PATCH v3 0/2] Staging: vc04_services: bcm2835-camera: Fix code style checks
Date: Mon, 19 Feb 2024 12:22:32 +0100
Message-Id: <20240219112234.8673-1-mo.c.weber@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <236d985c-1835-410f-b0b5-cacbd5fbf930@moroto.mountain>
References: <236d985c-1835-410f-b0b5-cacbd5fbf930@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resubmit these patches to address comments to rebase the 8 v2 changes into
2 patches topicwise
Fix patches with same subject issue based on v2, which fixes multiple code
style checks for better readability, consistency, and fixes typos from v1

Moritz C. Weber (2):
  Staging: vc04_services: bcm2835-camera: fix blank line style check
  Staging: vc04_services: bcm2835-camera: fix brace code style check

 .../bcm2835-camera/bcm2835-camera.c           | 61 +++++++++----------
 1 file changed, 28 insertions(+), 33 deletions(-)

-- 
2.30.2


