Return-Path: <linux-kernel+bounces-104703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A82CC87D291
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8DB1F22E41
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C926481B9;
	Fri, 15 Mar 2024 17:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m6luGXXi"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8503DBBC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523138; cv=none; b=cQ/qjU6LPsWxkNIGrHbE/8Qgvh49ttSRdEVaPJ5zZPzpMLEPcx33C9nvkVESOWrQ5Kw8rPtT0PW4LDK+kHGHnmxGxyBCk+vs387LP5AqOQ7801QkH/mR8mrXYk82CMGhTTJ1HM07hV6m7gjRKBZlGzfOZ/Gi5LB6s9s4SyJR66o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523138; c=relaxed/simple;
	bh=LjdE53DAeCK/DV4IGBzwE6QKkJ7zjfXL42DBeebkQMg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bcuUEJ3DouUvCEr96TRNPBAmxaWguH+qEWNxcLCOS1PH7aPrDBhd4QLtAzh9zf5JVdH4G2ufXZXqMtCPg5TcDMk6ss53yMbdOyXmqiF2a1RVRhFwtZTFVWWcUrKKByO+lRxN91b2+FBZjNblckWaFre7avumb/j9PhO+lsWzQ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m6luGXXi; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a08eb0956so37128027b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710523136; x=1711127936; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x+U5NBs6WRZY8QHIXBoAKLIZmwg0dfigkJKpGoGlj90=;
        b=m6luGXXi0PWusywGR+Lq/xkyw7xDaTzplPCL5M83eLqy8JEnPGZHJa3IRei94ZXlH8
         0DF2tBQX2dvSmk3tw0AEZXIRRYpwusZvxB5bOabQcjedOzF2WIngnXQX7HCrIRmtJuOm
         1fAAURqN2TgDvGu2lFUJUcoUx+j1cMpl4NNAfuwSbrJvvPv1Xv1f+B9yEuEjj678BrNe
         P0Sn0Ivseq5S6b+QrCzRPVIiwuycgY08AFb9N0elYfAlqejMwdZmcok0MIV1cV0uMpKe
         AFfNKUa4yvK2JigmPy5evrzujpIB9B7JmcOs7EBZ5xnT37/tehRB6etaq6Z9QoH2jdP/
         zscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710523136; x=1711127936;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x+U5NBs6WRZY8QHIXBoAKLIZmwg0dfigkJKpGoGlj90=;
        b=fosUW3U1NLzsFdax1cjBLQ/iD8NFdvfO2iSIDVVqpzFGNy2BcTQoB+t7wLuL/WkA2G
         tgQjSLYBKDrbBANvxqbnX6KUoBt4AXvjovdAVpCfA5JENG9GMaSkz+TwrBirpZ/44ScU
         XaE67WtZiLOJ5QBwsUmfpYn8al/fA4lCGg/CzVn1JvmJMYS5/qUNVmFi2kKqtWKwmgHZ
         9RpeDkfKMxQIMnvjVI7iag7v7dMkhCRyofzCsWSUbiOz1zf8lHuAvr+4IEZh176ru6l2
         +FlVTRp8loTFaqYClInMk5T/tK10BUacoR7S0O84Fer5XsP0rHjZbJkRebg5rJZZvWXD
         Rjsg==
X-Forwarded-Encrypted: i=1; AJvYcCVqiALPywsYXBEjVTUCkE6dAPiV+pA/BFUPGqa9swBtF4aEbxw6Z4iJN0VoYCpv/f9spqQoi3SqxRnmTV76G6Rm9SzZ27RlLkxTM88Y
X-Gm-Message-State: AOJu0YxaUPamJ6bqNcX3ZDycpfbe8EK4VVxxS3g3epT3VU1oktqShEiB
	rDxTdPIoavGzMVBgJPnWQ3UwJ7ij7SKw3yO2IVlYH+mDDHoenT331aAmCtI1/E2TVnHX/XoA8AE
	2JQ==
X-Google-Smtp-Source: AGHT+IEJ7GpoKdok/Jv7P5V2DJOncHhW1qMA+O9OKiAgOc41iLcJp85JipwLdakV4XdThj9EjCn4ZDMQlmo=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a81:4ed3:0:b0:60a:5d76:a875 with SMTP id
 c202-20020a814ed3000000b0060a5d76a875mr890098ywb.5.1710523136230; Fri, 15 Mar
 2024 10:18:56 -0700 (PDT)
Date: Fri, 15 Mar 2024 17:18:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240315171836.343830-1-jthies@google.com>
Subject: [PATCH v2 0/1] usb: typec: ucsi: Check capabilities before discovery
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


