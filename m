Return-Path: <linux-kernel+bounces-54759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD43584B348
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9788D282131
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66ABE12EBD4;
	Tue,  6 Feb 2024 11:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y9DR9RcL"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4951EA80
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218332; cv=none; b=DnZW4mftaeDaFYEPR5rNu6ErVuwwc3fbbVYMuAafnlKRyZEYrAa9kwv2veLu/rG2cDppRwRCFnUasW+9slbNE683DitwPAHHWWPGUdZluCPXU6ECZSQ/4GMdh2SLhd8PpZWSUmfXH7jh7+erkKHzZKzqpIEznyIipCbd55sT5OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218332; c=relaxed/simple;
	bh=RAUcQj04TyEXEDqfDrWDiMlYnTPZzSWd7J0PrXfQYhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q6CNX4fERPl0/GEJ5v5sceI6hgzDeAWYMW0pYtdnduJpQKE0FINYZQ3k5uEbsWQoTi1hpuXEB8ZAtYDYH/xsKbxInaPgRsibyYg6iBGn3NXm8w2jfaDzxQwQ7CsjMCm7oWJ3pdrKeTdqdYF6Vc99wQesUO55pRnxLMpUjhmLHEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y9DR9RcL; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6d5206e96so5026444276.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 03:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707218330; x=1707823130; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e345+swzPUmQgd41l0m3kNKJ/xmdbW17sX8/bM58R7U=;
        b=Y9DR9RcLqQquZMzl8oG+qCFOpkWKgKCZWiikR6jOKzHT0OmKaujpl377FvtPE42WhT
         Gj2Nb0qHAUy4L/ovHudsCz1YiH4ECaZoQ059ROUZDbUNkA7u4bw4jjieiRoPhpiezaa2
         cKEt8jdbQXgkIUpXgOoVnSMci9XxjMC49hwiJdmE5BQNpKemXLkOwdTRxJJZ0b26VjH5
         12pXlumv80QUZ3owU4AzbtaUGrJbfACXG0f26o5Wdl/uE6STcYMxVTpJp0S/JKUiK9Dn
         GiR1iOU5kGEGCbyzqKhPAphO8AJY29h4NSowg/FNXAJ+1IzgzOEOKA8tIJh+XLRwRS9C
         +ZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707218330; x=1707823130;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e345+swzPUmQgd41l0m3kNKJ/xmdbW17sX8/bM58R7U=;
        b=XO9Vq1V2/IpBtqTpoD8lHdNp5VoQxQM0Fq1puyuoMh/enbxnroa3YAviGAVaV1WX/2
         NszKg0faoQaAAratZl3XpdXs9Vb240nHWKrpq0a+Oji+b4ga01mFU3zsnn3liqJcZcIx
         1Ebn9oKN3sqDh+5aNkY327mGtkT2Nw1+EKc7/Nx99HLYtOikVY7PjdKCYm2H1nuVxKI5
         tIwNQxlhUOohvPoymi1kGVJvwIs5x76qOYJ1dS1kYYJGU48w5N2+iJ37rK+aAzvr5cjj
         faTUdZL8y37ZX36Cg823s+5YUInP9J0mA9b4asJQ/wpB91v/w1Gw5DKuJbtMgUg628dJ
         Fipw==
X-Gm-Message-State: AOJu0YynLHp6FTTOhFWP3RMPKLSu8S22NlrWtzzE00VabKMbGw9AHf/5
	t35oi2zNAeNufQmcKV2mbS46zosvX1V5VOs4AvtyU/DGM4sUFfZ/9RvMnWA8QgfwqvOXhPNlbEk
	+S8T6RVEPOAKUnzOpQi8MpIObZWE44lTFi75BdA==
X-Google-Smtp-Source: AGHT+IH5fKEJpfHApHOplFSXWwd53luljuax/eSuatIgasfLKxsU+SyYcCYNNtHkP+jet8LCGSrmSvjmsvLU/HM9H40=
X-Received: by 2002:a25:840c:0:b0:dc6:e8b3:9ffd with SMTP id
 u12-20020a25840c000000b00dc6e8b39ffdmr1292874ybk.53.1707218328670; Tue, 06
 Feb 2024 03:18:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205191310.1848561-1-colin.i.king@gmail.com>
In-Reply-To: <20240205191310.1848561-1-colin.i.king@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 6 Feb 2024 12:18:12 +0100
Message-ID: <CAPDyKFosojWAaSWATX6hGh8cJ7yU3zCxheMSiKUsMgJmB1Y-+Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: wbsd: remove redundant assignment to variable id
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Pierre Ossman <pierre@ossman.eu>, linux-mmc@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Feb 2024 at 20:13, Colin Ian King <colin.i.king@gmail.com> wrote:
>
> The variable id is being initialized with a value that is never
> read, it is being re-assigned later on. The initialization is
> redundant and can be removed.
>
> Cleans up clang scan build warning:
> drivers/mmc/host/wbsd.c:1287:4: warning: Value stored to 'id'
> is never read [deadcode.DeadStores]
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/mmc/host/wbsd.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
> index 001a468bc149..f0562f712d98 100644
> --- a/drivers/mmc/host/wbsd.c
> +++ b/drivers/mmc/host/wbsd.c
> @@ -1284,8 +1284,6 @@ static int wbsd_scan(struct wbsd_host *host)
>                         continue;
>
>                 for (j = 0; j < ARRAY_SIZE(unlock_codes); j++) {
> -                       id = 0xFFFF;
> -
>                         host->config = config_ports[i];
>                         host->unlock_code = unlock_codes[j];

A few lines down there is check "if (id != 0xFFFF)". Looks like that
is a redundant check. Would you mind cleaning up that part too, as a
part of the $subject patch?

Kind regards
Uffe

