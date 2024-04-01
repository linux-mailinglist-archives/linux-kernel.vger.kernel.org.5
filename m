Return-Path: <linux-kernel+bounces-126997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE96894593
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18731F21D8C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B5F535C4;
	Mon,  1 Apr 2024 19:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Y2IiX8A5"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B84120304
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712000381; cv=none; b=B7OC7MnPK6q9abz9cLnAX3klW9nzBE6sdGrdtNcDj92KiJqiI+JWtngRTShBZWTcnO1zVHlwtPQC8p6oR5GTtSa3fFuwB3QCEHv58hRHZT1lYG9ZjD4Bo6iZo6ni3knBcAyEZ/j1Bok13wqVIiOAouB5OJWf91iRGAj49STMDNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712000381; c=relaxed/simple;
	bh=LskxEzdqiK7UJEs0HwcKgs9F4ApVVJrqCgN0+VDPHSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AqZpac/o5TWeqIjSdjyjVK2a6vVKSl8iXrtwIKANWZ5u+5yiMHHXQNNB5zQLQ4kZfK2szaGMgNHQfvONUtPcNOplWXuG3hx/6U/aBvtDFYEubc+Ks8cNbhrpd654kaJ9YbXgFB/v0nS9N1LzHA4vaxItH89FEolTxwbMezlUWoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Y2IiX8A5; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d094bc2244so47871391fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 12:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712000378; x=1712605178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LskxEzdqiK7UJEs0HwcKgs9F4ApVVJrqCgN0+VDPHSw=;
        b=Y2IiX8A55LdPNCYAIU3Rbq0GaQsq3BwCyGtA4Qadedy7IVYW8Eb4vLl7jwTM8G8xTW
         qKMSiGA19KWnE1lzF2q9xJYf4IhEpTCYRxZJK7cp9XCoo1I3AvE3/CZpZyC4tqiMJOce
         Qt+PQU+WjkmLDL9DNLsWAiKniAMCVWQqFtJJ8GQFoUJTuEPhMcazO3MuBnhoQdh1qumb
         KCUaOjL5T5o+lY0XJvE7iYzpDUou4oNAUtmTlpBX3/mUpbnaO9jEy2KTDesoREjxfivs
         bOGaYuR2JYJIbBHqcBt7pKAPJAFfaUB/hK2TwOqra3Y+WDjsA7RoTOLcZdAdJwK/jFna
         FyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712000378; x=1712605178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LskxEzdqiK7UJEs0HwcKgs9F4ApVVJrqCgN0+VDPHSw=;
        b=fcXtLTpW+/XgjmPCS438neOjsQnbez+U0/hl0mZ0wsqDuXzWa7n4ZG9AcECV8gKDLl
         TLL7kbn9v4xmxPzSM1WIT/XslSvB241Iq+PVKJYKLDrRE273Tz/GOETDC3MqU5DZgwi+
         7loewu0pRvEBVVkx6v5czTQOc14T4RiGI2fPtocHcR+TbFLFR0LsfDZgqN0n1Qvnxfhf
         LI6oTDHf81yS5LOQS85tig/+oFDRqbBbSYpS10uFzr/byRnyzANRE70d7UC8lD1/mDLx
         5fUVLlGYv8l0fMRUlAXlEL8AUw4/aTUULwMDRy0BP2rtEXrLBmbSYDxuJC5lAeUJ2EqA
         c+lQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUwakXWZqlp2UT6jPA2H1fwgXOHVndQzt36Pqp7yY6M7dFY5qj2jhJ8lrq9N4HU6/vgKSlqFoehObt14xFQdoQuxb5+H9a1M8s60r2
X-Gm-Message-State: AOJu0YzCBpYoj9CixupPMTOMIfPB7hgofOWgBWNgKJVNxBmtMIF88b7T
	5E7cbE7mQmh574nxj7upMZO80LOQdnyZYWigWaR4jjfNwdD7EDSRAD2ux8caqyjJjxsNQKXZN8O
	LgwAo8Xa09rwWIkO2reYUv/ftuYcjCoudlq7umQ==
X-Google-Smtp-Source: AGHT+IEO8zJ8rv0MhPzignDlPzaz635H7qKxQfMLwxc/lKvYLJz6e8GZV+puDbUt2GN15bbO2cyTz2xS1jBwdL7Wo8U=
X-Received: by 2002:a2e:3209:0:b0:2d6:c2dc:3396 with SMTP id
 y9-20020a2e3209000000b002d6c2dc3396mr5979861ljy.30.1712000377759; Mon, 01 Apr
 2024 12:39:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com> <20240401-ad4111-v1-3-34618a9cc502@analog.com>
In-Reply-To: <20240401-ad4111-v1-3-34618a9cc502@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 1 Apr 2024 14:39:26 -0500
Message-ID: <CAMknhBHo3xkkZymVfvauL7nBPn9+c1ZUoPwyk4mJO4syRJEhiQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] iio: adc: ad7173: refactor channel configuration parsing
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 10:10=E2=80=AFAM Dumitru Ceclan via B4 Relay
<devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
>
> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>
> Move configurations regarding number of channels from
> *_fw_parse_device_config to *_fw_parse_channel_config.
>
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---

Commit messages need to explain _why_ the change is being made [1]. It
is not obvious to me why this needs to be moved.

[1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html=
#the-canonical-patch-format

