Return-Path: <linux-kernel+bounces-116902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5115E88A4AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E4A2E68C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DDA19068D;
	Mon, 25 Mar 2024 11:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ubO3c8P0"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465CD1AD555
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711364325; cv=none; b=lUXqHAwFZtarFhCGAJs3wMHtr0RcJc9XIbP0zstVjA9Q3cguxmDVy05mZrovXGNHkmVDZxpG+3hTXIIKMjh2J41IVEGJtvKOu4nNx15gTzJVqiQmqTQd6giL5jdthwfmTFxOpAHiojBHFh20hmCaWzmM/ITbF+RMLU1SqWGigtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711364325; c=relaxed/simple;
	bh=XL25HA/rMlyrHNwpF1lAFH+pCOsV21peUzjqYOvTZl8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MteEySt2t7WU9qMEfzwfhBnXlrd2CN5QgsHbLlH5lqjlErwTYdzuXAgSRtVk7ixUqG5xug84hO3HNwge5HS6ycW+Lhctqk64O2Wt3VJwC9PwCPgevuCb8ipzGifZxwCW35VjcHiJQRMVeD9uuG6Yai8QeTVaP8PacMrdgGlmtQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ubO3c8P0; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so548616766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711364321; x=1711969121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+JNuKywlvftNSqF5b7Cj7QzF+9URkW2/+w38BGlUpg=;
        b=ubO3c8P0QQ515B+i28nRNAd09dhgCOo+ohLNR6cnWEkz5F7iTr5KXs/X543YjtJ343
         deEss0Y2kwq6zp7LvJvEvbAX9nmCpldkYcb6+EKl6SYOvgrO6GWc5DTI4wedeA4eO+Vi
         joQsjqTVWS2Z2U0xCGPrS5t6z6pnTQcw9X8o8Be9IG1bMjmDW8UKS9/q7nRYwwNbWOgm
         5+k+2Ez04oaCdD3kzZKjYH+u3sCF1eOWnH3VqprJhg6sZbAJe8Ul20/WrAePGLRhFHAR
         Zf8j82dDCkIQNYBYnB/RUbFfqdN5MRZtSetGQpgEzAP5XSi8yjIBoXcbyzd/DzU2tzi3
         UOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711364321; x=1711969121;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+JNuKywlvftNSqF5b7Cj7QzF+9URkW2/+w38BGlUpg=;
        b=oYczPLA4vukbK0lC6DucR1W1iep/iER+jCW++ly3HRbqhZDkX6WyYX8hwBbk3JAeu3
         gebghEiHb7jVL6JUoYUajX92bWzvJLH2lq4jsGWAYa7mGlS9q4xHqsJQnDF91FLcaUFS
         srgOC9OXf95hI0uEXQmwJzQRpUT78P/mjezITmb+0MaDUSQsEn+QR+Mhq1Z3e/0/s8Vs
         TIr+9vSaKYEljSsnNwbKe5KOh4C2LA69puS2ZrJL46ohZDj35nM5FopDSb0dfNbL5x12
         TBNTbyXY4Avbmgl/c5JcyDzcLM3+NwYJ18m1r56cGu/GAcOYGwSV1q2YtWN0AS987tsC
         1vgg==
X-Forwarded-Encrypted: i=1; AJvYcCU3G2RP3/XurWbPmxrD7adJu7rupivLay58wT5b0E2QCPj1qNqAZAinGMWLke2hgt+l22vHV82Jtk20tgdhBbPnA0a2tsjdgQLjAXNz
X-Gm-Message-State: AOJu0YwxSWkPO+RBhb+nw7O7oN/0B84FCQ934RQPkbL/Ia0ZbTMquXia
	DWX4TUE2BkDIOPodpGYVHXpk04Tcp9PEgmKOwFWDe9/eLzEM3zqFzZZ4yayK3Ygngp1Z+4TQXAT
	e
X-Google-Smtp-Source: AGHT+IGRdluR+ctpxxP9cfjdQCuYGJCipeL0daH2dPwa0geRThKN5t2BbwP0SMuxIbKj6UiewWaR8g==
X-Received: by 2002:a17:907:7283:b0:a47:4c82:edb2 with SMTP id dt3-20020a170907728300b00a474c82edb2mr3384870ejc.5.1711364321216;
        Mon, 25 Mar 2024 03:58:41 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id i1-20020a170906a28100b00a4668970f74sm2935707ejz.108.2024.03.25.03.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:58:40 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240312164428.692552-1-krzysztof.kozlowski@linaro.org>
References: <20240312164428.692552-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: pinctrl: samsung: drop unused header with
 register constants
Message-Id: <171136432013.35586.992518195753048545.b4-ty@linaro.org>
Date: Mon, 25 Mar 2024 11:58:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 12 Mar 2024 17:44:28 +0100, Krzysztof Kozlowski wrote:
> The bindings header for Samsung pin controller DTS pin values (holding
> register values in fact) was deprecated in v6.1 kernel in
> commit 9d9292576810 ("dt-bindings: pinctrl: samsung: deprecate header
> with register constants").  This was enough of time for users to switch
> to in-DTS headers, so drop the bindings header.
> 
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: pinctrl: samsung: drop unused header with register constants
      https://git.kernel.org/pinctrl/samsung/c/4184e4912ca69d4f18a800144539af3b37c6a663

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


