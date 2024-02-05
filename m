Return-Path: <linux-kernel+bounces-52628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A75849AA3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE8D1C21DFD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C8E1BC5E;
	Mon,  5 Feb 2024 12:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QsFq9+aY"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D691CD01
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137078; cv=none; b=r37bzuDyxYv9oUDStcGBKVraigFEEXdCDgIuxU0I6/BPbqHQoO6ZV65Mrb5aSp7OuYGepdmMW51VVSeytaSIdaM4zXivMsE7QlpU33k51ls0YhhUrYpJ9OeNBfvSPvRExG5bw9eKDH7ONYoaggMPRu7Kq7IXrenLPchehCRPK5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137078; c=relaxed/simple;
	bh=2LucDbaKWnc43eYl6V2+NFUWC00In0EAYHQmGvq+4OE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gIIRF1oQYXKi8+wEW5gbACATJeqfC1rRCHoyqWT6fL8LeWa5Y6WpB4MAB2RLjvziCR0F1ewBYVf4XrAz8l01smRZpj9XtD03REOduAjSsEpK9Htd3AgayNZ/jZGkSVd2P4gYJxsCxifNYwZpB4RP0xMdtoAjyD9giBTsbe0SRV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QsFq9+aY; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5600c43caddso2271093a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 04:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707137074; x=1707741874; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G4Vl82m2zEorDZ7pWMk9i0Xlp64g/8z9zNmyXXlM3Ww=;
        b=QsFq9+aYmq8eoNC+vBZJUfqY3wHp2qxaDBzJO2GTqVezsx/mYHUouoAwYbLEar77SB
         NKyIcRqzIsYBDJb8orbHAGgc2gXtD1GlkanV65kGe000pzbVOPkrWcq/oLMo1+4/DKpM
         pL6nHJN5gAhFg/R4WO2kE/wL9NYmgqYGjUA8uaK75CYmiQ0saAZpQqlz72uhf77ZBzm4
         Vi5a/OnJW6H84c6SxlWfBHhkCOoWM/57Voo0y4xABziRcyiL1rEm40/utuWildNb8mvv
         fPlUNEoM+J3XzJ90QEFp7NuTXsRlleEcE/526m8vyaMsa7CmTFPaJ+QBTkamFAv4Ua/B
         bNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137074; x=1707741874;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G4Vl82m2zEorDZ7pWMk9i0Xlp64g/8z9zNmyXXlM3Ww=;
        b=qN9cl/KVL32huHOh79wBz9lUuqZTM3uHMQD1vcNkFTfaZYQfIT4lS/fewCg6XKWjQe
         62zjhQOrr2xu8lQ5sPC9Y2z3DpiKbq5yh5mj3eTs5/smb/U8Nt0KV/GfWoNDCkqzesDc
         KF5WRlxsLjVKKuG0TsndKxPCwjedTqvHcQfNcqLokX0L3QVJw5G0eyQNfZCdnHZRSUTe
         mpnBIUyPOMG0J3Ru12drtOgVQdaxZ+mMgpRcz0ANcgKPrOkmKDdMALoAghs/0bVTrV9x
         GE2C52cbsWF4uZ4jiiQYT6adMibZtpCv6vsJBX+JHCUdiNy9hZcizZZ4vFzW91tYgfLa
         xigQ==
X-Gm-Message-State: AOJu0YxDgfE4FxJ4V796mSxyNvLFYLO9vcBmvRZbH3/voHRTXbvAoHQ2
	i40/H75spAeTquoVrclFx8o/sIwOC0hoidcV8witVTaNS4zb9J2tiK65++2Kkd0=
X-Google-Smtp-Source: AGHT+IFcCBosTBE78GusQ6RADTjnIHb6MB9A+FrK1+MA3FZHOcbc8Iblcq/I7+Slr1+SiFtgUSoo3g==
X-Received: by 2002:a17:906:7853:b0:a31:4e96:f40a with SMTP id p19-20020a170906785300b00a314e96f40amr7218077ejm.26.1707137074271;
        Mon, 05 Feb 2024 04:44:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW4WiNmIJTwOQBdIusFKWvbUqNu81vffJtRd1DoC8f/9LiqEWIS+V1mSm6nQfEhW2qzARfp0/POzL6npsKHd4796GaGtgSCgHsBz0U9VlZ+EXQIo/iGEct5EQS4b/XYC3ioesFeptDuF6egOuCSjybk/ot9TKooH4FYvAnK1K5nFyTCNePDxDUQlTi4OkRPT9IUM6z9teerFQfOWaZ6fVMa6NJN7RDxeS5/J6mEW8oQHi9myZFSZjVF1/XrmkCdjuNUYFhngJlFP9pLH30RQgQpM//LR7gFDCmsY2O0NuXClfBWn53ENpktlgzxg4hFCOrHzb1cSQgX0jCHn6f2FhdaMt9h9sQMr8Pql2NoAf77yWtbPNmgUU5PVO5VpEPJKXSwJuOB91nHnHgNzhVYJyP/nrS/dkPlJmOUh72rKCfPFtdJ
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id th7-20020a1709078e0700b00a3742b09617sm3102294ejc.182.2024.02.05.04.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:44:33 -0800 (PST)
Date: Mon, 5 Feb 2024 15:44:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: James Schulman <james.schulman@cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ASoC: cs35l56: fix reversed if statement in
 cs35l56_dspwait_asp1tx_put()
Message-ID: <0c254c07-d1c0-4a5c-a22b-7e135cab032c@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

It looks like the "!" character was added accidentally.  The
regmap_update_bits_check() function is normally going to succeed.  This
means the rest of the function is unreachable and we don't handle the
situation where "changed" is true correctly.

Fixes: 07f7d6e7a124 ("ASoC: cs35l56: Fix for initializing ASP1 mixer registers")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From static analysis and review, not tested.
---
 sound/soc/codecs/cs35l56.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index c23e29da4cfb..ebed5ab1245b 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -115,7 +115,7 @@ static int cs35l56_dspwait_asp1tx_put(struct snd_kcontrol *kcontrol,
 
 	ret = regmap_update_bits_check(cs35l56->base.regmap, addr,
 				       CS35L56_ASP_TXn_SRC_MASK, val, &changed);
-	if (!ret)
+	if (ret)
 		return ret;
 
 	if (changed)
-- 
2.43.0


