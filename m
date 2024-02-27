Return-Path: <linux-kernel+bounces-82656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117058687D3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707C728572A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD5C1DA37;
	Tue, 27 Feb 2024 03:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.i=@xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.b="IpBvL4Nu"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5790E22626
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 03:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709005241; cv=none; b=YSImQ8Gvfe274I0/AmUhGGcz9q75EIOzNr/f4Ps5Sq+MxB8iOpCOPiHxiAkKuZrDFpe90qPFLs7k0OJNV0ke2VypVv8rLZVTr6FxyINiBWF47I8rO1TzPNW1lMsepyVsYIhDiDaLY7PJfdTp6EzMeFJaWff4ZyFuP9e5qz1l20s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709005241; c=relaxed/simple;
	bh=zU9oD31knEalbiOB2cAkxpqg9wLWKqGXJVMMBzS6PoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fuyTwDXa5sOYQM2n6RYwKz+s/t0WDpYrxtOuR8axcpLtbtSi6RL37TM62+LBmnYESh6JXB8H9WOsh0Q+wyXwnBPit1HWmfE0ShZQt1+OUB/9bKlLdt5DCoiRb/fL5AzYfXs4PUf7i6ulFMHOSnKFttlVpN/Vwj1vbJ+NCNL0Rg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xiaomi.corp-partner.google.com; spf=pass smtp.mailfrom=xiaomi.corp-partner.google.com; dkim=pass (2048-bit key) header.d=xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.i=@xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.b=IpBvL4Nu; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xiaomi.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.corp-partner.google.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-59fc4d05861so2090146eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xiaomi-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1709005239; x=1709610039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zU9oD31knEalbiOB2cAkxpqg9wLWKqGXJVMMBzS6PoI=;
        b=IpBvL4NuIUUXdGKZhLgGBLl9+M1DjNkO/LSvq92v0oQT/cfvK8J4NoWQFvIRFKjChA
         1R2tJtTN6hTRtev23OAnxs3anG9WnLcD/0zN3ioVzsaEPIlfW83GInhIfsfLTJzssOvj
         o3XK0i1RccrBIvJ143j4syOOm2s1uO87TEfmAcUczqdkl2obJwCG8t9hPpbE1+S7uFKo
         LLsydil73p6rp/ONqzCXyOXnKTDdPGf6kwKQEGkU4bxOa0pWRG/PlbT2kD7xiz0UHpJ5
         8LnC2hAlKdB+6SB8LJnv1X3fJ5Wy8ueb3jboi4KaRbt25jOgtwu2yr8LV/0XOYkGxLJ9
         5Ipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709005239; x=1709610039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zU9oD31knEalbiOB2cAkxpqg9wLWKqGXJVMMBzS6PoI=;
        b=ehBnJi2zKWqtkWy/3EHyUwFuRjrxDil+5GxRCoJ5ROQWiid7jujciopuupiycXtcp0
         BE+ov3r5GHQa2Ryka4qSK8VT1R06VXz+aEkx72wZUkUxKkzeIVOtLR25DOgaoS5XMh5u
         TQwfmarHEHw6lVX44NmkIQrEm9nD7mIXjQ1ZaEiDJs8YKEyqeFxK2b4cLdbUzjR/y1tI
         hBIr0MqgzMmp4wRO/RI9MC+uZqTDuODbd1gY8rxH7IvJ0bd58zew9i41qiGDR9gZsznt
         UvGfD1Gb4aDe1QVjRTpJCIpoX/1xcW5PN3M4oi1eT6g0+sdNc/lBIjdjLU2Umj9qc+/p
         EO/w==
X-Forwarded-Encrypted: i=1; AJvYcCVLANmcsdtbXJm4g8vizFUKAYFtaGsSb30JgjaQa8/oUpN2OjslaK5t4ykb0HJEJe0q1GXmCJR5NwJxXDrtOugA9rzSv6XPyrK1Z9Nd
X-Gm-Message-State: AOJu0YwJF4/IWI1osdjzjrihPgW+4zZAt03gbI7tJ7O6ONK7T+tD2lfp
	dSVnpSA4mqYZq4syIKyuzFW9wXes+bUc01xAJxrzLz4q4Ctti12LZmm90Mz4Crw=
X-Google-Smtp-Source: AGHT+IF59cK5ZcqQAcJe1CGGsv7k5mDEoUJZ8WlzdPRcbYF0ubYhXH9QLOC3m9RGtAvBZjZrNVQptg==
X-Received: by 2002:a05:6358:59a3:b0:17b:59f4:f640 with SMTP id c35-20020a05635859a300b0017b59f4f640mr10778172rwf.1.1709005239276;
        Mon, 26 Feb 2024 19:40:39 -0800 (PST)
Received: from xuyingfeng-OptiPlex-7080.mioffice.cn ([2408:8607:1b00:8:b27b:25ff:fe2a:187f])
        by smtp.gmail.com with ESMTPSA id h22-20020aa786d6000000b006e089bb3619sm4811499pfo.112.2024.02.26.19.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 19:40:38 -0800 (PST)
From: Rumeng Wang <wangrumeng@xiaomi.corp-partner.google.com>
To: djakov@kernel.org
Cc: fengqi@xiaomi.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	tkjos@google.com,
	wangrumeng@xiaomi.corp-partner.google.com,
	xuyingfeng@xiaomi.com
Subject: [PATCH] interconnect:Replace mutex with rt_mutex for icc_bw_lock
Date: Tue, 27 Feb 2024 11:40:31 +0800
Message-ID: <20240227034031.1195-1-wangrumeng@xiaomi.corp-partner.google.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <4c3f9f52-cd56-4d20-a44d-bfca0b2e3b7e@kernel.org>
References: <4c3f9f52-cd56-4d20-a44d-bfca0b2e3b7e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello, it has been a week since the last reply. Is there any progress on this issue?
Thanks.

