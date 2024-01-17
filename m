Return-Path: <linux-kernel+bounces-29552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F3A83101B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071A71F27502
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6678225620;
	Wed, 17 Jan 2024 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GIdPpeZC"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF7E1E888
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 23:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705534730; cv=none; b=Z5toTMxrVamL5DoQa63TWVhZ7/iyXGbuqt/Dg5PW3f60XgzdTmTRwXyJyWPQSXbLBm3GblJZz6469aqslK0qo++5n89oTN45rXdN0he0/t27jZVFo70OXdBUS+cObFiAdTlUJNVSie1L1XEui2EkhY7vjNTmkdfCD3bR7+b2Luo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705534730; c=relaxed/simple;
	bh=pxorCkqOjMFaMYCBfXX/TnrVPiSIpbqSu0NnuqNyQvE=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:Message-ID:Subject:To:Cc:Content-Type;
	b=LrKQwcHVCoAK8PioEiiYIsRXBFl9B7/ytvyXWS3Ll9e3vjiv1G38eo+YrcKT6jvWKZa2xGxGiRK4k2oqKGUGY7/8F6ewQtDQ6j6Ds19mQg4MoKnfitfHVlrsvrAaQQdq4lyuFeyJWCOJYvkKuR5cczZ/R2oBThOt4GPXw6wMQYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GIdPpeZC; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cd33336b32so153789711fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 15:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705534726; x=1706139526; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4iG9VdLGXdpbT4WkWKm7lX68XYJ8nJC5c+vtDz71y3E=;
        b=GIdPpeZCaXcCjGrqlSfvMaZfc8FTUhmk1My9czlvf5KXWoMKSRdatPkW4ZY7J9Zh5y
         ZqYCyxAcwcu3hodV3zisBrpW9nF3Y1FcQhuC+LeHpsrShiqfTTn4tWGR518PJ3v622lG
         VU6vk0uMd9fEI9v4bsDVUVPj46qrYaOxnoqRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705534726; x=1706139526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4iG9VdLGXdpbT4WkWKm7lX68XYJ8nJC5c+vtDz71y3E=;
        b=EEBrpFsWVTu4JP15porfp1545PLPZcN/LAHjGOiqitIGX8PGXhHrJUGeVSUj9CLYDI
         thb7ggv0aRiH1Qjjz6TkXhfOcWrttyfwqPvQP0JL0HMXQeazQYq/lFPKoBG+jQby3V6U
         wlRjKVpeokVEM+ze4ZnJvLH0ENPZxv4vzOkvEJjM11lFIsSnEKQDwXmGmFxku67DdaMZ
         gNbOgTpN+dbyyTHIW40vbM7nXfnmG+WrQok0GuAOqIbej9i14wFEHboyj/TmHIL6RQoR
         bPL2aDqmt7new9ZyIiEj0d2YeyZn0/EI+67/zw2AB7zUqlpShCOLXvkmFXe9l2Ug+1PE
         xUDw==
X-Gm-Message-State: AOJu0Yxa+kiW2BADiCxmj4x4ATs9OpIwfTSwT+sXuI1nu8xjdKAd4pl/
	Ifnylns2xFE6DV1mKfJMpAKSY5CQ3ttfTFNEXLivrxpsGj7IWCazxLp9qVZkqlxhX3ddnBcqKLJ
	2WWpGMg==
X-Google-Smtp-Source: AGHT+IFLePxtzRPBXr8orAdU8RE+eZh7NCMHaysChBRuj2wrc4mDuYn4Q5PPx8M8p1/viLdsl5whHA==
X-Received: by 2002:a2e:3206:0:b0:2cd:a2e:fba6 with SMTP id y6-20020a2e3206000000b002cd0a2efba6mr23974ljy.11.1705534726272;
        Wed, 17 Jan 2024 15:38:46 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id c40-20020a509fab000000b00559e3693226sm1201392edf.36.2024.01.17.15.38.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 15:38:45 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5578485fc0eso10903737a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 15:38:45 -0800 (PST)
X-Received: by 2002:a05:6402:3584:b0:559:ee67:387 with SMTP id
 y4-20020a056402358400b00559ee670387mr40980edc.43.1705534725399; Wed, 17 Jan
 2024 15:38:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116164248.GL1920897@google.com>
In-Reply-To: <20240116164248.GL1920897@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jan 2024 15:38:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiOzXLOB6-k364f3=SfnMMdmxcKU7ipSds_1EvxqqGfJw@mail.gmail.com>
Message-ID: <CAHk-=wiOzXLOB6-k364f3=SfnMMdmxcKU7ipSds_1EvxqqGfJw@mail.gmail.com>
Subject: Re: [GIT PULL] Backlight for v6.8
To: Lee Jones <lee@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jan 2024 at 08:42, Lee Jones <lee@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-6.8

-ENOSUCHTAG.

Did you forget to push out?

                  Linus

