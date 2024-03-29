Return-Path: <linux-kernel+bounces-124400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D95AA891703
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816A21F257B6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBA569D3A;
	Fri, 29 Mar 2024 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnT9uR2g"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899693A1D8;
	Fri, 29 Mar 2024 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711709159; cv=none; b=jDu2z+Pn7TO37pomCEyPQmT5AEOxup7be2yiP4/jfJfyNR62OccwNiHcIMSmZF1TJPAIiYHpZpe+v05WqdaYalcYGvW0CsqS5c5GcIzpKwsjQZxgxex+VJRMSP/PPAmDIbhhKuhFON2KQqJv/P8wNJh7reVF4wFe3ZHkyH+aW90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711709159; c=relaxed/simple;
	bh=3p1MnAvTvbM0t3kjcikAq7feZV2SysEDS5m4MAhUerI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MRkgf+0q7yqF1e8NwhbWWnlG4jjtLPdkRX9SN4UWmKCGuV/S8aMcst1SqhzMCIFq4duBMgg7uFy32/bM7cHC62l5Ly6Le5O2Yryr5uaXSNhfcw4F+uClLltFMwOPAxX3OEs2tnRVcFkqie6HmvQKjfhVjiphbVjN0giAMgtUOSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnT9uR2g; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56c197d042fso2246263a12.0;
        Fri, 29 Mar 2024 03:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711709156; x=1712313956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3p1MnAvTvbM0t3kjcikAq7feZV2SysEDS5m4MAhUerI=;
        b=NnT9uR2g9ag8S1M0lbmKde9HfxpwtiGfjr+DvEU0Mxbbc39Xl4+L5cSBjThsuVzcBd
         wDUPRUe7xEZjlE1r2ME2HFtiXxM0ZELo+YVIHl6pP7yNnN7ojC61w/NErrMvnvmmxs/W
         AvjBata9Dru0zV6u7/kvQX+KKA3JtsleTY2EbW9dPqDWW7ZFdjoflF75ebSi8WzQmcAZ
         7l82z5hCCIbVJdLa5NF7c0CA4bMp2QFthEFHvj36ktEiBDfRCCT1XdLpP3OBJwsvdytd
         lwAFqn3KcolHQGWSka7ZQOqLuszf6bgj8kWzKlgrbqm7zqxzDrifVsmKkGDF7CZ+3IWZ
         WsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711709156; x=1712313956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3p1MnAvTvbM0t3kjcikAq7feZV2SysEDS5m4MAhUerI=;
        b=euEPVoFO/HcoynO4FcpByiExUxAnPdwCYIrLTRDTxeMfzpDROSA4wwEHDyWlDtprAN
         342t3Kr5CAZzc3xE+Ftf1ozkSzrksgRjDIDVJ98hIG/EBN/1V73O68v9mcdTkwWS2cvN
         EOr+TxmMJZRwsg94pRaP4hv2aGsZKWBBOhiWKGsdP8oROhsCUVfFdKFhbQdgP0p0g3e7
         u/eH/VzLwwcPiwXcZRVJMULYvP0mq46IpSap6zRqUFdeed6g0JPA6D9IMiOPoouaWM/P
         M1qfqnENnxKHpDpbcwpTtf1qXFu38Hbkmqe2UJ1XoLSWHfeBZy2At7WuRO4kdiKO3T46
         loYA==
X-Forwarded-Encrypted: i=1; AJvYcCWcLaYMwwO6pLOUNkH9xMaENF7Y5Q3IBxYUa4qwJ9Mjht9HSvAx29CHEj0h+xzplfo2Pbf6BvHeOipffNDUWvN2DUh7U1CdLhXM
X-Gm-Message-State: AOJu0YyUmwkVAZOTIwk4i2fToLcZOGFUzmST0fT901yboPugi+Rz4u5k
	7EIgzMp0ohS+DZ8V/K2r7GilyfLqmhvjjSLyhX58pb8BxApZ4F8hZ23rKdZIin1ReaGjA9o3bQe
	bzfgi13vsY6mWm8WrBSHSZMhwZsY=
X-Google-Smtp-Source: AGHT+IFwjWkTX5l976yERom21AWME+K47YnamJar2gcG1I0yD4/rFL4n0j8/DKk0Uqo/6BEuQnqD5hAWZ7fTL6KOLgc=
X-Received: by 2002:a17:907:1115:b0:a46:ed72:6bb4 with SMTP id
 qu21-20020a170907111500b00a46ed726bb4mr1157215ejb.72.1711709155656; Fri, 29
 Mar 2024 03:45:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328223340.17159-1-rdunlap@infradead.org>
In-Reply-To: <20240328223340.17159-1-rdunlap@infradead.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 29 Mar 2024 12:45:19 +0200
Message-ID: <CAHp75Vcpi6BMqxw8A0TaatvZNbecrPmEmKdD5MVj0dPrkmhiGg@mail.gmail.com>
Subject: Re: [PATCH v2] spi: spi.h: add missing kernel-doc for @last_cs_index_mask
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-spi@vger.kernel.org, 
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 12:33=E2=80=AFAM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
> kernel-doc complains about last_cs_index_mask not described, so add its
> description.
>
> spi.h:778: warning: Function parameter or struct member 'last_cs_index_ma=
sk' not described in 'spi_controller'

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

