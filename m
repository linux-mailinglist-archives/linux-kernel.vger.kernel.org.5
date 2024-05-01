Return-Path: <linux-kernel+bounces-165735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D998B9060
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26E091F23F61
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4392B1635A9;
	Wed,  1 May 2024 20:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mforney.org header.i=@mforney.org header.b="tyYUIcxU"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E2B16191B
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 20:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714593884; cv=none; b=XchdqBCq3FfSaw5yCJuVSMZ4BEdgA9dUwUXwEcc6cZps12vsy284kUPIQF++TUKROLKudcmtX9zIUAel2JgfWgQtQWvgJqX76vVX9cKZy0HjOXDXeIS+oTwUUMWtsUEfpR9jwm1Q3F6VMhepiZLvXQD2B09w+im6eBd+15+02vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714593884; c=relaxed/simple;
	bh=Y0CK+l13J9hMie3EIzL6d+o5r8hwZWn1+a9iswKDlU0=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:Message-Id:
	 MIME-Version:Content-Type; b=c9OYOl7hlact9h/5rDPrXmmvReoju1YsxqaXhod5LuyvkNC6InPn4W+KeGqm4TuA0KJ2Yx7wHjY5KDquS3jo1ns/HDra9JoQldbLQ79lU+tOfLMUNatQONq6ZnCg1XR+uJTabGekXDZPXocQYMfY9R9tBuWIZxtdy9EB8yHgG1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mforney.org; spf=pass smtp.mailfrom=mforney.org; dkim=pass (2048-bit key) header.d=mforney.org header.i=@mforney.org header.b=tyYUIcxU; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mforney.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mforney.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f103b541aeso6062329b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 13:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney.org; s=google; t=1714593881; x=1715198681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:references:from:subject:cc:to:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LnLzRmYxWQ0xWU0/l608+uhGlXGm+eTVFqBxpwekKbE=;
        b=tyYUIcxUEBGHk/Nc6F5mPDEUBSAY2Jfhg9Z7I8teI5bh4oV57lSz8traKiM9jYF0ft
         4VNWQN+yRmmrqHJkdcSeANIKHkoaHYF0JhS0d+RheRoZM8SSMVwlVJBeAVYaWPAT7Mc8
         5PdHok4l1f3bCMZiratLb203xL8YfCE7V3bCnZWsUyxMyBsI/+N45GeGvsiDIQ8bKrTZ
         lvyt8M+u7voCeO8QSuoM5ivCQ/geAORFzsAiCK+VtIURs+TMl+QUe2GWxYNjwIbTuKPp
         xn3tqJPNxyisT2MKFdrCL2tr503LXhXZVV9p97Iy/hBHq5RZTbCY3QOBvtiFLuzjLUR9
         jMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714593881; x=1715198681;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:references:from:subject:cc:to:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LnLzRmYxWQ0xWU0/l608+uhGlXGm+eTVFqBxpwekKbE=;
        b=XCnB2cvasQu+XirzFoqYbIo7EcZgLqAriOtit/wcF/As7Wm1HiLigU4V/VgTafEd/0
         23KGQo1TuLF7RelDD9jzNDKb9b/T0NIVdiJEeT+yWdDv/KqtHrxiBmvQtm8R3EhZHeXw
         8G6yOhFcnLzSCbC6My6kQrR0YJbKsqboSfxzFSNCincDP/ur3Cayw6M6eDtAil2d+gFR
         VIz6onMagtJXefCqt9SCg4mMItC86RhTLDKDPSs7daFDcCveHGFpBOW/zir43vXUyTNc
         PLzgXZwFAadqIKucscTHO/kQQJKIY2crwjof9s77GZLvZmj1k3W08ipFm41hA0m88UPn
         +2CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrPLHy7F/CQ+fMRe4ntUw/lGsNyDdIoze8cbuOOh9M9zIvpurJCo6/ewSwJnFEvLV+7lpEPX7mMK4JZOBv93zXIdUzJvi89IaEP8uN
X-Gm-Message-State: AOJu0YzYdwXvEs5itD7gBQaqe4IH/wVDHirRnuzFdjGdWTHQBIFIzWs8
	I7M4Fj+yZPg5LTgqXNWr5PCOzsM+499kEKgKBrFZK3al60Po4Zyf40GeyxtXtU4=
X-Google-Smtp-Source: AGHT+IGuIoUPm+qDmwyr9OZHb1tPZ+GL11t/9KEIjx32bGz5VlOlicXDFu+IUmeGYhOeZE8wgQAj4A==
X-Received: by 2002:a05:6a00:b44:b0:6f3:e6ac:1a3f with SMTP id p4-20020a056a000b4400b006f3e6ac1a3fmr4013945pfo.11.1714593881446;
        Wed, 01 May 2024 13:04:41 -0700 (PDT)
Received: from localhost ([2601:647:6400:20b0:16dd:a9ff:fee7:6b79])
        by smtp.gmail.com with ESMTPSA id s23-20020a62e717000000b006ed045e3a70sm22984102pfh.25.2024.05.01.13.04.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2024 13:04:40 -0700 (PDT)
Date: Wed, 01 May 2024 13:04:40 -0700
To: Michael Forney <mforney@mforney.org>
Cc: Max Kellermann <max.kellermann@ionos.com>, tytso@mit.edu,
 adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, brauner@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Revert "ext4: apply umask if ACL support is disabled"
From: Michael Forney <mforney@mforney.org>
References: <20240315142956.2420360-1-max.kellermann@ionos.com>
 <3MDOTS1CN0V39.3MG49L9WIC8VM@mforney.org>
In-Reply-To: <3MDOTS1CN0V39.3MG49L9WIC8VM@mforney.org>
Message-Id: <3HNN4SNRB3DRD.39I8TYZWPN7S0@mforney.org>
User-Agent: mblaze/1.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Michael Forney <mforney@mforney.org> wrote:
> Max Kellermann <max.kellermann@ionos.com> wrote:
> > This reverts commit 484fd6c1de13b336806a967908a927cc0356e312.  The
> > commit caused a regression because now the umask was applied to
> > symlinks and the fix is unnecessary because the umask/O_TMPFILE bug
> > has been fixed somewhere else already.
>=20
> Thanks, Max! I've verified that this fixes symlink modes for me,
> as well as the flatpak corruption error I was getting.
>=20
> > Fixes: https://lore.kernel.org/lkml/28DSITL9912E1.2LSZUVTGTO52Q@mforney=
org/
> > Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
>=20
> Tested-by: Michael Forney <mforney@mforney.org>

Just checking in on this. I'd really like to see this regression
fixed. It currently affects versions 6.5 through 6.9-rc6 as well
as all longterm releases.

