Return-Path: <linux-kernel+bounces-41180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7878B83ECFA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 12:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70A2AB226E6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 11:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225D02030A;
	Sat, 27 Jan 2024 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gaqxik0r"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1DE1F605
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 11:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706356307; cv=none; b=by0tgK7Qr4HqUQkQ7uJuAkyyRePRdHJlU4+CuF7pQ/4N3eVuj5WpFtTjiVAbh+19qDR/rX/6BJaxZ8h0mqSeLmFPgsBVfLXSNBGVlKNNFEy7LY7lMknRjjD13JWx9/Wdj/MZxuCxjWkuUeYEesGkYXLcgbcrl/yZy6suw+idy10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706356307; c=relaxed/simple;
	bh=s7sbFD5rK68sTinN2sHMpOlyPBNLIyDeSR6rna9Gosk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WAv/OxQqzYUCJQ3gzotow+y1LNf2uuSuFWSXm+JCHvKheGuWF9xhZImY5KYF3ecBO8ohW+wC9RmtNLHBKCJvfVD0eOPyqeYxBJsxUq/c83DYUiQ2g+SAiXzOy8H+hbLL+oaCntnNYA7JMCK/TqcAW6s7p4m2CMzmO5ppfBGWXls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gaqxik0r; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-337d05b8942so1508372f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 03:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706356304; x=1706961104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7CPKaI879w3EsoHAHrSNs9w8/YFZ73Teg43RHZbluc=;
        b=gaqxik0r7Ve/pAM9C4KFP2wRwQFvXVFfcERWRDsIshiq/RMWVKXHLmbfhn2upMqVUF
         dUsEQ4pZYB1iG0Zq8qbTzahOPEzzxziUNjD0T/4S0/UNoEyYE3r7xJy+MRACy0OtFp0I
         PYnFrLAxV/QhjEo5689ZzJmfbB8QdAqw2MMJn+kscO6VgHwedx9ezAvM0oeE6jPZo28y
         /YYLe9UR5NX2YyLEy80jqT0IJRomN1V/JmkNhpQeVvrWziaWXARfJvdtBmiDiRVTvBW5
         20ep1DqCm6IM9F1kEP6WdGAqgCXEBKBKvViiSd/6AUXLBGoyL3rmua9R+sSGjhNmrruX
         3O5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706356304; x=1706961104;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7CPKaI879w3EsoHAHrSNs9w8/YFZ73Teg43RHZbluc=;
        b=m8H8zVQkQeAygW5WS2EEcja+wKcMlaOXeMHUssnFMqlRzjkQeTfjVcs+Sb/OvrGQEM
         VKDdKAxUc9IoqB8JhqhmpSbhCBvWbd5MfJUbhOBo5WaZ+y5m4s9YTDQ41LrzGtKjWSTx
         aYL8tNAXtvLzI4gO5qYjzOQO7Ma8eDoj6YOE16vl8OBLFh234ZSFQCWdNaueYIMVONx6
         nm4hpdrwK96cqILw15CW0Dg5MCSH1J4ld6MxsMeo3uk2Fass1NA1sOdpGG3EN0MKnoNL
         Vz/QT9B0vEfaqju8MsIGwnZ4jK1UYnd5kYZx0MeDWdnjvsaGonBo+oqsIyKJ8vRAqxuT
         MdJQ==
X-Gm-Message-State: AOJu0Yz5t1Clu1tH3N364tyCbcZG1eoJX2+cg78um31Cio5vr/dr+y4i
	3/q1c38SAv/gz/yfXZOlcmAZdQJiXxYi5SE6aZQvpKvV4Lsc4Y5dqfHoa7QYzj8=
X-Google-Smtp-Source: AGHT+IFzjyK4rw6VpR9KhpvPkJZXlDlVtk6r4JDfcEtmA1SSjPihQXOdh7a1z/38+yU92cgQZk+k8Q==
X-Received: by 2002:a5d:4c87:0:b0:337:c642:7acf with SMTP id z7-20020a5d4c87000000b00337c6427acfmr817854wrs.108.1706356304031;
        Sat, 27 Jan 2024 03:51:44 -0800 (PST)
Received: from [172.20.10.4] (82-132-215-85.dab.02.net. [82.132.215.85])
        by smtp.gmail.com with ESMTPSA id ba15-20020a0560001c0f00b0033ae54cdd97sm765295wrb.100.2024.01.27.03.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 03:51:43 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Michael Walle <michael@walle.cc>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
In-Reply-To: <20240109213739.558287-1-krzysztof.kozlowski@linaro.org>
References: <20240109213739.558287-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: nvmem: add common definition of
 nvmem-cell-cells
Message-Id: <170635630286.41579.13272488705212256827.b4-ty@linaro.org>
Date: Sat, 27 Jan 2024 11:51:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Tue, 09 Jan 2024 22:37:39 +0100, Krzysztof Kozlowski wrote:
> Linux kernel NVMEM consumer bindings define phandle to NVMEM cells
> ("nvmem-cells"), thus we also want the common definition of property
> defining number of cells encoding that specifier, so the
> 
> 

Applied, thanks!

[1/1] dt-bindings: nvmem: add common definition of nvmem-cell-cells
      commit: c0e855d525b771e6fef67c7b75657380c9e02c31

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


