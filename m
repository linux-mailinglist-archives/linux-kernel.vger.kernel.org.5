Return-Path: <linux-kernel+bounces-23975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C2F82B4B7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45F12851C3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F89953E09;
	Thu, 11 Jan 2024 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TB6mkpFY"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0CB54BC1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d542701796so30732355ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704997336; x=1705602136; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JeadZqWdYA2IdNebxsMHN/uo6ca7gtVrMgXVKsPep7I=;
        b=TB6mkpFYsvXO+6SBUiGal4UiJh0evVOU7VGc1YhpeOa6vKnd41YAHiUZZheaWbdeDu
         npuORxcmrvm7brKS7IItuIWq18YLkbR9gWbJWVTiQR0ljJpqBnAeZ5KmQ/5NS377/5II
         dIyRjEW38kQMJ/pbbb5NJNQ/iabiCHLRD2IH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704997336; x=1705602136;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JeadZqWdYA2IdNebxsMHN/uo6ca7gtVrMgXVKsPep7I=;
        b=qCZ1fNUrAEV8sbLxrt7iL1Ca53waZ92blN9+pjIZTppUKHULFHYav2yT8hcBDwvjPg
         tH0HUKJPJCLr4yKtSi2yROXUxlwPlsl66sDQ9hI7UujjuSgOMSggQ2aTxfDpYjhCfw0e
         Oc1wSRg5VNPrnY+S7cyvfznCyEu2cjEqBsC+a5bpa927bsju+oi2pyhDSAgjdGUv+d9a
         USR3YcybHFDhscoXykAybRF/NpBbbLuKrwil+V0CsmMBY7PuU343qI4jcybi+fuUtN2F
         lLFqO/Zk0WDB/k8AQs2u0/wom1LJDF0/hRiwpBiWoUa/Sa1AZWmOSBxEIRVSlt2IpCDk
         b+2w==
X-Gm-Message-State: AOJu0YyhCnPK+lsIZHyEJ36PaiG7jWgxcajdrWgZoLvPdmSHPI/nB4AR
	T9nACMbCnn4yXmrm+0RXB50BSqOHoyaw
X-Google-Smtp-Source: AGHT+IGJus0nMPPM5qaBgzEokOZ4WJgh5X3X1XXPJH9f0UmpJ1F92TRiupCulmhnjeX3fscv1OnoMw==
X-Received: by 2002:a17:902:f7cd:b0:1d4:2473:e833 with SMTP id h13-20020a170902f7cd00b001d42473e833mr147873plw.69.1704997335994;
        Thu, 11 Jan 2024 10:22:15 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kj16-20020a17090306d000b001d4301325a6sm1463892plb.247.2024.01.11.10.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 10:22:15 -0800 (PST)
Date: Thu, 11 Jan 2024 10:22:14 -0800
From: Kees Cook <keescook@chromium.org>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Tony Luck <tony.luck@intel.com>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pstore/ram: Register to module device table
Message-ID: <202401111021.AA9C35CD87@keescook>
References: <20240110210600.787703-1-nfraprado@collabora.com>
 <20240110210600.787703-2-nfraprado@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240110210600.787703-2-nfraprado@collabora.com>

On Wed, Jan 10, 2024 at 06:05:02PM -0300, Nícolas F. R. A. Prado wrote:
> Register the compatible for this module on the module device table so
> it can be automatically loaded when a matching DT node is present,
> allowing logging of panics and oopses without any intervention.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Ah-ha! Yeah, good idea.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

