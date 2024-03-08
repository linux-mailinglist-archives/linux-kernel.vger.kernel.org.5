Return-Path: <linux-kernel+bounces-97306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65676876887
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9635F1C22430
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F772E41F;
	Fri,  8 Mar 2024 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAMODvIO"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45C55A10F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 16:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709915380; cv=none; b=L7+SAW2nl9pexSR1TXncdu9bC9u7Bju92op/WQBG9OB0kcRfIv5CDUUrhzf6QTHaje/X47VwuE6ltft0ol+gmQeJR4RddpIQbQn6uLmYl/fq1lbxg9zlt749haBQcJHb8sem5Zgju5XWdrU2p6PZwrRfY4h1SviStgAefDL4XGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709915380; c=relaxed/simple;
	bh=3K2dyY59QMbK45K27keA2V/f+oNgDgMOvqb1BGWGMic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxSD5bZs/vDIzT2O/NtX6Hob3SveWXIL0nLpgQHezPyZ+d4V2+T6PR1a1p94KPGc3Z8X5wkmLjNTkEd3c1LROBOM0hwwU7PZ4W5eopkvRHnKy1xZgu45DhpQ8BmjS+qagKUVupJNsj86BJgEXxK9X0YUWaOHu5YVHQ/A40bNZx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAMODvIO; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a45bdf6e9c2so277803266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 08:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709915377; x=1710520177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3K2dyY59QMbK45K27keA2V/f+oNgDgMOvqb1BGWGMic=;
        b=lAMODvIOeP7MTndoE/hGdTYfbiAW4Ydf7tBvV7u7Bys88LrvRzeSTn/7qFqSDWyFTg
         1SaCJkoG+BzGLo4YkSo5XOCiAKbXlE0LR7X4xZzcz5ZnTFSle1scjh+ZrsuCzUmhq6+w
         pmge55oNEYdSfpmEPfmbCp8CUsYxVXNn8Mqb4g44PKYe43HRsNfc2xScPV05IGw/LY4l
         YHl665Y07D9AWN6ItM8qivFrGFpIngJZJ39xydkPEgCkgG5ycQ9qvtRtOjKc/eSG6Y6x
         BwjdMGZcwHl2gP8eN1XK5cy8E8FVBMR7tjaKCKZ2cct32IRCMUUuwqGDlErWzok1iQp+
         asQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709915377; x=1710520177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3K2dyY59QMbK45K27keA2V/f+oNgDgMOvqb1BGWGMic=;
        b=DbcsFED7vVxTjCdxkVIAJGAIIQtf5ckPyQT4LWwo4AxRDpY8Aa/nEmnunsRUui4q03
         LaFO9XS2oQXe89gIeEaITvkC3COBhgbgZ4XlWH3EwCuJVv5nfO6wugy74S0G3fmn33pG
         PIbRreHxqYWMsWpPF+EtGX4KlwLaI8oW3sBRjEPT2XYsz70KsCUnWJpKY4mmkx6/b1MP
         xa7UYiilVWSL0zPLUjsPpwt7fEAR2rXgAqlaBmjuUYzish+zQqK0Bt7H8mgaBSJGeLpF
         ahq6FVRio5hY2GZfBCLBSF2vZNXaMgZkroZwzBO/jjBeI8jpWKF371zipbtJBHlfsUAd
         diXg==
X-Forwarded-Encrypted: i=1; AJvYcCWgTRwEt26CeAdZSQOgU1nyY2daylF4GiEEzhIsVf4Ux7H/cM2zS12Jcow6JBZNwg5YKGu1rSuifaWeRPaFvKm2bN1oSn3alewaxsRk
X-Gm-Message-State: AOJu0YwhQTYz1W2IMn03+ffJWPLGtB3oj/7kdJpK3ypUAGZZuqmEPXMM
	ZsJXD2Qxl6j8OFBmXEaqeB9CFeVoNOiCDaSTqNRzDG8gIJAafYb/qohO6hVh4bQIcEG9CEqSm6v
	iIlHUh/nMaPRz/HoOXyJ4Yv5d3is=
X-Google-Smtp-Source: AGHT+IE00X7/ws9uzFwHrN7Z0mQ0hIlgxafJNHRg9ehgnG0jJzoQqLAm5AHtPHV5v2UOY/jE33Ne3ei4Aq9Ewvx2Tio=
X-Received: by 2002:a17:907:c306:b0:a45:f866:4bd8 with SMTP id
 tl6-20020a170907c30600b00a45f8664bd8mr758753ejc.60.1709915376898; Fri, 08 Mar
 2024 08:29:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308015435.100968-1-brookxu.cn@gmail.com> <20240308144208.GA9194@lst.de>
In-Reply-To: <20240308144208.GA9194@lst.de>
From: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date: Sat, 9 Mar 2024 00:29:27 +0800
Message-ID: <CADtkEefTzbYN4qEAgAXDTB-+HMxfENw2m+xcoxzy83YW-bGEhA@mail.gmail.com>
Subject: Re: [PATCH v3] nvme: fix reconnection fail due to reserved tag allocation
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christoph Hellwig <hch@lst.de> =E4=BA=8E2024=E5=B9=B43=E6=9C=888=E6=97=A5=
=E5=91=A8=E4=BA=94 22:42=E5=86=99=E9=81=93=EF=BC=9A
>
> The fix looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> But given that's we consolidate to a single place each for setting
> up the tagsets for admin and I/O queues, what about just killing
> the symbolic name and moving the assignments and comments directly
> into the only users?

This works now, but I donot know whether
nvme_alloc_admin_tag_set()/nvme_alloc_io_tag_set()
will be suitable for all driver in future, such as driver for apple
device not use these two funcs
to init tagset (anyway it not use these two macros too), so maybe new
driver would use these
value in other position.

>

