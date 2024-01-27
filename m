Return-Path: <linux-kernel+bounces-41175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A434E83ECE8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 12:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8481E1C21810
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 11:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AF7200DB;
	Sat, 27 Jan 2024 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MGQ/xrYc"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A7A1F608
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 11:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706354856; cv=none; b=R57uEpqL8INLj7635Rv/F0tyTXwahM/0Le3txdPini3Swz/kShxx6LwrXCvebiF8uu2roPZLNt1mDTZkxoLV5yv95ElruvjV9wOCv1A37D1iV4Hyic5jIcFDGzgK6HQSu9O6q3d5cxfbe23075FxEhcmZ7eclXq1jgWPdrfDZsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706354856; c=relaxed/simple;
	bh=vK0eqnJKg4J1aQCQzH+8/Z6rONOs/EvbsxZRDKrlQEk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LmmKsh7yV3yFCTeI2nlypEFaVIv6b360lK17K8XNcyPAZEAyC2kjNKrd1TfPmlEpceEDSsyhVj69u9ilCHh16D8SvUN5PF7ymwnFQ+jXbge5+uY1viRPK+mvfMxLJ8TQI9H2idaCF8EyZXA1DxPykHJgYs2LJPGCeYfjLatZCAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MGQ/xrYc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40eacb4bfa0so18633915e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 03:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706354853; x=1706959653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dpM1CkfDH0XB95t4O5VTpTHwxkxhmeZblwS/gZTA+A=;
        b=MGQ/xrYcc0tccIy6OBkCfe6pchSPtKKeZZxMDkMHwwWNr7/sr5hnfh0Cd9vdCBDQBo
         VJYsmbieXKK6MVt9RC7CGOTTLVAk7N8r3cAEKE5JwR0UScfwU9st7lLAAG76nKIYvfld
         Mb2IdtZypIA17kJe+xld05HSWq0Cgo2eeDzOwbB7QaFmaVAcQgXbtZrFPdM1VxIkGuLH
         12LVWGIRrEXWBDUU/RSPCXRTROektcGrYvMQbgOd9DiLQgf3ZbOZpSi/QL/ySXuHxo47
         OCXqr85xhB6TIjFA63/oFaxxHVQ0VzZLwkgy71VeD1MDYqM6G9gxCMyETjBecQOgIsOT
         Wrag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706354853; x=1706959653;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dpM1CkfDH0XB95t4O5VTpTHwxkxhmeZblwS/gZTA+A=;
        b=PBxSb2pZOW9iecSHCPw0e3PlgSwIx/V0xtTlbAGKjrjxmUkm1AEIDepQ+pxvFrBX38
         NffaZciOQVxHdTB7qqTMbQA+S3olWsNycyJPRBtLoG20VhM/RniuIIqS8ZWRhbxNoTOt
         5Q14xTKQtHsitY2hN1YOLPCkpHFHyQGH0BKoInWtSeCsFDjVan09TaawdWIDqRP6HpIF
         POLO2wy6+uIF73PZVsyAQ67rrQLok2sXVoPjFkgQEZUlIjyOu7sjT7UF+NuU5tRB6Uut
         8ZFHQdFWlq8c71sI+gy+Tav4BrzEmomVLeAEE8nt9mQLWDATTCqcJAKBF0a8l5X0MFXr
         s5Cw==
X-Gm-Message-State: AOJu0Yx61eRzuf8ThGPAxmhzPiEpjL99jGq1VVg/gsChjBXnaHrB5hHJ
	e2bSPT5taYnI3HcyWfYcts5vjBf5wNqYvVn+ac/igRkgY671lGgIlzqISOEGGtY=
X-Google-Smtp-Source: AGHT+IEZqYwNJrHEDeaHzZ7naxdfE4X1NGyfJELKrR6djyUokV5E53Zvh98ZWJ9alwwC/brnFRuBtQ==
X-Received: by 2002:a5d:6c63:0:b0:33a:dee8:ac89 with SMTP id r3-20020a5d6c63000000b0033adee8ac89mr1136329wrz.99.1706354852743;
        Sat, 27 Jan 2024 03:27:32 -0800 (PST)
Received: from [172.20.10.4] (82-132-215-85.dab.02.net. [82.132.215.85])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c500600b0040e3488f16dsm4369914wmr.12.2024.01.27.03.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 03:27:31 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240125134645.2549051-1-robh@kernel.org>
References: <20240125134645.2549051-1-robh@kernel.org>
Subject: Re: [PATCH] nvmem: fixed-cell: Simplify nested if/then schema
Message-Id: <170635485051.40968.2673432461747170125.b4-ty@linaro.org>
Date: Sat, 27 Jan 2024 11:27:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Thu, 25 Jan 2024 07:46:44 -0600, Rob Herring wrote:
> There's no reason to have a nested if/then schema as checking for compatible
> being present and containing 'mac-base' can all be done in one 'if' schema.
> 
> 

Applied, thanks!

[1/1] nvmem: fixed-cell: Simplify nested if/then schema
      commit: 290ea1d6f990c92d5ae599554d8acafdd0ddeb2e

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


