Return-Path: <linux-kernel+bounces-92514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF9987217D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FEE31F22B95
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3907B86AC9;
	Tue,  5 Mar 2024 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="fxEdGatf"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6396127
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649131; cv=none; b=c2Wg9vwj6OjuWVrtmGv/UltSH9snnPbsalj8SO5v4f9K4ZASZLg+rKzSjrBVRy1I2tdYdrtMq+h/uiy+F+EURXeNAX3vqVrD61EuAtp8HMH+fyK5yn/QvR47NZ8XyBMNqyChLxwkNunmZ1+uXQ/AsGpl1up4L0IS37HvzLLLjU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649131; c=relaxed/simple;
	bh=m4gwp8Brrok6cSY1uv1i8iyUlUiai0KjLje5iF+z1Ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWP8+WqOlOcJusgfZC00rPxGyL3xhx3p8VtGZrDdMX0qErC5COWGMz/pvBmb7QMRSYbATzvnd1bRRdz8IyM4EMco5qrsJNorjXQ/wg59bHrsAC4ET/D8MX9jpTvu4IykCgM2ab6b+EMUM5fombHqvGp+MJFJd3zXiE08eUhjW+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=fxEdGatf; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a45670f9508so263765966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 06:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709649128; x=1710253928; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m4gwp8Brrok6cSY1uv1i8iyUlUiai0KjLje5iF+z1Ys=;
        b=fxEdGatfJG0Lyf4faOdQf+X1B3ERlfeRuda+H8bokVyJQ7jLnTsIEoUdQ3yrwUs4Vx
         N9Be5PBUSRsiynBhgOPsemDMkTHAuwy73q+dQAPIEOQQpxYb/Nu/elloioQsPrEUlCvB
         W0RH3IJLLEj1EMqav3vlSrM2Ff5Fij94WTdfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709649128; x=1710253928;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4gwp8Brrok6cSY1uv1i8iyUlUiai0KjLje5iF+z1Ys=;
        b=a9Cx+rdzgPuL1nxxr2sVwXLtWgbotVgrOdVk6wPd7gy9x6+E7hUh4F5Rft6vOaaPMj
         2f8ZmrtwR8+R+i1Q70DbM0QrVsFbdoJU7InHwVqBfnsGfF45HFN4TKHmGySzvlBicO9D
         1FNPAUxHm4VUcFa+ZKntAsK6Jj1YN3JYzHx5+cZJIZUDe4454a0/8NUCQ8UhvO3FDdWx
         kAE0gkDm7LOCsukGWxC2tU1ZBFfDtOyv3IP8k63WR4jagXrmpZB8a3iLHh2BbLFeCCeW
         ocQkQo4JWdawk7ksMX/E/CrI+z/wAhBjq4YD4g7V07pcKHOKT28Etr8pGi4nAUXvjD5Z
         0KBA==
X-Forwarded-Encrypted: i=1; AJvYcCXKynmG6XLhMnm/vS9AMeB+FA9MfgZJjT79mAm230lUDhLe+RuOJqIPbCgxfItU9QXKRrs4TfTP8zakwVLsqzqud8MbfMnRDtgKLIq+
X-Gm-Message-State: AOJu0YyImgtyNNu8O3YbEpZMOhPwP+DV4n/N3suOpkUW8J7c6cZ2dlQ3
	7su0MLYC5qYnX9geYBycWpxeqiyxi0t0F449yPUAsZbzzZXfo9rgLpQn/+HI9JgVlVu3PZOYoKW
	bfyYrOpXqo/MgkVe8pzcmnE+ORTqxj9m6gMmYoQ==
X-Google-Smtp-Source: AGHT+IH74N86OpW+SCu9HB+VdyGPJtDL2TD+L4UUv0iiCACiyZphJleePA1BBASnlVYeN04Cq5uHAMBZ1lSh4QA6w3Q=
X-Received: by 2002:a17:906:8309:b0:a40:46f1:7263 with SMTP id
 j9-20020a170906830900b00a4046f17263mr7553753ejx.22.1709649128288; Tue, 05 Mar
 2024 06:32:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105152129.196824-1-aleksandr.mikhalitsyn@canonical.com> <20240105152129.196824-2-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20240105152129.196824-2-aleksandr.mikhalitsyn@canonical.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 5 Mar 2024 15:31:57 +0100
Message-ID: <CAJfpegvhLx0v=kPhFFXg5p+0AaSUfeqDRZTyYnFLvGiaY6HrJw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] fuse: fix typo for fuse_permission comment
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: mszeredi@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jan 2024 at 16:21, Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> Found by chance while working on support for idmapped mounts in fuse.
>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: <linux-fsdevel@vger.kernel.org>
> Cc: <linux-kernel@vger.kernel.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

Applied, thanks.

