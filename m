Return-Path: <linux-kernel+bounces-76156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 563DF85F395
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEBDAB2253D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A7236B1B;
	Thu, 22 Feb 2024 08:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J7LYGWGz"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4254C364CF
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592150; cv=none; b=TgsjwMDL69EzXsVakk0n1+RbinmSMq3asAGDSzH0gH9a9FfU3HCfIHCTAVKmK0Js2FTqBsxAst/xYdEjmLBrwG6rdPjqlhfh6lJxiPUrTxTCQ243b/rSSJqb+kja4EJe8wRSauj6ySMhsHowen/5hS0lvfiCPj5U+VjclKnL65A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592150; c=relaxed/simple;
	bh=IcM7smgmshlPZKJJye5knpGquFJahdcma+FIvudzbLo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TDuB1Q7Pz9ppM9Jb8xL5roG+FrHdw6i4Jikz/tEcuumf5DwJCpd9Yv7ckwjhd9oW417kmbqb2bMQ7OlLj/3zFH7Y55mJeslmFoCWUPveVFB+XyTuycEfypmnVVdSKv1UQdHpeey5sMl2gm9q9n4Z3buo7U12thddB75fhUbBKFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J7LYGWGz; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-564fc495d83so1922635a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708592144; x=1709196944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2xIBE07uRp27zY2uDwM2n5My/GljeuLw0Gdcn3yNZg=;
        b=J7LYGWGzChkTsEDAyRh5zEVArOjgduj7Xblqwpx2/8OI5npTNjONesTLZKOcSu63TA
         0XfBLHTiiUT7ih+cF+yBuC9P+g1NYZ7pnx4zcVLk2yFfxjGghWgnufMqmDyW5tSdav1p
         e9Xw55/E1tAMKQah+qHn9BOi8GPdM6Vq4SmxqlDRMEesK74I2lPp4gyrmqx7gffB/Plj
         QhLeEt/3A0pAGujnnr4WITPczze4F8wT+TX+DRkE9kCABIc2C0m1PMuUiS6hD2KS9O9H
         kPCFZQblD8rnTLGV9gJLB2dQO69p/VRXocingKxj4FoPSNxoRCGHJOzw+HU7zq77qf5e
         IUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708592144; x=1709196944;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2xIBE07uRp27zY2uDwM2n5My/GljeuLw0Gdcn3yNZg=;
        b=mgx7X1VIcww+NoaVM8DFqWh8hcdOh/I3McraLiOBM77Bll/LNFuRN/O8zS35fYCfFp
         OLB3LED8P9nrl1ExnWfunwzYo/QFSTtJfOa2v3aeharHQXszws90oHM8EXAXW9yxQDKm
         WLZITovi4KpNn2UZAFliswtTuSdEwb+cyeNayn3/9V551mf7JdUEv3AUqGFuFtFI/fuM
         G0XE28CBowaeheQl0/5xQDTVwh1Ma4gPsI7S6q5gi8brAZBaZawBJ9BELudF29p3k9sn
         BXTMECoFckt5X/VDuaJJwqKGMMo5+OyDYpuS+sUm6L+PhrK0on9hk90JU3gM43CgjsRj
         2S5w==
X-Forwarded-Encrypted: i=1; AJvYcCWo/QxdR8qtbmWpxUBu40cGKP4HwMzkDirWv91o3XOAxQG9cURzpr8ZNw7v0Pj3GCbEpNvi/bjdSEUgdir+Ak9EPImCfCGIA5eHaP+T
X-Gm-Message-State: AOJu0YwItvYy+zqNNlaH5OqS0Jgcvk8bqplaDERQoSYQUIa3O6AvgN6d
	yBd0yWjuu9b+uahVzNthZERBf7HUjqfEXU04Uv0zpEPocYtMU9l6bcCCE2goyF0hMkkZi1igm+X
	Mghg=
X-Google-Smtp-Source: AGHT+IGTBQXFQxIW1xR6WblG6hAs+BpiQfKPcE7mNs9Z7PfdBbyqjaLnHEWt+TEVaqWG2aU8UWq6IQ==
X-Received: by 2002:aa7:d60f:0:b0:565:4bce:db2 with SMTP id c15-20020aa7d60f000000b005654bce0db2mr13728edr.40.1708592143835;
        Thu, 22 Feb 2024 00:55:43 -0800 (PST)
Received: from [127.0.1.1] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id w22-20020aa7dcd6000000b00563918a48cfsm5325808edu.40.2024.02.22.00.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 00:55:43 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Sergei Shtylyov <sergei.shtylyov@gmail.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <263d6626fd4fa51b175b5c7a53e6a363e2c91519.1708354280.git.geert+renesas@glider.be>
References: <263d6626fd4fa51b175b5c7a53e6a363e2c91519.1708354280.git.geert+renesas@glider.be>
Subject: Re: [PATCH] dt-bindings: memory: renesas,rpc-if: Document R-Car
 V4M support
Message-Id: <170859214253.12531.12753169435670805395.b4-ty@linaro.org>
Date: Thu, 22 Feb 2024 09:55:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Mon, 19 Feb 2024 15:52:19 +0100, Geert Uytterhoeven wrote:
> Document support for the SPI Multi I/O Bus Controller (RPC-IF) in the
> Renesas R-Car V4M (R8A779H0) SoC.
> 
> 

Applied, thanks!

[1/1] dt-bindings: memory: renesas,rpc-if: Document R-Car V4M support
      https://git.kernel.org/krzk/linux-mem-ctrl/c/fdb88a1453d212ac52bbacfbaa9a950c626bfd1e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


