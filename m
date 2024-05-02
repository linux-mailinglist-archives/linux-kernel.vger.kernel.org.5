Return-Path: <linux-kernel+bounces-166075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF378B9597
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 302FC2822CD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB042D047;
	Thu,  2 May 2024 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lxbMelP/"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CD8225AE
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 07:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636148; cv=none; b=NbyxfRUfi5sF4NOFMhYr9v5phIxjkQjVWFv9LtbShmz91SRkhFCwnWg3U+Zn9yeykkPBz+cj1TULeLRqh+jdddR5d9V5Etuol0EZUQcqw9hwJa4BUR5lZ5IWDFQ4IAz1RFLboT9GwBRmXLz/nA/g7rJ4PaCPEQjF+jwduzsF37I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636148; c=relaxed/simple;
	bh=LlOCtF6Zb0rLhYKvh8QwXXI7BdM78hneYXaIqDcRnOs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JyciqwXkD5togpFiUrw23JCOqQ4/oQ2Bc+5EVCz+KBLJn1ivOx5fVHe5Ok8NBS4AbkAQtaOVGm9pGIC1DXK7wX7LYya60mFj7SjjFMldm6J8e2/7xurXdqdRFA4TKDnFCSHhWB27Lzk7+Q+ERaFTimel+QvWv0Y1tFGKc9SekB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lxbMelP/; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34dc129accaso1186917f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 00:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714636145; x=1715240945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/L1u1HCFXTpH+7xWuSoYn2EdHiMZmIi7anLXfgHnFc=;
        b=lxbMelP/o83uF/b5h2rjTmZp7PegUj785BONXddTUFXaUJiko9gf3fUoyw5+++BsoU
         VBPoGfSu+FXZ7a9B9VK9yO1H8633WKPu2+s6uvuGR72RMk73t5ibTfgfBubSZuEpe2hj
         j2lWSfIvAHs2YvnB64M9j567LFFTjcFLeOFFNXYnNlIHGb4GueJXLNYUQNeT96KoSqEc
         kq1Lf5tvoECKvpa2ABbT06asQsQUJtiFCKh5Ffl4DrBrlvqWXqGgZOdHJSVaUP3pEUND
         K8f4vuXA3OPwW+PLbgcy13366Gldr59dC58yQ7ZTmZacUcoGTjRQrVgfGjz9nUtxc6aO
         bRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714636145; x=1715240945;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/L1u1HCFXTpH+7xWuSoYn2EdHiMZmIi7anLXfgHnFc=;
        b=CuOjQiwLgw3ltUhoSOmQ6m3UAKCXAiOK2suiFH3LJY9E8seeh/xZUWIIJJlAs2ehhI
         q2MyO02a+rFwxXOWoWQ0KC7QaEo6+6GO0imgcHq4xpZ1CGx8kjA4ywUEbgu9KfO+y61q
         pBDJeIRQmf3s5MaZBQLDhi8y7njpFqaVLh2gBC0KuJGFsufIMHkf8DF3Hfnz70eVOsQB
         w4bLqqEOrpa07ifbFv56xnA0RMODbkPlRJmlBs00OSkgE3kSMyD9kCUKL2RvRboRCEcg
         yrB8ii2aGT/OT1D/a0SQVyxMpGG81yr8wP2qW57KgsCwKnKesRFCxZlOTRp9enJo3LUj
         da6w==
X-Forwarded-Encrypted: i=1; AJvYcCWxHgdNmubirAMWzS2tejBDSAdDkXMLEjBwrvmkfhYFRNGzpRXCQH8vKRdvlC6iyyLU0iQ6tpu+hDtEYwWJ8sBvnVAGTpx0UZ7KHUIs
X-Gm-Message-State: AOJu0Yzq9WizapCfkyZ0DPrRgDf+1s8LBODSMiscQDDe7RyAwEtB/HAq
	Z+asisSRYPhYbFLocK10Rh9eqsgOK/y+KjqLZEHuVybExlMBR60rfbW6ROdOjZ0=
X-Google-Smtp-Source: AGHT+IHa19D/EzuHCiy5xNLJZqU0x22ckGpuvDaNYuQXOsSvZlKDUAvluaUzlaCZBoMWPT95a/ZuKg==
X-Received: by 2002:adf:ff8e:0:b0:34d:369a:5add with SMTP id j14-20020adfff8e000000b0034d369a5addmr760296wrr.71.1714636145096;
        Thu, 02 May 2024 00:49:05 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id dd22-20020a0560001e9600b0034d829982c5sm584827wrb.5.2024.05.02.00.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 00:49:04 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240501052402.806006-1-sui.jingfeng@linux.dev>
References: <20240501052402.806006-1-sui.jingfeng@linux.dev>
Subject: Re: [PATCH v2] drm/panel: ili9341: Remove a superfluous else after
 return
Message-Id: <171463614435.3089805.14133558638178506676.b4-ty@linaro.org>
Date: Thu, 02 May 2024 09:49:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

Hi,

On Wed, 01 May 2024 13:24:02 +0800, Sui Jingfeng wrote:
> Because the else clause after the return clause is not useful, remove it
> to get a better look.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: ili9341: Remove a superfluous else after return
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/e91a36b472862a1d199ea8d1b1ca192a347bf33e

-- 
Neil


