Return-Path: <linux-kernel+bounces-135199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C6489BCA5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B23B4B22AE0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BD652F85;
	Mon,  8 Apr 2024 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="MsQeusz7"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1144524B7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712570691; cv=none; b=cOgMoDmBxOM1U+90GKfU79LLwbNGPfGmTOLgK9Tt8yAc2Iz0v5aOnXEYtYNXuPNFX3BfX62JuUO8pENJRo+ZJIuqVGNpAr1Q4CYuu4DoKc7P7p2IUqtvsi+Y1YLxQDbilAlRMxg3ig3dlEaWHi3Q9wR9Dfbto38E006XzsfWLC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712570691; c=relaxed/simple;
	bh=IPQr5DBVIqmQjiMPRP9fQJbEY+9iIM4NqcF2fUQwx+Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jxnW2zMqZPFjgXRJMBKyarsQ2kp/x/C6Xq8Wp2ZJKtor/FBlT7o60HqvjTL0RAAnfVjqaSDBmWUEr0u42Ml2sq3Eq4aIBWdjzWyl3XnFy4kaZ5qRRn9GQ2DDyHSaqQxF1hPgIboHIOqY3DZymzbIUSlwU9QQ728XlMGICio5sh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=MsQeusz7; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a51abd0d7c2so367939666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 03:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712570688; x=1713175488; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPQr5DBVIqmQjiMPRP9fQJbEY+9iIM4NqcF2fUQwx+Y=;
        b=MsQeusz7E8s563WyEiqyVREI2y/4W/rKdYvH1mAfhft6xwCelgS3gJtr5tX41j16U3
         ONxlPl6+QpdbeFydnZc5HcrQiBC0WSIKHaqulvp5XYr3y3zNCtWpIidIv84e/22zgefq
         Kzf4WLfQvzCKY0vQKiOJfuxNuBSLWaGaAESU/z1z4bNkTlx/eytlIjWBPgxPMY4EtdZp
         ktYN/9hYfn4CJHFjKaBg6hKkoQZeya8ODjnHGWtzGSnasVsg+6gxW582LU5tR3B8yTEo
         6shUkF6srpLlb6QKVs2wN2NmYtYC1yaq5eqliTVYkY3MyqifQojrx3eCRXiNmmxdvQh7
         G/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712570688; x=1713175488;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPQr5DBVIqmQjiMPRP9fQJbEY+9iIM4NqcF2fUQwx+Y=;
        b=XJazsu/4zGhDvopsYs5fg2Pew3rKxlB+GCmPaYS9WTOrl2tzPlpoy5Y9DsFmdjuAco
         cV9MTIOKzVCzF8CzicScJghDU5GtSuUAVAjh/6uhsRsLrP6umKk+9qlOEUtVzIZ78/Bb
         SUBUFIlYahLdBq/xAj3nKSDy23hnu1p7ByiUin5Mu5JWIn4QRdvnh1sP8nYJb4uiEVLt
         Z8mTML94M4VcrQVubH+JOp68MMjnxkkRWM5TMavsbDOWsYlYr/qbwxRzxVA1K9Mo7+t1
         qEqdxKrKtK1CuzInTL15bQPJBukoTpAv/WI1ku4vxDi2mvfVrCSoHOhddzsS5LwAnsWr
         0WAw==
X-Forwarded-Encrypted: i=1; AJvYcCWCGE1iMqyVGXDWwYAdKq7nPJDL3FA/NvxRKUoxcVQQ9fIOzoHy3vyF1WzBDiz0CYrX2SrM09T7TLXNZ8lDsPIU4o7rRJpSAddcDKQ2
X-Gm-Message-State: AOJu0Yx4fppAvrot3DiZ/fe2b01yMotUkbxSjAe1CkGvE3+sMNCwUwcb
	RnNNhnt67pcGpm+lRA99zZft8XNXGIXji8SDEmD26ZHomO+/8/2Fvws/2YOZwCH9o8nnHLPcF/y
	M
X-Google-Smtp-Source: AGHT+IFApRzGDXPEnWJrIkuXggzqiy7GiiA3NwloDSeO5yZx0JiS9EZ/CR/qAyApezteLvp7g4NGuA==
X-Received: by 2002:a17:906:7316:b0:a51:d23e:c53 with SMTP id di22-20020a170906731600b00a51d23e0c53mr2191454ejc.31.1712570687880;
        Mon, 08 Apr 2024 03:04:47 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:10c6:ce01:bd98:da4e:9b4c:75b3])
        by smtp.gmail.com with ESMTPSA id m8-20020a1709061ec800b00a46d2e9fd73sm4242441ejj.222.2024.04.08.03.04.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2024 03:04:47 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] zonefs: Use str_plural() to fix Coccinelle warning
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <99a8d3ec-1028-44c5-9fcd-01598a40a014@kernel.org>
Date: Mon, 8 Apr 2024 12:04:36 +0200
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9AAAD718-D1D7-416E-87A9-3CA2BA20C93B@toblux.com>
References: <20240402101715.226284-2-thorsten.blum@toblux.com>
 <99a8d3ec-1028-44c5-9fcd-01598a40a014@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On 8. Apr 2024, at 03:48, Damien Le Moal <dlemoal@kernel.org> wrote:
>=20
> Looking at this function definition:
>=20
> static inline const char *str_plural(size_t num)
> {
> return num =3D=3D 1 ? "" : "s";
> }
>=20
> It is wrong: num =3D=3D 0 should not imply plural. This function needs =
to be fixed.

I think the function is correct because in English it's:

0 files
1 file (every number but 1 is plural in English)
2 files
..

Best,
Thorsten=

