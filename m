Return-Path: <linux-kernel+bounces-39647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A6683D443
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 07:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53FD81C22D9C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 06:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C4F1429A;
	Fri, 26 Jan 2024 06:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="miEr/8f2"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3AEC13C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 06:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706249521; cv=none; b=dU5Jj7NCjTNN180Mxc6ACdyHxNOWuKszsqHH0V2LbFHq0KWOoZTSxlidcuvG+2JTVgmfhxu7NhU/1ZYwBxX+W7GmTqiz6OL+YayNTJi06TR/9LDMoR0ZJTAxGJfU9G6fQsD/iwA6Cn9xoM09+BK77NjtvK2LYFSYsoWJnLcEPQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706249521; c=relaxed/simple;
	bh=7UZnrODZ/MY++iMvwo41MGHM2nNlZwIfqePHWJK1BZc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iWELx6FzDgEQss8CxpmR/c5eFE79G0lPtMv1nlek8TZgTqVpWvr6Vx6QHNgwHKtc1qb5me4Nl1cVJFBuzJjDGDO6tt/kLKGHlbt73DOa65HqSQJy/J2OFhVyEfk9xbDIVbY42LDmFRhbIHxS9S9uHd9KssD4IBlW8QoVufaOA9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vamshigajjela.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=miEr/8f2; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vamshigajjela.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6029c85922dso1002017b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 22:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706249519; x=1706854319; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZKVNWMZBR2eYWT59dTj/uyfqypo9Ohb4eJLIAFi1GR8=;
        b=miEr/8f2cGy2fP/QWzj89Uh134Z2dWFVsvKQiqF8v5RKrmIyuRac1YvJq3AcaTNYOn
         HCfA2lVlA/+QgiWoCh3KPg6apTHWdyLWFi4IPl/EIK+V6EmnPZXLQzq2HfAAFzbM8NNM
         2rwhj4CJFyfLvsSx3xykmyfnnLG/ooUmIP3SVvRffRz9Ilhv5y4lSN5KNhkfDYQKwe0/
         7CsgbLjLg7EWT4aAEm7u6ns3ydqOzmwdDs6Wuq270drNos/McjitV2pEyjlVJpScUU+K
         ulOHOnbQ4c4xaqip8YpfPg90ZdmxjEQx23o7TJzpZezvJ3uOjLzKSlz4At3A7mb6ly8T
         rvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706249519; x=1706854319;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZKVNWMZBR2eYWT59dTj/uyfqypo9Ohb4eJLIAFi1GR8=;
        b=CRoOmosi+nTS7N8v/7TKSb81jWwdOxTraVf6vUiX1BQ//NN74H2nrSsIEDIx2XFUhw
         RnL01/c1S8UL3rF7+sHN2WsxqGGO3RwOrEdKJMDhQqxCN3hIgeSWuh7Q5q6y89DQh3dx
         EwEMYeTIw95vxeoENhRZ22onYEjN7pQY1q7nAmnu45RGfaeBBT0GNf+xkts79SJwgwB4
         61oDt2JggCMuR80Mw6B1Vo+48YbwEbECB7zoPNk6BCsWBkghVY8+g4DrCjGJDjsw75B2
         rQjKA87zhsrBx6sMM7C2hRbS4jwK3qrCHAbcCOzegFJPHlAjTHRYFrnVmuNV1un10efV
         +gow==
X-Gm-Message-State: AOJu0YwenQq38ko6x3sDaEnmEvZE+rTNNufX8mPk9T/ndQsq/qVfBFkJ
	aK+7jpcMyrhxjbqIhEq42iTt/2ysgemzlWbZxs/MafYEG5WdJcCNSlQk3NWZmUBOFeNmXwxRgab
	/rMOmUuVFGvVGYNkGrmpmsEEjjjwj4w==
X-Google-Smtp-Source: AGHT+IH82jPh3xY3v78gOnMPT1V1lhKcVdBHqduQKdsqG7nWYVumN5IGbWTSDlztvr4d3XTi9EEIsJDhzaJCZH2V6MGF
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a05:690c:fc2:b0:5ff:9315:7579 with
 SMTP id dg2-20020a05690c0fc200b005ff93157579mr478886ywb.6.1706249519070; Thu,
 25 Jan 2024 22:11:59 -0800 (PST)
Date: Fri, 26 Jan 2024 11:41:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240126061153.2883199-1-vamshigajjela@google.com>
Subject: [PATCH v1 RESEND] spmi: hisi-spmi-controller: Fix kernel panic on rmmod
From: Vamshi Gajjela <vamshigajjela@google.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Johan Hovold <johan+linaro@kernel.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, linux-kernel@vger.kernel.org, 
	manugautam@google.com, Vamshi Gajjela <vamshigajjela@google.com>
Content-Type: text/plain; charset="UTF-8"

Ensure consistency in spmi_controller pointers between
spmi_controller_remove/put and driver spmi_del_controller functions.
The former requires a pointer to struct spmi_controller, while the
latter passes a pointer of struct spmi_controller_dev, leading to a
"Null pointer exception".

'nr' member of struct spmi_controller, which serves as an identifier
for the controller/bus. This value is assigned a dynamic ID in
spmi_controller_alloc, and overriding it from the driver results in an
ida_free error "ida_free called for id=xx which is not allocated".

Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
---
 drivers/spmi/hisi-spmi-controller.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spmi/hisi-spmi-controller.c b/drivers/spmi/hisi-spmi-controller.c
index 9cbd473487cb..af51ffe24072 100644
--- a/drivers/spmi/hisi-spmi-controller.c
+++ b/drivers/spmi/hisi-spmi-controller.c
@@ -303,7 +303,6 @@ static int spmi_controller_probe(struct platform_device *pdev)
 
 	spin_lock_init(&spmi_controller->lock);
 
-	ctrl->nr = spmi_controller->channel;
 	ctrl->dev.parent = pdev->dev.parent;
 	ctrl->dev.of_node = of_node_get(pdev->dev.of_node);
 
@@ -326,7 +325,8 @@ static int spmi_controller_probe(struct platform_device *pdev)
 
 static void spmi_del_controller(struct platform_device *pdev)
 {
-	struct spmi_controller *ctrl = platform_get_drvdata(pdev);
+	struct spmi_controller_dev *spmi_controller = platform_get_drvdata(pdev);
+	struct spmi_controller *ctrl = spmi_controller->controller;
 
 	spmi_controller_remove(ctrl);
 	spmi_controller_put(ctrl);
-- 
2.43.0.472.g3155946c3a-goog


