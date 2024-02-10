Return-Path: <linux-kernel+bounces-60575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9B3850742
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8B52B21C2F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EDB5FEF7;
	Sat, 10 Feb 2024 23:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SxDJ+Uav"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46AF5FDD7
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707606921; cv=none; b=mQA/LdvAnr+x4I1ECPCUlVIupoGyEBXifzqgKkL8b+blQKs5Jdx501WtrAaWH7VVxETm1onwtmpMPudXJF+DVc/w3gOV2RjQj2NCPp/LhWtNU3Mi88qRBx5dZ7ud98X4g12EDBkTfemx2Psz7VcJLROmSZu7t/zlHKcoJ/xL6pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707606921; c=relaxed/simple;
	bh=/3YzkBLodMNUrjnwjELpDTo92n8iOXA1+uqd9b5AE1c=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=dw9iGBeblLBqeURhYeF+FjygXAEch3CZyWf7uzZnLjsmL4llRkOK3gxEcxB/lr08LZ5d1NjuTy4TZYP7Nbft38zwnZff8K6s4zk7J8uY6VQYhNxbhYd9Rtaq3ksJenSBbp3ZevoRIxL6gr6B3dLCKw8+JEbArJ7KlzBGMTzheRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SxDJ+Uav; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b267bf11so2580777276.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707606919; x=1708211719; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X74cf6T8C4bXDHMgSvTgHCjENEzriqu7nAo5Mgz+MM4=;
        b=SxDJ+Uav1JT1xkr11P8EWEEH4aiXtqA/CIPkKFuknE8oeTqX2JHCgSUINDuODtOmpq
         pObCE5xGnFRkDYuBH9S0dR8GJtn58SBdpwz711//joxiINoHdiESNXrSXHHNQPmmPSGr
         noebh6eRIBWeXMnrPEIJCsjCYa/MewornumtwWDCwKZvuTacIdfkiYrs+GFLv/uxpTjM
         /sRHtp6Pv0BKDFoXrWNVgASVNLj5AA53fwHqWqSSjb2J5v7vwjO6Cn2swRXggb5tuaFt
         J7yxGEWnqt0IBWXbzpnP4uG0J9DZ0Yi1mzweIxc6PXf2Y1RUcfwXFymIyTyG4oqiRxuA
         MDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707606919; x=1708211719;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X74cf6T8C4bXDHMgSvTgHCjENEzriqu7nAo5Mgz+MM4=;
        b=b5NTK1lXE/Q4KAPi/KHS7wBGiUuqhuwZx/nDwniXnO0wLvbvpBg9d3jW31r8R3JtIn
         ttYLme2xERZ5coGhJAxKWWZmH8vT/OjwgSI5LCXaR547zeI41mLLPRNQphmbrfq2NGhS
         ZSrjf8nVyC8VxR/Dsi65GGuF0bacIpWx/h5iLyo/syVmbb87DmmzThxt4RWeBuTULRNs
         UqSX1VZ3s5eHOPlFgnCXF6wVHWc4VfSLBR3AsRKiqi1AFCtxyfkDd+gZEna9qEFqB8tJ
         136RJO8v9DIymIlRPWAwJCx+0kfeIcD3FLqvMHcS3IenwLkHpepfAUe5UXxPS7LxH8XV
         0jRQ==
X-Gm-Message-State: AOJu0YwDDjL+vT6JOhNMh5G4OH8qGBmEdY0YUJElCBv5HC4p/m9/Rg47
	766jalRyZjEHkYW3NTH59aPlKvg3j6pcB1FNPrDCqckGjYfhGbbrJRkQVTD5cORUNDWXerRYUSf
	e0f8HKNsk2jhNaA==
X-Google-Smtp-Source: AGHT+IH2Adref4+yil6FrbE6d/7iC18rjqbq852WHMSpdwSZBvXZFSyEt1R4atXsHCbl3PmMo9FKTKBDAQtPReQ=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:80ad:1a11:8cc3:735])
 (user=saravanak job=sendgmr) by 2002:a05:6902:2213:b0:dc6:ebd4:cca2 with SMTP
 id dm19-20020a056902221300b00dc6ebd4cca2mr118406ybb.11.1707606918832; Sat, 10
 Feb 2024 15:15:18 -0800 (PST)
Date: Sat, 10 Feb 2024 15:15:12 -0800
Message-Id: <20240210231513.111117-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH] MAINTAINERS: of: Add Saravana Kannan
From: Saravana Kannan <saravanak@google.com>
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Adding myself as a second maintainer for Open Firmware and Device Tree
to help Rob out with reviews and other maintainer work.

Cc: devicetree@vger.kernel.org
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
Discussed this with Rob.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b01f890ec789..45c6c13b4edf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16359,6 +16359,7 @@ F:	drivers/infiniband/ulp/opa_vnic
 
 OPEN FIRMWARE AND FLATTENED DEVICE TREE
 M:	Rob Herring <robh@kernel.org>
+M:	Saravana Kannan <saravanak@google.com>
 L:	devicetree@vger.kernel.org
 S:	Maintained
 W:	http://www.devicetree.org/
-- 
2.43.0.687.g38aa6559b0-goog


