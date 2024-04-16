Return-Path: <linux-kernel+bounces-147646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F85C8A76D3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8FF2847FE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2868A136E09;
	Tue, 16 Apr 2024 21:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b="X3BX3xxB"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5140B6CDC0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713303303; cv=none; b=K1UqE3sMX9HkFOFRESjrBXd3khMvQYWdgJD4u7Jo9dxoxsWFrXpn7hzyFSshLLnIgmJxWJNOySOyKQUJOxMpf83K/syKScrkdmgHJfRryHwG000OukiLUmGg48wg31ZXZMyiJMtAHX4W97Os8tVb2n48Hnwx2/TmJ9vFkyOUNlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713303303; c=relaxed/simple;
	bh=AbGUTIr93cIZBICMTdcgi4m66F6R94LZwRvkAx0ybN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EuwmpCbsizFtwpdsnTdT131zBPamiyrdHEgNU8Im/4tNdqzacM9z3GTPygMA91b2l4JsMhrUSY2CxpChWrPm2d5po8sLoJ7emuLG2shzA8KC/NSZYr2VHVxkLlIyWcJ54YyFn5nexBodnRmHR+VnwIQ8uMThwd/L7X1oykahOvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net; spf=pass smtp.mailfrom=iwanders.net; dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b=X3BX3xxB; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iwanders.net
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4347cbdb952so14985381cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 14:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iwanders.net; s=google; t=1713303300; x=1713908100; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AbGUTIr93cIZBICMTdcgi4m66F6R94LZwRvkAx0ybN4=;
        b=X3BX3xxBdfZyLm2Y7uCzFrunCUEdaIQJYFUNYrgsuZV0URPn8HN6hGiaZZ6r1oJT0u
         Utge9fWhUY4s7yOVYneuf4Fz14j0ZcE/RLTuDzu/jVRRzodKavKPDEhEH6au4d1sDovN
         t98mjnzqZWWanHx2WCgd4uHfGskwTtsEPatls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713303300; x=1713908100;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AbGUTIr93cIZBICMTdcgi4m66F6R94LZwRvkAx0ybN4=;
        b=uzROUV/28yaN5REhCipv83ncIr5Ab6hM0phiHGfbUIMWS+N1zT64cXMEstUzBGNcKL
         7Hz9VFxMr6h2Fjr46IC6btc2tj1F7wNDlZrUqDEbeD6j7d5vYu2AmBV3Nk6dW3SAm9aU
         rOXfLLM2Yvdyk5PoOJosol2ZfnB2gOkuxaUl7BaH0jaw0O7jOC1tlMxr7aYT/mHpqrxC
         djZtaCXXmnVf9SHGGeD45uDeNkgez5XxPXSJZ1mu1Rfnrda0oTjWxX+laUUhlLfGtlAp
         Jvht8no3STgv1stpHK3D5u7Ns7xiIdIN8bgsXnLJtB14AlTIS26M26/osgjIhisat/h7
         viCg==
X-Forwarded-Encrypted: i=1; AJvYcCWywUuLfUXvftXDdHIEjE5CA4t6jlYB6RZ5XBhjGA2reHy8YvXLa+f4PEOeOmRmrRb+V63hSR1LKieNmZNY5kWuXtLWgGQuwfh3HupZ
X-Gm-Message-State: AOJu0YyiCtXlqMeuiDIN568E0GmLmk1idmtHFo+DJL9Bmu2a5mh88JSU
	VRV2r5XzanWbDo9hGkpSQN08JBezxQYt8ScQ70neWO7UguQtCOhzax5h6m493EM=
X-Google-Smtp-Source: AGHT+IHDjh9+d1ObR8Ij8WEXEfjPgBM7QNiW7UwML0UelHwkd95ejcMfHejXGyIypHi5JcRJDdmBKQ==
X-Received: by 2002:a05:622a:40c:b0:434:8f14:d24 with SMTP id n12-20020a05622a040c00b004348f140d24mr19186828qtx.62.1713303300063;
        Tue, 16 Apr 2024 14:35:00 -0700 (PDT)
Received: from eagle.lan (24-246-30-234.cable.teksavvy.com. [24.246.30.234])
        by smtp.gmail.com with ESMTPSA id s11-20020ac8528b000000b0043476c7f668sm7566740qtn.5.2024.04.16.14.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 14:34:59 -0700 (PDT)
From: Ivor Wanders <ivor@iwanders.net>
To: luzmaximilian@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	ivor@iwanders.net,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 2/3] hwmon: surface_temp: Add support for sensor names
Date: Tue, 16 Apr 2024 17:34:56 -0400
Message-Id: <20240416213456.3214-1-ivor@iwanders.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <97d0f68f-63da-4f72-ae8d-89fbf9aadf62@gmail.com>
References: <97d0f68f-63da-4f72-ae8d-89fbf9aadf62@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

> Ivor reverse-engineered the interface calls to get the sensor
> names and wrote the vast majority of this patch (I only changed some
> smaller things and gave advice, hence the co-developed-by). Therefore I
> wanted to give proper attribution to Ivor for his work and not squash it
> into a single patch.

By all means squash them in the next patch revision to make things simpler
to review, I don't think it's a large enough piece of work to worry too
much about attribution if it makes review more difficult.

~Ivor

