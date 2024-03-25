Return-Path: <linux-kernel+bounces-116355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A789A8896C9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB54B1C2FF71
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE936CDC5;
	Mon, 25 Mar 2024 04:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/9UWXwB"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D676E5F6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 00:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711326048; cv=none; b=G4zm3SiDeZYk+iNt5KnkLFIrIio+3m/DZm109fYffZD2FXRL11qROQC6ZzY/YmIq3OWb170aDDjW4AdSh/i6BA+Hi3rwIMTBeAwXFcyBvXDi2SRLweM0ZutvDr+M4mN+BbLCuRIs+qwYEJZ2hm4v7Tbdq9EknQE+22T0b4oC3xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711326048; c=relaxed/simple;
	bh=kNPwhbB59dfsjqrBiLb6DyYToWCZBjAxfD5AU1RTERc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jeuCxfgLeKuM2PxnzK37XgesJ8P3dilPtw8oh4drE+oRY75Rwc7s64Rda9ARqqyMkOflmQIrYXBGJCpO9a4dv9nMbkludXK8TGdkeHLA4MLbWsP/Skf5DoXs+jqU54YevFdkYGVUybbHeAJqwjk8LYgi0oGa44PlEMc8C8x0Izs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/9UWXwB; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-690c08a7ff6so11395696d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 17:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711326046; x=1711930846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTU2F5si1/OFdfjv4ATOGTW9TTEuV8rNNpxA0GmfW4s=;
        b=Z/9UWXwB8l/6cQqMgZkzr5k4W9DIJxDvPtNSlN865+Jwav/LqWJywC+8UCVoi9x916
         GokDz5kbe4FHkIytcTk7/TSjCu89oTf0Wak0iw1ggof6AS8Rl3XlasNKKmo0Z1dEXePq
         tr4mxybcDgjQd1nuf3ULNIZORfey4iJEt3wwNQBgplWK/aM/ehHlF3EbgR4yIL6lswbd
         kOhc1KOHfmOEAQol295vPSYJJ58xXHW4zNjZfBCSs9Nb7NmippRuRPStuyVdzH0kGsVA
         xXq3riMNrk0Am4WJa22c3J1Iz9ZTL6uiUx10yTJCGKIvvhYbeV1M4BH/ZTfe50sqfHqS
         bvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711326046; x=1711930846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTU2F5si1/OFdfjv4ATOGTW9TTEuV8rNNpxA0GmfW4s=;
        b=JJUeMNCX7Vl8Wj+KLmRvEmbgHS+a5ynoamaPlLV5b5fppifX7X1DsPynXmD3ihn5R0
         g7tBjXrgvFIExr4qehJ/whQmpUfl1oOuhW3Rw8yewM2/zCJrHMZFm8LxTlACIlOZRdBo
         2X452lMsg/pRTyCfGsu/vHOi7WWg9lMLWm0T1smiThHSmSCVwX7PJQRfLzAeXLmAwlCN
         8fODceE6ikkGEiWDnl7EB2Q0RmEjYhN+QVinMUeGeu0XGXmy15hb+OZboq+kwTeYLuM2
         DKu1rlsLX/AUq2twZSllI7Jku47eyxvUyCd3R4a0XXOf3TwCHdI3atA5HQhfQplpUpsB
         Bw/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqDtuRCQyg6ojEF5cDCaR3SsrE+bBrssmMpZFnLHuZiBSbwmuj3M9KFcKrMC9gKghBbw5G0yERpEqjXkPlXGByaKZW/nGnHtvYB8Jt
X-Gm-Message-State: AOJu0YwB0dBkPvz3WyiULLz9imxIunOBGMaZUErZya8fJ5+0tUxZSy4Y
	7pr/s1Q9xPCSKbiHWfeHMUZPp+lDtwWK3vAxTozfojtc/7uX/sDZ10gkRh5JnZQ=
X-Google-Smtp-Source: AGHT+IHo+rsNfqP8HY2fvRqPpR4JL8hbw89v0TQD9JmTljbeVDrpFeggGwGtqUC3PW68QS3LgOuw+A==
X-Received: by 2002:a05:6214:5d81:b0:696:74cc:646 with SMTP id mf1-20020a0562145d8100b0069674cc0646mr6534841qvb.2.1711326045984;
        Sun, 24 Mar 2024 17:20:45 -0700 (PDT)
Received: from SDF-ThinkCentre-M93p.localdomain (c-76-17-255-148.hsd1.mn.comcast.net. [76.17.255.148])
        by smtp.googlemail.com with ESMTPSA id gf15-20020a056214250f00b006912014b98dsm3497306qvb.129.2024.03.24.17.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 17:20:45 -0700 (PDT)
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
Date: Sun, 24 Mar 2024 19:26:03 -0500
Message-Id: <20240325002603.44157-1-shimmyshai00@gmail.com>
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

Hey Jonathan,

Since I haven't heard a reply from you so far, and I've also done some more
research on the ClockInput options and stuff I'm soon going to ask the
firmware developers to commit the following updated ACPI bindings unless I
get comment there is still something wrong with them. I'm posting about it
here because this is going to have to be the base for any revisions to
these kernel patches I propose later and so I really want to make sure I
get both "sides" of this right (i.e. both the firmware and kernel). If I
don't hear back within a few days I'm going to just send this as-is and
see if it gets accepted by the firmware team.

Note also that the kernel CRU driver currently won't be able to do anything
with all the info in the CRU binding right now, but the UEFI firmware also
pre-initializes the unit so it isn't super necessary I think, I just
thought to add the binding so it can be referenced elsewhere in the tables.
I believe this is the "proper" way from comparing the descriptions of the
ClockInput tag and "clocks" DTB option; the DTB clocks options all
reference the CRU (which makes sense from description of the physical
hardware itself), so I am fairly confident this is "best", but if anyone
objects on this side I still want to hear it as soon as possible.

ACPI binding for the CRU:

  Device (CRU_) {
    /* coining a new _HID is unnecessary so long as compatible string exists */
    Name (_CID, "PRP0001")
    Name (_UID, 0)
    Name (_CCA, 0)

    Method (_CRS, 0x0, Serialized) {
      Name (RBUF, ResourceTemplate() {
        Memory32Fixed (ReadWrite, 0xfd7c0000, 0x5c000)
        ClockInput (1100000000, 1, Hz, Fixed, "CLK0", 0)
        ClockInput (786432000, 1, Hz, Fixed, "CLK1", 0)
        ClockInput (850000000, 1, Hz, Fixed, "CLK2", 0)
        ClockInput (1188000000, 1, Hz, Fixed, "CLK3", 0)
        ClockInput (702000000, 1, Hz, Fixed, "CLK4", 0)
        ClockInput (400000000, 1, Hz, Fixed, "CLK5", 0)
        ClockInput (500000000, 1, Hz, Fixed, "CLK6", 0)
        ClockInput (800000000, 1, Hz, Fixed, "CLK7", 0)
        ClockInput (100000000, 1, Hz, Fixed, "CLK8", 0)
        ClockInput (400000000, 1, Hz, Fixed, "CLK9", 0)
        ClockInput (100000000, 1, Hz, Fixed, "CLKA", 0)
        ClockInput (200000000, 1, Hz, Fixed, "CLKB", 0)
        ClockInput (500000000, 1, Hz, Fixed, "CLKC", 0)
        ClockInput (375000000, 1, Hz, Fixed, "CLKD", 0)
        ClockInput (150000000, 1, Hz, Fixed, "CLKE", 0)
        ClockInput (200000000, 1, Hz, Fixed, "CLKF", 0)
      })
      Return (RBUF)
    }

    Name (_DSD, Package () {
      ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
      Package () {
        Package (2) { "compatible", "rockchip,rk3588-cru" },
      }
    })

    // PLL_PPLL
    Device (CLK0) {
      Name (_ADR, 0x0)
    }
    
    // PLL_AUPLL
    Device (CLK1) {
      Name (_ADR, 0x1)
    }
    
    // PLL_NPLL
    Device (CLK2) {
      Name (_ADR, 0x2)
    }
    
    // PLL_GPLL
    Device (CLK3) {
      Name (_ADR, 0x3)
    }
    
    // ACLK_CENTER_ROOT
    Device (CLK4) {
      Name (_ADR, 0x4)
    }
    
    // HCLK_CENTER_ROOT
    Device (CLK5) {
      Name (_ADR, 0x5)
    }
    
    // ACLK_CENTER_LOW_ROOT
    Device (CLK6) {
      Name (_ADR, 0x6)
    }
    
    // ACLK_TOP_ROOT
    Device (CLK7) {
      Name (_ADR, 0x7)
    }
    
    // PCLK_TOP_ROOT
    Device (CLK8) {
      Name (_ADR, 0x8)
    }
    
    // ACLK_LOW_TOP_ROOT
    Device (CLK9) {
      Name (_ADR, 0x9)
    }
    
    // PCLK_PMU0_ROOT
    Device (CLKA) {
      Name (_ADR, 0xa)
    }
    
    // HCLK_PMU_CM0_ROOT
    Device (CLKB) {
      Name (_ADR, 0xb)
    }
    
    // ACLK_VOP
    Device (CLKC) {
      Name (_ADR, 0xc)
    }
    
    // ACLK_BUS_ROOT
    Device (CLKD) {
      Name (_ADR, 0xd)
    }
    
    // CLK_150M_SRC
    Device (CLKE) {
      Name (_ADR, 0xe)
    }
    
    // CLK_GPU
    Device (CLKF) {
      Name (_ADR, 0xf)
    }
  }
  
ACPI bindings for I2C (I2C1 as example):

  Device (I2C1) {
    Name (_HID, "RKCP3001")
    /* _CID is no longer required */
    Name (_UID, 1)
    Name (_CCA, 0)

    Method (_CRS, 0x0, Serialized) {
      Name (RBUF, ResourceTemplate() {
        Memory32Fixed (ReadWrite, 0xfea90000, 0x1000)
        Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { 350 }
        ClockInput (198000000, 1, Hz, Fixed, "\_SB_.CRU_", PCLK_I2C1)
        ClockInput (198000000, 1, Hz, Fixed, "\_SB_.CRU_", BCLK_I2C1)
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
  }

---
Shimmy


