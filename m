Return-Path: <linux-kernel+bounces-154681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6D18ADFB8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209E0281CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD99524A5;
	Tue, 23 Apr 2024 08:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ek8nh+OR"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FC93F9E8;
	Tue, 23 Apr 2024 08:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713860881; cv=none; b=ELO9Td+93UoJuFL1/ocUiXpe137vrC3g70SUM+IzF/jM7zre8Z2Uw/CEhjORB7hpFAdcwQd1yeE17obbWdrXha3Ocuz/uGXByHSOcu1qpDleZJ+U4Hb1eVXGaVR3MxT0LBS2kYmoc7LLslYNj7fv52z2xS8UvzFQHL+2iv/oARY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713860881; c=relaxed/simple;
	bh=4rgs+Q8tD+dHRzJTXxgmPYJ2leRoMwnoR8des6f8Y3E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rozTRni9ywgrfK/RTIH67zaBiBuVUBIjlcXSZP4pVWEMQmvS9grX4VJmhcQv9SzqZCwJcEJMPLwIUOrQTdQDRrxsiQOZ8vuV7orIZeikn+zOlRr3+eg6Z54qmzcg5W+OcnaB4jW/OKiPT5rZ8hmTkDOvEgfPMOACiD1C4uvjHJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ek8nh+OR; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a51a7d4466bso569372966b.2;
        Tue, 23 Apr 2024 01:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713860878; x=1714465678; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n1ow1jnUWA2uy4x+ujOJIYra489DoEXou+HGtbxx9DY=;
        b=Ek8nh+ORjB+eFUgGkeNsV+dK/LKnDl/wLUkZ8a//cBx2xnWvOx1VQHbgGR58RjOv+C
         n11zQ47aExU4mVqUyfEHmgmJpArPO8JMFnQxR0lMd0Y+NVJZMKVV+eYUNyy680UWWmBF
         QyjL278dVy54/YA0qL4UUc56m8eVk1Z+TMX0C2ene8umxTmcvQz/c+GzZxZImB8DhpkH
         TpSbQixSeNZ8d2ARH45VyPn5X+TYdo4stpbbABNN7WGoJSv1LgKwN8k7qVziOfh9l3tO
         nR4pWvN5Z03lsNok0PHrtgN7rW5NoVmK05zIXMD5IgwqJ3+/rSJA/m7T3oxzgUd+B7wd
         ckuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713860878; x=1714465678;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1ow1jnUWA2uy4x+ujOJIYra489DoEXou+HGtbxx9DY=;
        b=tW7uqh3aYat2nx9j+zZsAnHvdrVN3D93X6rXC1TXptrHtA9xpY8awbJ0T2HOVmQwDK
         foWicyTW1iLPxKX0zJ9I42PprMY8EoOGa7xpFYQmxanqapGwGIMbu4sFi3vDDHDhqynh
         LzioByYndDbx4Cy6BCMmULgELuAWEDx8QxRoY86nbXIHk469XASspUb3Z6ZiWjhWNXg3
         5nKE/pChetOilSaSdZGRxpwzJGmrVDEDQ2VjWbtTRziylL61fbBQpgsNPwPFN724E3DX
         Q1MI1xMwcdaJksEKK7uG1/+DbS/ilHkHQphImzApi3RdorTx/KgNwMWIa1LXCaW+OqmY
         9SUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMRovHSGGmtJ4sIemo0uJFoyYC50KsCO5b8JGi6HMoTSLg8d+OiQ7gSmtGQfjFFJ5G98YqAh6Nd2m3du4d7uR8/xnoGuzNY6Kl0H42
X-Gm-Message-State: AOJu0YwLKdnGD1gVRB3WwtvmE01X6HQhveGQq4ltAgJ2MxIa78Yn/WUk
	6Mhf13rRG3/k92vyz47mCCkzQ6HYE4JPcS+YBpvZvTlvgk8Y9Fj5
X-Google-Smtp-Source: AGHT+IGdXvZE85ygrZFhUrP7aObavKBO1ceClUkXfSC1BjEwFEregBeh8y6zm1Psp3IVsTRdHsfAuw==
X-Received: by 2002:a17:906:4718:b0:a58:7982:6282 with SMTP id y24-20020a170906471800b00a5879826282mr990508ejq.62.1713860878079;
        Tue, 23 Apr 2024 01:27:58 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id z13-20020a17090655cd00b00a4739efd7cesm6798786ejp.60.2024.04.23.01.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 01:27:56 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/2] cpufreq: dt/dt-platdev: eliminate uses of
 of_node_put()
Date: Tue, 23 Apr 2024 10:27:43 +0200
Message-Id: <20240423-of_node_put_cpufreq_dt-v1-0-19f51910276f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP9wJ2YC/x3MQQqAIBBA0avErBPMdGFXiZDQsWajphZBdPek5
 Vv8/0DBTFhg6h7IeFGhGBqGvgO7r2FDRq4ZBBeSSyFY9CZEhyad1dh0+oyHcZVpq0YlnUbtObQ
 4ZfR0/+N5ed8Pf8gwuGgAAAA=
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713860876; l=1045;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=4rgs+Q8tD+dHRzJTXxgmPYJ2leRoMwnoR8des6f8Y3E=;
 b=m9B63KnDmu0Phc7Ai4aQwdSEXublyZ92HpOKSUhIN2N0RdK7MbLybtUomXpTXEqF4f1C8LgDO
 VLCzBQdGCUTBEh6Zgw9AP3ov5mo9xLhxDJdQ/ZPPmir644SAjSbnM9f
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series removes uses of of_node_put() in dt and dt-platdev, which
can be replaced with the clenaup handler introduced with
54da6a092431 ("locking: Introduce __cleanup() based infrastructure").

This change provides a scope-based cleanup mechanism to avoid potential
memory leaks that can appear if of_node_put() is not used correctly.

The series is based on linux-next (next-20240422) and has been validated
with a Rockchip RK3568 that makes use of these drivers.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (2):
      cpufreq: dt: eliminate uses of of_node_put()
      cpufreq: dt-platdev: eliminate uses of of_node_put()

 drivers/cpufreq/cpufreq-dt-platdev.c |  7 ++-----
 drivers/cpufreq/cpufreq-dt.c         | 21 ++++++---------------
 2 files changed, 8 insertions(+), 20 deletions(-)
---
base-commit: f529a6d274b3b8c75899e949649d231298f30a32
change-id: 20240422-of_node_put_cpufreq_dt-9c5354d9e9f0

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


