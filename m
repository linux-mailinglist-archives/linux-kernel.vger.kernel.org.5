Return-Path: <linux-kernel+bounces-94569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8E887418A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAFF61F221C3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1E217559;
	Wed,  6 Mar 2024 20:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f7RMqKbX"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF62C14A82
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 20:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709758147; cv=none; b=XrnkScDbJpomZPEE6TGbCFlvhgLqy7JWPMlb8HZ5caRA9ipGwOOqUAsPSLW2g53iFS1iOx+Y3NnqluKL3Ut511PA2fR/TcNdc/fYs9PvnZ6gSjfXAfC0EPto1Jaeu4RBlb79N3IQp1t0Is/uQhGVGZSh3HnH628DtQZq9NTVJiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709758147; c=relaxed/simple;
	bh=u0NUGzaBwJJBDPDk+I8V2n/hSdIaXHnoyk2XhQl0fYk=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=duCV6JJy3pC3vnHY1AUYxiNCmj22AwJo/AHG8uA5cc0F/O3fm3JE5CXbjvD+X2mK1RjI7aCLFMKpC2B6xOzkYN4F0daUyblwqfqjIsb4F4rPOXAaV8R+vbEMdEv2K+2CnYyU2KsPmxp+J8epZqJ/i7HmSQYM/dZFBM1FU+Bqz5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f7RMqKbX; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a12d31d76fso11455eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 12:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709758144; x=1710362944; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Lh7llgd/JQCb1eSfK1/AyRPT+0hSRouCKpBQqLhFMy4=;
        b=f7RMqKbXketNJuB3shvhxAYuIQt1p/W9KEofFfFoXNtGMEvwcLKlbA/y8B7qFAP0mz
         Uaq6FeF/hmPRJQ4Mlypercfkb2NAAdGlsQ16zjf6MbKKyAGJOqwZhpUdUC2HsHktbiHc
         /B3tqGI01Wih4X5zjSHgQdwyyerh1/5oOxK/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709758144; x=1710362944;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lh7llgd/JQCb1eSfK1/AyRPT+0hSRouCKpBQqLhFMy4=;
        b=t/TCwWdwMvmLZb98WJw5+V0W1ECTrIWI9mddbkGxNEo+ZRmlqJGgK14k/CYqCYDmRM
         glCpl2a8KYy5VfCVE0WNPcoBhnWoP3WJ4VjcXnRPFe5gpzZKmlg6bCHHYlSLoT3WV1Ue
         UAxQ79RYh5UTbPYLufvMtVy4HuLf537UxziUhEiJAMDhKeeKpB/EM2ArJeyR06oorxMu
         rSJuWUT+jg7BO/LZmZ2/vfnFOJavIQJ58WZSiAGmZQkmHPbKJgtv9Q6oXE96S1wfIdkg
         xm3k67dCEFAyhd7cxoP6W5wxt27yP4Yf5P8098+mrLlcL2f3vRWDxrbxOYwdE3SCrfKN
         BnvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtY+m/8vFx/xJ9StkyahYErbS8XPQ58NtqZiylHSV/V3fW+ujXb+phpPKgPvxVOmF1cKjqQJozYHyik2wtlByQt4xAo2YQwVP2EtOd
X-Gm-Message-State: AOJu0Yy0LudzLbu7VyOpaX4eG5FHe4m7jyiG8whJ98qwwnRfBWZBr8hh
	AkorKvUqZWaUbBhm5vdblQIut1ky2e++uBALhcYbgNUHz1RKl9sQWtlWL5zK1pEa5W5XGrxYZv8
	+xw0=
X-Google-Smtp-Source: AGHT+IFVGZQR8U86VJz5P43E6DGSqdoAEwPbFVdw+UeJSKUHFVIrSm4jUdmSmlkCdRuRVJE+M+tXdw==
X-Received: by 2002:a4a:9296:0:b0:5a1:31a1:7f75 with SMTP id i22-20020a4a9296000000b005a131a17f75mr125515ooh.1.1709758143774;
        Wed, 06 Mar 2024 12:49:03 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ce4-20020a056820218400b005a163045e17sm649619oob.26.2024.03.06.12.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 12:49:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------dyrB9Dj0dIFy7kqQK25HEesI"
Message-ID: <6eeb5f78-a38d-4f00-abca-db417d08d6fe@linuxfoundation.org>
Date: Wed, 6 Mar 2024 13:49:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: shuah <shuah@kernel.org>, skhan@linuxfoundation.org,
 Linux PM <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Thomas Renninger <trenn@suse.de>
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower update for Linux 6.9-rc1

This is a multi-part message in MIME format.
--------------dyrB9Dj0dIFy7kqQK25HEesI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower fixes update for Linux 6.9-rc1.

This cpupower update for Linux 6.9-rc1 consists of a single fix
to a typo in cpupower-frequency-info.1 man page.

diff is included.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit b401b621758e46812da61fa58a67c3fd8d91de0d:

   Linux 6.8-rc5 (2024-02-18 12:56:25 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-6.9-rc1

for you to fetch changes up to a114d9f1f2cf4896d838ab0a9c30a75411736829:

   Fix cpupower-frequency-info.1 man page typo (2024-03-06 09:27:57 -0700)

----------------------------------------------------------------
linux-cpupower-6.9-rc1

This cpupower update for Linux 6.9-rc1 consists of a single fix
to a typo in cpupower-frequency-info.1 man page.

----------------------------------------------------------------
Jan Kratochvil (1):
       Fix cpupower-frequency-info.1 man page typo

  tools/power/cpupower/man/cpupower-frequency-info.1 | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
----------------------------------------------------------------
--------------dyrB9Dj0dIFy7kqQK25HEesI
Content-Type: text/x-patch; charset=UTF-8; name="linux-cpupower-6.9-rc1.diff"
Content-Disposition: attachment; filename="linux-cpupower-6.9-rc1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL21hbi9jcHVwb3dlci1mcmVxdWVu
Y3ktaW5mby4xIGIvdG9vbHMvcG93ZXIvY3B1cG93ZXIvbWFuL2NwdXBvd2VyLWZyZXF1ZW5j
eS1pbmZvLjEKaW5kZXggZGQ1NDViNDk5NDgwLi40N2ZkZDcyMTg3NDggMTAwNjQ0Ci0tLSBh
L3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL21hbi9jcHVwb3dlci1mcmVxdWVuY3ktaW5mby4xCisr
KyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL21hbi9jcHVwb3dlci1mcmVxdWVuY3ktaW5mby4x
CkBAIC0zMiw3ICszMiw3IEBAIEdldHMgdGhlIGN1cnJlbnRseSB1c2VkIGNwdWZyZXEgcG9s
aWN5LgogXGZCXC1nXGZSIFxmQlwtXC1nb3Zlcm5vcnNcZlIKIERldGVybWluZXMgYXZhaWxh
YmxlIGNwdWZyZXEgZ292ZXJub3JzLgogLlRQICAKLVxmQlwtYVxmUiBcZkJcLVwtcmVsYXRl
ZFwtY3B1c1xmUgorXGZCXC1yXGZSIFxmQlwtXC1yZWxhdGVkXC1jcHVzXGZSCiBEZXRlcm1p
bmVzIHdoaWNoIENQVXMgcnVuIGF0IHRoZSBzYW1lIGhhcmR3YXJlIGZyZXF1ZW5jeS4KIC5U
UCAgCiBcZkJcLWFcZlIgXGZCXC1cLWFmZmVjdGVkXC1jcHVzXGZSCg==

--------------dyrB9Dj0dIFy7kqQK25HEesI--

