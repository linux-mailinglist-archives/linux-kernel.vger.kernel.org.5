Return-Path: <linux-kernel+bounces-75008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B00285E16C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6121C24495
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024DD80BE4;
	Wed, 21 Feb 2024 15:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EnMRUP10"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0037F47A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529886; cv=none; b=HL4nM6UstBZQzyyFMoJ3a4rRocEY9kNggc4CXSIYt3tT0QsvyGh8oOJTUkA+BQRxknynrdEW3TdInINL3rZpH3uk2oLPtmoL3XRf8PjQN57TmUPN2arlczQJAgYaV98uumZoz+28NR/w2UShRbQTw7zxFygygiSf8TkrCUGiUUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529886; c=relaxed/simple;
	bh=grCOSi8XLFLNaMwkvCBLU81kgrXCuEK7+6nsE0tIJwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mLZl/hFbQDvbsDHkapyZFrMt5hTmWrXLgGDJWHVhbyEh2vauBQx1Gh7eZiDh7hvADukJASipyGCSw1UhOaBMDyAh/KmIYxNzQeSptvX/3EeCDNBgmiLeLWsMBXSomkqgpt1kod8tFWZ5PhbUysXMuzL/7NVrUvF6BwkLb45D9AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EnMRUP10; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-59f7d59d3f1so355583eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708529884; x=1709134684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEHN5AeQw8GvEzpiKivhi/yJeQapwymDAxDl0UXRrHY=;
        b=EnMRUP10tj4gX39sl5/sdn49FmzXvoX2UP0BbEP0GMvc9LCGsBlilOaTp0aoKcujqZ
         FqLNxXj/GmXhlUh13/wNZpsFCXCyp8aNCuUE6GBE2In26ltDatXBYJ7AVOa5F9ZOA1SU
         jCVYztHu6ij7bLLNEsylbmk1BgEwtSpr7J9UE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708529884; x=1709134684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEHN5AeQw8GvEzpiKivhi/yJeQapwymDAxDl0UXRrHY=;
        b=U/eJxjx6DAlozyIL7XG+vpTNctAigSNkYhbSM//FE0gIdGVXJLl/ecJPV27AWZzgGi
         Uv1LmvTPu9gplHY7/k77jIleAxKEKJfBMZ6mHTn+H+F6QVNyTQsMe1Z5bzoJiA9VoTBr
         qElqCkbz9JjqraSnPzvNiXt5ewolSkD9zxWs2qfL+NC3ogGZugfAK4z7fok6M0/WwpOr
         wntKq2Uk5Q2r+rsa/Rnn7m9gzBFvi2nX3LgwdibCq+7iVg99352MCgDZE9OPnVkWwiSP
         CWiAEMRtvFoYbbFZk5hP72iNiE6g2XuReuPB9uso2Xovyilusr2HMv9wSKaayE3mpUXn
         wKGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXd0JxxHUv0EPKl/+rFNPITWc46GuqEGEX9IJMmeBHKeLaDxb04f63eNpyJIWIUtBPjF/daZovkuB8Y3kgChu5FLmCx06Uzs0rYmd6V
X-Gm-Message-State: AOJu0YxFBkFbMQ4nAwrl23odYCzIJ6zh2Fp9347guKW/y49O1qLoRkcr
	KiSf2ro+wNA1skUPqB53c5M18gGUIonvlapDJTn+Jxy7AUi3ZmO6UgCrL8FpnQE3MThTD1SDM5v
	fcJ835+hiO86p9vZdB8L1x2CL8Y1ItF01lqSv
X-Google-Smtp-Source: AGHT+IEChvW8BSTbCSiTLMx41zznTkN+GvBMzZXbANOmOD7tZt6WMkfBtn5etm2aIN7Reqjdjh6UJ1h4VL7WfSOjNEc=
X-Received: by 2002:a4a:b78b:0:b0:59f:8466:5748 with SMTP id
 a11-20020a4ab78b000000b0059f84665748mr16124819oop.0.1708529883981; Wed, 21
 Feb 2024 07:38:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214170720.v1.1.Ic3de2566a7fd3de8501b2f18afa9f94eadb2df0a@changeid>
 <87jzn0ofdb.wl-tiwai@suse.de> <235ab5aa-90a4-4dd7-b2c6-70469605bcfb@suse.cz>
 <CAG-rBihs_xMKb3wrMO1+-+p4fowP9oy1pa_OTkfxBzPUVOZF+g@mail.gmail.com> <87le7e6um3.wl-tiwai@suse.de>
In-Reply-To: <87le7e6um3.wl-tiwai@suse.de>
From: Sven van Ashbrook <svenva@chromium.org>
Date: Wed, 21 Feb 2024 10:37:53 -0500
Message-ID: <CAG-rBigASZpsxEpjUnCWYpfmjuyJTQ44AXBr90fYbQWvit_YXA@mail.gmail.com>
Subject: Re: Stall at page allocations with __GFP_RETRY_MAYFAIL (Re: [PATCH
 v1] ALSA: memalloc: Fix indefinite hang in non-iommu case)
To: Takashi Iwai <tiwai@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>, Karthikeyan Ramasubramanian <kramasub@chromium.org>, 
	LKML <linux-kernel@vger.kernel.org>, Brian Geffon <bgeffon@google.com>, 
	stable@vger.kernel.org, Curtis Malainey <cujomalainey@chromium.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Wed, Feb 21, 2024 at 4:21=E2=80=AFAM Takashi Iwai <tiwai@suse.de> wrote:
>
> Both look like the code path via async PM resume.
> Were both from the runtime PM resume? Or the system resume?

The large firmware allocation that triggers the stall happens in
runtime resume.

This means runtime resume and system resume are affected.

Due to the way runtime PM works, the system suspend path is also affected.
Because system suspend first wakes up any runtime suspended devices,
before executing their system suspend callback.

So we get:
system active, SOF runtime suspended (audio not active)
  -> system suspend request
    -> calls SOF runtime resume callback (stall happens here)
    -> calls SOF system suspend callback

