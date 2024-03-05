Return-Path: <linux-kernel+bounces-92001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E99C871991
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 806351C21FD3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCC852F6F;
	Tue,  5 Mar 2024 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUTCgjJA"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D4D524B1;
	Tue,  5 Mar 2024 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709630864; cv=none; b=MhZfK0sPfmmpzLTNx7eIqEX/VKBpkhyAekpYe12kllSz/EIT1KFe4twgX+5OWerB2qSGdadY/cmDn2HkcJuNcCd2uMG4JTTYXvyekr5AzSRQhCdAJ4Z2tOLBnc2FfizWkr/xFeYLe8hENUZsmioV/MJYzPAUgo8dO1txZ9FvMEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709630864; c=relaxed/simple;
	bh=hhP4XU8PPTJplv1l0YzJ9uullD2EJhJdpXiJno/Icvk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=S67sKZaj6Xx7j8VxEUnCcJZnCzcIrbV5QdYO2ZAhKaU2FL1i33OYNQVPy4S8WY5GgJ0uRDKZ+5LDxZSqeMkBFOMGlRvePRrgrV2oQUgnIeInY71v8dO6OXyaoalN9YNfvfn8GYfUy9QE0FhfpZSeahqdy+uxmOrCHcdzTbHcE1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUTCgjJA; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-53fa455cd94so387126a12.2;
        Tue, 05 Mar 2024 01:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709630862; x=1710235662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hhP4XU8PPTJplv1l0YzJ9uullD2EJhJdpXiJno/Icvk=;
        b=PUTCgjJAzeCKOOEjPebtJkF01LrwKBSpxW8uRE/Y+Bi5mcp91sV6x5Udt58tcg6Tqs
         Rjb1BuRX/ghzVuSL2lrQRsi9XskD0HIA3ruqGK5Ii3vaZvuVwQiw7ssZPIDd/SljlJPp
         Bptatylx4WqjQPNgEsRB+Jjc3auYx6fDrt4w7Gmq4/TQEknXJW/0ij2WJl/UO15Rm38F
         t85RCuftTYH7m3sjutmoED4ttTDPTm0IC0ijG+kdo8Sw+O5PLR1Lzz4AeQGbLCG+2mfp
         qOtJenGJXZGPjYQXdzT0J949a3bNRxud/wfJmwKnPq+ZkEnICu9K78bnlP4bGVrvYDTZ
         Od2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709630862; x=1710235662;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hhP4XU8PPTJplv1l0YzJ9uullD2EJhJdpXiJno/Icvk=;
        b=I0zZyYspXhrJdYwmQGN52tR1vT3eyKC6pj0LVG92ehVSFlRRAFghz1dNVumfb6zrh1
         dTNV83uUXZ1OrE1y7LXhjkuP08Gvxg4wLfyJnOgzGzCtE8+UuNsCTwHyMndDzV2NdeHJ
         aF+mBE3eGiyouAvOewzVC7m8hJRIcDRkO4/mz1Ei1j633kd3ABtLeBRxL5rrSrcofzH/
         YIOVpkvVf6PIaW1AallAYHjcP3mcOeXeVW321JXeoKylUYOIdvpyyf9rHLhVCmkOCTBI
         lbzXa4t6fnmDho2+PGdfV7qiNyTjunmnfeBRkaayGprnCnlt444CnOA5Fs67vAG6wcc2
         miuA==
X-Forwarded-Encrypted: i=1; AJvYcCUnsx/XB7TTAsrHBCXVKrx/cJuOBYL/8Rb9tkFXmJMv3zcFMXi0voT6Bu8aa59/Daw4yii47nBftCa21szMjIE4iCcmwzQYHwyYsJ8sHUTaDLb0flr3pEp8hBXYpWRy0OhxYQ+DjvD7
X-Gm-Message-State: AOJu0YwM7gEFgghHGdj0BrGRzEvSTTDEp/Nt4BUU63eS6R+yoO4uI96z
	+25Bllh9IZXC2IiNpcsjQ6CXHgesEgzb1tw2GQ26Vk1h59X88nWD
X-Google-Smtp-Source: AGHT+IGR1KL13nTmlMI521isttizQfqG/VQ8qF0ECHK2t/qEmkZsDpPCuyUscmFTfM1I8R7HnWlP8Q==
X-Received: by 2002:a05:6a20:42a5:b0:1a1:4697:585e with SMTP id o37-20020a056a2042a500b001a14697585emr1318266pzj.18.1709630861848;
        Tue, 05 Mar 2024 01:27:41 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:863:befc:ec5c:8cb:6f1e:1f69])
        by smtp.gmail.com with ESMTPSA id y16-20020a056a00181000b006e63039486esm1812329pfa.189.2024.03.05.01.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 01:27:41 -0800 (PST)
Message-ID: <65e6e58d.050a0220.6580e.7a57@mx.google.com>
X-Google-Original-Message-ID: <20240103122005.GA3347@francesco-nb> (raw)
From: pratikmanvar09@gmail.com
To: francesco@dolcini.it
Cc: festevam@gmail.com,
	jun.li@nxp.com,
	kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev,
	pratik.manvar@ifm.com,
	pratikmanvar09@gmail.com,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org,
	thierry.reding@gmail.com,
	u.kleine-koenig@pengutronix.de,
	xiaoning.wang@nxp.com
Subject: Re: [PATCH v3] pwm: imx27: workaround of the pwm output bug
Date: Tue,  5 Mar 2024 14:57:29 +0530
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240103110200.1018-1-pratikmanvar09@gmail.com>
References: <20240103122005.GA3347@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Francesco,=0D
=0D
Sorry for the abysmal delay.=0D
Thanks for your review and suggestions.=0D
=0D
>Hello Pratik,=0D
>=0D
>On Wed, Jan 03, 2024 at 04:32:00PM +0530, pratikmanvar09@gmail.com wrote:=
=0D
>> From: Clark Wang <xiaoning.wang@nxp.com>=0D
>> =0D
>> This fixes the pwm output bug when decrease the duty cycle.=0D
>> This is a limited workaround for the PWM IP issue TKT0577206.=0D
>> =0D
>> Root cause:=0D
>> When the SAR FIFO is empty, the new write value will be directly applied=
=0D
>> to SAR even the current period is not over.=0D
>> If the new SAR value is less than the old one, and the counter is=0D
>> greater than the new SAR value, the current period will not filp the=0D
>> level. This will result in a pulse with a duty cycle of 100%.=0D
>> =0D
>> Workaround:=0D
>> Add an old value SAR write before updating the new duty cycle to SAR.=0D
>> This will keep the new value is always in a not empty fifo, and can be=0D
>> wait to update after a period finished.=0D
>> =0D
>> Limitation:=0D
>> This workaround can only solve this issue when the PWM period is longer=
=0D
>> than 2us(or <500KHz).=0D
>> =0D
>> Reviewed-by: Jun Li <jun.li@nxp.com>=0D
>> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>=0D
>> Link: https://github.com/nxp-imx/linux-imx/commit/16181cc4eee61d87cbaba0=
e5a479990507816317=0D
>> Tested-by: Pratik Manvar <pratik.manvar@ifm.com>=0D
>> Signed-off-by: Pratik Manvar <pratik.manvar@ifm.com>=0D
>=0D
>A very similar patch was already send in 2021 [1], did it had review=0D
>comments not addressed? Please have a look.=0D
>=0D
>In general please refrain from sending a new patch version every other=0D
>day, while every Linux kernel subsystem has different rules and a=0D
>difference pace of development, in this specific case sending a v3 just=0D
>adding your signed-off-by without allowing a little bit of time to wait=0D
>for more feedback is just not sane.=0D
Ok, I will keep this in mind. Thanks!=0D
>=0D
>[1] https://lore.kernel.org/all/?q=3Ddfn%3Adrivers%2Fpwm%2Fpwm-imx27.c+AND=
+b%3A%22Clark+Wang%22=0D
Ok, I did not check this. I will look into this. Thanks!=0D
=0D
Thanks & Regards,=0D
Pratik Manvar=

