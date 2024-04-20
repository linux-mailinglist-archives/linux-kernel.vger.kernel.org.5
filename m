Return-Path: <linux-kernel+bounces-152162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DA58ABA0B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 09:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5BA1C2091B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 07:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F07134A0;
	Sat, 20 Apr 2024 07:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5pfn6Ck"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7089510A20;
	Sat, 20 Apr 2024 07:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713597083; cv=none; b=lqu3Kw1gg4+wAfx20H97SIQkZ8HqpappOfM2c6bFreJpHiO1zDF0ltyH85Ls8bulnQU2s6eyO6Mhsau7lfxO3AFWdO+5v4sAQju0FmUrSFgYmQVOKGC9wiaNhiK+tKhacCU1x4JDiKdw8bwr4QdQ8LfvnxHmqn/w3UocBWGXCHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713597083; c=relaxed/simple;
	bh=FHbZcO9eBlYnt7XFS3eJVcq/xDUoC37Q2+wGWYF99lU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=In9lHTvoIMiVJVDVBk7u4iIs8/G0tOrAHXPbJERbIWI22xRbraO/wg8USQjpkNPWuKUqfw6qqjiCIn2oD3oQJQmXZmmEsTghmQni+HqRzGv8YD7KxaItrh35yzCNHJTDQu/eF+TiZzhGA0i8oty5i3T92lenA25Kn9c2fru2ZDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5pfn6Ck; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ee0642f718so2787687b3a.0;
        Sat, 20 Apr 2024 00:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713597081; x=1714201881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHbZcO9eBlYnt7XFS3eJVcq/xDUoC37Q2+wGWYF99lU=;
        b=I5pfn6CkCRS8D26JW689RbnZHv8UDSzDeNBaB7J8uzcJojyHKOgWX4HKAj2/YdjwT4
         4Rc6i2Ktp+V1UTOM1WOyODzlasypQ/trbWApuxsGdNLUVKkDg/g4ze7Ro56asCSSUfXS
         evluSxSOU92jj5l2uVZhIjQPCUFkD9LP/p46gV4lHrGRfyaUaUbtIo1NxP62aHZQsvyB
         VL47NWTIlzvWkxzqsH7iFVmP7HFbr5PatSpjt/OJRc2+0aWdlwQ/pqyLlFgPS2aW2rqv
         8bPgs0BH/Ncw/xVJNt/jy6VExsRDkXCEmBi7c6RtTHeZB5vTkV7ZNS1fZQFE0zKdLRxG
         W/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713597081; x=1714201881;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FHbZcO9eBlYnt7XFS3eJVcq/xDUoC37Q2+wGWYF99lU=;
        b=VZvXi2I2ErRt/+zc41/1GhuBu63uhU+N6cmh6YiF1VhggpqMFQi6kAvlki/KMBWGEB
         CzUEB0Lz15ePXd+D5H/sZR5pks1YL4XeBezAVZGHLelKUY1nI6C8qsagPBQhqAYRvfHU
         75UEW9/WQPJoagOfxWbNH08txq3z5hGx03ZBaEMsacRsciDmwrW6s+jhySmfwBF22pWg
         xtGQX/wXwF97HUuI/yiD9CLwnfnN4oLQWV1qki9s4E7AQUWcyIGUdcBsDJH2e1NXWfCB
         VsFIdaQv+Z7YgYRmtuweGBVS235jPzKq7SFIInvVkOA4F6dffKc9N5dTzeCAYzpqsF2r
         ie5w==
X-Forwarded-Encrypted: i=1; AJvYcCUCL0d1rSdA/TYPBTfJa043RjcpYOBwyAGhnMxewOaZVIGF8pi+siWftjbiTtpU0S2Ykohf1OgrwGAPQOW2gQfVz4pQBPKhR0J89a5SlfqbuN4UzfzYgn4YBFOqvQTDlMVMTcRaBw0OJhE=
X-Gm-Message-State: AOJu0YxHjJTKI+kcJE2F5koSUWlXONtMNS//QSYj4nQxH07T6ITc4Fkl
	jhvUxvNYKu5dN30kI7cMpUQVdNtDCkVsVD0D2R0G3XFnFlRxc2jU
X-Google-Smtp-Source: AGHT+IF7/BjkCTlEQA9k75Hm9RDDzMxIE7GIDqYigrbGxhJScjrrK4MvQMABkzfgKwFrdwg3rGG2Mw==
X-Received: by 2002:a05:6a21:3406:b0:1a7:52db:6711 with SMTP id yn6-20020a056a21340600b001a752db6711mr10716105pzb.2.1713597081476;
        Sat, 20 Apr 2024 00:11:21 -0700 (PDT)
Received: from [127.0.0.1] ([106.194.121.201])
        by smtp.gmail.com with ESMTPSA id m2-20020a638c02000000b005e857e39b10sm4210958pgd.56.2024.04.20.00.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 00:11:20 -0700 (PDT)
Date: Sat, 20 Apr 2024 12:41:07 +0530 (GMT+05:30)
From: Shresth Prasad <shresthprasad7@gmail.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: daniel.thompson@linaro.org, deller@gmx.de,
	dri-devel@lists.freedesktop.org, javier.carrasco.cruz@gmail.com,
	jingoohan1@gmail.com, julia.lawall@inria.fr, lee@kernel.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Message-ID: <fe7df45c-b61f-4e8a-a13f-1e6a85cf83bf@gmail.com>
In-Reply-To: <yelspf4hfmmj3lnk3exyc6tm2lrsqlet623q2s5zrm2unba6nw@43ewuqdzckdg>
References: <20240419111613.GA12884@aspen.lan> <819a56c3-bbaf-4d5e-87de-78c1312c56d1@gmail.com> <yelspf4hfmmj3lnk3exyc6tm2lrsqlet623q2s5zrm2unba6nw@43ewuqdzckdg>
Subject: Re: [PATCH][next] drivers: video: Simplify device_node cleanup
 using __free
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <fe7df45c-b61f-4e8a-a13f-1e6a85cf83bf@gmail.com>

20 Apr 2024 1:13:42 am Dmitry Baryshkov <dmitry.baryshkov@linaro.org>:

> On Sat, Apr 20, 2024 at 12:22:41AM +0530, Shresth Prasad wrote:
>>=20
>>> Please fix the subject line to be "backlight: <driver>: ...". I came
>>> very close to deleting this patch without reading it ;-) .
>>=20
>> Really sorry about that, I'll fix it.
>>=20
>>> Do we need to get dev->of_node at all? The device, which we are
>>> borrowing, already owns a reference to the node so I don't see
>>> any point in this function taking an extra one.
>>>=20
>>> So why not simply make this:
>>>=20
>>> =C2=A0=C2=A0=C2=A0 struct device_node *np =3D dev->of_node;
>>=20
>> Looking at it again, I'm not sure why the call to `of_node_put` is there=
 in the first place. I think removing it will be fine.
>>=20
>> I'll fix both of these issues and send a patch v2.
>=20
> Just a stupid quesiton: on which platform was this patch tested?
>=20
> --=20
> With best wishes
> Dmitry
I tested the patch on a x86_64 qemu virtual machine

Regards,
Shresth

