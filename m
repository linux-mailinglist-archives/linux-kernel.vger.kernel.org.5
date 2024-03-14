Return-Path: <linux-kernel+bounces-103925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A057B87C69E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40C661F216AD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345E312E5D;
	Thu, 14 Mar 2024 23:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QbKckNPn"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267B41079D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 23:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710460560; cv=none; b=WPnFUqqy9LiqceGlfnydJ6R3ZRCy+isTmUCkzDJwayHWV6BQbuZSGU3SeGKKBfgb8BGXnANy1Q2sf8eNAZEt7MNMzDdS6LzBs2pbwYBv3g/GYIL/8gWUGVzhcjd2X82u4g4myzRDS/NSkqcp6dmu4TZSnAOM5SnFiluG0Ny7Wnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710460560; c=relaxed/simple;
	bh=LjdE53DAeCK/DV4IGBzwE6QKkJ7zjfXL42DBeebkQMg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bQdJABoNal0pTtr6eURD66Y3Je2wMCFyXOO3TYFSotci15DEdes6gS2I8NG+EYrdE5gzIsB/Sbtq7SDu0cssS5SRZSPocekyQoHtXfz/yJX6x8zm/0kH+hcBnEUqKU75J0yT1lPO5giJA2wYrYaU2laTZ0OzHEHege+myoldcCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QbKckNPn; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a61b31993so27032957b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710460558; x=1711065358; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x+U5NBs6WRZY8QHIXBoAKLIZmwg0dfigkJKpGoGlj90=;
        b=QbKckNPncs5Bds0MZI0HXsStr3IYzeYe20eyGQQ1NHhNNTWz9N0J78kQ+B7WiCFcFt
         qbRXmJqO4NU2XiV+pQiJ1ClIJfqBMvt9Q9d3rdWRR5ZQ5Vsvr7uOII8pCOL4KPTkkU4d
         Xp3T+9u/o4XNN16g5AY4s8Wew0Vq3Z9RGHmeYedWWAjZairN/SKosl2xPLC/2i6BxysP
         Eg0BwE6ZKcj4SKyab41UgKqV32wMq3gP3AMYo8z1eo0xlHqavLjVjKsgFIp+C7QC6eyr
         4zRrJH9WS/u3tZHvzIsnnd7T3EjkLIEdCaTOvhYX3uAaNC+buCg82eZruRA+Bw+YTyoB
         +o5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710460558; x=1711065358;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x+U5NBs6WRZY8QHIXBoAKLIZmwg0dfigkJKpGoGlj90=;
        b=aT5ogH++r0shHM70Nq1IcSukCUDvWQwZg6fcu+4KNPGHacLd95FN7OP0P7+apiAl71
         B/EbYiAGDm3VtGiEcYf6yrKE0Pj7kN/SaDn4FFEM4tQLi2wC5FzhlT8HheKliUa5YLNN
         YBE5IEivd9z6IGTC3AlqxrLDyeUiMTKTqy0SfN2opazMJgpZZ3R1kLZd+QjYUtswrwoo
         eE/8OODAcD653Fy3q5HMVnGJE+HwHGbjcZA9StFyRiWN2BKaaRb25W+STQc7gRac7PAG
         yWTbt46JiulNcof9zH7JgpdDlWhYRk7Lwxp84ywKmjKIlWWua71EejDkrjpzz3PBkPeH
         Dc3w==
X-Forwarded-Encrypted: i=1; AJvYcCUA4ka3GF1nH+1TOiOfPmCcRFOiA+zQZ3TH4DwrmR4yw0RbyW11qWHKuIPPnTnyJVMaVey1TiTkvj0yKkH/S35ngL81MX60Vi+Md6Vd
X-Gm-Message-State: AOJu0Yy0gFc+vHFjc7/UPh0gF3dCFNR3GhvWG0QnOxNw52rfTlxLNWTQ
	dXsz9hm9te0WOGhw3fwfH+mDGZXhRLiHOHEjXz5nYoSrYO1ZSXZHYHlCj1zXVzlNo2Fn2Gt9FgM
	zYg==
X-Google-Smtp-Source: AGHT+IGqEEqaF1+2TvM6N+G9QkyYpXzWZJzKUP3e3L5FO3hVn3mgUrT2aIHEULaIU1RadtsZFQYUGGFwRZk=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a0d:d808:0:b0:60b:998c:389f with SMTP id
 a8-20020a0dd808000000b0060b998c389fmr713940ywe.10.1710460558222; Thu, 14 Mar
 2024 16:55:58 -0700 (PDT)
Date: Thu, 14 Mar 2024 23:55:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240314235554.90079-1-jthies@google.com>
Subject: [PATCH v1 0/1] usb: typec: ucsi: Check capabilities before discovery
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Heikki,

This patch updates the UCSI driver to better check the appropriate
capability bit before sending a UCSI command to discovery cable and
identity information.

These have been tested on a the usb-testing branch merged with a
chromeOS 6.8-rc2 kernel. Let me know if you have any questions.

Thanks,
Jameson

Jameson Thies (1):
  usb: typec: ucsi: Check capabilities before cable and identity
    discovery

 drivers/usb/typec/ucsi/ucsi.c | 34 +++++++++++++++++++++-------------
 drivers/usb/typec/ucsi/ucsi.h |  5 +++--
 2 files changed, 24 insertions(+), 15 deletions(-)


base-commit: d99e42ce6b8341d3f09e22c6706461ec900fe172
-- 
2.44.0.291.gc1ea87d7ee-goog


