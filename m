Return-Path: <linux-kernel+bounces-129038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC21C896399
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0081C22D12
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 04:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1044596F;
	Wed,  3 Apr 2024 04:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQzf4Kur"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6246AD7;
	Wed,  3 Apr 2024 04:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712119265; cv=none; b=KQPxXqgTCBek+oLExcNSiTmelXJ11xewtjeTy4nFMNE+E+xxKRMkdGlYk3sA/9qTmKw1+RiSDSsKgdLLFU6CQBaCCt8eqYF27biqUr/PenW/hY1QOuPYbbScLvcl9Y6ehV2mqYLrYnfqAM2iua9hzglG+FjhsoxKWliD5ruoEsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712119265; c=relaxed/simple;
	bh=tAUWnoAjK4f4N8u2nRlqABDVBizkq6YQK37LOUpzcxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MfeXnPHmYtJksDRARuIzxW50zLfU0UlVOpGnLWVFe4UXA5Xcikh8HrXKStw0PUeN243sJaYjJoMbegdFha3G1/wLUlWAajJPawrLeZ3kVAdw0DXQQFK35s2581xY3Wd2aLSF/lxCvNk5NZus8xqk/RhkDD1UfSDug28joShmBwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQzf4Kur; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56df8e6a376so1031109a12.0;
        Tue, 02 Apr 2024 21:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712119262; x=1712724062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tAUWnoAjK4f4N8u2nRlqABDVBizkq6YQK37LOUpzcxM=;
        b=OQzf4KurypsqNVIYgsw/xSmlmnDrZbvQfIExXgKnyMnOdx7nqtg+teBj2ETPksUoIP
         qzr0g7fgTt5N1yh8OolaJ2u/Yx73DS5Y/DHHrvTbaG5pCCUHcUE4xAnRgVyyAoQQvOqG
         hgbm1jsTNV0yMEts5RPimRc4kJYbjCFRIARQAFyTiOdf6Fnz08aJ9RUHLmxS0CYcxNeh
         Cv2YsvbOyjza/A35IO408TQXOBbJKNj5syMbpdunpokeI7pGxylz8nY8zipRFiliyBdz
         2AYYqAXHYLpyK9sAXDpIqgPYO2bu8QgjZ5WCKsMB8qCRgt8tHY2ykwrq4AC3PLiL47+3
         uOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712119262; x=1712724062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tAUWnoAjK4f4N8u2nRlqABDVBizkq6YQK37LOUpzcxM=;
        b=r+7KUTfmnS1dT+5/JXASosvsB3dSo00/4GRWjW414OGbHajJsidF2V4/ge27svyrfX
         hc+DLxJfxzOL+DoA/2mGD6H1RygwuvK8FUIZJ5naVra+9Ih3+bdg3qr37lpb8nstmFuA
         YtgGNakTsW0X/tQecRA6pDiRbnuVRkHRdzJAIbQnElYpHYkh6eXhoAbqC+/IIBo5U+o+
         bI4nv1W1jg0kvc3/1nHbRBUO0BwW1YutvmzH/N0g04J1YG0dAAMe+GkmSre5GZjSLaeI
         5JZdX3FEjdYGnmEk1YBRcWknUSW8NwJV7n8evdvx1VdvW7f80NewGO77M0pxEbqxHsgi
         uFQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC0BMrBkedtmA5FBQTyqIkZ0eKz9XBEAsYIco7XLiDjKJpHVUMa5l/qAhKyp5gCJ/6u7XoK955JDxiGntx8CmVv9tWxxpf8t2A5Jxd6S5TSmJclzBsiFTtXnMMFbGTW0Fg4gZHytOtvjMFg64=
X-Gm-Message-State: AOJu0YzbxagdFxEdu4qzDdOyep8wSBKaQ//Iw9aSKleDkydE/Cf/Rnur
	Oat7DnDAWDlqb76AG4jJvgel/P74wCTzygCCWOcKgCbo65Op6nv+
X-Google-Smtp-Source: AGHT+IFoJ2ZN+EBh+8WDL27sAlKM9SycR+TnpzMf5hWL69IYYFEe66Y6nzAwIDJ4LDuPXAQIOLHuRA==
X-Received: by 2002:a50:d59c:0:b0:56d:fbe4:aeba with SMTP id v28-20020a50d59c000000b0056dfbe4aebamr1157828edi.21.1712119261721;
        Tue, 02 Apr 2024 21:41:01 -0700 (PDT)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id e5-20020a056402104500b0056dbd754811sm5250095edu.40.2024.04.02.21.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 21:41:01 -0700 (PDT)
Message-ID: <954572ee-1f8f-43b6-a8b7-93a3608c84d6@gmail.com>
Date: Wed, 3 Apr 2024 06:40:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mt76: mt7603: add debugfs attr for disabling frames
 buffering
Content-Language: en-US
To: Shengyu Qu <wiagn233@outlook.com>, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>
Cc: Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 openwrt-devel@lists.openwrt.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>
References: <20240325223319.30125-1-zajec5@gmail.com>
 <TY3P286MB261180E5A3A3A11351441DEC983E2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <TY3P286MB261180E5A3A3A11351441DEC983E2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2.04.2024 18:54, Shengyu Qu wrote:

 > Maybe we could disable frames buffering by default until it is fixed?

Please check commit description:

"If this solution yields a success we can make this feature disabled by default."


 > Also, maybe we could do more tests on newer models such as mt7986/81 to
 > make this patch benefit more models?

Can you point me to the mt7915 driver buffering code? I clearly missed that.

