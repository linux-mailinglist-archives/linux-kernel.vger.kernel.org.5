Return-Path: <linux-kernel+bounces-61632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B298514BA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1377F1C21B65
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CBF3FB29;
	Mon, 12 Feb 2024 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qrqViZLi"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943AC3F9E6
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743659; cv=none; b=oy8UGoSKLEcM0KSQYc71WNY7as41QTvs7XhqpQcl6zklBbELrTZqYUBDMZKBBqg8uod2LniPHRR6jELdo+JMxtvq8ViYnpujrmuPLe1rD4nr3nCaNGLmLnJDTLvugXV4Iex4JY+dZE42W8BP2OuGOPkRk2gIiAfxTC6QxumG9xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743659; c=relaxed/simple;
	bh=JSAWGIZBNCAZSWbCjPYZeQI/FYDdaMk1VJYHwKb53zs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=h3Hpa+Pcwe8nSbKcxHeL7rWmbmMQm6i3F88H/evMrD31JEQKrTJ7iu1lNFRicTHYdPTKW7OlnBHVI2FOfY42CFFNoq9ukrReK058oOWs+a1tsKydM1WDJHz0vEh6bGYEsYw/otx5RIIt19agZCCMVdYGqTJVWlm7fMaledmSr0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qrqViZLi; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso4864210276.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707743656; x=1708348456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kvuLvApdM/ZlGaK4NZuFt8gRWwgyTlGJWJvpEXVTb1w=;
        b=qrqViZLizdf0aql/k5PcPKn8ORvJ/+FSAIqs6eRLaRQkbEWsMnwesFc05DXnMomrqN
         laYghTiRnmMOv5Wnn2xG7XsNa2rD4FX+b6QhiIgnK27ccPXQ9f4gmn5YBkuJxP59Cr7+
         iWXIij8WbEwDyQPUbVh/HF6WAip+9MXLO6Zm1xzGsAgeOVRC+OWu6mpkEsWwxyJlAoxu
         mDRBvzKfwcg01c0hcDSIunAvthrNGesWdCL/ZvBHVmSCR2WhqDc1Pla5ntrFNX4KoJ+N
         OdsIZrzlXJ09GpbwwKNT1xLtmB53RoD5frXE7/VkH64gnM+T94Th9jOXgMniT30z2v8X
         duWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707743656; x=1708348456;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvuLvApdM/ZlGaK4NZuFt8gRWwgyTlGJWJvpEXVTb1w=;
        b=DxRTicKb6jR9ki/FfpxNlgcq6eRt4FtqdUQO4gXn1loztFZxkjQfifeGbiNtQ9wstE
         DwDAqRQir5+98ALd1TIrSk7/lq8gKI4g4PAlacjTb7Tl7L53Qvw0Gh6oPktRitUdmXfQ
         KfSx/9V2RLOAcCXkY02pyisGuz4JxxUgE0KWu/BMWfN7dlYaQp/IFMzEFQ6UUB8w13yb
         1Isb1c/9OOlaQDrsbIlxZMPeT23H2707o2trUpGteqruU2/jlQpfcMglV+zjBo0mmiPc
         8PQKL+Ic04voG378zHvwAEqafpuXQKYvasHehRbw+qqKWf+gmrr1YPN7myGXaFNupZF9
         cOwA==
X-Forwarded-Encrypted: i=1; AJvYcCX9RRN0gsRw0rtCjOKrRSK7UUfaKoDyn0LBO3uT0TwB4lbuPTJ/Jgdj1twBT0FIw/zJx67ovAWsaFZs+5XoSbfPFK/QOhTvNIYoVl6W
X-Gm-Message-State: AOJu0Yz+MXfXYGiLjb34cBfMLh4QUjoEFmbMerRF+tuwWNam85O3lskG
	l63MmgAxJBfJMIjZJFnGMWjQdzfhqEhhinZx7WQSr8s0X+9HKWrGLiFuygEGLfJk/Kk7WXUrU6q
	hAJOssmX+vQ==
X-Google-Smtp-Source: AGHT+IFr9+EiSzPAdqxdDrunMziFdLc97Szl2+/YcVLrl65gByrGUTWmItIayvjwjfIhJaI2on5s096RjZxdJg==
X-Received: from szatan.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2d83])
 (user=panikiel job=sendgmr) by 2002:a05:6902:120c:b0:dc6:e5d3:5f03 with SMTP
 id s12-20020a056902120c00b00dc6e5d35f03mr1820499ybu.4.1707743656565; Mon, 12
 Feb 2024 05:14:16 -0800 (PST)
Date: Mon, 12 Feb 2024 13:13:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212131323.2162161-1-panikiel@google.com>
Subject: [PATCH 0/9] Add Chameleon v3 video support
From: "=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
To: airlied@gmail.com, akpm@linux-foundation.org, conor+dt@kernel.org, 
	daniel@ffwll.ch, dinguyen@kernel.org, hverkuil-cisco@xs4all.nl, 
	krzysztof.kozlowski+dt@linaro.org, maarten.lankhorst@linux.intel.com, 
	mchehab@kernel.org, mripard@kernel.org, robh+dt@kernel.org, 
	tzimmermann@suse.de
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	chromeos-krk-upstreaming@google.com, ribalda@chromium.org, 
	"=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Google Chameleon v3 is a testing device capable of emulating multiple
DisplayPort monitors, used for testing purposes.  It is based on an Arria
10 SoCFPGA.  This patchset adds V4L2 drivers for two IP blocks used in
the device's FPGA: the Chameleon v3 framebuffer, and the Intel DisplayPort
RX IP.  The former is a video capture device that takes video signal and
writes frames into memory, which can be later processed by userspace.
The latter is a DisplayPort receiver IP from Intel, its datasheet can
be found at:
https://www.intel.com/programmable/technical-pdfs/683273.pdf

The framebuffer driver is a regular v4l2 capture device driver, while
the DP RX driver is a v4l2 subdevice driver. In order to avoid code
duplication, some parts of the DisplayPort code from the DRM subsystem
were put into headers usable by the DP RX driver. Apart from that, the
patchset adds a new callback to the internal v4l2 subdevice API to allow
querying the dv timings of individual video streams of the DP receiver.

Pawe=C5=82 Anikiel (9):
  media: v4l2-subdev: Add a pad variant of .query_dv_timings()
  media: Add Chameleon v3 framebuffer driver
  drm/dp_mst: Move DRM-independent structures to separate header
  lib: Move DisplayPort CRC functions to common lib
  drm/display: Add mask definitions for DP_PAYLOAD_ALLOCATE_* registers
  media: intel: Add Displayport RX IP driver
  media: dt-bindings: Add Chameleon v3 framebuffer
  media: dt-bindings: Add Intel Displayport RX IP
  ARM: dts: chameleonv3: Add video device nodes

 .../bindings/media/google,chv3-fb.yaml        |   77 +
 .../devicetree/bindings/media/intel,dprx.yaml |  125 +
 .../socfpga/socfpga_arria10_chameleonv3.dts   |  130 +
 drivers/gpu/drm/display/Kconfig               |    1 +
 drivers/gpu/drm/display/drm_dp_mst_topology.c |   76 +-
 drivers/media/platform/Kconfig                |    1 +
 drivers/media/platform/Makefile               |    1 +
 drivers/media/platform/google/Kconfig         |    3 +
 drivers/media/platform/google/Makefile        |    2 +
 .../media/platform/google/chameleonv3/Kconfig |   13 +
 .../platform/google/chameleonv3/Makefile      |    3 +
 .../platform/google/chameleonv3/chv3-fb.c     |  897 +++++++
 drivers/media/platform/intel/Kconfig          |   12 +
 drivers/media/platform/intel/Makefile         |    1 +
 drivers/media/platform/intel/intel-dprx.c     | 2171 +++++++++++++++++
 drivers/media/v4l2-core/v4l2-subdev.c         |   11 +
 include/drm/display/drm_dp.h                  |    9 +-
 include/drm/display/drm_dp_mst.h              |  238 ++
 include/drm/display/drm_dp_mst_helper.h       |  232 +-
 include/linux/crc-dp.h                        |   10 +
 include/media/v4l2-subdev.h                   |    5 +
 lib/Kconfig                                   |    8 +
 lib/Makefile                                  |    1 +
 lib/crc-dp.c                                  |   78 +
 24 files changed, 3801 insertions(+), 304 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/google,chv3-fb.=
yaml
 create mode 100644 Documentation/devicetree/bindings/media/intel,dprx.yaml
 create mode 100644 drivers/media/platform/google/Kconfig
 create mode 100644 drivers/media/platform/google/Makefile
 create mode 100644 drivers/media/platform/google/chameleonv3/Kconfig
 create mode 100644 drivers/media/platform/google/chameleonv3/Makefile
 create mode 100644 drivers/media/platform/google/chameleonv3/chv3-fb.c
 create mode 100644 drivers/media/platform/intel/intel-dprx.c
 create mode 100644 include/drm/display/drm_dp_mst.h
 create mode 100644 include/linux/crc-dp.h
 create mode 100644 lib/crc-dp.c

--=20
2.43.0.687.g38aa6559b0-goog


