Return-Path: <linux-kernel+bounces-127792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F2789510E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707661C23427
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906E865BAA;
	Tue,  2 Apr 2024 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bl/iffb0"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E443627E2
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055451; cv=none; b=ul/NlpCj6hpVazcvMERJ9eCKEiSMz36GJi5++yt1qYbt5PCsAWW5JZN+23yKtt6OXPG54CqEIIKBE70vvQuhlJpkMCYqK479vJJYf1yzocrJUqiH2H5i1BE7TCYej/x4QlM3MpDL0ArMad+IwDo6PA9giCCUbuapsEZUntiwo1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055451; c=relaxed/simple;
	bh=d0W7s7xEzq40ODWgrd/gyvKQEv+isEPy+Q1IH9uK4tE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b733gUegrPK441iiQMkhwuMNUFlJ/whZ1SA0w3LTIELmHV5KuLDyJNu99iMBpfLn73POoqAXGIgHS4QHTg+k99NA8mjN30tqgGrROkEx5QGMSTRlX875N0rslBBCrvl9commuA6kh7LMtIq8Jxth7h0KtbCbbgyDl9ix3xM1hP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bl/iffb0; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-614769887e6so17936127b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 03:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712055449; x=1712660249; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v5ud0WRFEiUcD7UIgiAFguot1tshhBCNqaEQ95A64vY=;
        b=Bl/iffb0SvBElBl/1KphMhKNwho/zK0tkmV5uxGRj7iPBGQZul38M/4XjZLpGWZ+Nb
         iDJtZAPrje7DaKGyq9N+TcYp7bURVSCVSVNu+TjIAE7g70K3ZKpUrGmZ2a74I6oLWfqe
         VqYjqYnVdfczAb32CHFgfxa9RbAAgzHgRdjBvgLvnvbMY853JxQk1kvpMzBR/+HuP09p
         NSHHPRFD8rwLd4kUh2Kw6QiHf5ZN1ZeD5ik97hmyCF2nA3Zo7/OhNGJ87RzD0urBVbxn
         pM2PjoVD8QHNpSzp6MrcFtI0gBgKY0apPI6puqk0lngKef8eH62aaKqLMRVea3mdHHqf
         rqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712055449; x=1712660249;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v5ud0WRFEiUcD7UIgiAFguot1tshhBCNqaEQ95A64vY=;
        b=oCFfjETcjIcpoEJo4BDLbN1Fd/9jpXZsYRlOJqc96YoxJaVrRsQ9gU1aEk79a5f7eS
         r6hUupmHLjuUFwtBFC6aSKC4k5rKHBVtwd/mkTyyA9TfpEQRGO4w8g7GmlLmZ1WEKGPC
         dOvamXwdqGokxOQTbSbC3Smx9cB8TutrMjrkJ9an5dTDQFvRQGhDB1S2j+I+nS3VExBy
         v9VCOhU+Bj07WQtTw/o/Ie3BafUHRGIIuSuXU67VgJP+X8/5k+a1SWXN3b4SccZur/ng
         OusLiHd7hRWDDD6uhC995kdvSjbGvAzXOFr8E+RADeR9VZUpGwmDh4HwI4MIeUnbkvgs
         NUIw==
X-Forwarded-Encrypted: i=1; AJvYcCW5KnK+s0BCv+zFG9Dq063xTOM/CSb2/n/aom9V8ZrAe1o42FTR9ghziOJXf51s01YbNp1OzBZJbTCyH1o+NXDMwcVR9txJzemXnN0w
X-Gm-Message-State: AOJu0Yz9CBUVC3TmW452NcA+xqr0RJon9I/O6QjI7eBHdc+oY3nR2Lei
	IqZe7BXZEsVCiyj9/oNBwlfRBOyodMXhGu8MGqJDSzMuQBuf4x4DesLXBw87UyZ8YBqsyoCm7aK
	R8wnIOtsv2i1Hs/WS0qGK0UDFqMG3DJvyF5Os3A==
X-Google-Smtp-Source: AGHT+IGarruifddPehjtofjaAlYrasfSCyCAHxLYlqaILPgbiDf3R0LL4s0ZCEXlMQG2/UuAHB0wKSQdufrufErbgeA=
X-Received: by 2002:a0d:cc57:0:b0:615:f9f:7a62 with SMTP id
 o84-20020a0dcc57000000b006150f9f7a62mr1948418ywd.13.1712055449212; Tue, 02
 Apr 2024 03:57:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326094215.212930-1-r.czerwinski@pengutronix.de>
In-Reply-To: <20240326094215.212930-1-r.czerwinski@pengutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 2 Apr 2024 12:56:53 +0200
Message-ID: <CAPDyKFq=bUdEneAqDTx8NkiwUsa_8xLjEOs3kENeipmrRyLqSA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: debugfs: convert permissions to octal
To: Rouven Czerwinski <r.czerwinski@pengutronix.de>
Cc: kernel@pengutronix.de, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Mar 2024 at 10:42, Rouven Czerwinski
<r.czerwinski@pengutronix.de> wrote:
>
> Convert the existing symbolic permissions to the octal presentation as
> this is the preferred representation for debugfs permissions.
>
> Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/debugfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index 1642ea72d22c..6dbab860e453 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -351,11 +351,11 @@ void mmc_add_host_debugfs(struct mmc_host *host)
>         root = debugfs_create_dir(mmc_hostname(host), NULL);
>         host->debugfs_root = root;
>
> -       debugfs_create_file("ios", S_IRUSR, root, host, &mmc_ios_fops);
> +       debugfs_create_file("ios", 0400, root, host, &mmc_ios_fops);
>         debugfs_create_file("caps", 0600, root, &host->caps, &mmc_caps_fops);
>         debugfs_create_file("caps2", 0600, root, &host->caps2,
>                             &mmc_caps2_fops);
> -       debugfs_create_file_unsafe("clock", S_IRUSR | S_IWUSR, root, host,
> +       debugfs_create_file_unsafe("clock", 0600, root, host,
>                                    &mmc_clock_fops);
>
>         debugfs_create_file_unsafe("err_state", 0600, root, host,
> @@ -388,7 +388,7 @@ void mmc_add_card_debugfs(struct mmc_card *card)
>         root = debugfs_create_dir(mmc_card_id(card), host->debugfs_root);
>         card->debugfs_root = root;
>
> -       debugfs_create_x32("state", S_IRUSR, root, &card->state);
> +       debugfs_create_x32("state", 0400, root, &card->state);
>  }
>
>  void mmc_remove_card_debugfs(struct mmc_card *card)
>
> base-commit: 928a87efa42302a23bb9554be081a28058495f22
> --
> 2.44.0
>

