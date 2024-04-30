Return-Path: <linux-kernel+bounces-163268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA0B8B6801
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958AF1C21FD6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AD6DDA1;
	Tue, 30 Apr 2024 02:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckAE7q91"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009EA8BF0;
	Tue, 30 Apr 2024 02:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714444836; cv=none; b=KPUm4dImDTgK1Nze7K8gF3C8CKxp/EUn0UWLyfduaNRPuD2vahNfdffRRovlkj6wIlVajd1rMurIWIsobIz3dCcVpByUcArdVMRYnv1A3/g91mffbio58TXOPKTzp33HJhlFZwkhWshGvVfzEDnMjj0P/8n6T7MToEJyhCSrsFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714444836; c=relaxed/simple;
	bh=V+BIjUiYOCcEwN69Co+s6BOhtm9QYzyaY1P9x36j10g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CZiRi9Y1xhhIqaRU+SMglb8Ks177R9N7+Abs6bpreUrQ9c7gRnrf/M6srDh1HZPfqx5N40ymGwX2y8F8NHOrLZHk7xsEcZT/pxpY2BVuAmgUolBt5zKTjqMTsXvxBV1X+33rLsimJRST/wJqb+aFagAMyfUncgVqWPXe7T4rmhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckAE7q91; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso3665319a12.2;
        Mon, 29 Apr 2024 19:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714444834; x=1715049634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sW8wTvn689x/3NF6m1acLAgYnG3AFU0fUmh1MuYjwa0=;
        b=ckAE7q91IfzrN70d6LiK7org9WJGLKvjajs3CUkuJp2Cu9R9dvBzXfJpxQhkrBXEQg
         +8vjvKaudu1CysIq9mQu9OfXzx7fCVnAi/ohh0YADMsn6d+OzPMhETN9kvGMM9hP6Kt6
         dgoM4QgNrgA8+5sF4EdG21LvG4KWuhoIDVFAAXb7eTanybvVKkuHE8yRGfe6qZJbzOll
         Oa6dPyUR0hWjiWum+BICU1b06BpBS73DY0xMOvu/fdC9iZNYdoI3BrLLg/kO0wwxMzzc
         WrPvYoF29lMhsfbvfWTiJEwtaarXk6zvichhgiPjONis0N/+O54WlUNpuilS4qbjNdxp
         eSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714444834; x=1715049634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sW8wTvn689x/3NF6m1acLAgYnG3AFU0fUmh1MuYjwa0=;
        b=goEsG2gUBQz55j2vMBGsmmzgxLo9zaNtYG0qZbAEbQ86HZdh9/x4uKprbMGnzfY5g/
         QlKjLTlu0DN0JzySUQt1EnHpmbeJmwaglUJoOfnkvLsl5ZJw1WmnzEOB87548FceV1le
         66MEmZ+HZHtLAz4pd0TIGIL5iDuzZ3YtDvPz3mWmaV9lhUnaDnnL0JH5nfWzZ//hQRc5
         xawCUft/uVgKsYuTRcKA81+3PyLpn+XiWN8MHBfWpE1qHbbboOqDiStWeOc7BcWleFiF
         M2Cfb8U3vM7lYwnA3GwVZ3zh4930iEMEImptfz1tM6rXi3MsF0CHahZnHEXDIl5XOCf5
         t2Bg==
X-Forwarded-Encrypted: i=1; AJvYcCU2EYI6QTxUAL4L/9nvaI37JeSvP9KXQMrDZM3SZz5jqHkctPeCUprnTvikjyDuYtDt/+EaDWUEGd3iPLqAQ8Xq/6iOIhJh75pQnMlqNp+Ls7c53i2q7LLX976K1lq4diNHHGCpzo4h2Q==
X-Gm-Message-State: AOJu0YychkdOQQYaEtKaNTsti6Ujwi8gukUrKEznQm/fXr7sYAMizbmJ
	WvaFGc4OEN3rRBbBr8wApVt2cvMTv6rblyKUrjF5V+9IYmYsfNw8STv1SEiH8SA=
X-Google-Smtp-Source: AGHT+IGQ/U4aomSuAFTFW8a1DiWeeFc6BiBlthAINUNDuett4xlAUBHOZ+zlA9EnnefZijQ2Xnwbnw==
X-Received: by 2002:a05:6a20:2a1e:b0:1a7:94ea:a9b4 with SMTP id e30-20020a056a202a1e00b001a794eaa9b4mr10919673pzh.32.1714444833844;
        Mon, 29 Apr 2024 19:40:33 -0700 (PDT)
Received: from toyko-2.5 ([45.32.55.39])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ec8c00b001eac94472f6sm8400379plg.93.2024.04.29.19.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 19:40:33 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ezequiel@vanguardiasur.com.ar,
	p.zabel@pengutronix.de,
	mchehab@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	sebastian.reichel@collabora.com,
	liujianfeng1994@gmail.com,
	sfr@canb.auug.org.au,
	sigmaris@gmail.com,
	nicolas@ndufresne.ca,
	linkmauve@linkmauve.fr
Subject: [PATCH v7 0/2] Add hantro g1 video decoder support for RK3588
Date: Tue, 30 Apr 2024 10:40:00 +0800
Message-Id: <20240430024002.708227-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the v7 version of this series adding hantro g1 video decoder
support for RK3588.

RK3588 has Hantro G1 video decoder known as VDPU121 in TRM of RK3588 which
is capable to decode MPEG2/H.264/VP8 up to 1920x1088. This vpu ip is also
found in RK3568.

Test results from fluster can be found from thread of v3[1].

Changes in v7:
 - Change compatible string from vdpu121 to vpu121 to match the real
   hardware
 - Change the devicetree node vdpu_mmu to vpu_mmu because this mmu is
   also used by vepu121 jpeg encoder
 - Link to v6: https://lore.kernel.org/all/20240418111002.83015-1-liujianfeng1994@gmail.com/

Changes in v6:
 - Apply dt-bindings first
 - Collect missing commit tags of old versions
 - Specify the base commit suggested by Diederik
 - Link to v5: https://lore.kernel.org/all/20240413064608.788561-1-liujianfeng1994@gmail.com/

Changes in v5:
 - Add missing interrupt-names to devicetree node
 - Rebase devicetree patch based on next-20240412
 - Link to v4: https://lore.kernel.org/all/20240316071100.2419369-1-liujianfeng1994@gmail.com/

Changes in v4:
 - Change compatible string to rockchip,rk3588-vdpu121
 - Link to v3: https://lore.kernel.org/all/20231231151112.3994194-1-liujianfeng1994@gmail.com/

Changes in v3:
 - Drop code in hantro_drv.c because hantro g1 vpu in rk3588 is compatible
with the one in rk3568, only adding devicetree node should work.
 - Change devicetree node name to video-codec@fdb50000 to match the reg
address.
 - Add dt-bindings rockchip,rk3588-vpu compatible with rockchip,rk3568-vpu
 - Link to v2: https://lore.kernel.org/all/20231228131617.3411561-1-liujianfeng1994@gmail.com

Changes in v2:
- Fix alphabetical order in patch1 and patch3
- Sort device tree node by bus-address
- Drop rk3588_vpu_variant fron v1 because that is exactly the same as rk3568_vpu_variant
- Link to v1: https://lore.kernel.org/all/20231227173911.3295410-1-liujianfeng1994@gmail.com

[1]https://lore.kernel.org/all/20240118080602.9028-1-liujianfeng1994@gmail.com/

Jianfeng Liu (2):
  dt-bindings: media: rockchip-vpu: Add rk3588 vpu121 compatible string
  arm64: dts: rockchip: Add Hantro G1 VPU support for RK3588

 .../bindings/media/rockchip-vpu.yaml          |  3 +++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 21 +++++++++++++++++++
 2 files changed, 24 insertions(+)


base-commit: b0a2c79c6f3590b74742cbbc76687014d47972d8
--
2.34.1


