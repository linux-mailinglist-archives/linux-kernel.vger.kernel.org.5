Return-Path: <linux-kernel+bounces-12884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B85281FC15
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 00:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C394CB222AA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 23:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC4910A1D;
	Thu, 28 Dec 2023 23:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b="OajBQIF/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B273210A01
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iwanders.net
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-67f91d48863so46867656d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 15:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iwanders.net; s=google; t=1703807438; x=1704412238; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9darX8R7g5MjCyzy3Z8xvlLW0J2TPRLyQHjGa081eZM=;
        b=OajBQIF/DJsOz2h9p1hlTFLSgnN0xUGk63DuiQPswLqADAzjqPMy9RekQcRl0l9Frg
         G+5fK6xLeOQawcOaKIXI3svM9687TszhV2C13v5dVyceScHcoF8Td76lyeiJdxNjYYhw
         QdcmC+iPMQZwowwigRIRuK8nwETTnIj9gjVmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703807438; x=1704412238;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9darX8R7g5MjCyzy3Z8xvlLW0J2TPRLyQHjGa081eZM=;
        b=qAXeM3cVWyyl5X/vPHFkM9HlEeXxQvqd4rWqqH/GH2ZpiRSR8iHkRaXv62X24PDMPm
         H8neZR7KXCa3W6eYCdarzp5dxjcxueE6qu+IgHCJsMukLwICt8Pi+Z2yLngHNx6y+jjK
         60BpqWp0aET2H+to2cLvuaBAqF23RnWHvO0KFtIFqjJQfFhRk/sVYyaBcGHG+hDG/4p4
         0Lm7BXH2VU44squXy2r25LgljZIJ/1AN9VACDvQfR1o+z2Kn/iwXYux8mMreGt/BlIf8
         3T4iph/FTfh/4rRnqM00eGZKwYXG/2CLFn5QsAc83issm78mk9kv5kHBK8MJB/ddAAJq
         O3nQ==
X-Gm-Message-State: AOJu0YxFdWt1OxN+uST/4QSzAxGwX5niCJ6H5MfXRRuWdX7liWzoJ6Ks
	uwcZPN2akP1mFSb5BUzo/9FF4Z/6ZdySP61sVlNSV160TrdNyQ==
X-Google-Smtp-Source: AGHT+IHjiqkhhkMX4zMRUaMP5pQJBc381IH+eBRoixqDzwpcb1iMaHxZ5eMj+j5BnpC8msTJWs9Xxw==
X-Received: by 2002:a0c:e70d:0:b0:67f:c3da:f1db with SMTP id d13-20020a0ce70d000000b0067fc3daf1dbmr9540051qvn.93.1703807438659;
        Thu, 28 Dec 2023 15:50:38 -0800 (PST)
Received: from eagle.lan (24-246-30-234.cable.teksavvy.com. [24.246.30.234])
        by smtp.gmail.com with ESMTPSA id mm7-20020a0562145e8700b00680608371adsm1597663qvb.18.2023.12.28.15.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 15:50:38 -0800 (PST)
From: Ivor Wanders <ivor@iwanders.net>
To: w_armin@gmx.de
Cc: corbet@lwn.net,
	hdegoede@redhat.com,
	ivor@iwanders.net,
	jdelvare@suse.com,
	linux-doc@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	luzmaximilian@gmail.com,
	markgross@kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hwmon: add fan speed monitoring driver for Surface devices
Date: Thu, 28 Dec 2023 18:50:30 -0500
Message-Id: <20231228235030.6526-1-ivor@iwanders.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <764c0645-674a-4a25-9bdb-2707e9532af7@gmx.de>
References: <764c0645-674a-4a25-9bdb-2707e9532af7@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi Armin, thank you for your time and comments.

> You can drop those checks, the hwmon core.
> Maybe you could use a more unique name for the hwmon chip, like "surface_fan".
Sure, incorporated both suggestions.

> Please propagate the error from __ssam_fan_rpm_get().
Done. Currently that function can only return -EIO and 0, but indeed best to
propagate that in case more error codes are returned in the future.

> What exactly is the purpose of calling ssam_device_set_drvdata() here?
That line was necessary when this driver also hooked into the thermal subsystem.
Integration with the thermal subsystem was removed in downstream iterations when
I discovered we can't directly control the fan speed, see [1] for more info.
I've removed this line, as it no longer serves any purpose here.

~Ivor

[1]: https://github.com/linux-surface/kernel/pull/144#issuecomment-1853123261

