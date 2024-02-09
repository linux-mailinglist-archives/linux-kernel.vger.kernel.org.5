Return-Path: <linux-kernel+bounces-60121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F19850021
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4890B1F238E3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C330D35280;
	Fri,  9 Feb 2024 22:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GByAOdzw"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C5F25625
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 22:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707518308; cv=none; b=PLFJ2nBd8VMsXw96J7RtIzfU/sJNJOYtn6AkftDYZARw+aDC5uOFy2SPXq9mxiCE9i0f355MTk/SPPLGvcI8qfCv83DUuadAe087JTYxF40/hwQzB+XVhd0Zg2LOLrItFuaE93WGg+PzTxT/TE//54FyXnHRicVFu4WWqYiYMus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707518308; c=relaxed/simple;
	bh=CneQkxAM2XFwm/rlwWTx78xUpKNPxGdJmojiYb4Db4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IhjiVMC0qhUxH0yjbFap9tH1Vnwdf5hGzDSw0aa1WrjFlJoGf6yaW8CDuYrN1M6wyx+/whzJZR+UVpxluA08a657LxRqKf9ZQs9UZ/z7G17lF4psi7jCKRvn2Ui8TX/dxRFtCtktiSdbuQd5aJoQa8E+YvcpAr3tUBKIWwZb9WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GByAOdzw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d94b222a3aso12542355ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 14:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707518306; x=1708123106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BA088edQE9MyZoucoNS82KLHl0uttqfXtdVNBUsV2lw=;
        b=GByAOdzwmthaDqZUTnExg+oy8CofOA2jJJjgTazwDHYgPiFwALA1OZGs0/Ftr2VfdV
         88FgIKXL+JsDo2X1eIjhOJ1uyq00IosBYNnK1WKvCGuNj1eWl/X0TxsHOjeGSiFSVNQ0
         hAnuIOhhzFVAVHLDy5ySXZRgS7Poo/KZTaYsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707518306; x=1708123106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BA088edQE9MyZoucoNS82KLHl0uttqfXtdVNBUsV2lw=;
        b=EbQXGZ2mLeZfGkg0qXiRNJQCNymW0yPimBC7NLh2tBSgSmLzI3vHIb5JFg9+d/erpO
         hPOODMHj0NgMPPjpQpQOyg3hT7xJZavKDuH36Fn5PhyPuEqjjUHmWc16bGwK3gNp5X9S
         98J5nddI7H9JhhevAevhNjZ/y0YN2KmN3blY1EDTrnxH/W/XWgydrFZyO6dvgqsncDxW
         XwyXf1lwlp+s67djh2R4j4Q//318aqndLleFoeZ/3koWYkgZd+ITRqna/XWDAolsPpUQ
         +SpF1YPWY2Z6EMl6YiSQors5sb0ewZSUr1cG0Gr/pYlzXodheyLwZqZE8hVbSRU887Xg
         vgCA==
X-Forwarded-Encrypted: i=1; AJvYcCXpUXhSjkzVLRMnmmZw5G6XsNxPpCRZm3fjOBDV2eDglfXR5dDPza/3HkYBcvbp8JD2tIU6LS1G2+UDOTpT5vwn8ygy9VrCnEj8j8hR
X-Gm-Message-State: AOJu0YwAHCZ8CGdedWfYufP5Q4LdISf2tzJlnjNcw2XA5uUJkOhmns5T
	/MI69K2h7yk+GpieHU1CvwT2G39Y4gmjd+wJlgzPcTtwZiq1J69IlSooecxd1g==
X-Google-Smtp-Source: AGHT+IEA3550bJ+etF7eGHcMPiX34Guc3JFJMpIfWrFe4F00ei6dA1OBzcWR24+np1q6tAbPxeq/uA==
X-Received: by 2002:a17:902:e9c4:b0:1d9:c367:205d with SMTP id 4-20020a170902e9c400b001d9c367205dmr673735plk.53.1707518305843;
        Fri, 09 Feb 2024 14:38:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUNwf5J35fIQTKYNTgsrUnV7uFWXD9RJWfJMZKiwwVifVxjnQQpf2B+juXGvKo8dQhfYRmHkq7P0oVE9Zg03BproOfY9UzECgRnn7cO4uHIpf9ZvjJFQ0nFbs9P38ArSbagR9XTYHkipPRprWto9ValfkEMoc58O49ZJJwJRwGgRtg6PIPviL7TCYs9+yIfabxavBugXRoVTKVzVxKubOtDXose1e7A4YjueEERXqS7XYFdrcYbSCGv35aMHDEVwzxS4tsnmyB1gND6dd9/CMBDIm2PNXDqQKFysgAY+QmbLxLmTiqtZ0eJAwooohkpTE+XEnjJL3TPOjzBd2T4x9RUFbVVhJFo9h0Pt8WUpi44S5FEemoHhwgT+STjIT6EpdasfwjzLtYT02VLRhTWOEn+YKn1K8n32eN/Jt1S+iuHky3uaXlcvyiIqmm/n1aPCrLrqZjLTTqhuSAeORFng5k=
Received: from localhost (209.148.168.34.bc.googleusercontent.com. [34.168.148.209])
        by smtp.gmail.com with UTF8SMTPSA id jc9-20020a17090325c900b001d9f4c562b2sm1990156plb.23.2024.02.09.14.38.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 14:38:25 -0800 (PST)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org
Cc: pmalani@chromium.org,
	jthies@google.com,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rajaram Regupathy <rajaram.regupathy@intel.com>,
	Saranya Gopal <saranya.gopal@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] usb: typec: ucsi: Adding support for UCSI 3.0
Date: Fri,  9 Feb 2024 14:37:29 -0800
Message-ID: <20240209223824.622869-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


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

Changes in v5:
  - Change min_t to clamp

Changes in v4:
  - Added missing Tested-By tags from v1 and reviewed-by tags.
  - Fix BCD translation of PD Major Rev
  - Replace IS_MIN_VERSION macro and just compare version directly.

Changes in v3:
  - Change include to asm/unaligned.h and reorder include.

Changes in v2:
  - Changed log message to DEBUG
  - Formatting changes and update macro to use brackets.
  - Fix incorrect guard condition when checking connector capability.

Abhishek Pandit-Subedi (3):
  usb: typec: ucsi: Limit read size on v1.2
  usb: typec: ucsi: Update connector cap and status
  usb: typec: ucsi: Get PD revision for partner

 drivers/usb/typec/ucsi/ucsi.c | 49 +++++++++++++++++++++++--
 drivers/usb/typec/ucsi/ucsi.h | 67 ++++++++++++++++++++++++++++++++---
 2 files changed, 110 insertions(+), 6 deletions(-)

-- 
2.43.0.687.g38aa6559b0-goog


