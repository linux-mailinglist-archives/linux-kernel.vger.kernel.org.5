Return-Path: <linux-kernel+bounces-37831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB81483B62D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6981C22B2B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C0667C4B;
	Thu, 25 Jan 2024 00:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O5ilmRpd"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94287193
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 00:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706143503; cv=none; b=t8U5t4TxvDMkJEfQaj36hB3IsblMrFp0tNRI3SIAdehnVi5J7P4ANjVumydFhrkLmE1xIG+Bv+6FAj87SnhWlmI1uWqIbr6Xda4kZ/R+mMV559CmtD1/RbVZqivJ/7WdInMWV2FAA3dJg6VRwMEKVa39BPE9jlBmJJBmXI3CUgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706143503; c=relaxed/simple;
	bh=1Ub0qMCSBqSUX8wgOlnHabtJlPqKVHQn2eRwVX1V8h4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GfvKzkvbshsBtRVFZMTuI0sYkU8e5P+KtPOljqxkDXqX9P9kd8NpbNFLZuvE1Md/3ydqzyRE3QOfUU4iikLYG5nDvoGtrktoMCmtqtKa9Nyng+fhP9noJh8dBaJuIHkY4RSD95xvv/clBFmG1OVSIVapZwtPKjfXV182FeDA2X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abhishekpandit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O5ilmRpd; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abhishekpandit.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc3645a6790so5598016276.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706143499; x=1706748299; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VJjR2jV5qU9yB/wyVcnR/yaTWQ4dMOB892g68teFZLI=;
        b=O5ilmRpdS00jIkpr0Mj/tVA/FETxeA+9l2BRZR8nGjkDoPvYPwFQHxClfoKcNPkenq
         9WowNz6O7UZQWFq53fYNuPN7MonoOefpmDtQMmQWmI8267cZ4MEX1HcBrQH/qsgBQy/R
         Fa9yvKTGSvdb+T5xapUZEJQnkHVNRjnlPCW7tLqcgPHqiACE7ILiIGHjnl8aj9qX+c7E
         BNVjI3ZfJsvQZR1vp+oa5AP98/KjRWifkTE116J0ef++LJu301uTKqYIxjrP/Ig8neoO
         9NxGN/kyoVJccZ08c/hi6Uip3bCddxqWZr5NcW9Nx2Qy7e0ATMOwcx+GVsoe2Vxapxdb
         2PdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706143499; x=1706748299;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VJjR2jV5qU9yB/wyVcnR/yaTWQ4dMOB892g68teFZLI=;
        b=vUiBqbH33+CyKGkJ6YHNJHhNahaCRtVlLJmAabQ7ycxeSffZaul+S66hUurRI9KblD
         2esZ+Zk39ap6i1hWNTS98DEdoH5gAUnoF904N7i3kqb8MVPzwipYcLrz5MtFBDKIgEtS
         bqhEsqsnggLaPq5T4jOkcoDDVh8JdsooDjgJ5f1bNV4Pu2mIHNXeyKD+ZwGaoc5Sfwfa
         u3M+XHbieRwU/z3qeg6HlGp0q2DovGDSBuZKKrk0lmNCiPyccvhtSQe7jf/z3SftSJtv
         gVRKPfH8G6mCsdPDyuY/1kjHGOhGKl3Z0faa+JzUpMoyaRDDswphH4uqI9r2tTt1Ytwj
         JKIg==
X-Gm-Message-State: AOJu0Yy9MYgOjsSPu5GP2VeQgSSkCR881kL8iQp29+SzKc+RYtxtlHgS
	AQMGRJCkm6Bd+/Na19nII/58EXtwI+PRGNzgZjZwJDRQ4jfo2Pv5v1cCZBAcfixspfXQvD6Dkut
	zke32LAOutoOHrtOUwH7yUzMpu6HqHNfyIQ==
X-Google-Smtp-Source: AGHT+IFThnUDHcVqOwc/fNcLzTHF6n8GCLiYUBEuW/ph4bODWoDy5/5fW5CM4Ts/6tPSTQGaLmAitsiZ9Vz9gmTMhSpkiA==
X-Received: from abps.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:9b4])
 (user=abhishekpandit job=sendgmr) by 2002:a05:6902:2587:b0:dbe:a5b7:a8d3 with
 SMTP id du7-20020a056902258700b00dbea5b7a8d3mr117632ybb.3.1706143499680; Wed,
 24 Jan 2024 16:44:59 -0800 (PST)
Date: Wed, 24 Jan 2024 16:44:51 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240125004456.575891-1-abhishekpandit@google.com>
Subject: [PATCH v2 0/3] usb: typec: ucsi: Adding support for UCSI 3.0
From: Abhishek Pandit-Subedi <abhishekpandit@google.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Bjorn Andersson <andersson@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rajaram Regupathy <rajaram.regupathy@intel.com>, 
	Saranya Gopal <saranya.gopal@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>


Hi Heikki,

This series starts the work adding UCSI 3.0 support to the UCSI driver.

There's a couple of pieces to start here:
* Add version checks and limit read size on 1.2.
* Update Connector Status and Connector Capability structures.
* Expose Partner PD revision from Capability data.

These were tested against on a 6.6 kernel running a usermode PPM against
a Realtek Evaluation board.

One additional note: there are a lot more unaligned fields in UCSI now
and the struct definitions are getting a bit out of hand. We can discuss
alternate mechanisms for defining these structs in the patch that
changes these structures.

Thanks,
Abhishek

Changes in v2:
  - Changed log message to DEBUG
  - Formatting changes and update macro to use brackets.
  - Fix incorrect guard condition when checking connector capability.

Abhishek Pandit-Subedi (3):
  usb: typec: ucsi: Limit read size on v1.2
  usb: typec: ucsi: Update connector cap and status
  usb: typec: ucsi: Get PD revision for partner

 drivers/usb/typec/ucsi/ucsi.c | 49 +++++++++++++++++++++++++--
 drivers/usb/typec/ucsi/ucsi.h | 64 ++++++++++++++++++++++++++++++++---
 2 files changed, 107 insertions(+), 6 deletions(-)

-- 
2.43.0.429.g432eaa2c6b-goog


