Return-Path: <linux-kernel+bounces-110953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F30A886630
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0BD71C234EB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 05:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0477BA3F;
	Fri, 22 Mar 2024 05:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGUtFSoT"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880343D0A9;
	Fri, 22 Mar 2024 05:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711085381; cv=none; b=XqDyr5BEwE+5ymjtLZWFPvY78MbVlZi0Up6GY72qYLVChpt+1uWn8aXGYPzvRdin5eUIwLcMHuGSitV5hu+KbmoHiQ1DT4KltYb88w3MgKIpeDrzWpii/8VxULjmf1GYnyJfVtUr5GXV+rCS2hJSW+jsjPpa9xhuGAqyFDyK6wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711085381; c=relaxed/simple;
	bh=81cZAtaOWpOYn1E7lQu3xtus81/XyacutkrW0opIIoM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S45MLHv0+WBg98w2kuBS7wl8HR+On4XjuxE6cC10qt9XHSe9FNWMpX9pwF/u+0H8CMd/0kZ6yiTdmKXgHPAH5lS4rQic3U3oJnI3rcZGWVYpa/1m4Z6pmfTDxTAyEpt1OxS5+IviMLRLs7p0S/KHIWUIIILaA9TLjpOP3Aqiupk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGUtFSoT; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e7425a6714so1254138b3a.0;
        Thu, 21 Mar 2024 22:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711085379; x=1711690179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eKuc7rRsF3BVGUdsmkv70uBPAFrZhnJYrr2a7AQjyLM=;
        b=gGUtFSoTvURGs1RFf6ETIvAANg6GAiw6EdQ3EZLGHDbvA7UsR4lihutFF1UIB5eng4
         7tqY9kOA5+0LZfedEgLijWT/ZxWRu4vVTVNL/x9ri03I7lmxVLtSTARnnrkk/zomcLEv
         ZO1bwSwTcjG3GcTJCLdOY4WOgqqN9qs9shom3lTXEypYRllZJTgyElJNjaUrzLPutDbT
         XeGD9psf+UlN1qQmRZxcfNXK2G/L90Ra6a1C5dw5hpNZ3u7Aog6Dk4op1PpXiBfvEi4o
         aveL3zwTf3F6iFYjhSGrKaF91OBHPbZKlsQjt3/Sgxwkpwy554AFp++aqq+6HatKq9ZN
         jYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711085379; x=1711690179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eKuc7rRsF3BVGUdsmkv70uBPAFrZhnJYrr2a7AQjyLM=;
        b=L3lA2R8xIwBKqE+nbrA2lT6RPNs8PephsQ21eLZZcE3LiVWPiClyWSUBiDqdV3Y8fs
         DQ9I6zNMMjBl0nQqxMWWTHNEsveLylq0HQl7AUuDBlheYmn9V1FGaNhvOaLMl+7cccm8
         NhnI3/ZUrzvhk3aqEkdbtSANp/PeRfu2NoqqDX998EYeFxA9Xnf6pckdBSeF1+D04Mqd
         +21Wy/zy3LSoZaN6eA0QY4jMjfNh3g2C0DMPyGNayjVJeq7guiIN+xnFZi7OiSJ3Z5Ni
         YjmXNYyptv/xJmhQYlWfN/yRV/GhL8tQqSDV5Mx8gHq2JTK/KeQHYxPbM2zCXZQ3SOnz
         3YnA==
X-Forwarded-Encrypted: i=1; AJvYcCVC9hoZ8kvBtg+dSYygECJ4yPwLL45fiJY0iol6yShnWjtadD1t8gyqWOZ+S2y93YtfP8MzgkIIYb7DaYZ825kdKpn+PBM6av9qHvzbaYKjLF6Jk9QeEUamhgzFJuHOaOBfYyGZOqYPq+I=
X-Gm-Message-State: AOJu0YxMKuWisH3V2LoRMxmbe0v+IN8izQnKUGnEKBKtFxx8ZOPM+jNE
	olfOcu8iQ0Cm1AKuwV0HAgzqWZR8f4OZtp6E6g1yP3qXgFzvLIKHEEYcQ423izc=
X-Google-Smtp-Source: AGHT+IG1wONfMhDgpNcmYtojN3iaTSokCBfqPYFhCX95UwuPyoVY1kdaKMY2QgMtuma7vNQeBqQ55g==
X-Received: by 2002:a17:902:da83:b0:1dd:9da3:59ff with SMTP id j3-20020a170902da8300b001dd9da359ffmr1946521plx.42.1711085378879;
        Thu, 21 Mar 2024 22:29:38 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.103])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902d38500b001dffa622527sm882978pld.225.2024.03.21.22.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 22:29:38 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	jacob-chen@iotwrt.com,
	ezequiel@vanguardiasur.com.ar,
	mchehab@kernel.org,
	liujianfeng1994@gmail.com,
	sfr@canb.auug.org.au
Subject: [PATCH v1 0/2] media: rockchip: rga: Add rk3568 support
Date: Fri, 22 Mar 2024 13:29:13 +0800
Message-Id: <20240322052915.3507937-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RGA2 on the Rockchip rk3588 is the same core as the RGA2 on the
Rockchip rk3288 and rk3568.

This series adds the necessary device tree binding and node in the device
tree to enable the RGA2 on the Rockchip rk3588.

Tested on rock5b with gstreamer command:
gst-launch-1.0 videotestsrc ! video/x-raw,format=BGRx ! v4l2convert ! xvimagesink

Jianfeng Liu (2):
  dt-bindings: media: rockchip-rga: add rockchip,rk3588-rga
  arm64: dts: rockchip: Add RGA2 support to rk3588

 .../devicetree/bindings/media/rockchip-rga.yaml       |  1 +
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi             | 11 +++++++++++
 2 files changed, 12 insertions(+)

-- 
2.34.1


