Return-Path: <linux-kernel+bounces-99300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0424D87863C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32DC282F6A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E924CE05;
	Mon, 11 Mar 2024 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VJnXGeuX"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C90E4AEEB
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710177794; cv=none; b=eLmAgmteF0DfOkckhkxPbSFZ/i9eAj1WEs6Zd1tpU5UEfOzsX5/Rl46trY1KKWgA+f74ghe51p7h459jsIAsgyPoUDzb6pgD3+QS1G3unjg0f1SkrLBep9eRmS+1zofkvXCzL1YW9hktIoSxyycocloR76ebnWiAD8Wmx5zIcRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710177794; c=relaxed/simple;
	bh=oKUsJDC4xXjk3cXvZ0UkhE+m5A6JJ3EOsCl7WrkesAY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uU/sJUODaqG0/UZ99srJRCZn7V89AXzoRyzzEtGi2KCCz+gkOpC/TAxSgBoITRFCA/UABmMAMAKAfa7b1eQNuVpsCr/N35zLAtFj5bdOIBmFkHlSy1r0o4jpeJptoAzt8fL2xZmR3xEAxJtAD5lDWUJgALBDQm3vDkRGV7eYfys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kyletso.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VJnXGeuX; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kyletso.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b267bf11so3636722276.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710177792; x=1710782592; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eEFSDQP8nEwgMk7vCT7vaN5aD9pBnwi9LafjzuTKO94=;
        b=VJnXGeuXXmWKS0uRl6BNBeMoQhcNH/BnuKEhE1cT1f27uNBl6tD2HVSgFnQqPFvomY
         nZAYqloYaLJn5ezj6znJfy+mpOfQFBmdRPcsovnyWXEUg+QO3eFx2bD8s2sDbGEyAoUa
         ub2Pq+3qZEadLIT+5hAxqK6kzlBTvA2m/T0Ep39pwjdy5ytwwRb/9gwmGcRnz4dSnJb1
         HRWeHmvtuIPEHTvsICPXMcILjnqIkbgd3kx7ZKM+7EFHX7KT8FMAElnArQ3cZ8uUNbH7
         FTdB9M47DMO7ujY1Guuk2r3ErJ9y2jr7C5iFMumX/GqPGIVg71rJ7D3wlZwJf1608AlK
         Gghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710177792; x=1710782592;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eEFSDQP8nEwgMk7vCT7vaN5aD9pBnwi9LafjzuTKO94=;
        b=UvbJukldJ4HlHOqqijglNm/KFde5k+KlSr4xOqFdLEfpG+1j0w/axWfSyB++PAjjfH
         MNUNbaCHxEb5gdwfhgsJyhteJWO9cIDR3O3LHVxc0pmRDPvoTiBFdiXaEikgWF9U8Cet
         Ceho8w76YdknSQ3KZ/6OoDFVUPEnieFyOFW3KCBxyY2cIYzkxSO8pQ8iTSOe8BlWGFgE
         jzs11a4dWuJkVz4iBKJ4Kl7ovHPDJIscMsu48HsJKsYVaZEFSA0JwmDzkE6B+IP2BNWb
         OYXN7wqggKMSlJzJuAtW4ERVdHDyYKOOaeZB/do09bSsgLiYZwjATlI3X18iyPrDlPBQ
         88rw==
X-Forwarded-Encrypted: i=1; AJvYcCWt9pxUU0SoBk46jB6jTT8Uszu4QW2GQDa1e3jfwnKKFP8Dio/0CgYFQ53tNXxYa8HM/SDTg17tb+8XkGaPA12lTJZIOrQXMOXcKkTU
X-Gm-Message-State: AOJu0YzIqu9d77EtTuejGKtTwJPqvsNIoTl5331SScrtQ2QxklMuWOS/
	vf0UhUfjAsGK2FnuNTbEtAaKBD3AcbKph7xcp0u8+ZWk5dBprqg3UZThdvUovcMj0EI0hTv3fNZ
	+GmJIPA==
X-Google-Smtp-Source: AGHT+IEOmE8gBkWsQ+VxVdk/lX9Bz/bX02Oz9mDyF9yTgj6j/8N1NeP6m21R1WLnEHPrOKjNcIihOqVPnS0z
X-Received: from kyletso-p620lin01.ntc.corp.google.com ([2401:fa00:fc:202:f39:e78f:4944:b22])
 (user=kyletso job=sendgmr) by 2002:a25:c4c4:0:b0:dcc:6bf0:2eb6 with SMTP id
 u187-20020a25c4c4000000b00dcc6bf02eb6mr387095ybf.6.1710177792170; Mon, 11 Mar
 2024 10:23:12 -0700 (PDT)
Date: Tue, 12 Mar 2024 01:23:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240311172306.3911309-1-kyletso@google.com>
Subject: [PATCH v1] usb: typec: tcpm: Update PD of Type-C port upon pd_set
From: Kyle Tso <kyletso@google.com>
To: linux@roeck-us.net, heikki.krogerus@linux.intel.com, 
	gregkh@linuxfoundation.org
Cc: badhri@google.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	Kyle Tso <kyletso@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The PD of Type-C port needs to be updated in pd_set. Unlink the Type-C
port device to the old PD before linking it to a new one.

Fixes: cd099cde4ed2 ("usb: typec: tcpm: Support multiple capabilities")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Tso <kyletso@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 3d505614bff1..896f594b9328 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -6907,7 +6907,9 @@ static int tcpm_pd_set(struct typec_port *p, struct usb_power_delivery *pd)
 
 	port->port_source_caps = data->source_cap;
 	port->port_sink_caps = data->sink_cap;
+	typec_port_set_usb_power_delivery(p, NULL);
 	port->selected_pd = pd;
+	typec_port_set_usb_power_delivery(p, port->selected_pd);
 unlock:
 	mutex_unlock(&port->lock);
 	return ret;
-- 
2.44.0.278.ge034bb2e1d-goog


