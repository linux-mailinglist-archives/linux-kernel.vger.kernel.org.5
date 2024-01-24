Return-Path: <linux-kernel+bounces-37678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A1A83B382
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D63671F245C8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5C51350E3;
	Wed, 24 Jan 2024 21:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAT6BK93"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AF1811E4;
	Wed, 24 Jan 2024 21:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706130138; cv=none; b=OlHsBXY/1Ka7A8SxqgBGzarH3w9Rvo+my5fdg0y87NLvQxGu8dG6hYSvnz7V738lysB383BfeV6McSUlmzFrX3YoeMy52OZkxyfHvwpo9rm2zjuKADjWvtB/JAzG61yMxKwFTRm6rLx7IqF9orpX3z5SFIhuB9wg3m+J2jSaYWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706130138; c=relaxed/simple;
	bh=bAfj+lfShymZsoyfoask6vCqYCWRiyyMZUbTs15Vpx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gXc7gaLK/CXft48XRipjhR/CiVuNkDGjnjKV1b8ZOm4Vwgbrf6pRT6pD+i6t1wDQzknoMGcam80X4Tm648ywEYniUH2aJpeosHtkPz3DYrrsg2+5F9Ii25GnJ8ksxT5UHgMebyge0+4Fz5DB4sX50BYReqhfrSZdtuIhC9Ug2Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAT6BK93; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33929364bdaso4230206f8f.2;
        Wed, 24 Jan 2024 13:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706130135; x=1706734935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAfj+lfShymZsoyfoask6vCqYCWRiyyMZUbTs15Vpx4=;
        b=SAT6BK93AAWBwtPCcmFGrqt8VpCp2dJhItpq6DrPnq7kEpemgarqgQfNiqpCApzsYq
         uxO25MBYNcyL4aWEegY1wB4xI5/CfgwXX+iYLYFaDTTbfguzFOaU5ie7LXUp0yptZzvT
         9LTbXnI5jfs7SZRDvGl4R8b+jtdJ4ippmstbNVFG1pOKSNEei0kVEDc9td5Q4N6dp3Mg
         j19kzcbxIVFNbxVcvubbsnNTRwYflI0UudToh5PnXafnlxMfJE0gw1KF6AUP7a4CEMQf
         2FoodFx1iL3Q93cAegP5GljgsmyZZySs4K2XAtQrJAAK9FVsAg4Y93xNoCyf8YRYVieK
         cUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706130135; x=1706734935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAfj+lfShymZsoyfoask6vCqYCWRiyyMZUbTs15Vpx4=;
        b=fuHDSMWgCsVBw8CBQgZqc7b8sJkzVU7dGEN+JMTMUyQpj+B9IiqL0fuv6jKZinvOW7
         q3RfSFGOLgpoovyPFARBJDJLz9dneleqlWndl/GDXXdxNc6GV3h5/K4U4iH6MOZupEVQ
         JF45RGGD/PO09hTd/f5hRjoh+hv5S6ZCVWCFiJAHUJvHFZoCrVsfCKrIYaEHRXktazbm
         BctpMMTAS51YC2VKyfb6ZKHWyyAcohuY+SqDm+MpK3OpP7tXN2i0D35GAAER6Ov7ZMXA
         qSFCWIf/ieWrE5j0/b+fHyXIQSPHPJ3erEzg/RTshMTYItaIod6xPCRLBwR74ioYaTRC
         9vHw==
X-Gm-Message-State: AOJu0Yys4f61Szq/5gptJJ9gbkPWmpTIyeDDfPgXpL09sseubxRCpcGe
	+R7RfaPs97RoBcSpa4AQ2gEYjBvmOVMRwxP4qua0C1QPpnEMfuQjGWSEcgX69GFoM6q0Dkw22ev
	DgZg/ixlvhF70nzztxSGsw5iGoCM=
X-Google-Smtp-Source: AGHT+IGwGaxKf7Y8cfweBcRUvpL0St41Liw7fqV4ScKzacDTxGnaM89bGFd8uR2QyCCyum73jdgw2cuOIb4C0xkQIII=
X-Received: by 2002:a5d:4e82:0:b0:337:4b63:ea54 with SMTP id
 e2-20020a5d4e82000000b003374b63ea54mr881759wru.85.1706130135326; Wed, 24 Jan
 2024 13:02:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124153016.1541616-1-ckeepax@opensource.cirrus.com>
In-Reply-To: <20240124153016.1541616-1-ckeepax@opensource.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 24 Jan 2024 23:01:38 +0200
Message-ID: <CAHp75VfS9jFuxBQQ9B6FJ4nFBgsctY-GX5+53iVtz=UgdtAOEA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] spi: cs42l43: Tidy up header includes
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lee@kernel.org, broonie@kernel.org, alsa-devel@alsa-project.org, 
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 5:30=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> Including some missing headers.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>


--=20
With Best Regards,
Andy Shevchenko

