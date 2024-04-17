Return-Path: <linux-kernel+bounces-148296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B208A807D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2AF61F21E84
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7B613B29B;
	Wed, 17 Apr 2024 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWC1jbih"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD7413B280
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 10:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713348889; cv=none; b=m5Rcoz4AFmPMp72pCWomSFHS6/NnDtYxGhpg14xFk7VgnGdNOfVJGIQ3/b8IT4FPvpPiJ5DzwXRYsiWAUOBQX0GrrLO6jtSs0+BIvcXUEDeThJiRtL4Q+0/bUA4/lB7vBSkJ1aIFjfx3T2QpGm6C+q1N7P556cw0cYXi1mh+B6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713348889; c=relaxed/simple;
	bh=Nsjf4W046CIAEyOcmt/MlZoEUduqPetqmPDoVbBknjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IsYDyFm3kiqlOF4gcERwPp1mWmVgGpkx8V4rAU6giw5umtbLLY39ZSi80Bx2VbVPBavixwaPcYRjSm4FO+6deqLnuFxAUxA/q3gkfqhFI4tmkRQEnrrAv98+ts8PzO/sN78typ3Wvuu0oCFWW2dlQt90hAJl7xwJp/pqHEhwkb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VWC1jbih; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713348887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mfznY1Xt+1agp915j30/FccRLbon5LKlLd7NU6tQjbY=;
	b=VWC1jbihrlhykawVWWzGbX518hICl/ApFmJ8wEPiMoLVtISWkiuxpA/mfAAcCesWKYpW1R
	lNLjwpZCTGHWL2jfIZ7pXQKIlPrFPUiP99Ke85Ft1QnyyKDse99/WB52dbJxEoN3A0yIZO
	poSuG6mdm5Z0Ig9PLSfPiSHfYCHXFY8=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-hBF8pXRNMJyCMgE3R0h-yw-1; Wed, 17 Apr 2024 06:14:46 -0400
X-MC-Unique: hBF8pXRNMJyCMgE3R0h-yw-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3c613c1c51eso4878547b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 03:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713348885; x=1713953685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mfznY1Xt+1agp915j30/FccRLbon5LKlLd7NU6tQjbY=;
        b=eSv2ort3gAMCaG5OHS9fejhaMldv3/Itqb5eMxzPZ1r0PF0t9zVziT7c0IZ8r2uw66
         H4uV2PB+uiha0SxBIHugGnfQBOnaEImHiYwWu663jcwWzA3uqD3N9cRJ1YsSfClAFBSy
         lgSWGo4XV0ebAPxPyxi5KdGcOllKF9JpPxBOU24CuzZZywpGTvLo0i1Nu2qPfcVHl7hK
         qVcMUjBKZycw7ahkLlWCwcG9zvfMiwTng9fBMS2eDQL06S+gDacWB1QGwx0XYTj2d0K9
         61AJ/ARsN6vpYviUUWuOHAHH0MrA2ctgrqDUlwpnOq24ZFXfFKNLZjvqJoFQkhSF8FAC
         0zBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGfVx/TUEmHK7Nbx8tjj8blGp0OzhbDmaaLM2AZyFu9HEGGmMp2c/7h29u2pm1tIOqleFkfHsdHtzLwmLxp+AQvUPG+oZju3UHcZaH
X-Gm-Message-State: AOJu0YyRuce4zxcyJ0RgdBfoldAyFa4Yp/yaqnwUE2KnTjO+pcQ0bExR
	cVi6diUBvf53iU+3VcolLv3oSXG5hcxug5Y5pRGdgFIhWy9tMcyz6Snt3z52Mm9fcJ7OKp2XUF7
	1gEtGFve8WBP2CfwsRB/Q1Ft43wo3ApuXdjbNW2E8rX6k1Fm7T/DOZ2VcQg9d9zENs9x41Q==
X-Received: by 2002:a05:6808:6243:b0:3c7:13fd:d878 with SMTP id dt3-20020a056808624300b003c713fdd878mr7873799oib.9.1713348885191;
        Wed, 17 Apr 2024 03:14:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDz0OAbOJqHdNWrsnzh2Aggk3FP1TUtJ619gQjpyPq9dPplYtFuLf0MpY36myUuCQuf7T1/g==
X-Received: by 2002:a05:6808:6243:b0:3c7:13fd:d878 with SMTP id dt3-20020a056808624300b003c713fdd878mr7873788oib.9.1713348884914;
        Wed, 17 Apr 2024 03:14:44 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id js7-20020a05622a808700b0043781985244sm71939qtb.59.2024.04.17.03.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 03:14:44 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: repair file entry in DOCUMENTATION
Date: Wed, 17 Apr 2024 12:14:29 +0200
Message-ID: <20240417101429.240495-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 1e596d5eff3d ("docs: Detect variable fonts and suggest denylisting
them") adds the new script check-variable-fonts.sh and intends to refer to
it in the DOCUMENTATION section in MAINTAINERS. However, the file entry
refers to scripts/check-variable-font.sh. Note the missing "s".

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair this new file entry in the DOCUMENTATION section.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4356b28ce625..250c8f8caa08 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6493,7 +6493,7 @@ S:	Maintained
 P:	Documentation/doc-guide/maintainer-profile.rst
 T:	git git://git.lwn.net/linux.git docs-next
 F:	Documentation/
-F:	scripts/check-variable-font.sh
+F:	scripts/check-variable-fonts.sh
 F:	scripts/documentation-file-ref-check
 F:	scripts/kernel-doc
 F:	scripts/sphinx-pre-install
-- 
2.44.0


