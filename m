Return-Path: <linux-kernel+bounces-111718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA73886FF4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 530C02852D1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A2156B6C;
	Fri, 22 Mar 2024 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bz3+/dDi"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7C656763
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122404; cv=none; b=M56hkV9eF5ZFWV0g5hWRM8YrocrMD58qJRyTA4wFc0TtRH2z3mxShpigi2DaRxlqd7Rb+qTo3pM1He8TG7f+ztIeSGjEAERwKKIs9GVgYcqGmKxNvJefQNHXlAsGQTp5FM9yEvJ5PUS+FZHkeL4LyQGtLuam62kMnlvNp6SAu7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122404; c=relaxed/simple;
	bh=GWiquWv5BJsZVf3ZW6VcRvKycvRpOApOWriPmdrub6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fEANBm9O59zVK6B43meADEMAuG5WiT63akxPVm9XxS43AJFyInQcBnC0Km2ZPK7DZ+VCW30npD9gFMUYpaoH3qyPwP0BPwtvCqTaUS/T6/N8oDFvmg35pybJ0n1hq2UKa/AhXJHQzI0KlQm+geVSUMMmGa8KuOOS1Ej30Xyz9IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bz3+/dDi; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a4e0859b65so311284eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711122402; x=1711727202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96lv65PomJczPVcbCEzC4lSgtrlAVKdXmUyJYVWOjwA=;
        b=Bz3+/dDiOjbWvrg9NW1mH6fyOZFbO3kq6w00UZxoqC8WcPa+hNU5H65H0ZxkNiDAax
         DZvizfENKCN08JPTdxLWXMNyPdOV42JdLo5GF3TgD7LkB4GMzAvmCFw2Gu8LgK3/+8cl
         HL6kETrid4Oh/En5s3/cTDFvxlcpD3gTBp9qeAKrKv1ExYU46JmF1KSQ7I1NhY2HiLYt
         /ZDb+YV1qcLVvb5d8//rfkSzazBiJYwH+DzvunyqJ1KjzSAz+J4wyEeb013oOHnUv3+l
         EEB/aaN31sTvBEfX2N/RDrQzvidMXlT6xER7o7yCoOOq3EdOSrz737XaCIsu2mUEFpoL
         kbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711122402; x=1711727202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96lv65PomJczPVcbCEzC4lSgtrlAVKdXmUyJYVWOjwA=;
        b=D85Iydw/UMganXXTtyrMfiYA/fYCGqyPSWjm0ZPPO5WKbKsUbo8alhoU6jGno2LZnF
         MJgz93gyGymRrLlEzNDhATGhQl8LxTNBvmNg4xraczIqXvECOFoBbLuTsJqClobxqo+k
         1933LLmyaPqkzNjD7HXex44W2xgkJZ1NlXRHY9wAn0UmUtvKzkzjyblBTU7gO9m1Mgli
         WHtVYcblPDUnDaTZRzdU2EGgo2W22BP6KyKlDTRpsr0yHs26BP8j4eJ4WQ2tbLu7xxAU
         txUGerAhkQsLBBMEiUXr19XdkQo7W/d8/5lLdi3uN10GoDHszBT6LAzX+0J1C6h5IGVw
         F3Eg==
X-Forwarded-Encrypted: i=1; AJvYcCX7qBa70+7d2iC9Q91aDg32574MCvgEGrvrTTyQfUSMU1eTJkBXHrb25tNlwPjRc0rbi0SmkKnrXIJF3VExAp9O3UoD82V2APJRuesw
X-Gm-Message-State: AOJu0YytqoBCM6rxTYMXVTp5Su7crAtiJGVxRP6cokdeEM2iPPPUSaaL
	DUVo+A4t5bPrA2p+gwImo0HrT87jr2zUyfHnaHXAXogk5rjtru5i
X-Google-Smtp-Source: AGHT+IEv9ZxKcchGYyFvYPBWCNnIlMIW7NCeS2Ho7P/n+lG0Zf7uCRvbt7IEmfN0wg3auiwaxWph5g==
X-Received: by 2002:a05:6808:158c:b0:3c3:b109:4e9e with SMTP id t12-20020a056808158c00b003c3b1094e9emr54438oiw.5.1711122401778;
        Fri, 22 Mar 2024 08:46:41 -0700 (PDT)
Received: from SDF-ThinkCentre-M93p.localdomain (c-76-17-255-148.hsd1.mn.comcast.net. [76.17.255.148])
        by smtp.googlemail.com with ESMTPSA id ff19-20020a05622a4d9300b004312563cbb0sm971950qtb.83.2024.03.22.08.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 08:46:41 -0700 (PDT)
From: Shimrra Shai <shimmyshai00@gmail.com>
To: jonathan.cameron@huawei.com
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	max.schwarz@online.de,
	niyas.sait@huawei.com,
	shimmyshai00@gmail.com
Subject: Re: Re: [PATCH 0/0] (proposed?) Add ACPI binding to Rockchip RK3xxx I2C bus
Date: Fri, 22 Mar 2024 10:51:46 -0500
Message-Id: <20240322155146.22755-1-shimmyshai00@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240322103521.00001a12@Huawei.com>
References: <20240322103521.00001a12@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

For

> It would be good to highlight in this description what is missing for
> doing a standard ACPI binding and not using any specific hacks in the
> driver (get clocks as normal etc).
> 
> There are ACPI clock bindings, but Linux doesn't support the yet (I think?)
> See ACPICA commit
> https://github.com/acpica/acpica/commit/661feab5ee01a34af95a389a18c82e79f1aba05a
> 
> I've seen prototype code but was a while back.  I'd like to see that
> work compled rather than having every driver need to paper over the hole.
> 
> The alias is a different question that needs to be addressed.
> If this is a common pattern, push it up in to the i2c core, not
> a specific driver.  I see there is already code related to that
> in i2c_add_adapter - that just wants an ACPI option.
> 
> Jonathan

and

> That implies that the kernel can cope with the device tree wrapped up in
> ACPI path.  If that's the case, why do you need RKCP3001 as you can
> match on the compatible?

This was all based on how the people working on the firmware project wrote
the ACPI binding. That said, since I've got a foot in it too I can 
definitely submit them an updated binding. The binding for the I2C in the
project looks like this:

  Device (I2C1) {
    Name (_HID, "RKCP3001")
    Name (_CID, "PRP0001")
    Name (_UID, 1)
    Name (_CCA, 0)

    Method (_CRS, 0x0, Serialized) {
      Name (RBUF, ResourceTemplate() {
        Memory32Fixed (ReadWrite, 0xfea90000, 0x1000)
        Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { 350 }
      })
      Return (RBUF)
    }
    Name (_DSD, Package () {
      ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
      Package () {
        Package (2) { "i2c,clk-rate", 198000000 },
        Package (2) { "rockchip,bclk", 198000000 },
        Package (2) { "#address-cells", 1 },
        Package (2) { "#size-cells", 0 },
      }
    })
  }
  
(there are others, e.g. I2C2, I2C3, etc. one for each I2C bus, with
correspondingly different _UID and some different numbers for interrupts
etc.)

From what I'm gathering from reading the documentation at
https://uefi.org/specs/ACPI/6.5/19_ASL_Reference.html
which is admittedly quite terse and doesn't provide nearly enough examples
for my liking, and given I have not been able to find a "in the wild" ACPI
using ClockInput, I presume a better binding would be like this, correct?:

  Device (I2C1) {
    Name (_HID, "RKCP3001")
    /* _CID is gone now because we are no longer assuming mirror of DT */
    Name (_UID, 1)
    Name (_CCA, 0)

    Method (_CRS, 0x0, Serialized) {
      Name (RBUF, ResourceTemplate() {
        Memory32Fixed (ReadWrite, 0xfea90000, 0x1000)
        Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { 350 }
        ClockInput (198000000, 1, Hz, Fixed, "PCLK", 0)
        ClockInput (198000000, 1, Hz, Fixed, "BCLK", 0)
      })
      Return (RBUF)
    }
    Name (_DSD, Package () {
      ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
      Package () {
        Package (2) { "#address-cells", 1 },
        Package (2) { "#size-cells", 0 },
      }
    })

    Device (PCLK) {
      Name (_ADR, 0x0)
    }

    Device (BCLK) {
      Name (_ADR, 0x1)
    }
  }

Note now I added two device nodes for the clocks and use ClockInput to
describe the frequencies. I'm unsure though about the device node part,
however; I know that the .DTB has a central node for the CRU (the actual
clock generator on the RK3588), so should we instead have a top-level
Device node "CRU_" and reference the ClockInputs to that, e.g. something
like

        ClockInput (198000000, 1, Hz, Fixed, "CRU_", I2C1_PCLK)
        ClockInput (198000000, 1, Hz, Fixed, "CRU_", I2C1_BCLK)

? (Note the obvious analogy to rk3588s.dtsi for the labels, which would be
#defined constants.) Though in this case I'd ask if someone here would be
kind enough to supply the structure for the top-level CRU binding so that I
don't have to guess the "best" form for the kernel like the makers of the
firmware were doing which is what led to this disagreement in the first
place.

FWIW, I'd also be willing to help lend a hand to finish out the support for
the ClockInput binding in the ACPI reader subsystem. There already seems to
be some support, e.g. in drivers/acpi/acpica/rsinfo.c and a few other
places, but I'm not sure what else is needed to get it going and would need
to study that subsystem in much more depth.

- Shimmy


