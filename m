Return-Path: <linux-kernel+bounces-59904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B51B484FD2E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AFDAB226FB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7718984A4F;
	Fri,  9 Feb 2024 19:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EPhgXupE"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3759B8287F;
	Fri,  9 Feb 2024 19:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707508306; cv=none; b=hGr1obL6UEPqUpD9pHVk6BEimuiV+GFt75D7Pr0PEHQOy0qecpIm5NiwG1w+th5yVxyHbaiGrDzoXNRA7cDO5DWM/VVHfijqY0w8iFEg8cF6mzFwv+bFPn04rPUodX7FA3JentHjfEAi2QgItVSnWSaOV2Nte7Gaj166aqZaBDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707508306; c=relaxed/simple;
	bh=KtgwUt4+mfG/3dP/ncZASoiPd5LZ3sA6qJ5MASSvB7c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=bDfQz6H0UXvv+MlHg22oRD39uOfSsjIiXqz0s6Jn0tuylPKsLALd4hwAFGgkXKuxo3vTblXzPCwGu3Ye25LBx7YAdA7vm7s0TnDhwQwE8+y0tcJ8K4hg3LX1pxRUDsQk3KCBtnDlCQ9niBuqTN4ZsoSbkzaWLqmx4FbPVLyqjJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=EPhgXupE; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4106cf2e9e2so8241155e9.3;
        Fri, 09 Feb 2024 11:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1707508303; x=1708113103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtgwUt4+mfG/3dP/ncZASoiPd5LZ3sA6qJ5MASSvB7c=;
        b=EPhgXupEY/TRN4ZQ0+J3rUaLO3Nkl5NGoiHwM6C5jOHdftDssmtkzVrCUt+WP1gYz/
         ttiQROTNf7h9apuWsZZm14BFvB4XFQLFc50rjzB+5sBWJ+OErszRnSNFnLsm47amVIad
         oZvS73pJ/EVPhBUMx17eH91zZpgXAVZdFqlAVGYrQImIZlLmPn3Y+1qAJfgwoLojC2BQ
         WRF/MiRPCa0HwUEPhZWXSdB+AUt/I+n3OEY6L0e0rvJZ4q4ePQ4TKzbLu0Qnxno77Y6s
         STjwatqdAYMKRF14rFxehU79jliuAtTUnNn2yNHd8EAuMHLcOXViQrQO5rgVny/PlDwM
         QIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707508303; x=1708113103;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtgwUt4+mfG/3dP/ncZASoiPd5LZ3sA6qJ5MASSvB7c=;
        b=YI8QC6QYteSM5M5j1EHSx8VEBp5tfGYEPwQyneSiWsXxD5hVOHhwZ9Gh1bR/oD5hIx
         YJGR34wgzVWm/PUOtQUT4aEtPvN7so/SluFtgrMUvWy/T5rSHnsi1GOcC1GU+CcRh+wB
         6q5ceV+6q0DPdJlqFehJJC07JsJ8TFOckggcany3Kajn2C+ufm61OMx2RLlXqzgKCKYw
         asLGT/xg/c8LUtedGgKx7gwPPhHnfFn3C/lLbXTNyXZQyan/3RiydXM8EoLA1tN7oPMz
         E+okYDUbNP5IUoL110wgEedvk4qRnFUwqCH6PM6xasyr2Xi3N6ZLsG3Ps3/mbwrXYfoL
         xonA==
X-Forwarded-Encrypted: i=1; AJvYcCUbTz8VdYjYsVzSJEU/985PbJOJB4fA1d6whAPY4d8KQe5EHtFB4sVSGH5IOFap/siNuoeZ76+JV/lJy264fPUGddh+G79TI3uLulEK79dBtjIHIApQZv3YaQ+HY7eqhFqhBjurIywnFRg=
X-Gm-Message-State: AOJu0YyKWO+HDuemQhVIdBlFG/4/tnuwKqXxyQR7ayiNETxct0xeczed
	irfDGO3Fv/CGubvCXbf8NlN1cYU7hwM1Y06WAyqGqYxXTbxq52IBMQ==
X-Google-Smtp-Source: AGHT+IERW8EW6eUmko0zxCG7QiImVUs5d6fZ/w0LeDhVmHJHdhxv1lH3dBfDcQ2y7o9cz3GY4SZxbA==
X-Received: by 2002:a05:600c:3ac7:b0:410:88d2:c7a with SMTP id d7-20020a05600c3ac700b0041088d20c7amr68595wms.7.1707508303183;
        Fri, 09 Feb 2024 11:51:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXgvkLZXdGjty9XKPRC5jmFxqQG99d36+5kDTtKIa73fmuWvjfLvCw8EP3wT7csQs4haSoccNFEXELAh/8dCKZ10egWTQYnNSbdpWQ5YEuqS4iB5vufqDQ+jrx2+pW4me2H1srtDBYLAeEV2DKtQ5mza9S7N3+Gdw2e4N6e+bbSWTzEmXC8Nkzko6biCzCPejZ7O1XEjSfq
Received: from ?IPv6:::1? (p200300c85f2ffe005dd582a67e0023fd.dip0.t-ipconnect.de. [2003:c8:5f2f:fe00:5dd5:82a6:7e00:23fd])
        by smtp.googlemail.com with ESMTPSA id o17-20020a05600c2e1100b0040fcd22056asm412248wmf.1.2024.02.09.11.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 11:51:42 -0800 (PST)
Date: Fri, 09 Feb 2024 20:51:39 +0100
From: Sebastian Kranz <tklightforce@googlemail.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: samsagax@gmail.com, derekjohn.clark@gmail.com, jdelvare@suse.com,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_V2=5D_hwmon=3A_=28oxp-sensors=29_A?= =?US-ASCII?Q?dd_support_for_Ayaneo_Air_Plus_7320u=2E?=
In-Reply-To: <41928b42-4272-49a7-8c10-e63059fba72c@roeck-us.net>
References: <2a6ab115-9775-447b-adf5-d63043548c74@roeck-us.net> <20240209090157.3232-1-tklightforce@googlemail.com> <41928b42-4272-49a7-8c10-e63059fba72c@roeck-us.net>
Message-ID: <21FB6929-603E-45E8-80C1-590EDBDC8272@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sorry for the inconvenience=2E
Thanks you for your time and patience=2E

Am 9=2E Februar 2024 16:01:37 MEZ schrieb Guenter Roeck <linux@roeck-us=2E=
net>:
>On Fri, Feb 09, 2024 at 10:01:23AM +0100, Sebastian Kranz wrote:
>> Add support for handheld AYANEO AIR Plus with the same EC registers to =
add proper fan control=2E
>>=20
>
>checkpatch:
>
>WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit de=
scription?)
>
>Also, there is no change log=2E
>
>I fixed up the commit message when applying the patch, so there is no nee=
d
>to resend, but please keep that in mind for future submissions=2E
>
>Thanks,
>Guenter

