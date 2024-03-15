Return-Path: <linux-kernel+bounces-104415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B631B87CD77
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84D21C21FF4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A11F250EB;
	Fri, 15 Mar 2024 12:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Vx1gDAXR"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDFD24A13;
	Fri, 15 Mar 2024 12:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710507266; cv=none; b=E27Z2h+f+OHcjjou4fAAFaycPzhBGB1FahTGibdy8ZPIO6pnK1kRjvcaj7vOCLV0uz7NkQxHtOctxFF/+U6A5zBngmXskcoazjJuB92YTuXGCzRATbzUp1dsV1cdiAoLrXO6j79qm9xTeQtVDZ5+6/yTHNR9tyBbCbex+//732Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710507266; c=relaxed/simple;
	bh=FnevSE25K+MKKrigHJPozDtqVSkqIjWmYikPIzkANFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RUWyafnTt5SlS6FpReQPvFYr/c8rOcuSKSm/RQVtL7bGZuIvidqsTGWC8xj9zdR9DwwmzEInxImsIUYZYFOPjlv1BGqAyDWDlvA43kEFYj1Uj/n1UBYLqCXw56cSA6yOIGyATlMYEWc4ZRKeKhJyNWuTt53P1mgyoZiE9U5+zdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Vx1gDAXR; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so577114966b.0;
        Fri, 15 Mar 2024 05:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710507263; x=1711112063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t6FSfZ+VsCTUq+zlGRu8P79wzSbxHSd+irhIrHIaxrM=;
        b=Vx1gDAXReZqsNcOghdOMUN0OJS8IHRRR8ATY/6p1HPV6DrhK51LjXB5WokF0EPXwYm
         LbnDjAFcURlajw4x3HjLZ0K7GnZPG1+CXUBgf3Yy9wuAaLqALUpximyJxRsRul5zAGr5
         j6wmEEchEum2SKky/g8uPIu5YGSf4IbwfOkUAVAvAegK3muiLBrhva42mQcU4IT8H/Yf
         44WpeEmdWSzxFnctNd55dkWQUzRtIbJEtehu8wmzvtJ97jw2JgcvnEwP6hYmL4ER9Nu6
         CwR9hXpZNa1Z8vMphPZPTfksFmFokZYp+MbLwc81VuGh4aYxJvItD6mZuNhp7vCVpw1j
         K+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710507263; x=1711112063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t6FSfZ+VsCTUq+zlGRu8P79wzSbxHSd+irhIrHIaxrM=;
        b=UyDBAeNBGMOuEdYLQ4QUSRTpE+wB61Nups/S1kd9n8jEaXCXY+lrQU3OlZJSSvSXS/
         zPgn8whmcJG+ecoP2CM2f121rimOhocCxSy1sl63nVxrZP9CEXjVfBkfINwByYd57zBs
         gsQYEweHyi6xwALQgwcjiTcBjgX2wzwumoNr67X6Y1slIhJlhlZIzk7lTr3W5hpodDgU
         0efbIGINBNh4rD8w1BbHirkUR9Vo3akgMDq9giGaD/+B5yajODRiA92rTXThOsfkYh09
         00CAeJi+4vC92WKaFzbDi6dXt20/XPmYc25AcDbu2G046M7MadVPkTOdWyyXfnvzS6Xu
         pJzg==
X-Forwarded-Encrypted: i=1; AJvYcCUym4N5bHfQR17xQz0PIWpf709asDN+2ag/VISZjvqLrAv/7c6IhoFV1FKglrhqRDeyvJkNkDfN9w+AonQ5nEZox07sh74f1xvOYNbv
X-Gm-Message-State: AOJu0Yz0MIAfMMiWmP0UZd2lLELDa/a13hrQaORnQgmZ/ijIRTaG68NQ
	v948uoQRPWLWYtn4TyTAHCGxjihChcQcWiMjHDmUQclsRtTzvw+vBPZ74UgwdqdVxA==
X-Google-Smtp-Source: AGHT+IHLRROaqTtOPnbqNrdD84gNMSEFoBbFw3BbdR7qHeWh0+DXv+nUg6CQdXnF0OOXKqTcLD6rtw==
X-Received: by 2002:a17:906:4fcb:b0:a44:b96:2809 with SMTP id i11-20020a1709064fcb00b00a440b962809mr9735163ejw.24.1710507263026;
        Fri, 15 Mar 2024 05:54:23 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-095-119-217-226.95.119.pool.telefonica.de. [95.119.217.226])
        by smtp.gmail.com with ESMTPSA id r13-20020a170906364d00b00a465f8259c3sm1672917ejb.125.2024.03.15.05.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 05:54:22 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: linux-security-module@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Kees Cook <keescook@chromium.org>,
	apparmor@lists.ubuntu.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] apparmor: fix typo in kernel doc
Date: Fri, 15 Mar 2024 13:54:09 +0100
Message-ID: <20240315125418.273104-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix the typo in the function documentation to please kernel doc
warnings.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/apparmor/lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index cef8c466af80..d0485fb0ed63 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1124,7 +1124,7 @@ static int apparmor_socket_create(int family, int type, int protocol, int kern)
  * @sock: socket that is being setup
  * @family: family of socket being created
  * @type: type of the socket
- * @ptotocol: protocol of the socket
+ * @protocol: protocol of the socket
  * @kern: socket is a special kernel socket
  *
  * Note:
-- 
2.43.0


